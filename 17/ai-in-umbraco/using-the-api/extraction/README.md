---
description: >-
    Pull typed values such as text, numbers, dates, and lists out of free text using the experimental Extraction API.
---

# Extraction

{% hint style="warning" %}
Extraction is **experimental**. The API surface may change between releases. It is disabled by default. See [Enabling Extraction](#enabling-extraction) below.
{% endhint %}

The Extraction API reads a piece of text and returns typed values from it. You do not prompt a chat model and parse its text. Instead, you describe each value you want, and get back a `string`, `decimal`, `DateOnly`, `TimeOnly`, `DateTime`, or a list of strings. When a value is not in the text, you get an empty answer, not a guess.

Use Extraction for form-filling tasks, such as:

- Reading an order number, amount, and delivery date out of a support email
- Turning a lead email into a company name, contact, and meeting date
- Collecting every product named in a complaint

Extraction is not built on a Microsoft.Extensions.AI abstraction, because none exists for this kind of model. Umbraco AI defines its own `IAIExtractionClient` and adds profiles, connections, notifications, telemetry, and usage tracking on top.

## Enabling Extraction

Extraction is gated behind a feature flag. Until you enable it:

- The capability is hidden from discovery and is **not selectable** in the profile editor.
- Profiles using the capability cannot be created.
- The **Default Extraction Profile** setting is hidden.
- Providers that only support Extraction, such as [Cloudflare](../../providers/cloudflare.md), are not listed.
- The Management API endpoint returns **404**.
- `IAIExtractionService` throws an `InvalidOperationException`.

Enable the flag in `appsettings.json`:

{% code title="appsettings.json" %}

```json
{
    "Umbraco": {
        "AI": {
            "Experimental": {
                "Extraction": true
            }
        }
    }
}
```

{% endcode %}

Restart the site after changing the flag.

The C# API surface is marked with `[Experimental("UMBRACOAI_EXTRACTION")]`. The compiler reports an error when you use it until you suppress the `UMBRACOAI_EXTRACTION` diagnostic. Suppress it in each file that calls the API:

{% code title="C#" %}

```csharp
#pragma warning disable UMBRACOAI_EXTRACTION
```

{% endcode %}

The diagnostic and the feature flag are independent. The diagnostic only lets your code compile against the API. The flag controls whether the capability is available at runtime.

## Requests, Fields, and Answers

An Extraction call is made up of:

- **State**: the text to extract from, such as an email or a page body. It is required, and it is shared by every field in the call.
- **Fields**: one or more typed fields to read out of the state.
- **Reference date**: an optional date that relative expressions in the text, such as "yesterday" or "next Friday", are resolved against.
- **Answers**: one typed answer per field, plus the model and token usage for the whole call.

Each kind of field is its own class. The class you use decides the answer type you get back, so you never need to cast when you extract a single field.

| Field | Answer | Value type | Extra field properties |
| --- | --- | --- | --- |
| `AITextExtractionField` | `AITextExtractionAnswer` | `string?` | None |
| `AINumberExtractionField` | `AINumberExtractionAnswer` | `decimal?` | `Decimals`, `Integer`, `Unit` |
| `AIDateExtractionField` | `AIDateExtractionAnswer` | `DateOnly?` | None |
| `AITimeExtractionField` | `AITimeExtractionAnswer` | `TimeOnly?` | None |
| `AIDateTimeExtractionField` | `AIDateTimeExtractionAnswer` | `DateTime?` | None |
| `AIDurationExtractionField` | `AIDurationExtractionAnswer` | `decimal?` in `Unit` | `Unit` (required), `Decimals`, `Integer` |
| `AIListExtractionField` | `AIListExtractionAnswer` | `IReadOnlyList<string>` | `ItemType` |

### Field Properties

Every field has these properties:

| Property | Type | Required | Description |
| --- | --- | --- | --- |
| `Instructions` | `string` | Yes | What the value is. Must not be empty. Be specific, for example "The total amount the customer paid, including VAT". |
| `Id` | `string?` | See description | Identifies the field, and keys its answer in the response. Required when you use `GetExtractionResponseAsync`, even for one field. Optional with `ExtractAsync`, which assigns an ID for you. |

A field `Id` must start with a letter or underscore, contain only letters, digits, and underscores, and be at most 64 characters long. IDs must be unique within the request.

Some field kinds have extra properties:

| Property | Applies to | Type | Description |
| --- | --- | --- | --- |
| `Decimals` | Number, Duration | `int?` | Rounds the value to this many decimal places, from 0 to 6. |
| `Integer` | Number, Duration | `bool` | When `true`, the value must be a whole number. Defaults to `false`. |
| `Unit` | Number | `string?` | The unit or currency the number is in, such as `"DKK"` or `"kg"`. Helps the model pick the right number. |
| `Unit` | Duration | `AIDurationUnit` | **Required.** The unit the duration is measured and returned in: `Seconds`, `Minutes`, `Hours`, `Days`, `Weeks`, `Months`, or `Years`. |
| `ItemType` | List | `AIExtractionListItemType` | The kind of item to collect: `Text` (default), `Number`, or `Date`. Items always come back as strings. |

### Answer Properties

Every answer has these properties:

| Property | Type | Description |
| --- | --- | --- |
| `IsFound` | `bool` | `true` when a value was found. It is derived from the value: a non-null value, or a list with at least one item. |
| `Confidence` | `double?` | The model's confidence in the answer, from 0.0 to 1.0, when the provider reports one. |
| `NullProbability` | `double?` | The model's estimated probability that the value is not in the text, from 0.0 to 1.0, when the provider reports one. |
| `RawRepresentation` | `object?` | The provider's own answer object, when the provider exposes one. |

Each answer also has its own value:

| Answer | Value properties |
| --- | --- |
| `AITextExtractionAnswer` | `Value` (`string?`), and `Span` (`AIExtractionSpan?`), which is where the value sits in the state, when the provider reports it. |
| `AINumberExtractionAnswer` | `Value` (`decimal?`) |
| `AIDateExtractionAnswer` | `Value` (`DateOnly?`) |
| `AITimeExtractionAnswer` | `Value` (`TimeOnly?`) |
| `AIDateTimeExtractionAnswer` | `Value` (`DateTime?`). The kind is `Utc` when the provider returns a UTC time, and `Unspecified` when the text gives no time zone. No conversion to local time is applied. |
| `AIDurationExtractionAnswer` | `Value` (`decimal?`), and `Unit` (`AIDurationUnit`), which is always the unit the field asked for. |
| `AIListExtractionAnswer` | `Values` (`IReadOnlyList<string>`), and `Spans` (`IReadOnlyList<AIExtractionSpan>`), in the same order as `Values`, when the provider reports them. |

An `AIExtractionSpan` has a `Start` and an `End` character offset into the state. `End` is exclusive, so `state[span.Start..span.End]` is the matched text.

A value that is not in the text comes back as `null`, or as an empty list for a list field. Check `IsFound` before you use a value.

### The Response

| Property | Type | Description |
| --- | --- | --- |
| `Answers` | `IReadOnlyDictionary<string, AIExtractionAnswer>` | One answer per field, keyed by field `Id`. |
| `ModelId` | `string?` | The model that produced the answers, when known. |
| `Usage` | `UsageDetails?` | Token usage for the whole call, when the provider reports it. |
| `RawRepresentation` | `object?` | The provider's own response object, when the provider exposes one. |

When you extract a single field, the response is an `AIExtractionResponse<TAnswer>`. It adds an `Answer` property that holds the one answer, typed to match the field.

## IAIExtractionService

`IAIExtractionService` is the primary interface for extracting values. It lives in the `Umbraco.AI.Core.Extraction` namespace. It has two groups of methods:

- `ExtractAsync` extracts one field and returns its typed answer.
- `GetExtractionResponseAsync` extracts multiple fields from the same state in a single model call.

{% code title="IAIExtractionService.cs" %}

```csharp
[Experimental("UMBRACOAI_EXTRACTION")]
public interface IAIExtractionService
{
    // One field, using the default Extraction profile
    Task<AIExtractionResponse<TAnswer>> ExtractAsync<TAnswer>(
        AIExtractionField<TAnswer> field,
        string? state = null,
        AIExtractionOptions? options = null,
        CancellationToken cancellationToken = default)
        where TAnswer : AIExtractionAnswer;

    // One field, using the profile with this ID
    Task<AIExtractionResponse<TAnswer>> ExtractAsync<TAnswer>(
        Guid profileId,
        AIExtractionField<TAnswer> field,
        string? state = null,
        AIExtractionOptions? options = null,
        CancellationToken cancellationToken = default)
        where TAnswer : AIExtractionAnswer;

    // One field, using the profile with this alias
    Task<AIExtractionResponse<TAnswer>> ExtractAsync<TAnswer>(
        string profileAlias,
        AIExtractionField<TAnswer> field,
        string? state = null,
        AIExtractionOptions? options = null,
        CancellationToken cancellationToken = default)
        where TAnswer : AIExtractionAnswer;

    // One field, configured with a builder
    Task<AIExtractionResponse<TAnswer>> ExtractAsync<TAnswer>(
        Action<AIExtractionBuilder> configure,
        AIExtractionField<TAnswer> field,
        string? state = null,
        CancellationToken cancellationToken = default)
        where TAnswer : AIExtractionAnswer;

    // Multiple fields in one call, using the default Extraction profile
    Task<AIExtractionResponse> GetExtractionResponseAsync(
        AIExtractionRequest request,
        AIExtractionOptions? options = null,
        CancellationToken cancellationToken = default);

    // GetExtractionResponseAsync also has profile ID, profile alias,
    // and builder overloads, matching the ExtractAsync overloads above.
}
```

{% endcode %}

The `state` parameter is optional in the signature, but the call fails without it. There is nothing to extract from.

## Basic Usage

The following example reads an order number out of a support email, using the default Extraction profile:

{% code title="OrderNumberReader.cs" %}

```csharp
#pragma warning disable UMBRACOAI_EXTRACTION

using Umbraco.AI.Core.Extraction;

namespace MyProject.Services;

public class OrderNumberReader
{
    private readonly IAIExtractionService _extractionService;

    public OrderNumberReader(IAIExtractionService extractionService)
    {
        _extractionService = extractionService;
    }

    public async Task<string?> GetOrderNumberAsync(string email, CancellationToken cancellationToken)
    {
        AIExtractionResponse<AITextExtractionAnswer> response = await _extractionService.ExtractAsync(
            new AITextExtractionField
            {
                Instructions = "The order number, for example A-12345"
            },
            email,
            cancellationToken: cancellationToken);

        return response.Answer.IsFound ? response.Answer.Value : null;
    }
}
```

{% endcode %}

## Extracting Multiple Fields at Once

Use `GetExtractionResponseAsync` to read multiple fields from the same text. All the fields are answered in a single model call, and the call is recorded as one usage entry. The fields can be of different kinds.

Give every field an `Id`. Each answer is returned in `Answers` under its field's `Id`. Cast it to the answer type that matches the field.

{% code title="TicketReader.cs" %}

```csharp
#pragma warning disable UMBRACOAI_EXTRACTION

using Umbraco.AI.Core.Extraction;

namespace MyProject.Services;

public class TicketReader
{
    private readonly IAIExtractionService _extractionService;

    public TicketReader(IAIExtractionService extractionService)
    {
        _extractionService = extractionService;
    }

    public async Task ReadAsync(string ticket, CancellationToken cancellationToken)
    {
        var request = new AIExtractionRequest
        {
            State = ticket,
            ReferenceDate = DateOnly.FromDateTime(DateTime.UtcNow),
            Fields =
            [
                new AITextExtractionField
                {
                    Id = "orderId",
                    Instructions = "The order number"
                },
                new AINumberExtractionField
                {
                    Id = "amount",
                    Instructions = "The amount the customer paid",
                    Unit = "DKK",
                    Decimals = 2
                },
                new AIDateExtractionField
                {
                    Id = "deliveredOn",
                    Instructions = "The date the order was delivered"
                },
                new AIListExtractionField
                {
                    Id = "damagedProducts",
                    Instructions = "Every product the customer says arrived damaged"
                }
            ]
        };

        AIExtractionResponse response = await _extractionService.GetExtractionResponseAsync(
            request,
            cancellationToken: cancellationToken);

        var orderId = (AITextExtractionAnswer)response.Answers["orderId"];
        var amount = (AINumberExtractionAnswer)response.Answers["amount"];
        var deliveredOn = (AIDateExtractionAnswer)response.Answers["deliveredOn"];
        var damaged = (AIListExtractionAnswer)response.Answers["damagedProducts"];

        if (amount.IsFound)
        {
            decimal paid = amount.Value!.Value;
        }

        IReadOnlyList<string> products = damaged.Values;
    }
}
```

{% endcode %}

Given a ticket such as "Order A-88412 arrived on 3 October. I paid 701,10 kr, but the mug and the teapot were broken.", with a reference date in 2026, the answers are `"A-88412"`, `701.1`, `2026-10-03`, and `["mug", "teapot"]`. The amount is written the Danish way in the text, and comes back as a `decimal`, whatever the server's culture.

## Choosing a Profile

When you do not name a profile, the service uses the default Extraction profile. Set it under the **AI** section > **Settings**, or with the `DefaultExtractionProfileAlias` fallback in [`AIOptions`](../../reference/configuration/ai-options.md).

To use a specific profile, pass its alias or ID:

{% code title="Profile selection" %}

```csharp
// Default Extraction profile
var byDefault = await _extractionService.ExtractAsync(field, text, cancellationToken: cancellationToken);

// Profile by alias
var byAlias = await _extractionService.ExtractAsync("support-extraction", field, text, cancellationToken: cancellationToken);

// Profile by ID
var byId = await _extractionService.ExtractAsync(profileId, field, text, cancellationToken: cancellationToken);
```

{% endcode %}

To override the profile's model for one call, pass `AIExtractionOptions`:

{% code title="Model override" %}

```csharp
var response = await _extractionService.ExtractAsync(
    "support-extraction",
    field,
    text,
    new AIExtractionOptions { ModelId = "@cf/cloudflare/clairic" },
    cancellationToken);
```

{% endcode %}

## AIExtractionBuilder

The builder overloads give you full control over auditing and telemetry. The other overloads call them for you. Both `ExtractAsync` and `GetExtractionResponseAsync` have a builder overload.

| Method | Description |
| --- | --- |
| `.WithAlias(string alias)` | Sets an alias for auditing and telemetry. **Required.** The same alias always produces the same inline extraction ID. |
| `.WithName(string name)` | Sets a display name. Defaults to the alias. |
| `.WithProfile(Guid profileId)` | Selects a profile by ID. Uses the default Extraction profile if omitted. |
| `.WithProfile(string profileAlias)` | Selects a profile by alias. |
| `.WithExtractionOptions(AIExtractionOptions options)` | Sets per-call options, such as a model override. |
| `.WithContextItems(IEnumerable<AIRequestContextItem> items)` | Attaches context items to the request. |
| `.AsPassThrough()` | Skips notifications and duration tracking when a parent feature already handles them. |

{% code title="Builder example" %}

```csharp
var response = await _extractionService.GetExtractionResponseAsync(
    extraction => extraction
        .WithAlias("support-ticket-intake")
        .WithProfile("support-extraction"),
    request,
    cancellationToken);
```

{% endcode %}

## Errors

The service checks the request before it contacts any provider. It also checks the provider's answers before it returns them.

| Exception | When |
| --- | --- |
| `ArgumentException` | The request is invalid. For example, the state is empty or there are no fields. A field `Id` is empty, invalid, or used twice. `Instructions` is empty, or `Decimals` is outside 0 to 6. |
| `InvalidOperationException` | The feature flag is off. Or no profile has the given ID or alias, the profile is not an Extraction profile, or no default Extraction profile is configured. Also thrown when a builder overload is called without `WithAlias`, or when a notification handler cancels the call. |
| `AIProviderException` | The provider call failed, for example because of an invalid API key or rate limiting. Also thrown when the provider's answers do not match the fields. For example, an answer is missing, is the wrong type, or has a confidence outside 0 to 1. The call is recorded as failed. |

## Setting Up Extraction

### 1. Enable the Feature Flag

See [Enabling Extraction](#enabling-extraction) above.

### 2. Install a Provider with Extraction Support

Currently, [Cloudflare](../../providers/cloudflare.md) is the only provider with Extraction support:

{% code title="Terminal" %}

```bash
dotnet add package Umbraco.AI.Cloudflare
```

{% endcode %}

### 3. Create a Connection and Profile

Create a Cloudflare connection in the backoffice. Then create a profile with the **Extraction** capability and the **Clairic** model. Extraction profiles have no extra settings.

### 4. Set the Default Extraction Profile

Go to the **AI** section > **Settings** and pick the profile under **Default Extraction Profile**. Calls that do not name a profile use it.

## Extraction in Umbraco Automate

With the Umbraco.AI.Automate add-on installed, the **Extract Values** action runs Extraction as a step in an automation, without code. Each extracted value becomes a step output that later steps can bind to. See [Extract Values](https://docs.umbraco.com/umbraco-automate/add-ons/ai/actions#extract-values).

## Related

- [Capabilities](../../concepts/capabilities.md) - Available capability types
- [Cloudflare Provider](../../providers/cloudflare.md) - Provider with Extraction support
- [Extraction Controller](../../frontend/extraction-controller.md) - Frontend API
- [Extraction Management API](../../management-api/extraction/README.md) - REST endpoint
- [Extraction Capability](../../extending/providers/extraction-capability.md) - Add Extraction to a custom provider
