---
description: >-
    Guardrails evaluate and filter AI inputs and responses for safety, compliance, and quality enforcement.
---

# Guardrails

A guardrail is a collection of rules that evaluate AI content at runtime to prevent unsafe, non-compliant, or low-quality responses. Guardrails run in the **pre-generate** phase for input filtering and the **post-generate** phase for response validation. Together, these phases provide comprehensive control over what goes into and comes out of AI operations.

## What Guardrails Store

| Property  | Description                                  |
| --------- | -------------------------------------------- |
| `Id`      | Unique identifier (GUID)                     |
| `Alias`   | Unique string for programmatic lookup        |
| `Name`    | Display name shown in the backoffice         |
| `Rules`   | Ordered collection of evaluation rules       |
| `Version` | Current version number (for version history) |

## Guardrail Rules

Each guardrail contains one or more rules. A rule references a registered evaluator and specifies when and how it is applied.

| Property      | Description                                          |
| ------------- | ---------------------------------------------------- |
| `Id`          | Unique identifier (GUID)                             |
| `EvaluatorId` | The registered evaluator to use (e.g., "contains")    |
| `Name`        | Display name for the rule                            |
| `Phase`       | When the rule runs: `PreGenerate` or `PostGenerate`  |
| `Action`      | What happens when flagged: `Block`, `Warn`, or `Redact` |
| `Config`      | Evaluator-specific configuration (JSON)              |
| `SortOrder`   | Controls evaluation order within the guardrail       |

### Phases

Rules specify when they run in the AI pipeline:

| Phase          | Description                                                      |
| -------------- | ---------------------------------------------------------------- |
| `PreGenerate`  | Evaluated before the request is sent to the AI provider.          |
| `PostGenerate` | Evaluated after the AI provider returns a response.               |

### Actions

Rules specify what happens when content is flagged:

| Action   | Description                                                                       |
| -------- | --------------------------------------------------------------------------------- |
| `Block`  | Stop processing and throw `AIGuardrailBlockedException`.                           |
| `Warn`   | Allow the content through unchanged and log a warning.                             |
| `Redact` | Replace flagged content with `[REDACTED]` before it reaches the AI model or caller. |

## Example Guardrail Configurations

| Guardrail            | Use Case                | Rules                                     |
| -------------------- | ----------------------- | ----------------------------------------- |
| `content-safety`     | General safety          | Contains for competitor brands (Block), Regex for SSNs (Block) |
| `brand-compliance`   | Brand voice enforcement | LLM Safety Judge with brand criteria (Warn)      |
| `data-protection`    | Data protection         | Regex for emails pre-generate (Redact), Regex for phone numbers post (Redact) |
| `quality-assurance`  | Output quality          | LLM Safety Judge for accuracy (Warn)             |

## Built-in Evaluators

Umbraco.AI ships with three evaluators:

| Evaluator        | ID          | Type       | Redact | Description                                                       |
| ---------------- | ----------- | ---------- | ------ | ----------------------------------------------------------------- |
| Contains         | `contains`  | Code-based | Yes    | Flags content containing a specific substring. Config: `SearchPattern`, `IgnoreCase` |
| Regex Match      | `regex`     | Code-based | Yes    | Flags content matching a regular expression pattern. Config: `Pattern`, `IgnoreCase`, `Multiline` |
| LLM Safety Judge | `llm-judge` | Model-based| No     | Uses an AI model to evaluate content against configurable criteria. Config: `ProfileId`, `EvaluationCriteria`, `SafetyThreshold` |

### Evaluator Types

| Type         | Description                                                                    |
| ------------ | ------------------------------------------------------------------------------ |
| `CodeBased`  | Deterministic evaluation using patterns and rules. Fast, runs during streaming |
| `ModelBased` | Uses an AI model for evaluation. More nuanced, runs after stream completes     |

## Using Guardrails in Code

### Getting a Guardrail

{% code title="Example.cs" %}

```csharp
public class GuardrailExample
{
    private readonly IAIGuardrailService _guardrailService;

    public GuardrailExample(IAIGuardrailService guardrailService)
    {
        _guardrailService = guardrailService;
    }

    public async Task<AIGuardrail?> GetSafetyGuardrail()
    {
        return await _guardrailService.GetGuardrailByAliasAsync("content-safety");
    }
}
```

{% endcode %}

### Creating a Guardrail

This example creates a guardrail that combines a Block rule for competitor brand mentions with a Redact rule for email addresses:

{% code title="Example.cs" %}

