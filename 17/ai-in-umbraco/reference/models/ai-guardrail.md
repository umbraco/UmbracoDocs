---
description: >-
    Model representing an AI guardrail with evaluation rules.
---

# AIGuardrail

Represents a collection of rules that evaluate AI inputs and responses for safety, compliance, and quality enforcement.

## Namespace

```csharp
using Umbraco.AI.Core.Guardrails;
```

## Definition

{% code title="AIGuardrail" %}

```csharp
public sealed class AIGuardrail : IAIVersionableEntity
{
    public Guid Id { get; internal set; }
    public required string Alias { get; set; }
    public required string Name { get; set; }
    public IList<AIGuardrailRule> Rules { get; set; } = [];

    // Audit properties
    public DateTime DateCreated { get; init; } = DateTime.UtcNow;
    public DateTime DateModified { get; set; } = DateTime.UtcNow;
    public Guid? CreatedByUserId { get; set; }
    public Guid? ModifiedByUserId { get; set; }

    // Versioning
    public int Version { get; internal set; } = 1;
}
```

{% endcode %}

## Properties

| Property           | Type                     | Description                                     |
| ------------------ | ------------------------ | ----------------------------------------------- |
| `Id`               | `Guid`                   | Unique identifier (auto-generated)              |
| `Alias`            | `string`                 | Unique alias for programmatic lookup (required)  |
| `Name`             | `string`                 | Display name (required)                          |
| `Rules`            | `IList<AIGuardrailRule>` | Ordered collection of evaluation rules           |
| `DateCreated`      | `DateTime`               | When created (UTC)                               |
| `DateModified`     | `DateTime`               | When last modified (UTC)                         |
| `CreatedByUserId`  | `Guid?`                  | User who created                                 |
| `ModifiedByUserId` | `Guid?`                  | User who last modified                           |
| `Version`          | `int`                    | Current version number                           |

## Example

{% code title="Example" %}

```csharp
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
            Name = "Redact email addresses",
            Phase = AIGuardrailPhase.PreGenerate,
            Action = AIGuardrailAction.Redact,
            Config = JsonSerializer.SerializeToElement(new { pattern = @"[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}", ignoreCase = true }),
            SortOrder = 1
        },
        new AIGuardrailRule
        {
            EvaluatorId = "llm-judge",
            Name = "Quality check",
            Phase = AIGuardrailPhase.PostGenerate,
            Action = AIGuardrailAction.Warn,
            Config = JsonSerializer.SerializeToElement(new { evaluationCriteria = "Check brand compliance", safetyThreshold = 0.7 }),
            SortOrder = 2
        }
    ]
};
```

{% endcode %}

## Related

- [AIGuardrailRule](#aiguardrailrule) - Rule model
- [IAIGuardrailService](../services/ai-guardrail-service.md) - Guardrail service

---

## AIGuardrailRule

Represents a single evaluation rule within a guardrail.

## Definition

{% code title="AIGuardrailRule" %}

```csharp
public sealed class AIGuardrailRule
{
    public Guid Id { get; internal set; }
    public required string EvaluatorId { get; init; }
    public required string Name { get; set; }
    public AIGuardrailPhase Phase { get; set; } = AIGuardrailPhase.PostGenerate;
    public AIGuardrailAction Action { get; set; } = AIGuardrailAction.Block;
    public JsonElement? Config { get; set; }
    public string? GuardrailName { get; set; }
    public int SortOrder { get; set; }
}
```

{% endcode %}

## Properties

| Property      | Type                | Description                                            |
| ------------- | ------------------- | ------------------------------------------------------ |
| `Id`          | `Guid`              | Unique identifier (auto-generated)                     |
| `EvaluatorId` | `string`            | Registered evaluator ID (required, immutable)          |
| `Name`        | `string`            | Display name (required)                                |
| `Phase`       | `AIGuardrailPhase`  | When to evaluate (default: PostGenerate)               |
| `Action`      | `AIGuardrailAction` | What to do when flagged: Block, Warn, or Redact (default: Block) |
| `Config`      | `JsonElement?`      | Evaluator-specific configuration                       |
| `GuardrailName` | `string?`         | Name of the parent guardrail (set during resolution)   |
| `SortOrder`   | `int`               | Controls evaluation order within the guardrail         |

## Enums

### AIGuardrailPhase

{% code title="AIGuardrailPhase" %}

```csharp
public enum AIGuardrailPhase
{
    PreGenerate = 0,   // Before sending to AI provider
    PostGenerate = 1   // After receiving AI response
}
```

{% endcode %}

### AIGuardrailAction

{% code title="AIGuardrailAction" %}

```csharp
public enum AIGuardrailAction
{
    Block = 0,   // Block content and throw AIGuardrailBlockedException
    Warn = 1,    // Allow content through unchanged, log a warning
    Redact = 2   // Replace flagged content with [REDACTED]
}
```

{% endcode %}
