---
description: >-
    Implement the experimental Decision capability for your custom provider.
---

# Decision Capability

{% hint style="warning" %}
Decision is **experimental**. When the `Umbraco:AI:Experimental:Decision` feature flag is off, the capability is hidden from discovery and not selectable in the profile editor, even if a provider implements it. A provider whose only capability is Decision is not listed at all while the flag is off.
{% endhint %}

The Decision capability answers typed yes/no, pick-one, and score questions. Implement it by extending `AIDecisionCapabilityBase<TSettings>` and returning your own `IAIDecisionClient`.

Unlike Chat, Embedding, and Speech-to-Text, Decision has no Microsoft.Extensions.AI client to wrap. `IAIDecisionClient` is an Umbraco AI interface, so your provider maps the request to its service and builds the response itself.

{% hint style="info" %}
Every Decision type is marked `[Experimental("UMBRACOAI_DECISION")]`. Add `#pragma warning disable UMBRACOAI_DECISION` to each file that implements or uses them.
{% endhint %}

## Base Class

{% code title="AIDecisionCapabilityBase<TSettings>" %}

```csharp
[Experimental("UMBRACOAI_DECISION")]
public abstract class AIDecisionCapabilityBase<TSettings>(IAIProvider provider)
    : AICapabilityBase<TSettings>(provider), IAICapability<TSettings>, IAIDecisionCapability
    where TSettings : class
{
    public override AICapability Kind => AICapability.Decision;

    // Override this (or CreateClientAsync) to create an IAIDecisionClient
    protected virtual IAIDecisionClient CreateClient(TSettings settings, string? modelId) { /* ... */ }

    // Override this for an async variant
    protected virtual Task<IAIDecisionClient> CreateClientAsync(
        TSettings settings, string? modelId, CancellationToken cancellationToken = default) { /* ... */ }

    // Inherited from AICapabilityBase<TSettings>: return available models
    protected abstract Task<IReadOnlyList<AIModelDescriptor>> GetModelsAsync(
        TSettings settings,
        CancellationToken cancellationToken = default);
}
```

{% endcode %}

A settings-free `AIDecisionCapabilityBase` also exists for providers without connection settings. `AIDecisionCapabilityBase<TSettings, TCapabilitySettings>` adds per-profile capability settings, applied to each request's `AIDecisionOptions` through `ApplyCapabilitySettings`.

## The IAIDecisionClient Contract

{% code title="IAIDecisionClient.cs" %}

```csharp
[Experimental("UMBRACOAI_DECISION")]
public interface IAIDecisionClient : IDisposable
{
    Task<AIDecisionResponse> GetResponseAsync(
        AIDecisionRequest request,
        AIDecisionOptions? options = null,
        CancellationToken cancellationToken = default);

    object? GetService(Type serviceType, object? serviceKey = null);
}
```

{% endcode %}

Each call receives one `AIDecisionRequest`:

- `State` is the content being judged. It can be `null`, and it is shared by every question.
- `Questions` holds one or more questions. Each has a unique, non-empty `Id`. The questions can be of different kinds.

Your client answers every question and returns them in `AIDecisionResponse.Answers`, keyed by question `Id`. Answer all the questions in a single call to your service when it supports that. Requests made through `IAIDecisionService.AskAsync` contain exactly one question.

Your client must follow these rules:

- **Return one answer per question, of the matching type.** Answer an `AIBinaryDecisionQuestion` with an `AIBinaryDecisionAnswer`, an `AIChoiceDecisionQuestion` with an `AIChoiceDecisionAnswer`, and an `AIScoreDecisionQuestion` with an `AIScoreDecisionAnswer`. Key each answer by its question's `Id`.
- **Return complete probabilities.** A choice answer needs a probability for every option key, and a score answer needs one for every level index. If your service leaves out options or levels with a probability of zero, add them with `0`.
- **Use the caller's model when set.** Prefer `options?.ModelId` over the model the client was created with.
- **Throw on failure.** Let HTTP errors surface as exceptions, such as `HttpRequestException` with a `StatusCode`. Umbraco AI classifies them through your provider's error classifier.
- **Do not validate the request shape.** Umbraco AI checks question IDs, instructions, option counts, and level counts before your client is called.

Umbraco AI wraps your client with validation, error classification, middleware, telemetry, and usage tracking. It also checks your answers, and reports a provider error when it finds any of these:

- A missing or extra answer, or an answer of the wrong type.
- A probability outside 0 to 1, or probabilities that do not add up to 1.
- A choice that is not an option key, or a score outside the levels.

Setting `Usage` on the response makes token counts appear in [Usage Analytics](../../backoffice/usage-analytics.md). One call is recorded as one usage entry, however many questions it holds.

## Answer Types

Set these properties when you build each answer. Set `ModelId` and `Usage` once, on the `AIDecisionResponse`, because they cover the whole call.

| Answer | Required properties | Optional properties |
| --- | --- | --- |
| `AIBinaryDecisionAnswer` | `TrueProbability` (the probability of "yes", 0.0 to 1.0) | `RawRepresentation` |
| `AIChoiceDecisionAnswer` | `Choice` (an option key), `Probabilities` (every option key) | `Confidence`, `RawRepresentation` |
| `AIScoreDecisionAnswer` | `Score` (0-based, fractional index into the levels), `Probabilities` (every level index, from 0 for the lowest level) | `Confidence`, `RawRepresentation` |

