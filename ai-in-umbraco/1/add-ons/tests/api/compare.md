---
description: >-
    Compare test runs and variations for regression detection.
---

# Compare Runs and Variations

Two endpoints support comparison: one for comparing individual runs and one for comparing variation groups within an execution.

## Compare Test Runs

Compares two test runs and detects regressions at the grader level.

### Request

```http
POST /umbraco/ai/management/api/v1/test-runs/compare
```

### Request Body

{% code title="Request" %}

```json
{
    "baselineTestRunId": "b2c3d4e5-f6a7-8901-bcde-f12345678901",
    "comparisonTestRunId": "c3d4e5f6-a7b8-9012-cdef-123456789012"
}
```

{% endcode %}

### Request Properties

| Property              | Type | Required | Description              |
| --------------------- | ---- | -------- | ------------------------ |
| `baselineTestRunId`   | guid | Yes      | The baseline run ID      |
| `comparisonTestRunId` | guid | Yes      | The comparison run ID    |

### Response

{% code title="200 OK" %}

```json
{
    "baselineRun": {
        "id": "b2c3d4e5-f6a7-8901-bcde-f12345678901",
        "testId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        "status": "Passed",
        "durationMs": 1250,
        ...
    },
    "comparisonRun": {
        "id": "c3d4e5f6-a7b8-9012-cdef-123456789012",
        "testId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        "status": "Failed",
        "durationMs": 1480,
        ...
    },
    "isRegression": true,
    "isImprovement": false,
    "durationChangeMs": 230,
    "graderComparisons": [
        {
            "graderId": "a1b2c3d4-0000-0000-0000-000000000001",
            "graderName": "Has bullet points",
            "baselineResult": {
                "graderId": "a1b2c3d4-0000-0000-0000-000000000001",
                "passed": true,
                "score": 1.0,
                "severity": "Error"
            },
            "comparisonResult": {
                "graderId": "a1b2c3d4-0000-0000-0000-000000000001",
                "passed": false,
                "score": 0.0,
                "failureMessage": "Expected output to contain '- ' but it was not found",
                "severity": "Error"
            },
            "changed": true,
            "scoreChange": -1.0
        }
    ]
}
```

{% endcode %}

### Response Properties

| Property            | Type   | Description                                    |
| ------------------- | ------ | ---------------------------------------------- |
| `baselineRun`       | object | Full baseline run details                      |
| `comparisonRun`     | object | Full comparison run details                    |
| `isRegression`      | bool   | True if comparison failed where baseline passed |
| `isImprovement`     | bool   | True if comparison passed where baseline failed |
| `durationChangeMs`  | long   | Duration change (positive = slower)            |
| `graderComparisons` | array  | Per-grader comparison results                  |

### Grader Comparison Properties

| Property           | Type   | Description                                    |
| ------------------ | ------ | ---------------------------------------------- |
| `graderId`         | guid   | The grader ID                                  |
| `graderName`       | string | The grader display name                        |
| `baselineResult`   | object | Grader result from the baseline run            |
| `comparisonResult` | object | Grader result from the comparison run          |
| `changed`          | bool   | Whether the grader result changed              |
| `scoreChange`      | double | Score difference (positive = improvement)      |

### Error Responses

{% code title="400 Bad Request" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.1",
    "title": "Bad request",
    "status": 400,
    "detail": "Both runs must belong to the same test."
}
```

{% endcode %}

{% code title="404 Not Found" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.4",
    "title": "Not Found",
    "status": 404,
    "detail": "Test run not found"
}
```

{% endcode %}

## Compare Variations

Compares two variation groups within the same execution for pairwise drill-down.

### Request

```http
POST /umbraco/ai/management/api/v1/test-runs/compare-variations
```

### Request Body

{% code title="Request" %}

```json
{
    "executionId": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
    "sourceVariationId": null,
    "comparisonVariationId": "var-1-guid"
}
```

{% endcode %}

### Request Properties

| Property                | Type | Required | Description                              |
| ----------------------- | ---- | -------- | ---------------------------------------- |
| `executionId`           | guid | Yes      | Execution containing both variations     |
| `sourceVariationId`     | guid | No       | Source variation (null = default config)  |
| `comparisonVariationId` | guid | Yes      | Variation to compare against             |

### Response

{% code title="200 OK" %}

```json
{
    "sourceVariationName": "Default",
    "sourceMetrics": {
        "testId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        "totalRuns": 3,
        "passedRuns": 3,
        "passAtK": 1.0,
        "passToTheK": 1.0,
        "runIds": ["run-1", "run-2", "run-3"]
    },
    "comparisonVariationName": "Claude Sonnet",
    "comparisonMetrics": {
        "testId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        "totalRuns": 3,
        "passedRuns": 2,
        "passAtK": 0.67,
        "passToTheK": 0.0,
        "runIds": ["run-4", "run-5", "run-6"]
    },
    "passRateDelta": -0.33,
    "averageDurationDeltaMs": 150.0,
    "isRegression": true,
    "isImprovement": false
}
```

{% endcode %}

### Response Properties

| Property                    | Type   | Description                              |
| --------------------------- | ------ | ---------------------------------------- |
| `sourceVariationName`       | string | Source variation name ("Default" or name) |
| `sourceMetrics`             | object | Metrics for the source variation         |
| `comparisonVariationName`   | string | Comparison variation name                |
| `comparisonMetrics`         | object | Metrics for the comparison variation     |
| `passRateDelta`             | double | Difference in pass rate (comparison - source) |
| `averageDurationDeltaMs`    | double | Difference in average duration (positive = slower) |
| `isRegression`              | bool   | Whether the comparison is a regression   |
| `isImprovement`             | bool   | Whether the comparison is an improvement |

## Examples

### Compare Against Baseline

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/test-runs/compare" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "baselineTestRunId": "b2c3d4e5-f6a7-8901-bcde-f12345678901",
    "comparisonTestRunId": "c3d4e5f6-a7b8-9012-cdef-123456789012"
  }'
```

{% endcode %}

### Compare Default vs Variation

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/test-runs/compare-variations" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "executionId": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
    "sourceVariationId": null,
    "comparisonVariationId": "var-1-guid"
  }'
```

{% endcode %}

## Related

- [Run Test](run.md) - Execute a test
- [List Test Runs](runs.md) - Query runs
- [Variations](../variations.md) - A/B testing concepts
