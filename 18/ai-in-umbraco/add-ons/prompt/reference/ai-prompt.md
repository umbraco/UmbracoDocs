---
description: >-
    Model representing a prompt template.
---

# AIPrompt

Represents a reusable prompt template with variables and configuration.

## Namespace

```csharp
using Umbraco.AI.Prompt.Core.Prompts;
```

## Definition

{% code title="AIPrompt" %}

```csharp
public sealed class AIPrompt : IAIVersionableEntity
{
    public Guid Id { get; internal set; }
    public required string Alias { get; set; }
    public required string Name { get; set; }
    public string? Description { get; set; }
    public required string Instructions { get; set; }
    public Guid? ProfileId { get; set; }
    public IReadOnlyList<Guid> ContextIds { get; set; } = [];
    public IReadOnlyList<Guid> GuardrailIds { get; set; } = [];
    public IReadOnlyList<string> Tags { get; set; } = [];
    public bool IsActive { get; set; } = true;
    public bool IncludeEntityContext { get; set; } = true;
    public int OptionCount { get; set; } = 1;
    public AIPromptDisplayMode DisplayMode { get; set; } = AIPromptDisplayMode.PropertyAction;
    public AIPromptScope? Scope { get; set; }

    // Audit properties
    public DateTime DateCreated { get; init; }
    public DateTime DateModified { get; set; }
    public Guid? CreatedByUserId { get; set; }
    public Guid? ModifiedByUserId { get; set; }

    // Versioning
    public int Version { get; internal set; } = 1;
}
```

{% endcode %}

## Properties

| Property               | Type                    | Description                                                                 |
| ---------------------- | ----------------------- | --------------------------------------------------------------------------- |
| `Id`                   | `Guid`                  | Unique identifier                                                           |
| `Alias`                | `string`                | Unique alias for code references (required)                                 |
| `Name`                 | `string`                | Display name (required)                                                     |
| `Description`          | `string?`               | Optional description                                                        |
| `Instructions`         | `string`                | Prompt template text (required)                                             |
| `ProfileId`            | `Guid?`                 | Associated AI profile                                                       |
| `ContextIds`           | `IReadOnlyList<Guid>`   | AI Contexts to inject                                                       |
| `GuardrailIds`         | `IReadOnlyList<Guid>`   | Guardrails to evaluate during prompt execution                              |
| `Tags`                 | `IReadOnlyList<string>` | Organization tags                                                           |
| `IsActive`             | `bool`                  | Whether prompt is available                                                 |
| `IncludeEntityContext` | `bool`                  | Include entity in system message                                            |
| `OptionCount`          | `int`                   | Number of result options to generate (0 = informational, 1 = single, 2+ = options) |
| `DisplayMode`          | `AIPromptDisplayMode`   | Where the prompt is shown (`PropertyAction` or `TipTapTool`)                |
| `Scope`                | `AIPromptScope?`        | Allow/deny rules defining where the prompt runs                             |
| `DateCreated`          | `DateTime`              | When created                                                                |
| `DateModified`         | `DateTime`              | When last modified                                                          |
| `CreatedByUserId`      | `Guid?`                 | Key of the user who created the prompt                                      |
| `ModifiedByUserId`     | `Guid?`                 | Key of the user who last modified the prompt                                |
| `Version`              | `int`                   | Current version number                                                      |

## AIPromptDisplayMode

{% code title="AIPromptDisplayMode" %}

```csharp
public enum AIPromptDisplayMode
{
    PropertyAction = 0,
    TipTapTool = 1
}
```

{% endcode %}

## Example

{% code title="MetaDescriptionPrompt.cs" %}

```csharp
var prompt = new AIPrompt
{
    Alias = "meta-description",
    Name = "Generate Meta Description",
    Description = "Creates SEO-friendly meta descriptions",
    Instructions = @"Write a meta description for this web page.

Title: {{pageTitle}}
Content: {{bodyText}}

Requirements:
- Maximum 155 characters
- Include the main topic
- Be compelling and action-oriented",
    ProfileId = chatProfileId,
    ContextIds = [brandVoiceContextId],
    Tags = ["seo", "content"],
    IsActive = true,
    IncludeEntityContext = true,
    OptionCount = 1,
    DisplayMode = AIPromptDisplayMode.PropertyAction,
    Scope = new AIPromptScope
    {
        AllowRules = [
            new AIPromptScopeRule
            {
                ContentTypeAliases = ["article", "blogPost"]
            }
        ]
    }
};

var saved = await _promptService.SavePromptAsync(prompt);
```

{% endcode %}

---

## AIPromptScope

Defines where a prompt is allowed to run. A scope consists of two lists: allow rules (whitelist) and deny rules (blacklist). Deny rules take precedence over allow rules. A prompt with no allow rules is not allowed to run anywhere.

{% code title="AIPromptScope" %}

```csharp
public class AIPromptScope
{
    public IReadOnlyList<AIPromptScopeRule> AllowRules { get; set; } = [];
    public IReadOnlyList<AIPromptScopeRule> DenyRules { get; set; } = [];
}
```

{% endcode %}

### Properties

| Property     | Type                              | Description                                           |
| ------------ | --------------------------------- | ----------------------------------------------------- |
| `AllowRules` | `IReadOnlyList<AIPromptScopeRule>` | Whitelist of places the prompt is allowed to run      |
| `DenyRules`  | `IReadOnlyList<AIPromptScopeRule>` | Blacklist of places the prompt is not allowed to run  |

## AIPromptScopeRule

Describes a single match rule. Within a rule, all non-empty properties must match (AND logic). Within each list, any value can match (OR logic).

{% code title="AIPromptScopeRule" %}

```csharp
public class AIPromptScopeRule
{
    public IReadOnlyList<string>? PropertyEditorUiAliases { get; set; }
    public IReadOnlyList<string>? PropertyAliases { get; set; }
    public IReadOnlyList<string>? ContentTypeAliases { get; set; }
}
```

{% endcode %}

### Properties

| Property                  | Type                        | Description                                                                          |
| ------------------------- | --------------------------- | ------------------------------------------------------------------------------------ |
| `PropertyEditorUiAliases` | `IReadOnlyList<string>?`    | Property Editor UI aliases to match (e.g., `Umb.PropertyEditorUi.TextBox`). Null or empty means any. |
| `PropertyAliases`         | `IReadOnlyList<string>?`    | Property aliases to match (e.g., `pageTitle`). Null or empty means any.              |
| `ContentTypeAliases`      | `IReadOnlyList<string>?`    | Content type aliases to match (e.g., `blogPost`). Null or empty means any.           |

## Related

- [IAIPromptService](ai-prompt-service.md) - Prompt service
- [Template Syntax](../template-syntax.md) - Variable interpolation
