---
description: >-
    Create custom guardrail evaluators to enforce domain-specific safety and compliance rules.
---

# Custom Guardrail Evaluators

Guardrail evaluators are the components that perform the actual content evaluation within guardrail rules. Umbraco.AI ships with built-in evaluators (Contains, Regex, LLM Judge), but you can create custom evaluators for domain-specific needs.

## Overview

Each evaluator:

- Has a unique ID and display name
- Defines what it checks (prohibited content, sensitive patterns, brand compliance, etc.)
- Can be code-based (deterministic, fast) or model-based (LLM-powered, nuanced)
- Optionally accepts configuration with a dynamic UI schema
- Is auto-discovered at startup

## Creating a Code-Based Evaluator

Code-based evaluators use deterministic logic like pattern matching. They run during streaming and provide fast responses.

### Step 1: Define Configuration

Create a configuration class with `[AIField]` attributes for backoffice UI generation:

{% code title="ProfanityFilterConfig.cs" %}

```csharp
using Umbraco.AI.Core.EditableModels;

public class ProfanityFilterConfig
{
    [AIField(
        Label = "Word List",
        Description = "Comma-separated list of words to flag",
        EditorUiAlias = "Umb.PropertyEditorUi.TextArea",
        SortOrder = 1)]
    public string WordList { get; set; } = string.Empty;

    [AIField(
        Label = "Ignore Case",
        Description = "Case-insensitive matching",
        EditorUiAlias = "Umb.PropertyEditorUi.Toggle",
        SortOrder = 2)]
    public bool IgnoreCase { get; set; } = true;
}
```

{% endcode %}

### Step 2: Implement the Evaluator

Extend `AIGuardrailEvaluatorBase<TConfig>` and apply the `[AIGuardrailEvaluator]` attribute:

{% code title="ProfanityFilterEvaluator.cs" %}

```csharp
using Microsoft.Extensions.AI;
using Umbraco.AI.Core.EditableModels;
using Umbraco.AI.Core.Guardrails.Evaluators;

[AIGuardrailEvaluator("profanity-filter", "Profanity Filter",
    Type = AIGuardrailEvaluatorType.CodeBased)]
public class ProfanityFilterEvaluator
    : AIGuardrailEvaluatorBase<ProfanityFilterConfig>
{
    public override string Description =>
        "Flags content containing words from a configurable word list";

    public ProfanityFilterEvaluator(IAIEditableModelSchemaBuilder schemaBuilder)
        : base(schemaBuilder)
    { }

    public override Task<AIGuardrailResult> EvaluateAsync(
        string content,
        IReadOnlyList<ChatMessage> conversationHistory,
        AIGuardrailConfig config,
        CancellationToken cancellationToken)
    {
        var evalConfig = config.Deserialize<ProfanityFilterConfig>()
            ?? new ProfanityFilterConfig();

        var words = evalConfig.WordList
            .Split(',', StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries);

        var comparison = evalConfig.IgnoreCase
            ? StringComparison.OrdinalIgnoreCase
            : StringComparison.Ordinal;

        var matched = words.FirstOrDefault(w => content.Contains(w, comparison));
        var flagged = matched is not null;

        return Task.FromResult(new AIGuardrailResult
        {
            EvaluatorId = Id,
            Flagged = flagged,
            Score = flagged ? 1.0 : 0.0,
            Reason = flagged ? $"Content contains prohibited word: {matched}" : null
        });
    }
}
```

{% endcode %}

The evaluator is automatically discovered and available in the backoffice when creating guardrail rules.

## Creating a Model-Based Evaluator

Model-based evaluators use an AI model to perform nuanced evaluation. They run after streaming completes (on the full response).

{% code title="BrandComplianceEvaluator.cs" %}

