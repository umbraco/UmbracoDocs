---
description: >-
    Update an existing test.
---

# Update Test

Updates an existing test. A new version is created automatically.

## Request

```http
PUT /umbraco/ai/management/api/v1/tests/{idOrAlias}
```

### Path Parameters

| Parameter   | Type   | Description        |
| ----------- | ------ | ------------------ |
| `idOrAlias` | string | Test GUID or alias |

### Request Body

{% code title="Request" %}

```json
{
    "alias": "test-summarize-quality",
    "name": "Summarization Quality (Updated)",
    "description": "Validates summarization output with stricter criteria",
    "testFeatureId": "prompt",
    "testTargetId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
    "profileId": "e401f2ff-7d65-5c12-a1f7-e812859a1962",
    "runCount": 5,
    "graders": [
        {
            "graderTypeId": "contains",
            "name": "Has bullet points",
            "config": { "searchPattern": "- ", "ignoreCase": true },
            "severity": "Error",
            "weight": 1.0
        },
        {
            "graderTypeId": "llm-judge",
            "name": "Quality check",
            "config": {
                "evaluationCriteria": "Is the summary concise, accurate, and under 200 words?",
                "passThreshold": 0.8
            },
            "severity": "Error",
            "weight": 1.0
        }
    ],
    "tags": ["quality", "summarization", "updated"]
}
```

{% endcode %}

The request body follows the same structure as [Create Test](create.md). All fields in the request replace the existing values.

## Response

### Success

{% code title="204 No Content" %}

```
(empty response body)
```

{% endcode %}

Use [Get Test](get.md) to retrieve the updated test, including the new `version` and `dateModified` values.

### Not Found

{% code title="404 Not Found" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.4",
    "title": "Not Found",
    "status": 404,
    "detail": "The requested test could not be found."
}
```

{% endcode %}

## Examples

{% code title="cURL" %}

```bash
curl -X PUT "https://your-site.com/umbraco/ai/management/api/v1/tests/3fa85f64-5717-4562-b3fc-2c963f66afa6" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "alias": "test-summarize-quality",
    "name": "Summarization Quality (Updated)",
    "testFeatureId": "prompt",
    "testTargetId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
    "runCount": 5,
    "graders": [
      {
        "graderTypeId": "contains",
        "name": "Has bullet points",
        "config": { "searchPattern": "- ", "ignoreCase": true },
        "severity": "Error"
      }
    ]
  }'
```

{% endcode %}
