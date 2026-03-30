---
description: >-
    Management API endpoints for AI Testing and Evaluation.
---

# Test API

The Test API provides endpoints for creating, managing, and executing AI tests, as well as querying and comparing test runs.

## Test Endpoints

| Method | Endpoint                                          | Description               |
| ------ | ------------------------------------------------- | ------------------------- |
| GET    | [`/tests`](list.md)                               | List all tests            |
| GET    | [`/tests/{idOrAlias}`](get.md)                    | Get a test by ID or alias |
| POST   | [`/tests`](create.md)                             | Create a new test         |
| PUT    | [`/tests/{id}`](update.md)                        | Update an existing test   |
| DELETE | [`/tests/{id}`](delete.md)                        | Delete a test             |
| POST   | [`/tests/{idOrAlias}/run`](run.md)                | Execute a single test     |
| POST   | [`/tests/run-batch`](run-batch.md)                | Execute multiple tests    |
| POST   | [`/tests/run-by-tags`](run-by-tags.md)            | Execute tests by tags     |

## Test Run Endpoints

| Method | Endpoint                                          | Description                      |
| ------ | ------------------------------------------------- | -------------------------------- |
| GET    | [`/test-runs`](runs.md)                           | List test runs (filtered)        |
| POST   | [`/test-runs/compare`](compare.md)                | Compare two test runs            |
| POST   | [`/test-runs/compare-variations`](compare.md)     | Compare two variation groups     |

## Base URL

```
/umbraco/ai/management/api/v1
```

## Test Object

{% code title="Test" %}

```json
{
    "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "alias": "test-summarize-quality",
    "name": "Summarization Quality",
    "description": "Validates summarization output quality and format",
    "testFeatureId": "prompt",
    "testTargetId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
    "profileId": "e401f2ff-7d65-5c12-a1f7-e812859g1962",
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

## Properties

| Property            | Type     | Description                                    |
| ------------------- | -------- | ---------------------------------------------- |
| `id`                | guid     | Unique identifier                              |
| `alias`             | string   | Unique alias for code references               |
| `name`              | string   | Display name                                   |
| `description`       | string   | Optional description                           |
| `testFeatureId`     | string   | Test feature harness (`prompt`, `agent`)        |
| `testTargetId`      | guid     | ID of the target entity                        |
| `profileId`         | guid     | Default AI profile (optional)                  |
| `contextIds`        | guid[]   | Default AI contexts                            |
| `testFeatureConfig` | object   | Feature-specific configuration (JSON)          |
| `graders`           | array    | Success criteria                               |
| `variations`        | array    | A/B testing overrides                          |
| `runCount`          | int      | Number of runs per execution                   |
| `tags`              | string[] | Organization tags                              |
| `baselineRunId`     | guid     | Baseline run for regression detection          |
| `version`           | int      | Current version number                         |

## Related

- [Test Concepts](../concepts.md)
- [Graders](../graders.md)
- [Variations](../variations.md)
