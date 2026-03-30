---
description: >-
    List test runs with filtering.
---

# List Test Runs

Returns a paginated list of test runs with optional filtering by test, batch, status, execution, or variation.

## Request

```http
GET /umbraco/ai/management/api/v1/test-runs
```

### Query Parameters

| Parameter     | Type   | Default | Description                              |
| ------------- | ------ | ------- | ---------------------------------------- |
| `skip`        | int    | 0       | Number of items to skip                  |
| `take`        | int    | 20      | Number of items to return                |
| `testId`      | guid   | null    | Filter by test ID                        |
| `batchId`     | guid   | null    | Filter by batch ID                       |
| `status`      | string | null    | Filter by status: `Running`, `Passed`, `Failed`, `Error` |
| `executionId` | guid   | null    | Filter by execution ID                   |
| `variationId` | guid   | null    | Filter by variation ID                   |

## Response

### Success

{% code title="200 OK" %}

```json
{
    "total": 3,
    "items": [
        {
            "id": "b2c3d4e5-f6a7-8901-bcde-f12345678901",
            "testId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
            "testName": "Summarization Quality",
            "testVersion": 1,
            "runNumber": 1,
            "profileId": "e401f2ff-7d65-5c12-a1f7-e812859g1962",
            "contextIds": [],
            "executedAt": "2024-06-15T11:00:00Z",
            "executedByUserId": "user-guid",
            "status": "Passed",
            "durationMs": 1250,
            "transcriptId": "t1-guid",
            "outcome": {
                "outputType": "Text",
                "outputValue": "- Point one\n- Point two\n- Point three",
                "finishReason": "stop",
                "tokenUsage": {
                    "inputTokens": 150,
                    "outputTokens": 45,
                    "totalTokens": 195
                }
            },
            "graderResults": [
                {
                    "graderId": "a1b2c3d4-0000-0000-0000-000000000001",
                    "graderName": "Has bullet points",
                    "graderTypeId": "contains",
                    "graderType": "CodeBased",
                    "weight": 1.0,
                    "negate": false,
                    "passed": true,
                    "score": 1.0,
                    "actualValue": "- Point one\n- Point two\n- Point three",
                    "expectedValue": "- ",
                    "failureMessage": null,
                    "metadata": null,
                    "severity": "Error"
                }
            ],
            "error": null,
            "batchId": null,
            "isBaseline": false,
            "baselineRunId": null,
            "executionId": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
            "variationId": null,
            "variationName": null
        }
    ]
}
```

{% endcode %}

### Run Response Properties

| Property        | Type   | Description                                    |
| --------------- | ------ | ---------------------------------------------- |
| `id`            | guid   | Run unique identifier                          |
| `testId`        | guid   | The test that was run                          |
| `testName`      | string | Test name at time of execution                 |
| `testVersion`   | int    | Test version at time of execution              |
| `runNumber`     | int    | Run number within the execution (1 to N)       |
| `profileId`     | guid   | Profile used for the run                       |
| `contextIds`    | guid[] | Contexts used for the run                      |
| `executedAt`    | date   | Execution timestamp (UTC)                      |
| `status`        | string | `Running`, `Passed`, `Failed`, or `Error`      |
| `durationMs`    | long   | Execution duration in milliseconds             |
| `transcriptId`  | guid   | Transcript ID for the full execution trace     |
| `outcome`       | object | The test output (type, value, tokens)          |
| `graderResults` | array  | Per-grader results                             |
| `error`         | object | Error details if the run failed with an exception |
| `batchId`       | guid   | Batch ID if part of a batch                    |
| `isBaseline`    | bool   | Whether this run is the baseline               |
| `executionId`   | guid   | Groups all runs from one execution             |
| `variationId`   | guid   | Variation ID (null for default config)         |
| `variationName` | string | Variation display name (null for default)      |

## Examples

### List All Runs for a Test

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/test-runs?testId=3fa85f64-5717-4562-b3fc-2c963f66afa6" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

### List Failed Runs

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/test-runs?status=Failed" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

### List Runs by Batch

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/test-runs?batchId=f1e2d3c4-b5a6-9870-fedc-ba0987654321" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

### List Runs for an Execution

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/test-runs?executionId=a1b2c3d4-e5f6-7890-abcd-ef1234567890" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

### List Variation-Specific Runs

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/test-runs?executionId=a1b2c3d4-e5f6-7890-abcd-ef1234567890&variationId=var-1-guid" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

## Related

- [Run Test](run.md) - Execute a test
- [Compare Runs](compare.md) - Compare two runs
