---
description: >-
    List available guardrail evaluators.
---

# List Evaluators

Returns all registered guardrail evaluators with their configuration schemas. Use this endpoint to discover which evaluators are available when creating guardrail rules.

## Request

{% code title="Endpoint" %}

```http
GET /umbraco/ai/management/api/v1/guardrail-evaluators
```

{% endcode %}

## Response

### Success

{% code title="200 OK" %}

```json
[
    {
        "id": "contains",
        "name": "Contains",
        "description": "Flags content containing a specific substring.",
        "type": "CodeBased",
        "supportsRedaction": false,
        "configSchema": {
            "fields": [
                {
                    "key": "searchPattern",
                    "label": "Search Pattern",
                    "description": "The substring to search for in the content.",
                    "editorUiAlias": "Umb.PropertyEditorUi.TextBox",
                    "defaultValue": null,
                    "sortOrder": 0,
                    "isRequired": true
                },
                {
                    "key": "ignoreCase",
                    "label": "Ignore Case",
                    "description": "Whether to perform case-insensitive matching.",
                    "editorUiAlias": "Umb.PropertyEditorUi.Toggle",
                    "defaultValue": true,
                    "sortOrder": 1,
                    "isRequired": false
                }
            ]
        }
    },
    {
        "id": "llm-judge",
        "name": "LLM Safety Judge",
        "description": "Uses an AI model to evaluate content for safety and compliance against configurable criteria.",
        "type": "ModelBased",
        "supportsRedaction": false,
        "configSchema": {
            "fields": [
                {
                    "key": "profileId",
                    "label": "Profile",
                    "description": "The AI profile to use for evaluation.",
                    "editorUiAlias": "Umb.PropertyEditorUi.TextBox",
                    "defaultValue": null,
                    "sortOrder": 0,
                    "isRequired": true
                }
            ]
        }
    }
]
```

{% endcode %}

## Response Properties

| Property            | Type    | Description                                                                     |
| ------------------- | ------- | ------------------------------------------------------------------------------- |
| `id`                | string  | Unique evaluator identifier                                                     |
| `name`              | string  | Display name                                                                    |
| `description`       | string  | What the evaluator checks                                                       |
| `type`              | string  | `CodeBased` or `ModelBased`                                                     |
| `supportsRedaction` | boolean | Whether the evaluator supports the `Redact` action                              |
| `configSchema`      | object  | Configuration schema for UI rendering (nullable when no configuration required) |

### Config Schema Field Properties

| Property        | Type    | Description                                         |
| --------------- | ------- | --------------------------------------------------- |
| `key`           | string  | Unique key identifying the setting                  |
| `label`         | string  | Display label for the setting                       |
| `description`   | string  | Help text for the setting                           |
| `editorUiAlias` | string  | UI alias of the editor used for the setting        |
| `editorConfig`  | object  | Configuration for the editor                        |
| `defaultValue`  | object  | Default value for the setting                       |
| `sortOrder`     | int     | Sort order of the setting in the UI                 |
| `isRequired`    | boolean | Whether the setting must be provided                |
| `group`         | string  | Optional group name for visual grouping in the UI   |

## Examples

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/guardrail-evaluators" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

{% code title="C#" %}

```csharp
var response = await httpClient.GetAsync("/umbraco/ai/management/api/v1/guardrail-evaluators");
var evaluators = await response.Content.ReadFromJsonAsync<GuardrailEvaluatorInfoModel[]>();
```

{% endcode %}
