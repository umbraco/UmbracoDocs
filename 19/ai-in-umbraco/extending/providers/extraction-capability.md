---
description: >-
    Implement the experimental Extraction capability for your custom provider.
---

# Extraction Capability

{% hint style="warning" %}
Extraction is **experimental**. When the `Umbraco:AI:Experimental:Extraction` feature flag is off, the capability is hidden from discovery and not selectable in the profile editor, even if a provider implements it. A provider whose only capability is Extraction is not listed at all while the flag is off.
{% endhint %}

The Extraction capability reads typed values, such as text, numbers, dates, and lists, out of a piece of text. Implement it by extending `AIExtractionCapabilityBase<TSettings>` and returning your own `IAIExtractionClient`.

Unlike Chat, Embedding, and Speech-to-Text, Extraction has no Microsoft.Extensions.AI client to wrap. `IAIExtractionClient` is an Umbraco AI interface, so your provider maps the request to its service and builds the response itself.

{% hint style="info" %}
Every Extraction type is marked `[Experimental("UMBRACOAI_EXTRACTION")]`. Add `#pragma warning disable UMBRACOAI_EXTRACTION` to each file that implements or uses them.
{% endhint %}

## Base Class

{% code title="AIExtractionCapabilityBase<TSettings>" %}

```csharp
[Experimental("UMBRACOAI_EXTRACTION")]
public abstract class AIExtractionCapabilityBase<TSettings>(IAIProvider provider)
    : AICapabilityBase<TSettings>(provider), IAICapability<TSettings>, IAIExtractionCapability
    where TSettings : class
{
    public override AICapability Kind => AICapability.Extraction;

    // Override this (or CreateClientAsync) to create an IAIExtractionClient
    protected virtual IAIExtractionClient CreateClient(TSettings settings, string? modelId) { /* ... */ }

    // Override this for an async variant
    protected virtual Task<IAIExtractionClient> CreateClientAsync(
        TSettings settings, string? modelId, CancellationToken cancellationToken = default) { /* ... */ }

    // Inherited from AICapabilityBase<TSettings>: return available models
    protected abstract Task<IReadOnlyList<AIModelDescriptor>> GetModelsAsync(
        TSettings settings,
        CancellationToken cancellationToken = default);
}
```

{% endcode %}

A settings-free `AIExtractionCapabilityBase` also exists for providers without connection settings. `AIExtractionCapabilityBase<TSettings, TCapabilitySettings>` adds per-profile capability settings.

## The IAIExtractionClient Contract

{% code title="IAIExtractionClient.cs" %}

```csharp
[Experimental("UMBRACOAI_EXTRACTION")]
public interface IAIExtractionClient : IDisposable
{
    Task<AIExtractionResponse> GetResponseAsync(
        AIExtractionRequest request,
        AIExtractionOptions? options = null,
        CancellationToken cancellationToken = default);

    object? GetService(Type serviceType, object? serviceKey = null);
}
```

{% endcode %}

Each call receives one `AIExtractionRequest`:

- `State` is the text to extract from. It is never empty, and it is shared by every field.
- `Fields` holds one or more fields. Each has a unique `Id`. The fields can be of different kinds.
- `ReferenceDate` is the date that relative expressions, such as "yesterday", resolve against. It can be `null`.

Your client answers every field and returns them in `AIExtractionResponse.Answers`, keyed by field `Id`. Answer all the fields in a single call to your service when it supports that. Requests made through `IAIExtractionService.ExtractAsync` contain exactly one field.

Your client must follow these rules:

- **Return one answer per field, of the matching type.** Answer an `AITextExtractionField` with an `AITextExtractionAnswer`, an `AINumberExtractionField` with an `AINumberExtractionAnswer`, and so on. Key each answer by its field's `Id`.
- **Answer "not found" with an empty value.** When a value is not in the text, return the answer with a `null` value, or an empty list for a list field. Never return a guess. `IsFound` is worked out from the value, so you do not set it.
- **Return the duration in the unit asked for.** An `AIDurationExtractionAnswer` must have the same `Unit` as its field.
- **Use the caller's model when set.** Prefer `options?.ModelId` over the model the client was created with.
- **Throw on failure.** Let HTTP errors surface as exceptions, such as `HttpRequestException` with a `StatusCode`. Umbraco AI classifies them through your provider's error classifier.
- **Do not validate the request shape.** Umbraco AI checks the state, field IDs, instructions, and decimals before your client is called.

Umbraco AI wraps your client with validation, error classification, middleware, telemetry, and usage tracking. It also checks your answers, and reports a provider error when it finds any of these:

- A missing or extra answer, or an answer of the wrong type.
- A `Confidence` or `NullProbability` outside 0 to 1.
- A list answer whose `Values` or `Spans` is `null`.
- A duration answer in a different unit from the one asked for.

Setting `Usage` on the response makes token counts appear in [Usage Analytics](../../backoffice/usage-analytics.md). One call is recorded as one usage entry, however many fields it holds.

## Answer Types

Set these properties when you build each answer. Set `ModelId` and `Usage` once, on the `AIExtractionResponse`, because they cover the whole call.

