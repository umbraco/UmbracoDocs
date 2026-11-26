---
description: >-
    API endpoints for managing AI guardrails.
---

# Guardrails API

Guardrails define rules that evaluate AI inputs and responses for safety, compliance, and quality enforcement.

## Endpoints

| Method | Endpoint                                                                              | Description                       |
| ------ | ------------------------------------------------------------------------------------- | --------------------------------- |
| GET    | [`/umbraco/ai/management/api/v1/guardrails`](list.md)                                 | List all guardrails               |
| GET    | [`/umbraco/ai/management/api/v1/guardrails/{guardrailIdOrAlias}`](get.md)             | Get a guardrail by ID or alias    |
| POST   | [`/umbraco/ai/management/api/v1/guardrails`](create.md)                               | Create a new guardrail            |
| PUT    | [`/umbraco/ai/management/api/v1/guardrails/{guardrailIdOrAlias}`](update.md)          | Update an existing guardrail      |
| DELETE | [`/umbraco/ai/management/api/v1/guardrails/{guardrailIdOrAlias}`](delete.md)          | Delete a guardrail                |
| GET    | [`/umbraco/ai/management/api/v1/guardrail-evaluators`](evaluators.md)                 | List available evaluators         |

## Base URL

```
/umbraco/ai/management/api/v1
```

## Guardrail Object

{% code title="Guardrail" %}

```json
{
    "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "alias": "content-safety",
    "name": "Content Safety Policy",
    "version": 2,
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
    "dateModified": "2024-01-20T14:45:00Z"
}
```

{% endcode %}

## Rule Properties

| Property      | Type   | Description                                          |
| ------------- | ------ | ---------------------------------------------------- |
| `id`          | guid   | Unique identifier                                    |
| `evaluatorId` | string | Registered evaluator ID (e.g., "contains", "regex")  |
| `name`        | string | Display name                                         |
| `phase`       | string | `PreGenerate` or `PostGenerate`                      |
| `action`      | string | `Block`, `Warn`, or `Redact`                         |
| `config`      | object | Evaluator-specific configuration (nullable)          |
| `sortOrder`   | int    | Controls evaluation order                            |

## Related

- [Guardrails Concept](../../concepts/guardrails.md)
- [Managing Guardrails](../../backoffice/managing-guardrails.md)
