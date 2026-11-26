---
description: >-
    Update an existing prompt.
---

# Update Prompt

Updates an existing prompt. A new version is created automatically.

## Request

```http
PUT /umbraco/ai/management/api/v1/prompts/{idOrAlias}
```

### Path Parameters

| Parameter   | Type   | Description          |
| ----------- | ------ | -------------------- |
| `idOrAlias` | string | Prompt GUID or alias |

### Request Body

{% code title="Request" %}

```json
{
    "alias": "meta-description",
    "name": "Generate Meta Description (Updated)",
    "description": "Creates SEO-friendly meta descriptions for web pages",
    "instructions": "Write a compelling meta description...",
    "profileId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
    "contextIds": ["e401f2ff-7d65-5c12-a1f7-e812859a1962"],
    "guardrailIds": [],
    "tags": ["seo", "content", "updated"],
    "isActive": true,
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
| `isActive`             | bool     | No       | Whether the prompt is available (default: `true`)                           |
| `includeEntityContext` | bool     | No       | Include entity in system message (default: `true`)                          |
| `optionCount`          | int      | No       | Number of result options: 0 = informational, 1 = single (default), 2+ = options |
| `displayMode`          | string   | No       | `PropertyAction` (default) or `TipTapTool`                                  |
| `scope`                | object   | No       | Scope rules (allow/deny) defining where the prompt can run                  |

## Response

### Success

{% code title="200 OK" %}

The response body is empty on success. Fetch the prompt using [Get Prompt](get.md) to see the updated values.

{% endcode %}

### Not Found

{% code title="404 Not Found" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.4",
    "title": "AIPrompt not found",
    "status": 404,
    "detail": "The specified prompt could not be found."
}
```

{% endcode %}

## Examples

{% code title="cURL" %}

```bash
curl -X PUT "https://your-site.com/umbraco/ai/management/api/v1/prompts/3fa85f64-5717-4562-b3fc-2c963f66afa6" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "alias": "meta-description",
    "name": "Generate Meta Description (Updated)",
    "instructions": "Updated instructions..."
  }'
```

{% endcode %}
