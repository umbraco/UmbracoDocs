---
description: >-
    Score content against labelled levels with the experimental Decision API.
---

# Score Questions

{% hint style="warning" %}
Decision is experimental and disabled by default. See [Enabling Decision](README.md#enabling-decision).
{% endhint %}

Use `AIScoreDecisionQuestion` to rate content against an ordered list of labelled levels. The answer is an `AIScoreDecisionAnswer`, which returns a score and a probability for each level.

## Question Properties

| Property | Type | Required | Description |
| --- | --- | --- | --- |
| `Instructions` | `string` | Yes | What to score. |
| `Levels` | `IReadOnlyList<AIDecisionScoreLevel>` | Yes | The levels, **lowest first**. Between 2 and 10 entries, none with an empty description. |

Each level is an `AIDecisionScoreLevel` with a `Description`:

{% code title="AIDecisionScoreLevel.cs" %}

```csharp
public sealed record AIDecisionScoreLevel(string Description);
```

{% endcode %}

A level is identified by its position in `Levels`, starting at 0 for the lowest level. Two levels can share the same description.

Pass the content to judge as the `state` argument of `AskAsync`, or as the request's `State`. Questions also have an optional `Id`. See [Requests, Questions, and Answers](README.md#requests-questions-and-answers).

## Answer Properties

| Property | Type | Description |
| --- | --- | --- |
| `Score` | `double` | Where the answer landed, as a 0-based index into `Levels`. The value can be fractional, such as `1.8`. |
| `Probabilities` | `IReadOnlyDictionary<int, double>` | The estimated probability for every level, keyed by its 0-based index into `Levels`. The probabilities add up to 1. |
| `Confidence` | `double?` | The provider's own confidence in `Score`, from 0.0 to 1.0. `null` when the provider does not report one. Values from different providers are not comparable. |

`AskAsync` returns an `AIDecisionResponse<AIScoreDecisionAnswer>`. Read the answer from its `Answer` property. The response also has `ModelId` and `Usage`.

The answer does not include a level label. To get one, round `Score` to the nearest index and look it up in `Levels`. With the levels `poor`, `ok`, and `good`, a `Score` of `1.8` sits between `ok` (1) and `good` (2). The nearest level is `good`.

## Example

The following service rates how readable a page summary is:

{% code title="ReadabilityRater.cs" %}

```csharp
#pragma warning disable UMBRACOAI_DECISION

using Umbraco.AI.Core.Decision;

namespace MyProject.Services;

public class ReadabilityRater
{
    private readonly IAIDecisionService _decisionService;

    public ReadabilityRater(IAIDecisionService decisionService)
    {
        _decisionService = decisionService;
    }

    public async Task<string> RateAsync(string summary, CancellationToken cancellationToken)
    {
        var question = new AIScoreDecisionQuestion
        {
            Instructions = "How easy is this summary to read for a general audience?",
            Levels =
            [
                new AIDecisionScoreLevel("poor"),
                new AIDecisionScoreLevel("ok"),
                new AIDecisionScoreLevel("good")
            ]
        };

        var response = await _decisionService.AskAsync(
            decision => decision.WithAlias("readability-rating"),
            question,
            summary,
            cancellationToken);

        // Round the score to the nearest level
        var nearest = Math.Clamp((int)Math.Round(response.Answer.Score), 0, question.Levels.Count - 1);

        return question.Levels[nearest].Description; // "poor", "ok", or "good"
    }
}
```

{% endcode %}

Use `Score` when you need a finer value than the label, such as for sorting or averaging. Use `Probabilities` to see how the model spread its answer across the levels. For example, `response.Answer.Probabilities[0]` is the probability of `poor`.

## Related

- [Decision](README.md) - Overview, enabling, and profile selection
- [Yes/No Questions](binary.md)
- [Pick-One Questions](choice.md)
