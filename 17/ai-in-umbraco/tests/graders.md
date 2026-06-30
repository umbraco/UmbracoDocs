---
description: >-
    Built-in graders for evaluating AI test outputs.
---

# Graders

Graders define success criteria for evaluating test output. Each grader receives the execution outcome and returns a score (0 to 1) with a pass/fail judgment.

## Shared Configuration

Every grader supports these options in addition to its type-specific configuration:

| Option     | Type   | Default | Description                                    |
| ---------- | ------ | ------- | ---------------------------------------------- |
| `Negate`   | bool   | false   | Inverts the result (pass becomes fail)         |
| `Severity` | string | Error   | `Info`, `Warning`, or `Error`                  |
| `Weight`   | double | 1.0     | Weight for aggregate scoring (0 to 1)          |

**Severity** determines how the grader affects the overall test result:

- **Info** - Informational. Does not affect pass/fail.
- **Warning** - Logs a failure but does not block the test.
- **Error** - Fails the test and blocks (default).

![Configure Contains Grader showing name, severity, weight, negate, and search pattern fields](../.gitbook/assets/backoffice-ai-test-grader-settings.png)

## Code-Based Graders

Code-based graders are deterministic and fast. They return a binary score of 1.0 (pass) or 0.0 (fail).

### exact-match

Validates exact string equality between the output and an expected value.

| Config Property | Type | Default | Description                    |
| --------------- | ---- | ------- | ------------------------------ |
| `ExpectedValue` | string | (empty) | The exact value to match     |
| `IgnoreCase`    | bool | true    | Case-insensitive comparison    |

{% code title="Example" %}

```json
{
    "graderTypeId": "exact-match",
    "name": "Exact output check",
    "config": {
        "expectedValue": "Hello, world!",
        "ignoreCase": true
    }
}
```

{% endcode %}

### contains

Validates that the output contains a specific substring.

| Config Property | Type | Default | Description                    |
| --------------- | ---- | ------- | ------------------------------ |
| `SearchPattern` | string | (empty) | The substring to find        |
| `IgnoreCase`    | bool | true    | Case-insensitive search        |

{% code title="Example" %}

```json
{
    "graderTypeId": "contains",
    "name": "Contains keyword",
    "config": {
        "searchPattern": "Umbraco",
        "ignoreCase": true
    }
}
```

{% endcode %}

{% hint style="info" %}
Use `Negate: true` to assert that output does NOT contain a value. For example, validate that a response does not include prohibited content.
{% endhint %}

### regex

Validates that the output matches a regular expression pattern.

| Config Property | Type | Default | Description                              |
| --------------- | ---- | ------- | ---------------------------------------- |
| `Pattern`       | string | (empty) | The regex pattern to match             |
| `IgnoreCase`    | bool | true    | Case-insensitive matching                |
| `Multiline`     | bool | false   | Enable multiline mode (^ and $ match line boundaries) |

The grader includes match details in the result metadata when the pattern matches (match value, index, length, and named groups).

{% code title="Example" %}

```json
{
    "graderTypeId": "regex",
    "name": "Valid SEO length",
    "config": {
        "pattern": "^.{50,160}$",
        "ignoreCase": false,
        "multiline": false
    }
}
```

{% endcode %}

### json-schema

Validates that the output is valid JSON containing expected keys. Uses dot-notation for nested property paths.

| Config Property  | Type | Default | Description                                  |
| ---------------- | ---- | ------- | -------------------------------------------- |
| `ExpectedKeys`   | string | (empty) | Required JSON keys (comma-separated, dot-notation for nested) |
| `RequireAllKeys` | bool | true    | All keys must be present                     |

{% code title="Example" %}

```json
{
    "graderTypeId": "json-schema",
    "name": "Has required fields",
    "config": {
        "expectedKeys": "title,description,metadata.author",
        "requireAllKeys": true
    }
}
```

{% endcode %}

When `RequireAllKeys` is `false`, the grader passes if at least one expected key is present.

### tool-call

Validates that specific tools were called during execution. This grader inspects the transcript's tool calls rather than the output text.

| Config Property  | Type   | Default | Description                              |
| ---------------- | ------ | ------- | ---------------------------------------- |
| `ExpectedTools`  | string | (empty) | Tool names (comma-separated)             |
| `ValidationMode` | string | Any     | `Any`, `All`, `Exact`, or `None`         |
| `ValidateOrder`  | bool   | false   | Whether tool calls must appear in order  |