| Answer | Value properties |
| --- | --- |
| `AITextExtractionAnswer` | `Value` (`string?`), optional `Span` |
| `AINumberExtractionAnswer` | `Value` (`decimal?`) |
| `AIDateExtractionAnswer` | `Value` (`DateOnly?`) |
| `AITimeExtractionAnswer` | `Value` (`TimeOnly?`) |
| `AIDateTimeExtractionAnswer` | `Value` (`DateTime?`). Use `DateTimeKind.Unspecified` unless your service returns an offset or zone. |
| `AIDurationExtractionAnswer` | `Value` (`decimal?`), `Unit` (required, the field's unit) |
| `AIListExtractionAnswer` | `Values` (strings, empty when none are found), `Spans` (empty, or one per value in the same order) |

Every answer also has optional `Confidence`, `NullProbability`, and `RawRepresentation` properties. Set `Confidence` and `NullProbability` only when your service reports them.

Spans are character offsets into `State`. `End` is exclusive. Leave the span out for a value that was not found.

## Basic Implementation

{% code title="MyExtractionCapability.cs" %}

```csharp
#pragma warning disable UMBRACOAI_EXTRACTION

using Umbraco.AI.Core.Extraction;
using Umbraco.AI.Core.Models;
using Umbraco.AI.Core.Providers;

namespace MyProvider;

public class MyExtractionCapability : AIExtractionCapabilityBase<MyProviderSettings>
{
    public MyExtractionCapability(IAIProvider provider) : base(provider) { }

    protected override IAIExtractionClient CreateClient(MyProviderSettings settings, string? modelId)
    {
        return new MyExtractionClient(settings, modelId ?? "my-extraction-model");
    }

    protected override Task<IReadOnlyList<AIModelDescriptor>> GetModelsAsync(
        MyProviderSettings settings,
        CancellationToken cancellationToken = default)
    {
        var models = new List<AIModelDescriptor>
        {
            new(new AIModelRef(Provider.Id, "my-extraction-model"), "My Extraction Model")
        };
        return Task.FromResult<IReadOnlyList<AIModelDescriptor>>(models);
    }
}
```

{% endcode %}

The client below shows the shape of the mapping for two field kinds. `MyApi` stands in for your service's own client, and extracts one field at a time. If your service accepts multiple fields in one call, send them all together instead.

{% code title="MyExtractionClient.cs" %}

```csharp
#pragma warning disable UMBRACOAI_EXTRACTION

using Umbraco.AI.Core.Extraction;

namespace MyProvider;

public class MyExtractionClient : IAIExtractionClient
{
    private readonly MyProviderSettings _settings;
    private readonly string _modelId;

    public MyExtractionClient(MyProviderSettings settings, string modelId)
    {
        _settings = settings;
        _modelId = modelId;
    }

    public async Task<AIExtractionResponse> GetResponseAsync(
        AIExtractionRequest request,
        AIExtractionOptions? options = null,
        CancellationToken cancellationToken = default)
    {
        var modelId = options?.ModelId ?? _modelId;
        var answers = new Dictionary<string, AIExtractionAnswer>();

        foreach (var field in request.Fields)
        {
            answers[field.Id!] = await ExtractAsync(field, request.State!, modelId, cancellationToken);
        }

        return new AIExtractionResponse { Answers = answers, ModelId = modelId };
    }

    private async Task<AIExtractionAnswer> ExtractAsync(
        AIExtractionField field,
        string state,
        string modelId,
        CancellationToken cancellationToken)
    {
        switch (field)
        {
            case AITextExtractionField text:
            {
                // Returns null when the value is not in the text
                string? value = await MyApi.ExtractTextAsync(
                    _settings, modelId, text.Instructions, state, cancellationToken);

                return new AITextExtractionAnswer { Value = value };
            }

            case AINumberExtractionField number:
            {
                decimal? value = await MyApi.ExtractNumberAsync(
                    _settings, modelId, number.Instructions, state, cancellationToken);

                if (value is not null && number.Decimals is { } decimals)
                {
                    value = Math.Round(value.Value, decimals);
                }

                return new AINumberExtractionAnswer { Value = value };
            }

            default:
                throw new NotSupportedException(
                    $"Unsupported extraction field type '{field.GetType().Name}'.");
        }
    }

    public object? GetService(Type serviceType, object? serviceKey = null) => null;

    public void Dispose()
    {
    }
}
```

{% endcode %}

## Register in Provider

Add the Extraction capability in your provider constructor:

{% code title="MyProvider.cs" %}

```csharp
#pragma warning disable UMBRACOAI_EXTRACTION

using Umbraco.AI.Core.Providers;

namespace MyProvider;

[AIProvider("myprovider", "My AI Provider")]
public class MyProvider : AIProviderBase<MyProviderSettings>
{
    public MyProvider(IAIProviderInfrastructure infrastructure)
        : base(infrastructure)
    {
        WithCapability<MyExtractionCapability>();  // Add Extraction support
    }
}
```

{% endcode %}

## Test Connection

The backoffice **Test Connection** button calls `GetModelsAsync` on your provider's first registered capability. Any exception it throws is treated as a failed test. If your models list is fixed, you can still send a small, cheap request from `GetModelsAsync` to check the credentials. The [Cloudflare provider](../../providers/cloudflare.md#test-connection) does this.

## Related

- [Creating a Provider](creating-a-provider.md) - Provider setup
- [Decision Capability](decision-capability.md) - The other typed-answer capability
- [Extraction API](../../using-the-api/extraction/README.md) - Using the Extraction API
