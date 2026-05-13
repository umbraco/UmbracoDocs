---
description: >-
    Prompt Management add-on for creating and executing reusable prompt templates.
---

# Prompt Management

The Prompt Management add-on (`Umbraco.AI.Prompt`) enables you to create, manage, and execute reusable prompt templates through the Umbraco backoffice and Management API.

## Installation

{% code title="Package Manager Console" %}

```powershell
Install-Package Umbraco.AI.Prompt
```

{% endcode %}

Or via .NET CLI:

{% code title="Terminal" %}

```bash
dotnet add package Umbraco.AI.Prompt
```

{% endcode %}

## Features

- **Prompt Templates** - Create reusable prompts with variable placeholders
- **Variable Interpolation** - Use `{{variable}}` syntax for dynamic content
- **Profile Association** - Link prompts to specific AI profiles
- **Context Injection** - Include AI Contexts for brand voice
- **Scoping** - Control where each prompt can be used using allow and deny rules
- **Version History** - Track changes with full rollback support
- **Backoffice Management** - Full UI for creating and managing prompts

## Quick Start

### 1. Create a Prompt

In the backoffice, navigate to the **AI** section > **Prompts** and create a new prompt:

| Field        | Value                                                                |
| ------------ | -------------------------------------------------------------------- |
| Alias        | `summarize-article`                                                       |
| Name         | Summarize Article                                                         |
| Instructions | `Summarize the following article in 3 bullet points:\n\n{{bodyText}}`     |
| Profile      | (select your chat profile)                                                |

### 2. Execute the Prompt

Template variables like `{{content}}` resolve from the target entity's property values. Execute the prompt against the document you want to summarize:

{% code title="ArticleSummarizer.cs" %}

```csharp
public class ArticleSummarizer
{
    private readonly IAIPromptService _promptService;

    public ArticleSummarizer(IAIPromptService promptService)
    {
        _promptService = promptService;
    }

    public async Task<string> SummarizeAsync(Guid articleKey)
    {
        var prompt = await _promptService.GetPromptByAliasAsync("summarize-article");

        var result = await _promptService.ExecutePromptAsync(
            prompt!.Id,
            new AIPromptExecutionRequest
            {
                EntityId = articleKey,
                EntityType = "document",
                PropertyAlias = "summary",
                ContentTypeAlias = "article"
            });

        return result.Content;
    }
}
```

{% endcode %}

## Template Syntax

### Basic Variables

Use `{{variable}}` to insert dynamic content:

```
Translate the following text to {{language}}:

{{text}}
```

### Image Variables

Use the `image:` prefix to include images from content properties:

```
Describe this image: {{image:heroImage}}
```

### Example Template

When prompts execute from property actions, entity and property values are available directly:

```
You are a content assistant for {{name}}.

Write a meta description for this content:

Title: {{pageTitle}}
Content: {{bodyText}}

Requirements:
- Maximum 160 characters
- Include the primary keyword
- Be compelling and action-oriented
```

## Documentation

| Section                                             | Description                          |
| --------------------------------------------------- | ------------------------------------ |
| [Concepts](concepts.md)                             | Prompt templates, variables, scoping |
| [Getting Started](getting-started.md)               | Step-by-step setup guide             |
| [Template Syntax](template-syntax.md)               | Variable interpolation details       |
| [Scoping](scoping.md)                               | Allow and deny rules for prompts     |
| [API Reference](api/README.md)                      | Management API endpoints             |
| [Service Reference](reference/ai-prompt-service.md) | IAIPromptService                     |

## Related

- [Add-ons Overview](../README.md) - All add-on packages
- [AI Contexts](../../concepts/contexts.md) - Brand voice and guidelines
- [Profiles](../../concepts/profiles.md) - AI configuration
