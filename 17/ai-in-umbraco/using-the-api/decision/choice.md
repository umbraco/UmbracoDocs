---
description: >-
    Ask the experimental Decision API to pick one of a fixed set of options and read the chosen key.
---

# Pick-One Questions

{% hint style="warning" %}
Decision is experimental and disabled by default. See [Enabling Decision](README.md#enabling-decision).
{% endhint %}

Use `AIChoiceDecisionQuestion` to have the model pick one option from a fixed list. The answer is an `AIChoiceDecisionAnswer`, which returns the key of the chosen option.

## Question Properties

| Property | Type | Required | Description |
| --- | --- | --- | --- |
| `Instructions` | `string` | Yes | What to decide. |
| `Options` | `IReadOnlyList<AIDecisionOption>` | Yes | The options to choose from. Between 2 and 255 entries. |

Each `AIDecisionOption` has a `Key` and an optional `Description`:

{% code title="AIDecisionOption.cs" %}

```csharp
public sealed record AIDecisionOption(string Key, string? Description = null);
```

{% endcode %}

- `Key` is the value returned when the option is chosen. Keys must be unique and not empty. Keys are compared case-sensitively.
- `Description` explains what the key means. Add one when the key alone is not clear, such as an ID.

Pass the content to judge as the `state` argument of `AskAsync`, or as the request's `State`. Questions also have an optional `Id`. See [Requests, Questions, and Answers](README.md#requests-questions-and-answers).

## Answer Properties

| Property | Type | Description |
| --- | --- | --- |
| `Choice` | `string` | The `Key` of the chosen option, exactly as you supplied it. |
| `Probabilities` | `IReadOnlyDictionary<string, double>` | The estimated probability for every option, keyed by option key. The probabilities add up to 1. |
| `Confidence` | `double?` | The provider's own confidence in `Choice`, from 0.0 to 1.0. `null` when the provider does not report one. Values from different providers are not comparable. |

`AskAsync` returns an `AIDecisionResponse<AIChoiceDecisionAnswer>`. Read the answer from its `Answer` property. The response also has `ModelId` and `Usage`.

## Example

The following service routes a support message to a team:

{% code title="SupportRouter.cs" %}

```csharp
#pragma warning disable UMBRACOAI_DECISION

using Umbraco.AI.Core.Decision;

namespace MyProject.Services;

public class SupportRouter
{
    private readonly IAIDecisionService _decisionService;

    public SupportRouter(IAIDecisionService decisionService)
    {
        _decisionService = decisionService;
    }

    public async Task<string> RouteAsync(string message, CancellationToken cancellationToken)
    {
        var response = await _decisionService.AskAsync(
            decision => decision.WithAlias("support-routing"),
            new AIChoiceDecisionQuestion
            {
                Instructions = "Which team should handle this message?",
                Options =
                [
                    new AIDecisionOption("billing", "Invoices, payments, and refunds"),
                    new AIDecisionOption("technical", "Errors, bugs, and how-to questions"),
                    new AIDecisionOption("sales", "Pricing and new purchases")
                ]
            },
            message,
            cancellationToken);

        return response.Answer.Choice; // "billing", "technical", or "sales"
    }
}
```

{% endcode %}

## Related

- [Decision](README.md) - Overview, enabling, and profile selection
- [Yes/No Questions](binary.md)
- [Score Questions](score.md)
