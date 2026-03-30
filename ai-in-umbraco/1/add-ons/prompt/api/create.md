---
description: >-
    Create a new prompt.
---

# Create Prompt

Creates a new prompt template.

## Request

```http
POST /umbraco/ai/management/api/v1/prompt
```

### Request Body

{% code title="Request" %}

```json
{
    "alias": "meta-description",
    "name": "Generate Meta Description",
    "description": "Creates SEO-friendly meta descriptions",
    "instructions": "Write a meta description for:\n\nTitle: {{title}}\nContent: {{content}}\n\nRequirements:\n- Maximum 155 characters\n- Be compelling",
    "profileId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
    "contextIds": ["e401f2ff-7d65-5c12-a1f7-e812859g1962"],
    "tags": ["seo", "content"],
    "isActive": true,
    "includeEntityContext": true,
    "scope": {
        "mode": "Allow",
        "contentTypeAliases": ["article", "blogPost"]
    }
}
```

{% endcode %}

### Request Properties

| Property               | Type     | Required | Description                                      |
| ---------------------- | -------- | -------- | ------------------------------------------------ |
| `alias`                | string   | Yes      | Unique alias (URL-safe)                          |
| `name`                 | string   | Yes      | Display name                                     |
| `instructions`         | string   | Yes      | Prompt template text                             |
| `description`          | string   | No       | Optional description                             |
| `profileId`            | guid     | No       | Associated AI profile                            |
| `contextIds`           | guid[]   | No       | AI Contexts to inject                            |
| `tags`                 | string[] | No       | Organization tags                                |
| `isActive`             | bool     | No       | Whether prompt is available (default: true)      |
| `includeEntityContext` | bool     | No       | Include entity in system message (default: true) |
| `scope`                | object   | No       | Content type scoping rules                       |

## Response

### Success

{% code title="201 Created" %}

```json
{
  "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
  "alias": "meta-description",
  "name": "Generate Meta Description",
  "version": 1,
  ...
}
```

{% endcode %}

### Validation Error

{% code title="400 Bad Request" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.1",
    "title": "Bad Request",
    "status": 400,
    "errors": {
        "alias": ["A prompt with this alias already exists"]
    }
}
```

{% endcode %}

## Examples

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/prompt" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "alias": "meta-description",
    "name": "Generate Meta Description",
    "instructions": "Write a meta description...",
    "isActive": true
  }'
```

{% endcode %}
