---
description: >-
    Create a new prompt.
---

# Create Prompt

Creates a new prompt template.

## Request

```http
POST /umbraco/ai/management/api/v1/prompts
```

### Request Body

{% code title="Request" %}

```json
{
    "alias": "meta-description",
    "name": "Generate Meta Description",
    "description": "Creates SEO-friendly meta descriptions",
    "instructions": "Write a meta description for:\n\nTitle: {{pageTitle}}\nContent: {{bodyText}}\n\nRequirements:\n- Maximum 155 characters\n- Be compelling",
    "profileId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
    "contextIds": ["e401f2ff-7d65-5c12-a1f7-e812859a1962"],
    "guardrailIds": [],
    "tags": ["seo", "content"],
    "includeEntityContext": true,
    "optionCount": 1,
    "displayMode": "PropertyAction",
    "scope": {
        "allowRules": [
            {
                "contentTypeAliases": ["article", "blogPost"]
            }
        ],
        "denyRules": []
    }
}
```

{% endcode %}

### Request Properties

| Property               | Type     | Required | Description                                                                 |
| ---------------------- | -------- | -------- | --------------------------------------------------------------------------- |
| `alias`                | string   | Yes      | Unique alias (letters, numbers, hyphens and underscores only, max 100)      |
| `name`                 | string   | Yes      | Display name (max 255)                                                      |
| `instructions`         | string   | Yes      | Prompt template text                                                        |
| `description`          | string   | No       | Optional description (max 1000)                                             |
| `profileId`            | guid     | No       | Associated AI profile                                                       |
| `contextIds`           | guid[]   | No       | AI Contexts to inject                                                       |
| `guardrailIds`         | guid[]   | No       | Guardrails evaluated during execution                                       |
| `tags`                 | string[] | No       | Organization tags                                                           |
| `includeEntityContext` | bool     | No       | Include entity in system message (default: `true`)                          |
| `optionCount`          | int      | No       | Number of result options: 0 = informational, 1 = single (default), 2+ = options |
| `displayMode`          | string   | No       | `PropertyAction` (default) or `TipTapTool`                                  |
| `scope`                | object   | No       | Scope rules (allow/deny) defining where the prompt can run                  |

## Response

### Success

{% code title="201 Created" %}

Returns the ID of the created prompt as the response body and a `Location` header pointing to the new resource. Use the [Get Prompt](get.md) endpoint to retrieve the full object.

```
"3fa85f64-5717-4562-b3fc-2c963f66afa6"
```

{% endcode %}

### Validation Error

{% code title="400 Bad Request" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.1",
    "title": "One or more validation errors occurred.",
    "status": 400,
    "errors": {
        "Alias": ["Alias must contain only letters, numbers, hyphens, and underscores."]
    }
}
```

{% endcode %}

### Duplicate Alias

{% code title="409 Conflict" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.8",
    "title": "Alias already exists",
    "status": 409,
    "detail": "A prompt with alias 'meta-description' already exists."
}
```

{% endcode %}

## Examples

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/prompts" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "alias": "meta-description",
    "name": "Generate Meta Description",
    "instructions": "Write a meta description..."
  }'
```

{% endcode %}
