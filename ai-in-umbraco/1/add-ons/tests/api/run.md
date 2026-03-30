---
description: >-
    Execute a single test and get results with metrics.
---

# Run Test

Executes a test and returns the results with per-variation metrics. The framework runs the default configuration plus all configured variations under a single execution ID.

## Request

```http
POST /umbraco/ai/management/api/v1/tests/{idOrAlias}/run
```

### Path Parameters

| Parameter   | Type   | Description        |
| ----------- | ------ | ------------------ |
| `idOrAlias` | string | Test GUID or alias |

### Request Body

The request body is optional. Use it to override the profile, contexts, or guardrails for the execution.

{% code title="Request" %}

```json
{
    "profileIdOverride": "e401f2ff-7d65-5c12-a1f7-e812859g1962",
    "contextIdsOverride": ["f512g3hh-8e76-6d23-b2g8-f923960h2073"],
    "guardrailIdsOverride": ["g623h4ii-9f87-7e34-c3h9-g034071i3184"]
}
```

{% endcode %}

### Request Properties

| Property              | Type   | Required | Description                              |
| --------------------- | ------ | -------- | ---------------------------------------- |
| `profileIdOverride`   | guid   | No       | Override profile for all runs            |
| `contextIdsOverride`  | guid[] | No       | Override context IDs for all runs        |
| `guardrailIdsOverride`| guid[] | No       | Override guardrail IDs for all runs      |

## Execution Flow

1. The default configuration runs `RunCount` times
2. Each variation runs with its settings (inherited or overridden `RunCount`)
3. Graders evaluate every run
4. The framework calculates metrics for the default config, each variation, and the aggregate

## Response

### Success

{% code title="200 OK" %}

```json
{
    "testId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "executionId": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
    "batchId": null,
    "defaultMetrics": {
        "testId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        "totalRuns": 3,
        "passedRuns": 2,
        "passAtK": 0.67,
        "passToTheK": 0.0,
        "runIds": [
            "b2c3d4e5-f6a7-8901-bcde-f12345678901",
            "c3d4e5f6-a7b8-9012-cdef-123456789012",
            "d4e5f6a7-b8c9-0123-defa-234567890123"
        ]
    },
    "variationMetrics": [],
    "aggregateMetrics": {
        "testId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        "totalRuns": 3,
        "passedRuns": 2,
        "passAtK": 0.67,
        "passToTheK": 0.0,
        "runIds": [
            "b2c3d4e5-f6a7-8901-bcde-f12345678901",
            "c3d4e5f6-a7b8-9012-cdef-123456789012",
            "d4e5f6a7-b8c9-0123-defa-234567890123"
        ]
    }
}
```

{% endcode %}

### Response Properties

| Property           | Type   | Description                                    |
| ------------------ | ------ | ---------------------------------------------- |
| `testId`           | guid   | The test that was executed                     |
| `executionId`      | guid   | Groups all runs from this execution            |
| `batchId`          | guid   | Batch ID (null for single runs)                |
| `defaultMetrics`   | object | Metrics from the default configuration runs    |
| `variationMetrics` | array  | Metrics for each variation                     |
| `aggregateMetrics` | object | Metrics across all runs (default + variations) |

### Metrics Object

| Property     | Type   | Description                              |
| ------------ | ------ | ---------------------------------------- |
| `testId`     | guid   | The test ID                              |
| `totalRuns`  | int    | Total runs executed                      |
| `passedRuns` | int    | Runs where all Error-severity graders passed |
| `passAtK`    | double | `PassedRuns / TotalRuns`                 |
| `passToTheK` | double | `1.0` if all passed, `0.0` otherwise    |
| `runIds`     | guid[] | IDs of the runs (for detail retrieval)   |

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

### Run with Default Settings

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/tests/test-summarize-quality/run" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{}'
```

{% endcode %}

### Run with Profile Override

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/tests/test-summarize-quality/run" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "profileIdOverride": "e401f2ff-7d65-5c12-a1f7-e812859g1962"
  }'
```

{% endcode %}

## Related

- [List Test Runs](runs.md) - Retrieve individual run details
- [Run Batch](run-batch.md) - Execute multiple tests
- [Compare Runs](compare.md) - Compare two runs