**Validation modes:**

| Mode    | Description                                          |
| ------- | ---------------------------------------------------- |
| `Any`   | At least one expected tool was called                |
| `All`   | All expected tools were called (in any order)        |
| `Exact` | The expected tools match the actual calls (same set) |
| `None`  | None of the expected tools were called               |

When `ValidateOrder` is `true` (with `All` or `Exact` mode), the expected tools must appear in the specified sequence.

{% code title="Example" %}

```json
{
    "graderTypeId": "tool-call",
    "name": "Called search tool",
    "config": {
        "expectedTools": "search_content,get_page",
        "validationMode": "All",
        "validateOrder": true
    }
}
```

{% endcode %}

### guardrail

Runs a guardrail evaluator against the test output. The grader passes when the evaluator flags the content.

| Config Property   | Type        | Default | Description                              |
| ----------------- | ----------- | ------- | ---------------------------------------- |
| `EvaluatorId`     | string      | (empty) | The guardrail evaluator to run           |
| `EvaluatorConfig` | JSON (optional) | null  | Evaluator-specific configuration         |

{% code title="Example - Content should be flagged" %}

```json
{
    "graderTypeId": "guardrail",
    "name": "Detects email addresses",
    "config": {
        "evaluatorId": "regex",
        "evaluatorConfig": {
            "pattern": "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}",
            "ignoreCase": true
        }
    }
}
```

{% endcode %}

{% hint style="warning" %}
The guardrail grader passes when the evaluator **flags** the content. To assert that content should NOT be flagged, set `Negate: true` on the grader configuration.
{% endhint %}

{% code title="Example - Content should NOT be flagged" %}

```json
{
    "graderTypeId": "guardrail",
    "name": "No competitor mentions",
    "negate": true,
    "config": {
        "evaluatorId": "contains",
        "evaluatorConfig": {
            "searchPattern": "CompetitorBrand",
            "ignoreCase": true
        }
    }
}
```

{% endcode %}

## Model-Based Graders

Model-based graders use an LLM to evaluate outputs. They return continuous scores between 0 and 1.

### llm-judge

Uses an LLM to evaluate the test output against custom evaluation criteria. The judge returns a score with reasoning.

| Config Property      | Type   | Default | Description                              |
| -------------------- | ------ | ------- | ---------------------------------------- |
| `ProfileId`          | guid   | null    | AI profile for the judge (optional)      |
| `EvaluationCriteria` | string | (default) | What aspects to evaluate               |
| `PassThreshold`      | double | 0.7     | Minimum score to pass (0 to 1)           |

The default evaluation criteria is: "Evaluate the quality, accuracy, and relevance of the response."

{% code title="Example" %}

```json
{
    "graderTypeId": "llm-judge",
    "name": "Content quality",
    "config": {
        "evaluationCriteria": "Evaluate whether the summary is concise, accurate, and captures the key points of the original content.",
        "passThreshold": 0.8
    }
}
```

{% endcode %}

The result metadata includes the judge's reasoning, strengths, and weaknesses.

{% hint style="info" %}
Model-based graders consume AI tokens for each evaluation. Consider using code-based graders for format and structure checks, and reserve the LLM judge for semantic quality evaluation.
{% endhint %}

## Combining Graders

You can add multiple graders to a test. Each grader evaluates independently. A test run passes when all `Error`-severity graders pass.

{% code title="Example - Multiple graders" %}

```json
{
    "graders": [
        {
            "graderTypeId": "regex",
            "name": "Length check",
            "config": { "pattern": "^.{50,160}$" },
            "severity": "Error",
            "weight": 1.0
        },
        {
            "graderTypeId": "contains",
            "name": "Has keyword",
            "config": { "searchPattern": "Umbraco" },
            "severity": "Warning",
            "weight": 0.5
        },
        {
            "graderTypeId": "llm-judge",
            "name": "Quality score",
            "config": {
                "evaluationCriteria": "Is the meta description compelling and action-oriented?",
                "passThreshold": 0.7
            },
            "severity": "Error",
            "weight": 1.0
        }
    ]
}
```

{% endcode %}

In this example, the test fails if the length check or quality score grader fails. The keyword check is a warning and does not block.

## Related

- [Concepts](concepts.md) - Core testing concepts
- [Variations](variations.md) - A/B testing across configurations
- [Guardrails](../concepts/guardrails.md) - Guardrail evaluators
