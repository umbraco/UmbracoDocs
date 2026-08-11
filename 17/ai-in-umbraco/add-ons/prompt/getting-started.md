---
description: >-
    Get started with Prompt Management.
---

# Getting Started with Prompts

This guide walks you through creating and using your first prompt.

## Prerequisites

Before starting, ensure you have:

- Umbraco.AI installed and configured
- At least one AI connection set up
- At least one chat profile created

## Step 1: Install the Package

{% code title="Package Manager Console" %}

```powershell
Install-Package Umbraco.AI.Prompt
```

{% endcode %}

Restart your application to run database migrations.

## Step 2: Create a Prompt in Backoffice

1. Navigate to the **AI** section > **Prompts**
2. Click **Create Prompt**
3. Fill in the details:

| Field        | Value                                  |
| ------------ | -------------------------------------- |
| Alias        | `meta-description`                     |
| Name         | Generate Meta Description              |
| Description  | Creates SEO-friendly meta descriptions |
| Instructions | See below                              |
| Profile      | (select your chat profile)             |

**Instructions:**

```
Write a meta description for this web page.

Title: {{pageTitle}}
Content: {{bodyText}}

Requirements:
- Maximum 155 characters
- Include the main topic
- Be compelling and action-oriented
- Do not include quotes
```

Variables such as `{{pageTitle}}` and `{{bodyText}}` resolve to properties on the entity the prompt is executed against. Replace them with the property aliases used in your own content types.

4. Click **Save**

## Step 3: Test the Prompt

In the prompt editor, use the **Test** panel to run the prompt against an existing document. The prompt executes using the real entity context, so variables resolve from that document's property values. Review the response in the test output.

## Step 4: Use in Code

### Via Service

Prompt templates resolve their variables from the runtime context that is built around the target entity. `{{pageTitle}}` and `{{bodyText}}` in the instructions map to properties on the document identified by `EntityId`.

{% code title="MetaDescriptionGenerator.cs" %}

```csharp
public class MetaDescriptionGenerator
{
    private readonly IAIPromptService _promptService;

    public MetaDescriptionGenerator(IAIPromptService promptService)
    {
        _promptService = promptService;
    }

    public async Task<string> GenerateAsync(Guid contentKey)
    {
        var prompt = await _promptService.GetPromptByAliasAsync("meta-description");

        var result = await _promptService.ExecutePromptAsync(
            prompt!.Id,
            new AIPromptExecutionRequest
            {
                EntityId = contentKey,
                EntityType = "document",
                PropertyAlias = "metaDescription",
                ContentTypeAlias = "article"
            });

        return result.Content;
    }
}
```

{% endcode %}

### Via API

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/prompts/meta-description/execute" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "entityId": "8c9a4e8f-2e89-4b3e-9a6f-1c2d3e4f5a6b",
    "entityType": "document",
    "propertyAlias": "metaDescription",
    "contentTypeAlias": "article"
  }'
```

{% endcode %}

## Step 5: Add Contexts (Optional)

To include brand voice in your prompt:

1. Create a Context with your tone guidelines
2. Edit your prompt
3. In the **Contexts** section, add your context
4. The context content will be included in the system message

## Step 6: Configure Scoping

Scoping controls where the prompt is allowed to run. A prompt with no allow rules is not available anywhere, so you need at least one allow rule before the prompt appears in the backoffice.

1. Edit your prompt
2. Expand the **Scope** section
3. Add an **Allow Rule** and choose the content types, properties, or property editors where the prompt should appear
4. Optionally add **Deny Rules** to exclude specific places
5. Save

See [Scoping](scoping.md) for full details on allow and deny rules.

## Next Steps

- Create more prompts for different use cases
- Explore [Template Syntax](template-syntax.md) for advanced variables
- Learn about [Scoping](scoping.md) for allow and deny rules
- Review the [API Reference](api/README.md) for programmatic access
