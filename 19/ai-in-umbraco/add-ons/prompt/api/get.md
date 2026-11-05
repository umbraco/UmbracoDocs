---
description: >-
    Get a prompt by ID or alias.
---

# Get Prompt

Returns the full details of a specific prompt.

## Request

```http
GET /umbraco/ai/management/api/v1/prompts/{idOrAlias}
```

### Path Parameters

| Parameter   | Type   | Description          |
| ----------- | ------ | -------------------- |
| `idOrAlias` | string | Prompt GUID or alias |

## Response

### Success

{% code title="200 OK" %}

```json
{
    "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "alias": "meta-description",
    "name": "Generate Meta Description",
    "description": "Creates SEO-friendly meta descriptions",
    "instructions": "Write a meta description for:\n\nTitle: {{pageTitle}}\nContent: {{bodyText}}",
    "profileId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
    "contextIds": ["e401f2ff-7d65-5c12-a1f7-e812859a1962"],
    "guardrailIds": [],
    "tags": ["seo", "content"],
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
    },
    "version": 3,
    "dateCreated": "2024-01-15T10:30:00Z",
    "dateModified": "2024-01-20T14:45:00Z"
}
```

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
# By ID
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/prompts/3fa85f64-5717-4562-b3fc-2c963f66afa6" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"

# By alias
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/prompts/meta-description" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}
