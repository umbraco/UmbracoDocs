---
description: >-
    Execute multiple tests in a batch.
---

# Run Test Batch

Executes multiple tests in a batch. All tests share the same batch ID for grouping.

## Request

```http
POST /umbraco/ai/management/api/v1/tests/run-batch
```

### Request Body

{% code title="Request" %}

```json
{
    "testIds": [
        "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        "b4c96a75-6828-5673-c4ad-3d074a77bfb7"
    ],
    "profileIdOverride": null,
    "contextIdsOverride": null,
    "guardrailIdsOverride": null
}
```

{% endcode %}

### Request Properties

| Property               | Type   | Required | Description                              |
| ---------------------- | ------ | -------- | ---------------------------------------- |
| `testIds`              | guid[] | Yes      | Test IDs to execute (at least one)       |
| `profileIdOverride`    | guid   | No       | Override profile for all tests           |
| `contextIdsOverride`   | guid[] | No       | Override context IDs for all tests       |
| `guardrailIdsOverride` | guid[] | No       | Override guardrail IDs for all tests     |

## Response

### Success

The response contains a dictionary mapping each test ID to its execution result.

{% code title="200 OK" %}

```json
{
    "results": {
        "3fa85f64-5717-4562-b3fc-2c963f66afa6": {
            "testId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
            "executionId": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
            "batchId": "f1e2d3c4-b5a6-9870-fedc-ba0987654321",
            "defaultMetrics": {
                "testId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
                "totalRuns": 3,
                "passedRuns": 3,
                "passAtK": 1.0,
                "passToTheK": 1.0,
                "runIds": ["run-1", "run-2", "run-3"]
            },
            "variationMetrics": [],
            "aggregateMetrics": {
                "testId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
                "totalRuns": 3,
                "passedRuns": 3,
                "passAtK": 1.0,
                "passToTheK": 1.0,
                "runIds": ["run-1", "run-2", "run-3"]
            }
        },
        "b4c96a75-6828-5673-c4ad-3d074a77bfb7": {
            "testId": "b4c96a75-6828-5673-c4ad-3d074a77bfb7",
            "executionId": "e2f3a4b5-c6d7-8901-fedc-ba9876543210",
            "batchId": "f1e2d3c4-b5a6-9870-fedc-ba0987654321",
            "defaultMetrics": {
                "testId": "b4c96a75-6828-5673-c4ad-3d074a77bfb7",
                "totalRuns": 1,
                "passedRuns": 0,
                "passAtK": 0.0,
                "passToTheK": 0.0,
                "runIds": ["run-4"]
            },
            "variationMetrics": [],
            "aggregateMetrics": {
                "testId": "b4c96a75-6828-5673-c4ad-3d074a77bfb7",
                "totalRuns": 1,
                "passedRuns": 0,
                "passAtK": 0.0,
                "passToTheK": 0.0,
                "runIds": ["run-4"]
            }
        }
    }
}
```

{% endcode %}

{% hint style="info" %}
Tests that cannot be found are excluded from the results. The response only includes tests that were executed.
{% endhint %}

### Validation Error

{% code title="400 Bad Request" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.1",
    "title": "Invalid request",
    "status": 400,
    "detail": "At least one test ID must be provided."
}
```

{% endcode %}

## Examples

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/tests/run-batch" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "testIds": [
      "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "b4c96a75-6828-5673-c4ad-3d074a77bfb7"
    ]
  }'
```

{% endcode %}

## Related

- [Run Single Test](run.md) - Execute one test
- [Run by Tags](run-by-tags.md) - Execute tests by tag
- [List Test Runs](runs.md) - Query batch runs by batch ID
