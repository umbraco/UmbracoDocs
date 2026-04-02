---
description: >-
    Execute all tests matching specified tags.
---

# Run Tests by Tags

Executes all active tests that have ALL specified tags. All matching tests share the same batch ID.

## Request

```http
POST /umbraco/ai/management/api/v1/tests/run-by-tags
```

### Request Body

{% code title="Request" %}

```json
{
    "tags": ["quality", "summarization"],
    "profileIdOverride": null,
    "contextIdsOverride": null,
    "guardrailIdsOverride": null
}
```

{% endcode %}

### Request Properties

| Property               | Type     | Required | Description                              |
| ---------------------- | -------- | -------- | ---------------------------------------- |
| `tags`                 | string[] | Yes      | Tags to filter by (all must match)       |
| `profileIdOverride`    | guid     | No       | Override profile for all matching tests  |
| `contextIdsOverride`   | guid[]   | No       | Override context IDs for all tests       |
| `guardrailIdsOverride` | guid[]   | No       | Override guardrail IDs for all tests     |

{% hint style="info" %}
Tests must have ALL specified tags to be included. A test with tags `["quality"]` does not match a request for `["quality", "summarization"]`.
{% endhint %}

## Response

### Success

The response follows the same structure as [Run Test Batch](run-batch.md) -- a dictionary mapping test IDs to execution results.

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
        }
    }
}
```

{% endcode %}

### Validation Error

{% code title="400 Bad Request" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.1",
    "title": "Invalid request",
    "status": 400,
    "detail": "At least one tag must be provided."
}
```

{% endcode %}

## Examples

### Run All Quality Tests

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/tests/run-by-tags" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "tags": ["quality"]
  }'
```

{% endcode %}

### Run SEO Tests with Profile Override

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/tests/run-by-tags" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "tags": ["seo"],
    "profileIdOverride": "e401f2ff-7d65-5c12-a1f7-e812859g1962"
  }'
```

{% endcode %}

## Related

- [Run Single Test](run.md) - Execute one test
- [Run Batch](run-batch.md) - Execute tests by ID
- [List Test Runs](runs.md) - Query runs by batch ID