```csharp
public async Task<AIGuardrail> CreateGuardrail()
{
    var guardrail = new AIGuardrail
    {
        Alias = "content-safety",
        Name = "Content Safety Policy",
        Rules =
        [
            new AIGuardrailRule
            {
                EvaluatorId = "contains",
                Name = "Block competitor brand mentions",
                Phase = AIGuardrailPhase.PostGenerate,
                Action = AIGuardrailAction.Block,
                Config = JsonSerializer.SerializeToElement(new { searchPattern = "CompetitorBrand", ignoreCase = true }),
                SortOrder = 0
            },
            new AIGuardrailRule
            {
                EvaluatorId = "regex",
                Name = "Redact emails in inputs",
                Phase = AIGuardrailPhase.PreGenerate,
                Action = AIGuardrailAction.Redact,
                Config = JsonSerializer.SerializeToElement(new { pattern = @"[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}", ignoreCase = true }),
                SortOrder = 1
            }
        ]
    };

    return await _guardrailService.SaveGuardrailAsync(guardrail);
}
```

{% endcode %}

{% hint style="info" %}
The Redact action is only available for evaluators that support it (code-based evaluators like Contains and Regex Match). Model-based evaluators such as LLM Safety Judge cannot identify specific text positions, so Redact rules using them degrade to Warn at runtime.
{% endhint %}

### Assigning Guardrails to a Profile

Guardrails are assigned to chat profiles via `GuardrailIds` in `AIChatProfileSettings`:

{% code title="Example.cs" %}

```csharp
var profile = new AIProfile
{
    Alias = "safe-chat",
    Name = "Safe Chat Profile",
    Capability = AICapability.Chat,
    ConnectionId = connectionId,
    Settings = new AIChatProfileSettings
    {
        GuardrailIds = [guardrailId]
    }
};

await _profileService.SaveProfileAsync(profile);
```

{% endcode %}

## How Guardrail Evaluation Works

When an AI operation executes, the guardrail middleware resolves all applicable guardrails and runs **pre-generate** rules against the input before it reaches the AI provider, then runs **post-generate** rules against the response. Rules flagged with `Block` throw an `AIGuardrailBlockedException`, rules with `Redact` replace matched text with `[REDACTED]`, and rules with `Warn` allow content through and log a warning. Action precedence when multiple rules flag the same content: **Block > Redact > Warn**.

### Streaming Behavior

During streaming responses:

- **Code-based** evaluators (Contains, Regex Match) hold back a trailing window of the response (100 characters) instead of releasing text to the caller the instant it arrives. Every time new text is generated, the whole held-back window is re-checked, so a pattern split across two provider chunks is still caught before any of it is released.
  - **Block** throws before any of the held-back text is released, so flagged content never reaches the caller.
  - **Redact** replaces matches with `[REDACTED]` inside the held-back window before it's released, so it works during streaming the same way it does for a non-streamed response.
  - A match longer than the 100-character window can still leak partially — this is an inherent limit of scanning a live stream rather than a completed response, not something a rule's `Action` controls.
- **Model-based** evaluators (LLM Safety Judge) still run only after the stream completes, on the full aggregated response. A **Block** or **Redact** action on a model-based post-generate rule cannot prevent already-streamed content from reaching the caller — it can only fail the request after the fact. If you need a guarantee for streaming responses, use a code-based evaluator for that rule.
- **Pre-generate Redact** rules work normally during streaming (redaction happens before the stream starts).

{% hint style="warning" %}
Holding back text for code-based evaluation adds a small, variable delay to streaming responses that have a post-generate code-based rule configured — a chat profile with no guardrails, or only pre-generate rules, or only model-based post-generate rules, streams exactly as fast as before. For a fast-streaming model this delay is generally imperceptible (a few hundred milliseconds); for a slow model it can be closer to a second. It's most noticeable in two situations: a short pause before the very first characters of the response appear, and a response shorter than the 100-character window, which arrives as a single chunk instead of streaming token-by-token. This is a deliberate trade-off — the alternative is a guardrail that silently has no effect on streamed responses.
{% endhint %}

### Handling Blocked Content

{% code title="Example.cs" %}

```csharp
try
{
    var response = await chatService.GetChatResponseAsync(
        chat => chat.WithAlias("guardrail-example").WithProfile(profileAlias),
        messages);
}
catch (AIGuardrailBlockedException ex)
{
    // ex.Message contains a human-readable explanation
    // ex.EvaluationResult contains detailed evaluator results
    var results = ex.EvaluationResult.Results;
    foreach (var result in results.Where(r => r.Flagged))
    {
        Console.WriteLine($"Evaluator: {result.EvaluatorId}, Reason: {result.Reason}");
    }
}
```

{% endcode %}

## Managing Guardrails

You can create, edit, and delete guardrails through the backoffice. See [Managing Guardrails](../backoffice/managing-guardrails.md) for step-by-step instructions. For programmatic management, see the [IAIGuardrailService](../reference/services/ai-guardrail-service.md) reference.

## Version History

Guardrails support version history. Every time you save a guardrail, a new version is created. You can:

- View the version history.
- Compare different versions.
- Roll back to a previous version.

See [Version History](versioning.md) for more information.

## Related

- [Profiles](profiles.md) - Assign guardrails to chat profiles
- [Managing Guardrails](../backoffice/managing-guardrails.md) - Backoffice guide