A binary answer has no confidence value. Set `Confidence` on a choice or score answer only when your service reports one.

## Basic Implementation

{% code title="MyDecisionCapability.cs" %}

```csharp
#pragma warning disable UMBRACOAI_DECISION

using Umbraco.AI.Core.Decision;
using Umbraco.AI.Core.Models;
using Umbraco.AI.Core.Providers;

namespace MyProvider;

public class MyDecisionCapability : AIDecisionCapabilityBase<MyProviderSettings>
{
    public MyDecisionCapability(IAIProvider provider) : base(provider) { }

    protected override IAIDecisionClient CreateClient(MyProviderSettings settings, string? modelId)
    {
        return new MyDecisionClient(settings, modelId ?? "my-decision-model");
    }

    protected override Task<IReadOnlyList<AIModelDescriptor>> GetModelsAsync(
        MyProviderSettings settings,
        CancellationToken cancellationToken = default)
    {
        var models = new List<AIModelDescriptor>
        {
            new(new AIModelRef(Provider.Id, "my-decision-model"), "My Decision Model")
        };
        return Task.FromResult<IReadOnlyList<AIModelDescriptor>>(models);
    }
}
```

{% endcode %}

The client below shows the shape of the mapping. `MyApi` stands in for your service's own client, and asks one question at a time. If your service accepts multiple questions in one call, send them all together instead.

{% code title="MyDecisionClient.cs" %}

```csharp
#pragma warning disable UMBRACOAI_DECISION

using Umbraco.AI.Core.Decision;

namespace MyProvider;

public class MyDecisionClient : IAIDecisionClient
{
    private readonly MyProviderSettings _settings;
    private readonly string _modelId;

    public MyDecisionClient(MyProviderSettings settings, string modelId)
    {
        _settings = settings;
        _modelId = modelId;
    }

    public async Task<AIDecisionResponse> GetResponseAsync(
        AIDecisionRequest request,
        AIDecisionOptions? options = null,
        CancellationToken cancellationToken = default)
    {
        var modelId = options?.ModelId ?? _modelId;
        var answers = new Dictionary<string, AIDecisionAnswer>();

        foreach (var question in request.Questions)
        {
            answers[question.Id!] = await AnswerAsync(question, request.State, modelId, cancellationToken);
        }

        return new AIDecisionResponse { Answers = answers, ModelId = modelId };
    }

    private async Task<AIDecisionAnswer> AnswerAsync(
        AIDecisionQuestion question,
        string? state,
        string modelId,
        CancellationToken cancellationToken)
    {
        switch (question)
        {
            case AIBinaryDecisionQuestion binary:
            {
                double probability = await MyApi.AskYesNoAsync(
                    _settings, modelId, binary.Instructions, state, cancellationToken);

                return new AIBinaryDecisionAnswer { TrueProbability = probability };
            }

            case AIChoiceDecisionQuestion choice:
            {
                // Returns the chosen key and a probability per key
                (string key, Dictionary<string, double> probabilities) = await MyApi.PickAsync(
                    _settings, modelId, choice.Instructions, state,
                    choice.Options.Select(o => o.Key).ToList(), cancellationToken);

                // Fill in any option the service left out
                foreach (var option in choice.Options)
                {
                    probabilities.TryAdd(option.Key, 0);
                }

                return new AIChoiceDecisionAnswer { Choice = key, Probabilities = probabilities };
            }

            case AIScoreDecisionQuestion score:
            {
                // Returns a fractional score and a probability per level, in level order
                (double value, double[] levelProbabilities) = await MyApi.ScoreAsync(
                    _settings, modelId, score.Instructions, state,
                    score.Levels.Select(l => l.Description).ToList(), cancellationToken);

                return new AIScoreDecisionAnswer
                {
                    Score = value,
                    Probabilities = levelProbabilities
                        .Select((probability, index) => (index, probability))
                        .ToDictionary(x => x.index, x => x.probability)
                };
            }

            default:
                throw new NotSupportedException(
                    $"Unsupported decision question type '{question.GetType().Name}'.");
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

Add the Decision capability in your provider constructor:

{% code title="MyProvider.cs" %}

```csharp
#pragma warning disable UMBRACOAI_DECISION

using Umbraco.AI.Core.Providers;

namespace MyProvider;

[AIProvider("myprovider", "My AI Provider")]
public class MyProvider : AIProviderBase<MyProviderSettings>
{
    public MyProvider(IAIProviderInfrastructure infrastructure)
        : base(infrastructure)
    {
        WithCapability<MyDecisionCapability>();  // Add Decision support
    }
}
```

{% endcode %}

## Test Connection

The backoffice **Test connection** button calls your capability's `GetModelsAsync`. Any exception it throws is treated as a failed test. If your service has no models endpoint, you can send a small, cheap request from `GetModelsAsync` to check the credentials. The [TypeSafe AI provider](../../providers/typesafe.md#test-connection) does this.

## Related

- [Creating a Provider](creating-a-provider.md) - Provider setup
- [Chat Capability](chat-capability.md) - Chat capability implementation
- [Speech-to-Text Capability](speech-to-text-capability.md) - Speech-to-text capability implementation
- [Decision API](../../using-the-api/decision/README.md) - Using the Decision API
