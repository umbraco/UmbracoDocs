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
            "id": "pii",
            "name": "PII Detection",
            "description": "Detects personal identifiable information using regex patterns for emails, phone numbers, SSNs, and credit card numbers.",
            "type": "CodeBased",
            "configSchema": null
        },
        {
            "id": "toxicity",
            "name": "Toxicity Detection",
            "description": "Detects toxic or harmful language using keyword and pattern matching with configurable word lists.",
            "type": "CodeBased",
            "configSchema": null
        },
        {
            "id": "llm-judge",
            "name": "LLM Judge",
            "description": "Uses an AI model to evaluate content against configurable criteria with a confidence threshold.",
            "type": "ModelBased",
            "configSchema": {
                "fields": [
                    {
                        "alias": "criteria",
                        "name": "Evaluation Criteria",
                        "description": "The criteria the LLM should use to evaluate content.",
                        "type": "string"
                    },
                    {
                        "alias": "threshold",
                        "name": "Threshold",
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
