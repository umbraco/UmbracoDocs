---
description: >-
    Ask typed yes/no, pick-one, and score questions using the experimental Decision API.
---

# Decision

{% hint style="warning" %}
Decision is **experimental**. The API surface may change between releases. It is disabled by default. See [Enabling Decision](#enabling-decision) below.
{% endhint %}

The Decision API asks a model typed questions about a piece of content and returns typed answers. You do not prompt a chat model and parse its text. Instead, you describe what to decide and get back the probability of "yes", the key of one option, or a score. Pick-one and score answers also include a probability for every option or level.

Use Decision for classification-shaped tasks, such as:

- Checking whether a comment is spam
- Routing a request to the right team or agent
- Rating the quality or tone of a piece of content

Decision is not built on a Microsoft.Extensions.AI abstraction, because none exists for this kind of model. Umbraco AI defines its own `IAIDecisionClient` and adds profiles, connections, notifications, telemetry, and usage tracking on top.

## Enabling Decision

Decision is gated behind a feature flag. Until you enable it:

- The capability is hidden from discovery and is **not selectable** in the profile editor.
- Profiles using the capability cannot be created.
- The **Default Decision Profile** setting is hidden.
- Providers that only support Decision, such as [TypeSafe AI](../../providers/typesafe.md), are not listed.
- The Management API endpoint returns **404**.

Enable the flag in `appsettings.json`:

{% code title="appsettings.json" %}

```json
{
    "Umbraco": {
        "AI": {
            "Experimental": {
                "Decision": true
            }
        }
    }
}
```

{% endcode %}

Restart the site after changing the flag.

The C# API surface is marked with `[Experimental("UMBRACOAI_DECISION")]`. The compiler reports an error when you use it until you suppress the `UMBRACOAI_DECISION` diagnostic. Suppress it in each file that calls the API:

{% code title="C#" %}

```csharp
#pragma warning disable UMBRACOAI_DECISION
```

{% endcode %}

The diagnostic and the feature flag are independent. The diagnostic only lets your code compile against the API. The flag controls whether the capability is available at runtime.

## Requests, Questions, and Answers

A Decision call is made up of:

- **State**: the content being judged, such as a comment or a page body. It is optional, and it is shared by every question in the call.
- **Questions**: one or more typed questions about the state.
- **Answers**: one typed answer per question, plus the model and token usage for the whole call.

Each kind of question is its own class. The class you ask decides the answer type you get back, so you never need to cast when you ask a single question.

| Question | Answer | Answers with | Guide |
| --- | --- | --- | --- |
| `AIBinaryDecisionQuestion` | `AIBinaryDecisionAnswer` | The probability that the answer is "yes" | [Yes/No Questions](binary.md) |
| `AIChoiceDecisionQuestion` | `AIChoiceDecisionAnswer` | The key of one of 2 to 255 options | [Pick-One Questions](choice.md) |
| `AIScoreDecisionQuestion` | `AIScoreDecisionAnswer` | A score against 2 to 10 labelled levels | [Score Questions](score.md) |

Every question has these common properties:

| Property | Type | Required | Description |
| --- | --- | --- | --- |
| `Instructions` | `string` | Yes | What to decide. Must not be empty. |
| `Id` | `string?` | See description | Identifies the question, and keys its answer in the response. Required and unique within the request when you ask multiple questions. Optional when you ask one question with `AskAsync`, which assigns an ID for you. |

The response has these properties:

| Property | Type | Description |
| --- | --- | --- |
| `Answers` | `IReadOnlyDictionary<string, AIDecisionAnswer>` | One answer per question, keyed by question `Id`. |
| `ModelId` | `string?` | The model that produced the answers, when known. |
| `Usage` | `UsageDetails?` | Token usage for the whole call, when the provider reports it. |
| `RawRepresentation` | `object?` | The provider's own response object, when the provider exposes one. |

When you ask a single question, the response is an `AIDecisionResponse<TAnswer>`. It adds an `Answer` property that holds the one answer, typed to match the question.

## IAIDecisionService

`IAIDecisionService` is the primary interface for asking questions. It lives in the `Umbraco.AI.Core.Decision` namespace. It has two groups of methods:

- `AskAsync` asks one question and returns its typed answer.
- `GetDecisionResponseAsync` asks multiple questions about the same state in a single model call.

{% code title="IAIDecisionService.cs" %}

```csharp
[Experimental("UMBRACOAI_DECISION")]
public interface IAIDecisionService
{
    // One question, using the default Decision profile
    Task<AIDecisionResponse<TAnswer>> AskAsync<TAnswer>(
        AIDecisionQuestion<TAnswer> question,
        string? state = null,
        AIDecisionOptions? options = null,
        CancellationToken cancellationToken = default)
        where TAnswer : AIDecisionAnswer;

    // One question, using the profile with this ID
    Task<AIDecisionResponse<TAnswer>> AskAsync<TAnswer>(
        Guid profileId,
        AIDecisionQuestion<TAnswer> question,
        string? state = null,
        AIDecisionOptions? options = null,
        CancellationToken cancellationToken = default)
        where TAnswer : AIDecisionAnswer;

    // One question, using the profile with this alias
    Task<AIDecisionResponse<TAnswer>> AskAsync<TAnswer>(
        string profileAlias,
        AIDecisionQuestion<TAnswer> question,
        string? state = null,
        AIDecisionOptions? options = null,
        CancellationToken cancellationToken = default)
        where TAnswer : AIDecisionAnswer;

    // One question, configured with a builder
    Task<AIDecisionResponse<TAnswer>> AskAsync<TAnswer>(
        Action<AIDecisionBuilder> configure,
        AIDecisionQuestion<TAnswer> question,
        string? state = null,
        CancellationToken cancellationToken = default)
        where TAnswer : AIDecisionAnswer;

    // Multiple questions in one call, using the default Decision profile
    Task<AIDecisionResponse> GetDecisionResponseAsync(
        AIDecisionRequest request,
        AIDecisionOptions? options = null,
        CancellationToken cancellationToken = default);

    // GetDecisionResponseAsync also has profile ID, profile alias,
    // and builder overloads, matching the AskAsync overloads above.
}
```

{% endcode %}

## Basic Usage

The following example checks whether a comment is spam, using the default Decision profile. The comment is passed as the state:

{% code title="SpamChecker.cs" %}

```csharp
#pragma warning disable UMBRACOAI_DECISION

using Umbraco.AI.Core.Decision;

namespace MyProject.Services;

public class SpamChecker
{
    private readonly IAIDecisionService _decisionService;

    public SpamChecker(IAIDecisionService decisionService)
    {
        _decisionService = decisionService;
    }

    public async Task<bool> IsSpamAsync(string comment, CancellationToken cancellationToken)
    {
        AIDecisionResponse<AIBinaryDecisionAnswer> response = await _decisionService.AskAsync(
            new AIBinaryDecisionQuestion
            {
                Instructions = "Is this comment spam?"
            },
            comment,
            cancellationToken: cancellationToken);

        return response.Answer.IsTrue();
    }
}
```

{% endcode %}

`IsTrue()` uses a threshold of 0.5 by default. Pass your own threshold, such as `IsTrue(0.9)`, to only treat highly likely answers as "yes".

## Asking Multiple Questions at Once

Use `GetDecisionResponseAsync` to ask multiple questions about the same state. All the questions are answered in a single model call, and the call is recorded as one usage entry. The questions can be of different kinds.

Give every question an `Id`. IDs must not be empty, and must be unique within the request. Each answer is returned in `Answers` under its question's `Id`. Cast it to the answer type that matches the question.

{% code title="CommentTriage.cs" %}

```csharp
#pragma warning disable UMBRACOAI_DECISION

using Umbraco.AI.Core.Decision;

namespace MyProject.Services;

public class CommentTriage
{
    private readonly IAIDecisionService _decisionService;

    public CommentTriage(IAIDecisionService decisionService)
    {
        _decisionService = decisionService;
    }

    public async Task TriageAsync(string comment, CancellationToken cancellationToken)
    {
        var request = new AIDecisionRequest
        {
            State = comment,
            Questions =
            [
                new AIBinaryDecisionQuestion
                {
                    Id = "spam",
                    Instructions = "Is this comment spam?"
                },
                new AIChoiceDecisionQuestion
                {
                    Id = "topic",
                    Instructions = "What is this comment about?",
                    Options =
                    [
                        new AIDecisionOption("product", "The product itself"),
                        new AIDecisionOption("delivery", "Shipping and delivery"),
                        new AIDecisionOption("other")
                    ]
                },
                new AIScoreDecisionQuestion
                {
                    Id = "tone",
                    Instructions = "How positive is the tone of this comment?",
                    Levels =
                    [
                        new AIDecisionScoreLevel("negative"),
                        new AIDecisionScoreLevel("neutral"),
                        new AIDecisionScoreLevel("positive")
                    ]
                }
            ]
        };

        AIDecisionResponse response = await _decisionService.GetDecisionResponseAsync(
            request,
            cancellationToken: cancellationToken);

        var spam = (AIBinaryDecisionAnswer)response.Answers["spam"];
        var topic = (AIChoiceDecisionAnswer)response.Answers["topic"];
        var tone = (AIScoreDecisionAnswer)response.Answers["tone"];

        bool isSpam = spam.IsTrue();
        string topicKey = topic.Choice;
        double toneScore = tone.Score;
    }
}
```

{% endcode %}

Batched questions are available from C# only. The [Management API](../../management-api/decision/README.md) and the [Decision Controller](../../frontend/decision-controller.md) ask one question per call. In Umbraco Automate, the **Ask Questions** action asks multiple questions in one call.

## Choosing a Profile

When you do not name a profile, the service uses the default Decision profile. Set it under the **AI** section > **Settings**, or with the `DefaultDecisionProfileAlias` fallback in [`AIOptions`](../../reference/configuration/ai-options.md).

To use a specific profile, pass its alias or ID:

{% code title="ProfileSelection.cs" %}

```csharp
#pragma warning disable UMBRACOAI_DECISION

using Umbraco.AI.Core.Decision;

namespace MyProject.Services;

public class ProfileSelection
{
    private readonly IAIDecisionService _decisionService;

    public ProfileSelection(IAIDecisionService decisionService)
    {
        _decisionService = decisionService;
    }

    public async Task AskAsync(Guid profileId, CancellationToken cancellationToken)
    {
        var question = new AIBinaryDecisionQuestion
        {
            Instructions = "Does this text contain a phone number?"
        };
        var text = "Call us on 12 34 56 78.";

        // Default Decision profile
        var byDefault = await _decisionService.AskAsync(question, text, cancellationToken: cancellationToken);

        // Profile by alias
        var byAlias = await _decisionService.AskAsync("moderation", question, text, cancellationToken: cancellationToken);

        // Profile by ID
        var byId = await _decisionService.AskAsync(profileId, question, text, cancellationToken: cancellationToken);
    }
}
```

{% endcode %}

To override the profile's model for one call, pass `AIDecisionOptions`:

{% code title="Model override" %}

```csharp
var response = await _decisionService.AskAsync(
    "moderation",
    question,
    text,
    new AIDecisionOptions { ModelId = "jev-latest" },
    cancellationToken);
```

{% endcode %}

## AIDecisionBuilder

The builder overloads give you full control over auditing and telemetry. The other overloads call them for you. Both `AskAsync` and `GetDecisionResponseAsync` have a builder overload.

| Method | Description |
| --- | --- |
| `.WithAlias(string alias)` | Sets an alias for auditing and telemetry. **Required.** The same alias always produces the same inline decision ID. |
| `.WithName(string name)` | Sets a display name. Defaults to the alias. |
| `.WithProfile(Guid profileId)` | Selects a profile by ID. Uses the default Decision profile if omitted. |
| `.WithProfile(string profileAlias)` | Selects a profile by alias. |
| `.WithDecisionOptions(AIDecisionOptions options)` | Sets per-call options, such as a model override. |
| `.WithContextItems(IEnumerable<AIRequestContextItem> items)` | Attaches context items to the request. |
| `.AsPassThrough()` | Skips notifications and duration tracking when a parent feature already handles them. |

{% code title="Builder example" %}

```csharp
var response = await _decisionService.AskAsync(
    decision => decision
        .WithAlias("comment-moderation")
        .WithProfile("moderation"),
    new AIBinaryDecisionQuestion
    {
        Instructions = "Is this comment spam?"
    },
    comment,
    cancellationToken);
```

{% endcode %}

## Errors

The service checks the request before it contacts any provider. It also checks the provider's answers before it returns them.

| Exception | When |
| --- | --- |
| `ArgumentException` | The request is invalid. For example, it has no questions, or a question `Id` is empty or used twice. Also thrown when `Instructions` is empty, or there are too few or too many options or levels. |
| `InvalidOperationException` | No profile has the given ID, the profile is not a Decision profile, or no default Decision profile is configured. Also thrown when the builder has no alias, or a notification handler cancels the call. |
| `AIProviderException` | The provider call failed, for example because of an invalid API key or rate limiting. Also thrown when the provider's answers do not match the questions. For example, an answer is missing, or the probabilities do not add up to 1. The call is recorded as failed. |

## Setting Up Decision

### 1. Enable the Feature Flag

See [Enabling Decision](#enabling-decision) above.

### 2. Install a Provider with Decision Support

Currently, [TypeSafe AI](../../providers/typesafe.md) is the only provider with Decision support:

{% code title="Terminal" %}

```bash
dotnet add package Umbraco.AI.TypeSafe
```

{% endcode %}

### 3. Create a Connection and Profile

Create a TypeSafe AI connection in the backoffice. Then create a profile with the **Decision** capability and the `jev-latest` model. Decision profiles have no extra settings.

### 4. Set the Default Decision Profile

Go to the **AI** section > **Settings** and pick the profile under **Default Decision Profile**. Calls that do not name a profile use it.

## Decision in Guardrails and Tests

Once Decision is enabled, you can also use it without writing code:

- The **Decision Safety Judge** guardrail evaluator flags content that a Decision profile judges unsafe. See [Decision Safety Judge Evaluator](../../backoffice/managing-guardrails.md#decision-safety-judge-evaluator).
- The **Decision Judge** test grader passes test output that a Decision profile judges to meet your criteria. See [decision-judge](../../testing-and-evaluation/graders.md#decision-judge).

Both are only listed while the feature flag is on. They do not fall back to the LLM judges. If Decision is unavailable, they fail safe with a reason.

## In This Section

{% content-ref url="binary.md" %}
[Yes/No Questions](binary.md)
{% endcontent-ref %}

{% content-ref url="choice.md" %}
[Pick-One Questions](choice.md)
{% endcontent-ref %}

{% content-ref url="score.md" %}
[Score Questions](score.md)
{% endcontent-ref %}

## Related

- [Capabilities](../../concepts/capabilities.md) - Available capability types
- [TypeSafe AI Provider](../../providers/typesafe.md) - Provider with Decision support
- [Decision Controller](../../frontend/decision-controller.md) - Frontend API
- [Decision Management API](../../management-api/decision/README.md) - REST endpoint
- [Decision Capability](../../extending/providers/decision-capability.md) - Add Decision to a custom provider
- [Managing Guardrails](../../backoffice/managing-guardrails.md) - Decision Safety Judge evaluator
- [Graders](../../testing-and-evaluation/graders.md) - Decision Judge test grader
