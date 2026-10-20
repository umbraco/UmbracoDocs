---
description: >-
    Get a test by ID or alias.
---

# Get Test

Returns the full details of a specific test.

## Request

```http
GET /umbraco/ai/management/api/v1/tests/{idOrAlias}
```

### Path Parameters

| Parameter   | Type   | Description        |
| ----------- | ------ | ------------------ |
| `idOrAlias` | string | Test GUID or alias |

## Response

### Success

{% code title="200 OK" %}

```json
{
    "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "alias": "test-summarize-quality",
    "name": "Summarization Quality",
    "description": "Validates summarization output quality and format",
    "testFeatureId": "prompt",
    "testTargetId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
    "profileId": "e401f2ff-7d65-5c12-a1f7-e812859a1962",
    "contextIds": [],
    "testFeatureConfig": {
        "variables": {
            "content": "Sample article text for testing..."
        }
    },
    "graders": [
        {
            "id": "a1b2c3d4-0000-0000-0000-000000000001",
            "graderTypeId": "contains",
            "name": "Has bullet points",
            "config": { "searchPattern": "- ", "ignoreCase": true },
            "negate": false,
            "severity": "Error",
            "weight": 1.0
        },
        {
            "id": "a1b2c3d4-0000-0000-0000-000000000002",
            "graderTypeId": "llm-judge",
            "name": "Quality check",
            "config": {
                "evaluationCriteria": "Is the summary concise and accurate?",
                "passThreshold": 0.7
            },
            "negate": false,
            "severity": "Error",
            "weight": 1.0
        }
    ],
    "variations": [],
    "runCount": 3,
    "tags": ["quality", "summarization"],
    "baselineRunId": null,
    "version": 1,
    "dateCreated": "2024-06-15T10:30:00Z",
    "dateModified": "2024-06-15T10:30:00Z"
}
```

{% endcode %}

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
# By ID
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/tests/3fa85f64-5717-4562-b3fc-2c963f66afa6" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"

# By alias
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/tests/test-summarize-quality" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}
