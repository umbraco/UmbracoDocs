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
Write a meta description for a web page with the following content.

Title: {{title}}
Content: {{content}}

Requirements:
- Maximum 155 characters
- Include the main topic
- Be compelling and action-oriented
- Do not include quotes
```

4. Click **Save**

## Step 3: Test the Prompt

In the prompt editor, use the **Test** panel:

1. Enter test variables:
    - `title`: "How to Bake Sourdough Bread"
    - `content`: "This guide covers everything from creating your starter to achieving the perfect crust..."
2. Click **Execute**
3. Review the response

## Step 4: Use in Code

### Via Service

{% code title="MetaDescriptionGenerator.cs" %}

```csharp
public class MetaDescriptionGenerator
{
    private readonly IAIPromptService _promptService;

    public MetaDescriptionGenerator(IAIPromptService promptService)
    {
        _promptService = promptService;
    }

    public async Task<string> GenerateAsync(string title, string content)
    {
        var prompt = await _promptService.GetPromptByAliasAsync("meta-description");

        var result = await _promptService.ExecutePromptAsync(
            prompt!.Id,
            new AIPromptExecutionRequest
            {
                Variables = new Dictionary<string, string>
                {
                    ["title"] = title,
                    ["content"] = content
                }
            });

        return result.Response;
    }
}
```

{% endcode %}

### Via API

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/prompt/meta-description/execute" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "variables": {
      "title": "How to Bake Sourdough Bread",
      "content": "This guide covers everything..."
    }
  }'
```

{% endcode %}

## Step 5: Add Contexts (Optional)

To include brand voice in your prompt:

1. Create a Context with your tone guidelines
2. Edit your prompt
3. In the **Contexts** section, add your context
4. The context content will be included in the system message

## Step 6: Configure Scoping (Optional)

To limit which content types can use the prompt:

1. Edit your prompt
2. Expand the **Scope** section
3. Choose **Allow specific types** or **Deny specific types**
4. Select the relevant content types
5. Save

## Next Steps

- Create more prompts for different use cases
- Explore [Template Syntax](template-syntax.md) for advanced variables
- Learn about [Scoping](scoping.md) for content type rules
- Review the [API Reference](api/README.md) for programmatic access
