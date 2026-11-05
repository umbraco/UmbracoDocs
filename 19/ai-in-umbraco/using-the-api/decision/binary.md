---
description: >-
    Ask a yes/no question with the experimental Decision API and read the probability of "yes".
---

# Yes/No Questions

{% hint style="warning" %}
Decision is experimental and disabled by default. See [Enabling Decision](README.md#enabling-decision).
{% endhint %}

Use `AIBinaryDecisionQuestion` to ask a question that has a yes or no answer. The answer is an `AIBinaryDecisionAnswer`, which holds the probability that the answer is "yes". You choose the threshold that counts as "yes".

## Question Properties

| Property | Type | Required | Description |
| --- | --- | --- | --- |
| `Instructions` | `string` | Yes | The yes/no question to decide. |
| `TrueCriteria` | `string?` | No | What counts as "yes", when the instructions alone are not enough. |
| `FalseCriteria` | `string?` | No | What counts as "no", when the instructions alone are not enough. |

Pass the content to judge as the `state` argument of `AskAsync`, or as the request's `State`. Questions also have an optional `Id`. See [Requests, Questions, and Answers](README.md#requests-questions-and-answers).

## Answer Properties

| Member | Type | Description |
| --- | --- | --- |
| `TrueProbability` | `double` | The model's estimated probability that the answer is "yes", from 0.0 to 1.0. |
| `IsTrue(double threshold = 0.5)` | `bool` | Returns `true` when `TrueProbability` is at least `threshold`. |

A binary answer has no separate confidence value. `TrueProbability` already tells you how sure the model is.

`AskAsync` returns an `AIDecisionResponse<AIBinaryDecisionAnswer>`. Read the answer from its `Answer` property. The response also has `ModelId` and `Usage`.

## Example

The following service flags comments for review. It spells out what "yes" and "no" mean. It uses a low threshold, so a person also reviews comments the model is unsure about:

{% code title="CommentModeration.cs" %}

```csharp
#pragma warning disable UMBRACOAI_DECISION

using Umbraco.AI.Core.Decision;

namespace MyProject.Services;

public class CommentModeration
{
    private readonly IAIDecisionService _decisionService;

    public CommentModeration(IAIDecisionService decisionService)
    {
        _decisionService = decisionService;
    }

    public async Task<bool> NeedsReviewAsync(string comment, CancellationToken cancellationToken)
    {
        var response = await _decisionService.AskAsync(
            decision => decision.WithAlias("comment-moderation"),
            new AIBinaryDecisionQuestion
            {
                Instructions = "Is this comment spam?",
                TrueCriteria = "Promotional, a scam, or unrelated links",
                FalseCriteria = "A genuine comment from a reader"
            },
            comment,
            cancellationToken);

        // Review anything with at least a 30% chance of being spam
        return response.Answer.IsTrue(0.3);
    }
}
```

{% endcode %}

Raise the threshold to act only on highly likely answers. For example, `response.Answer.IsTrue(0.9)` only treats highly likely spam as spam. Read `TrueProbability` directly when you need the number itself, such as for sorting or logging.

## Related

- [Decision](README.md) - Overview, enabling, and profile selection
- [Pick-One Questions](choice.md)
- [Score Questions](score.md)
