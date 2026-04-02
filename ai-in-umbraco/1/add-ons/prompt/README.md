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
- **Content Scoping** - Control which content types can use each prompt
- **Version History** - Track changes with full rollback support
- **Backoffice Management** - Full UI for creating and managing prompts

## Quick Start

### 1. Create a Prompt

In the backoffice, navigate to the **AI** section > **Prompts** and create a new prompt:

| Field        | Value                                                                |
| ------------ | -------------------------------------------------------------------- |
| Alias        | `summarize-article`                                                  |
| Name         | Summarize Article                                                    |
| Instructions | `Summarize the following article in 3 bullet points:\n\n{{content}}` |
| Profile      | (select your chat profile)                                           |

### 2. Execute the Prompt

{% code title="ArticleSummarizer.cs" %}

```csharp
public class ArticleSummarizer
{
    private readonly IAIPromptService _promptService;

    public ArticleSummarizer(IAIPromptService promptService)
    {
        _promptService = promptService;
    }

    public async Task<string> SummarizeAsync(string articleContent)
    {
        var prompt = await _promptService.GetPromptByAliasAsync("summarize-article");

        var result = await _promptService.ExecutePromptAsync(
            prompt!.Id,
            new AIPromptExecutionRequest
            {
                Variables = new Dictionary<string, string>
                {
                    ["content"] = articleContent
                }
            });

        return result.Response;
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

### Prefixed Variables

Use prefixes for special variable sources:

| Prefix      | Source               | Example                 |
| ----------- | -------------------- | ----------------------- |
| `entity:`   | Current content item | `{{entity:name}}`       |
| `property:` | Content property     | `{{property:bodyText}}` |
| `context:`  | Request context      | `{{context:culture}}`   |

### Example Template

```
You are a content assistant for {{entity:name}}.

Write a meta description for this content:

Title: {{property:pageTitle}}
Content: {{property:bodyText}}

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
| [Scoping](scoping.md)                               | Content type allow/deny rules        |
| [API Reference](api/README.md)                      | Management API endpoints             |
| [Service Reference](reference/ai-prompt-service.md) | IAIPromptService                     |

## Related

- [Add-ons Overview](../README.md) - All add-on packages
- [AI Contexts](../../concepts/contexts.md) - Brand voice and guidelines
- [Profiles](../../concepts/profiles.md) - AI configuration
