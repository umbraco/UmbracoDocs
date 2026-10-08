---
description: >-
    Update an existing AI guardrail.
---

# Update Guardrail

Updates an existing guardrail. A new version is created automatically.

## Request

```http
PUT /umbraco/ai/management/api/v1/guardrails/{guardrailIdOrAlias}
```

### Path Parameters

| Parameter             | Type   | Description             |
| --------------------- | ------ | ----------------------- |
| `guardrailIdOrAlias`  | string | Guardrail GUID or alias |

### Request Body

{% code title="Request" %}

```json
{
    "alias": "content-safety",
    "name": "Content Safety Policy v2",
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
        },
        {
            "evaluatorId": "llm-judge",
            "name": "Quality check",
            "phase": "PostGenerate",
            "action": "Warn",
            "config": {
                "evaluationCriteria": "Evaluate whether the response follows brand guidelines.",
                "safetyThreshold": 0.7
            },
            "sortOrder": 2
        }
    ]
}
```

{% endcode %}

{% hint style="info" %}
Include existing rule IDs to update them. Rules without IDs are created as new. Omitting an existing rule removes it.
{% endhint %}

## Response

### Success

{% code title="200 OK" %}

```
(empty response body)
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

### Validation Error

{% code title="400 Bad Request" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.1",
    "title": "Duplicate alias",
    "status": 400,
    "detail": "A guardrail with this alias already exists."
}
```

{% endcode %}

## Examples

{% code title="cURL" %}

```bash
curl -X PUT "https://your-site.com/umbraco/ai/management/api/v1/guardrails/3fa85f64-5717-4562-b3fc-2c963f66afa6" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "alias": "content-safety",
    "name": "Content Safety Policy v2",
    "rules": [
      {
        "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
        "evaluatorId": "contains",
        "name": "Block competitor mentions",
        "phase": "PostGenerate",
        "action": "Block",
        "config": { "searchPattern": "CompetitorBrand", "ignoreCase": true },
        "sortOrder": 0
      }
    ]
  }'
```

{% endcode %}