```csharp
using System.Text.Json;
using Microsoft.Extensions.AI;
using Umbraco.AI.Core.Chat;
using Umbraco.AI.Core.EditableModels;
using Umbraco.AI.Core.Guardrails.Evaluators;
using Umbraco.AI.Core.RuntimeContext;

public class BrandComplianceConfig
{
    [AIField(
        Label = "Brand Guidelines",
        Description = "The brand guidelines to evaluate against",
        EditorUiAlias = "Umb.PropertyEditorUi.TextArea",
        SortOrder = 1)]
    public string Guidelines { get; set; } = string.Empty;

    [AIField(
        Label = "Compliance Threshold",
        Description = "Score below this threshold flags content (0-1)",
        EditorUiAlias = "Umb.PropertyEditorUi.Slider",
        EditorConfig = "[{\"alias\":\"minValue\",\"value\":0},{\"alias\":\"maxValue\",\"value\":1},{\"alias\":\"step\",\"value\":0.1}]",
        SortOrder = 2)]
    public double Threshold { get; set; } = 0.8;
}

[AIGuardrailEvaluator("brand-compliance", "Brand Compliance",
    Type = AIGuardrailEvaluatorType.ModelBased)]
public class BrandComplianceEvaluator
    : AIGuardrailEvaluatorBase<BrandComplianceConfig>
{
    private readonly IAIChatService _chatService;
    private readonly IAIRuntimeContextAccessor _runtimeContextAccessor;

    public override string Description =>
        "Uses an AI model to evaluate content against brand guidelines";

    public BrandComplianceEvaluator(
        IAIChatService chatService,
        IAIRuntimeContextAccessor runtimeContextAccessor,
        IAIEditableModelSchemaBuilder schemaBuilder)
        : base(schemaBuilder)
    {
        _chatService = chatService;
        _runtimeContextAccessor = runtimeContextAccessor;
    }

    public override async Task<AIGuardrailResult> EvaluateAsync(
        string content,
        IReadOnlyList<ChatMessage> conversationHistory,
        AIGuardrailConfig config,
        CancellationToken cancellationToken)
    {
        var evalConfig = config.Deserialize<BrandComplianceConfig>()
            ?? new BrandComplianceConfig();

        // Prevent infinite recursion when the evaluator itself uses AI
        _runtimeContextAccessor.Context?.SetValue(
            Constants.ContextKeys.IsGuardrailEvaluation, true);

        try
        {
            var prompt = $"""
                Evaluate this content against the following brand guidelines.
                Return a JSON object: {{ "score": 0-1, "reasoning": "..." }}

                Guidelines: {evalConfig.Guidelines}

                Content: {content}
                """;

            var messages = new List<ChatMessage>
            {
                new(ChatRole.User, prompt)
            };

            var response = await _chatService.GetChatResponseAsync(
                chat => chat.WithAlias("guardrail-evaluation"),
                messages,
                cancellationToken);

            // Parse the score from the response
            // (simplified - add robust JSON parsing in production)
            var text = response.Message.Text ?? string.Empty;
            var score = ParseScore(text);
            var flagged = score < evalConfig.Threshold;

            return new AIGuardrailResult
            {
                EvaluatorId = Id,
                Flagged = flagged,
                Score = score,
                Reason = flagged
                    ? $"Brand compliance score {score:F2} below threshold {evalConfig.Threshold:F2}"
                    : null
            };
        }
        finally
        {
            _runtimeContextAccessor.Context?.SetValue(
                Constants.ContextKeys.IsGuardrailEvaluation, false);
        }
    }

    private static double ParseScore(string text)
    {
        // Extract score from JSON response
        var start = text.IndexOf('{');
        var end = text.LastIndexOf('}');
        if (start >= 0 && end > start)
        {
            var json = text.Substring(start, end - start + 1);
            using var doc = JsonDocument.Parse(json);
            if (doc.RootElement.TryGetProperty("score", out var scoreEl))
            {
                return scoreEl.GetDouble();
            }
        }
        return 0.0;
    }
}
```

{% endcode %}

{% hint style="warning" %}
Model-based evaluators must set the `IsGuardrailEvaluation` context flag before making AI calls. The flag prevents the guardrail middleware from evaluating the evaluator's own requests, which would cause infinite recursion.
{% endhint %}

## Evaluator Registration

Evaluators are auto-discovered via the `[AIGuardrailEvaluator]` attribute and `IDiscoverable` interface. No manual registration is needed.

To manually add or exclude evaluators in a Composer:

{% code title="GuardrailComposer.cs" %}

```csharp
public class GuardrailComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.AIGuardrailEvaluators()
            .Add<ProfanityFilterEvaluator>()
            .Exclude<ContainsGuardrailEvaluator>();
    }
}
```

{% endcode %}

## AIGuardrailResult

Every evaluator returns an `AIGuardrailResult`:

| Property | Type | Description |
| --- | --- | --- |
| `EvaluatorId` | `string` | ID of the evaluator that produced this result |
| `Flagged` | `bool` | Whether the content was flagged |
| `Score` | `double?` | Confidence score (0-1). Code-based evaluators typically return 0 or 1 |
| `Reason` | `string?` | Human-readable explanation |
| `Metadata` | `JsonElement?` | Evaluator-specific metadata (matched patterns, LLM reasoning, etc.) |

## Built-in Evaluators

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| `contains` | Contains | Code-based | Flags content containing a specific substring |
| `regex` | Regex Match | Code-based | Flags content matching a regular expression pattern |
| `llm-judge` | LLM Safety Judge | Model-based | Uses an AI model to evaluate content for safety and compliance |

## Related

- [Guardrails Concept](../../concepts/guardrails.md) - Understanding guardrails
- [Managing Guardrails](../../backoffice/managing-guardrails.md) - Backoffice guide
- [Custom Providers](../providers/README.md) - Creating AI providers
