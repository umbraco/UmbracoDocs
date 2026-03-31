---
description: >-
    Create a new AI guardrail.
---

# Create Guardrail

Creates a new guardrail with rules for evaluating AI inputs and responses.

## Request

```http
POST /umbraco/ai/management/api/v1/guardrails
```

### Request Body

{% code title="Request" %}

```json
{
    "alias": "content-safety",
    "name": "Content Safety Policy",
    "rules": [
        {
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
    ]
}
```

{% endcode %}

### Request Properties

| Property | Type   | Required | Description             |
| -------- | ------ | -------- | ----------------------- |
| `alias`  | string | Yes      | Unique alias (URL-safe) |
| `name`   | string | Yes      | Display name            |
| `rules`  | array  | No       | Collection of rules     |

### Rule Properties

| Property      | Type   | Required | Description                                    |
| ------------- | ------ | -------- | ---------------------------------------------- |
| `evaluatorId` | string | Yes      | Registered evaluator ID (e.g., "contains")     |
| `name`        | string | Yes      | Display name                                   |
| `phase`       | string | Yes      | `PreGenerate` or `PostGenerate`                |
| `action`      | string | Yes      | `Block` or `Warn`                              |
| `config`      | object | No       | Evaluator-specific configuration               |
| `sortOrder`   | int    | No       | Evaluation order (default: 0)                  |

## Response

### Success

{% code title="201 Created" %}

```json
{
    "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "alias": "content-safety",
    "name": "Content Safety Policy",
    "version": 1,
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
    "dateModified": "2024-01-15T10:30:00Z"
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
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/guardrails" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "alias": "content-safety",
    "name": "Content Safety Policy",
    "rules": [
      {
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

{% code title="C#" %}

```csharp
var guardrail = new
{
    alias = "content-safety",
    name = "Content Safety Policy",
    rules = new object[]
    {
        new
        {
            evaluatorId = "contains",
            name = "Block competitor mentions",
            phase = "PostGenerate",
            action = "Block",
            config = new { searchPattern = "CompetitorBrand", ignoreCase = true },
            sortOrder = 0
        }
    }
};

var response = await httpClient.PostAsJsonAsync("/umbraco/ai/management/api/v1/guardrails", guardrail);
```

{% endcode %}
