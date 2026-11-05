---
description: >-
    Variable interpolation syntax for prompt templates.
---

# Template Syntax

Prompt templates support variable interpolation using double curly braces: `{{variable}}`.

## Basic Variables

Variables in templates are resolved from the runtime context that is built for each execution. When a prompt runs against an entity (either from a property action in the backoffice or from a server-side call), the context is populated from that entity, so template variables typically map to the entity's property aliases.

```
Translate the following text to {{language}}:

{{text}}
```

Variables can reference:

- Request fields (`entityId`, `entityType`, `propertyAlias`, `contentTypeAlias`, `elementId`, `elementType`, `culture`, `segment`)
- Entity property values by alias (for example `{{pageTitle}}` or `{{bodyText}}`)
- The special `currentValue` variable, which is the current value of the property identified by `propertyAlias`
- Values added by registered runtime context contributors (these can be supplied via the `Context` items on the request)

{% hint style="info" %}
To pass custom data from your frontend, use the `Context` property on `AIPromptExecutionRequest` and rely on a runtime context contributor to map it into the template context.
{% endhint %}

## Nested Paths

Use dot notation to access nested object properties:

```
User: {{user.name}}
Email: {{user.email}}
Company: {{user.company.name}}
```

## Dictionary and Array Access

Access dictionary values and array elements using bracket notation:

```
First item: {{items[0]}}
Specific key: {{data["my-key"]}}
Combined: {{users[0].name}}
```

Supported path patterns:

- Simple property: `{{name}}`
- Nested property: `{{user.name}}`
- Array index: `{{items[0]}}`
- Dictionary key: `{{data["key"]}}` or `{{data['key']}}`
- Combined: `{{users[0].company.name}}`

{% hint style="info" %}
Path resolution is case-insensitive by default.
{% endhint %}

## Image Variables

Use the `image:` prefix to include images from content properties:

```
Describe this image:
{{image:heroImage}}

Write alt text for:
{{image:umbracoFile}}
```

The image processor:

1. Fetches the entity from Umbraco
2. Gets the media property value
3. Resolves the image content
4. Includes the image data in the AI request

{% hint style="info" %}
Image variables require the entity to have a media picker or upload property with the specified alias.
{% endhint %}

## Executing Prompts

### From Property Actions

When prompts execute from property actions in the backoffice, the runtime context is populated automatically:

- Entity ID and type
- Property alias being edited
- Content type alias
- Culture and segment (if applicable)
- Entity property values
- The current value of the property being edited (available as `{{currentValue}}`)

Templates can reference this context directly:

```
You are editing "{{name}}" ({{contentTypeAlias}}).

Current value:
{{currentValue}}

Suggest an improved version for SEO.
```

### From Code

Execute prompts programmatically using `IAIPromptService`:

{% code title="ExecutePromptWithContext.cs" %}

```csharp
var result = await _promptService.ExecutePromptAsync(
    promptId,
    new AIPromptExecutionRequest
    {
        EntityId = contentKey,
        EntityType = "document",
        PropertyAlias = "bodyText",
        ContentTypeAlias = "article",
        Culture = "en-US"
    });

Console.WriteLine(result.Content);
```

{% endcode %}

The `AIPromptExecutionRequest` properties:

| Property           | Type                                    | Required | Description                                                       |
| ------------------ | --------------------------------------- | -------- | ----------------------------------------------------------------- |
| `EntityId`         | `Guid`                                  | Yes      | Entity (document, media, etc.) key                                |
| `EntityType`       | `string`                                | Yes      | Entity type, for example `document` or `media`                    |
| `PropertyAlias`    | `string`                                | Yes      | Property alias being edited                                       |
| `ContentTypeAlias` | `string`                                | Yes      | Content type alias (or element type alias for blocks)             |
| `ElementId`        | `Guid?`                                 | No       | Block content key when executing inside a block element           |
| `ElementType`      | `string?`                               | No       | Element type when executing inside a block element                |
| `Culture`          | `string?`                               | No       | Culture/language variant                                          |
| `Segment`          | `string?`                               | No       | Segment variant                                                   |
| `Context`          | `IReadOnlyList<AIRequestContextItem>?`  | No       | Frontend context items processed by runtime context contributors  |

### Passing Custom Context

To pass custom data to the template, use the `Context` list. Each item contains a human-readable `Description` and an optional `Value` (a JSON string). Contributors registered with the AI runtime decide how these items are exposed to templates and system messages.

{% code title="ContextExample.cs" %}

```csharp
var result = await _promptService.ExecutePromptAsync(
    promptId,
    new AIPromptExecutionRequest
    {
        EntityId = contentKey,
        EntityType = "document",
        PropertyAlias = "summary",
        ContentTypeAlias = "article",
        Context =
        [
            new AIRequestContextItem
            {
                Description = "Target audience",
                Value = "\"marketing professionals\""
            }
        ]
    });
```

{% endcode %}

## Combining Variables

Mix different variable types in a single template:

```
## Content: {{name}}

Current text:
{{bodyText}}

{{image:featuredImage}}

Generate a social media post about this content.
```

## Best Practices

### Be Explicit

Instead of:

```
Write about {{topic}}
```

Use:

```
Write a 500-word blog post about {{topic}}.
Include an introduction, 3 main points, and a conclusion.
Use a conversational tone.
```

### Document Variables

Add comments to complex templates:

```
<!--
Required properties on the entity:
- pageTitle: main subject
- audience: target readers
- tone: writing style
-->

Write about {{pageTitle}} for {{audience}}.
Use a {{tone}} tone.
```

### Structure Complex Templates

For complex prompts, use clear sections:

```
## Context
You are a writing assistant.

## Current Value
{{currentValue}}

## Requirements
Respond in {{culture}}.
```

## Related

- [Concepts](concepts.md) - Prompt template concepts
- [Scoping](scoping.md) - Allow and deny rules
- [Property Actions](property-actions.md) - Using prompts in the backoffice
