---
description: >-
    Create a new test.
---

# Create Test

Creates a new test definition with graders and optional variations.

## Request

```http
POST /umbraco/ai/management/api/v1/tests
```

### Request Body

{% code title="Request" %}

```json
{
    "alias": "test-summarize-quality",
    "name": "Summarization Quality",
    "description": "Validates summarization output quality and format",
    "testFeatureId": "prompt",
    "testTargetId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
    "profileId": "e401f2ff-7d65-5c12-a1f7-e812859a1962",
    "contextIds": [],
    "testFeatureConfig": {
        "variables": {
            "content": "Umbraco is a flexible CMS built on .NET..."
        }
    },
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
                "evaluationCriteria": "Is the summary concise and accurate?",
                "passThreshold": 0.7
            },
            "severity": "Error",
            "weight": 1.0
        }
    ],
    "variations": [
        {
            "name": "Claude Sonnet",
            "profileId": "CLAUDE_PROFILE_GUID"
        }
    ],
    "runCount": 3,
    "tags": ["quality", "summarization"]
}
```

{% endcode %}

### Request Properties

| Property            | Type     | Required | Description                                    |
| ------------------- | -------- | -------- | ---------------------------------------------- |
| `alias`             | string   | Yes      | Unique alias (URL-safe)                        |
| `name`              | string   | Yes      | Display name                                   |
| `testFeatureId`     | string   | Yes      | Test feature: `prompt` or `agent`              |
| `testTargetId`      | guid     | Yes      | ID of the prompt or agent to test              |
| `graders`           | array    | Yes      | At least one grader (see below)                |
| `description`       | string   | No       | Optional description                           |
| `profileId`         | guid     | No       | Default AI profile                             |
| `contextIds`        | guid[]   | No       | Default AI contexts                            |
| `testFeatureConfig` | object   | No       | Feature-specific configuration (JSON)          |
| `variations`        | array    | No       | A/B testing overrides                          |
| `runCount`          | int      | No       | Number of runs per execution (default: 1)      |
| `tags`              | string[] | No       | Organization tags                              |

### Grader Properties

| Property       | Type   | Required | Description                                    |
| -------------- | ------ | -------- | ---------------------------------------------- |
| `graderTypeId` | string | Yes      | Grader type (for example, `exact-match`, `llm-judge`) |
| `name`         | string | Yes      | Display name for the grader instance           |
| `description`  | string | No       | What the grader validates                      |
| `config`       | object | No       | Grader-specific configuration (JSON)           |
| `negate`       | bool   | No       | Invert the result (default: false)             |
| `severity`     | string | No       | `Info`, `Warning`, or `Error` (default: Error) |
| `weight`       | double | No       | Weight for scoring, 0 to 1 (default: 1.0)     |

### Variation Properties

| Property            | Type   | Required | Description                                    |
| ------------------- | ------ | -------- | ---------------------------------------------- |
| `name`              | string | Yes      | Display name                                   |
| `description`       | string | No       | What the variation tests                       |
| `profileId`         | guid   | No       | Profile override                               |
| `runCount`          | int    | No       | Run count override                             |
| `contextIds`        | guid[] | No       | Context IDs override                           |
| `testFeatureConfig` | object | No       | Feature config override (deep-merged)          |

## Response

### Success

Returns `201 Created` with the new test's ID in the response body and a `Location` header pointing to the created test.

{% code title="201 Created" %}

```json
"3fa85f64-5717-4562-b3fc-2c963f66afa6"
```

{% endcode %}

Use [Get Test](get.md) with the returned ID to retrieve the full test details.

### Validation Error

{% code title="400 Bad Request" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.1",
    "title": "Duplicate alias",
    "status": 400,
    "detail": "A test with this alias already exists."
}
```

{% endcode %}

## Examples

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/tests" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "alias": "test-seo-length",
    "name": "SEO Description Length",
    "testFeatureId": "prompt",
    "testTargetId": "PROMPT_GUID",
    "runCount": 1,
    "graders": [
      {
        "graderTypeId": "regex",
        "name": "Length 50-160 chars",
        "config": { "pattern": "^.{50,160}$" },
        "severity": "Error"
      }
    ],
    "tags": ["seo", "format"]
  }'
```

{% endcode %}
