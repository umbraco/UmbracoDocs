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
| `PreGenerate`  | Evaluated before the request is sent to the AI provider          |
| `PostGenerate` | Evaluated after the AI provider returns a response               |

### Actions

Rules specify what happens when content is flagged:

| Action   | Description                                                                       |
| -------- | --------------------------------------------------------------------------------- |
| `Block`  | Stop processing and throw `AIGuardrailBlockedException`                           |
| `Warn`   | Allow the content through unchanged and log a warning                             |
| `Redact` | Replace flagged content with `[REDACTED]` before it reaches the AI model or caller |

## Why Use Guardrails

Guardrails provide these benefits:

- **Safety** - Prevent harmful or inappropriate content from reaching users
- **Compliance** - Enforce data protection by detecting sensitive patterns in inputs and outputs
- **Quality** - Use LLM-as-judge evaluation to ensure responses meet brand standards
- **Flexibility** - Combine multiple evaluators with different phases and actions
- **Reusability** - Assign the same guardrail to multiple profiles, prompts, and agents

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
                Name = "Block SSNs in responses",
                Phase = AIGuardrailPhase.PostGenerate,
                Action = AIGuardrailAction.Block,
                Config = JsonSerializer.SerializeToElement(new { pattern = @"\b\d{3}-\d{2}-\d{4}\b", ignoreCase = false }),
                SortOrder = 1
            }
        ]
    };

    return await _guardrailService.SaveGuardrailAsync(guardrail);
}
```

{% endcode %}

### Creating a Guardrail with Redaction

{% code title="Example.cs" %}

```csharp
public async Task<AIGuardrail> CreateRedactionGuardrail()
{
    var guardrail = new AIGuardrail
    {
        Alias = "email-redaction",
        Name = "Email Redaction Policy",
        Rules =
        [
            new AIGuardrailRule
            {
                EvaluatorId = "regex",
                Name = "Redact emails in inputs",
                Phase = AIGuardrailPhase.PreGenerate,
                Action = AIGuardrailAction.Redact,
                Config = JsonSerializer.SerializeToElement(new { pattern = @"[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}", ignoreCase = true }),
                SortOrder = 0
            },
            new AIGuardrailRule
            {
                EvaluatorId = "regex",
                Name = "Redact emails in responses",
                Phase = AIGuardrailPhase.PostGenerate,
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

When an AI operation executes with guardrails:

1. The guardrail middleware resolves all applicable guardrails
2. **Pre-generate** rules evaluate the input messages before sending to the AI provider
3. If any pre-generate rule with `Block` action flags content, an `AIGuardrailBlockedException` is thrown
4. If any pre-generate rule with `Redact` action flags content, matched text is replaced with `[REDACTED]` in the user message before sending to the AI provider
5. The request proceeds to the AI provider
6. **Post-generate** rules evaluate the response
7. If any post-generate rule with `Block` action flags content, an `AIGuardrailBlockedException` is thrown
8. If any post-generate rule with `Redact` action flags content, matched text is replaced with `[REDACTED]` in the response
9. Rules with `Warn` action allow content through unchanged (a warning is logged)

Action precedence when multiple rules flag the same content: **Block > Redact > Warn**.

### Streaming Behavior

During streaming responses:

- **Code-based** evaluators run on chunks as they arrive, using a sliding buffer to catch patterns split across chunk boundaries
- **Model-based** evaluators run after the stream completes on the full aggregated response
- If a code-based evaluator flags content during streaming, the stream is stopped immediately
- **Pre-generate Redact** rules work normally during streaming (redaction happens before the stream starts)
- **Post-generate Redact** rules degrade to Warn during streaming, because chunks have already been yielded to the caller and cannot be retroactively modified

### Handling Blocked Content

{% code title="Example.cs" %}

```csharp
try
{
    var response = await chatService.GetChatResponseAsync(profileAlias, messages);
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

## Guardrail Resolution

Guardrails are resolved automatically based on where they are assigned:

1. **Profile guardrails** - From `AIChatProfileSettings.GuardrailIds`
2. **Prompt guardrails** - From `AIPrompt.GuardrailIds` (Prompt add-on)
3. **Agent guardrails** - From `AIAgent.GuardrailIds` (Agent add-on)

The resolution system aggregates guardrails from all sources and deduplicates by guardrail ID.

## Managing Guardrails

### Via Backoffice

You can create, edit, and delete guardrails through the backoffice. See [Managing Guardrails](../backoffice/managing-guardrails.md) for step-by-step instructions.

### Via Code

{% code title="Example.cs" %}

```csharp
public class GuardrailManagement
{
    private readonly IAIGuardrailService _guardrailService;

    public GuardrailManagement(IAIGuardrailService guardrailService)
    {
        _guardrailService = guardrailService;
    }

    public async Task<IEnumerable<AIGuardrail>> GetAllGuardrails()
    {
        return await _guardrailService.GetGuardrailsAsync();
    }

    public async Task DeleteGuardrail(Guid id)
    {
        await _guardrailService.DeleteGuardrailAsync(id);
    }
}
```

{% endcode %}

## Version History

Guardrails support version history. Every time you save a guardrail, a new version is created. You can:

- View the version history
- Compare different versions
- Roll back to a previous version

See [Version History](versioning.md) for more information.

## Related

- [Profiles](profiles.md) - Assign guardrails to chat profiles
- [Prompts](../add-ons/prompt/concepts.md) - Assign guardrails to prompts
- [Agents](../add-ons/agent/concepts.md) - Assign guardrails to agents
- [Middleware](middleware.md) - How guardrails integrate into the pipeline
- [Version History](versioning.md) - Track guardrail changes over time
- [Managing Guardrails](../backoffice/managing-guardrails.md) - Backoffice guide
