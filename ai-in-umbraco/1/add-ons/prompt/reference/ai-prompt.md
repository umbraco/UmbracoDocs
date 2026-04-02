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
public class AIPrompt : IAIVersionableEntity
{
    public Guid Id { get; internal set; }
    public required string Alias { get; set; }
    public required string Name { get; set; }
    public string? Description { get; set; }
    public required string Instructions { get; set; }
    public Guid? ProfileId { get; set; }
    public IReadOnlyList<Guid> ContextIds { get; set; } = Array.Empty<Guid>();
    public IReadOnlyList<string> Tags { get; set; } = Array.Empty<string>();
    public bool IsActive { get; set; } = true;
    public bool IncludeEntityContext { get; set; } = true;
    public AIPromptScope? Scope { get; set; }

    // Audit properties
    public DateTime DateCreated { get; init; } = DateTime.UtcNow;
    public DateTime DateModified { get; set; } = DateTime.UtcNow;
    public Guid? CreatedByUserId { get; init; }
    public Guid? ModifiedByUserId { get; set; }

    // Versioning
    public int Version { get; internal set; } = 1;
}
```

{% endcode %}

## Properties

| Property               | Type                    | Description                                 |
| ---------------------- | ----------------------- | ------------------------------------------- |
| `Id`                   | `Guid`                  | Unique identifier                           |
| `Alias`                | `string`                | Unique alias for code references (required) |
| `Name`                 | `string`                | Display name (required)                     |
| `Description`          | `string?`               | Optional description                        |
| `Instructions`         | `string`                | Prompt template text (required)             |
| `ProfileId`            | `Guid?`                 | Associated AI profile                       |
| `ContextIds`           | `IReadOnlyList<Guid>`   | AI Contexts to inject                       |
| `Tags`                 | `IReadOnlyList<string>` | Organization tags                           |
| `IsActive`             | `bool`                  | Whether prompt is available                 |
| `IncludeEntityContext` | `bool`                  | Include entity in system message            |
| `Scope`                | `AIPromptScope?`        | Content type scoping rules                  |
| `DateCreated`          | `DateTime`              | When created                                |
| `DateModified`         | `DateTime`              | When last modified                          |
| `Version`              | `int`                   | Current version number                      |

## Example

{% code title="MetaDescriptionPrompt.cs" %}

```csharp
var prompt = new AIPrompt
{
    Alias = "meta-description",
    Name = "Generate Meta Description",
    Description = "Creates SEO-friendly meta descriptions",
    Instructions = @"Write a meta description for this web page.

Title: {{title}}
Content: {{content}}

Requirements:
- Maximum 155 characters
- Include the main topic
- Be compelling and action-oriented",
    ProfileId = chatProfileId,
    ContextIds = new[] { brandVoiceContextId },
    Tags = new[] { "seo", "content" },
    IsActive = true,
    IncludeEntityContext = true,
    Scope = new AIPromptScope
    {
        Mode = AIPromptScopeMode.Allow,
        ContentTypeAliases = new[] { "article", "blogPost" }
    }
};

var saved = await _promptService.SavePromptAsync(prompt);
```

{% endcode %}

---

## AIPromptScope

Defines content type scoping rules for a prompt.

{% code title="AIPromptScope" %}

```csharp
public class AIPromptScope
{
    public AIPromptScopeMode Mode { get; set; } = AIPromptScopeMode.None;
    public IReadOnlyList<string> ContentTypeAliases { get; set; } = Array.Empty<string>();
}

public enum AIPromptScopeMode
{
    None = 0,   // No restriction (default)
    Allow = 1,  // Only listed content types
    Deny = 2    // All except listed content types
}
```

{% endcode %}

## Related

- [IAIPromptService](ai-prompt-service.md) - Prompt service
- [Template Syntax](../template-syntax.md) - Variable interpolation
