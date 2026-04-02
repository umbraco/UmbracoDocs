---
description: >-
    List available guardrail evaluators.
---

# List Evaluators

Returns all registered guardrail evaluators with their configuration schemas. Use this endpoint to discover which evaluators are available when creating guardrail rules.

## Request

{% code title="Endpoint" %}

```http
GET /umbraco/ai/management/api/v1/guardrails/evaluators
```

{% endcode %}

## Response

### Success

{% code title="200 OK" %}

```json
{
    "items": [
        {
            "id": "contains",
            "name": "Contains",
            "description": "Flags content containing a specific substring.",
            "type": "CodeBased",
            "configSchema": {
                "fields": [
                    {
                        "alias": "searchPattern",
                        "name": "Search Pattern",
                        "description": "The substring to search for in the content.",
                        "type": "string"
                    },
                    {
                        "alias": "ignoreCase",
                        "name": "Ignore Case",
                        "description": "Whether to perform case-insensitive matching.",
                        "type": "boolean"
                    }
                ]
            }
        },
        {
            "id": "regex",
            "name": "Regex Match",
            "description": "Flags content matching a regular expression pattern.",
            "type": "CodeBased",
            "configSchema": {
                "fields": [
                    {
                        "alias": "pattern",
                        "name": "Pattern",
                        "description": "The regular expression pattern to match.",
                        "type": "string"
                    },
                    {
                        "alias": "ignoreCase",
                        "name": "Ignore Case",
                        "description": "Whether to perform case-insensitive matching.",
                        "type": "boolean"
                    },
                    {
                        "alias": "multiline",
                        "name": "Multiline",
                        "description": "Whether to enable multiline mode.",
                        "type": "boolean"
                    }
                ]
            }
        },
        {
            "id": "llm-judge",
            "name": "LLM Safety Judge",
            "description": "Uses an AI model to evaluate content for safety and compliance against configurable criteria.",
            "type": "ModelBased",
            "configSchema": {
                "fields": [
                    {
                        "alias": "profileId",
                        "name": "Profile",
                        "description": "The AI profile to use for evaluation.",
                        "type": "string"
                    },
                    {
                        "alias": "evaluationCriteria",
                        "name": "Evaluation Criteria",
                        "description": "The criteria the LLM should use to evaluate content.",
                        "type": "string"
                    },
                    {
                        "alias": "safetyThreshold",
                        "name": "Safety Threshold",
                        "description": "Confidence threshold (0-1) above which content is flagged.",
                        "type": "number"
                    }
                ]
            }
        }
    ]
}
```

{% endcode %}

## Response Properties

| Property       | Type   | Description                                                |
| -------------- | ------ | ---------------------------------------------------------- |
| `id`           | string | Unique evaluator identifier                                |
| `name`         | string | Display name                                               |
| `description`  | string | What the evaluator checks                                  |
| `type`         | string | `CodeBased` or `ModelBased`                                |
| `configSchema` | object | Configuration schema for UI rendering (nullable)           |

## Examples

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/guardrails/evaluators" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

{% code title="C#" %}

```csharp
var response = await httpClient.GetAsync("/umbraco/ai/management/api/v1/guardrails/evaluators");
var evaluators = await response.Content.ReadFromJsonAsync<ItemsResult<GuardrailEvaluatorInfoModel>>();
```

{% endcode %}
