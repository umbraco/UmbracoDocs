---
description: >-
    Get a guardrail by ID.
---

# Get Guardrail

Returns the full details of a specific guardrail including all its rules.

## Request

```http
GET /umbraco/ai/management/api/v1/guardrails/{guardrailIdOrAlias}
```

### Path Parameters

| Parameter             | Type   | Description             |
| --------------------- | ------ | ----------------------- |
| `guardrailIdOrAlias`  | string | Guardrail GUID or alias |

## Response

### Success

{% code title="200 OK" %}

```json
{
    "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "alias": "content-safety",
    "name": "Content Safety Policy",
    "version": 2,
    "rules": [
        {
            "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
            "evaluatorId": "contains",
            "name": "Block competitor mentions",
            "phase": "PostGenerate",
            "action": "Block",
            "config": {
                "searchPattern": "CompetitorBrand",
                "ignoreCase": true
            },
            "sortOrder": 0
        },
        {
            "id": "b2c3d4e5-f6a7-8901-bcde-f12345678901",
            "evaluatorId": "regex",
            "name": "Block SSNs in responses",
            "phase": "PostGenerate",
            "action": "Block",
            "config": {
                "pattern": "\\b\\d{3}-\\d{2}-\\d{4}\\b",
                "ignoreCase": false
            },
            "sortOrder": 1
        }
    ],
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
    "title": "Guardrail not found",
    "status": 404,
    "detail": "The specified guardrail could not be found."
}
```

{% endcode %}

## Examples

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/guardrails/3fa85f64-5717-4562-b3fc-2c963f66afa6" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

## Response Properties

| Property       | Type     | Description                          |
| -------------- | -------- | ------------------------------------ |
| `id`           | guid     | Unique identifier                    |
| `alias`        | string   | Unique alias for code references     |
| `name`         | string   | Display name                         |
| `version`      | int      | Current version number               |
| `rules`        | array    | Collection of guardrail rules        |
| `dateCreated`  | datetime | When the guardrail was created       |
| `dateModified` | datetime | When the guardrail was last modified |
