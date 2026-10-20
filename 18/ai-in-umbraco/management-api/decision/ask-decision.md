---
description: >-
    Ask a Decision profile a yes/no, pick-one, or score question and get a typed answer.
---

# Ask Decision

{% hint style="warning" %}
Returns **404** with an empty body when the `Umbraco:AI:Experimental:Decision` feature flag is disabled. The flag is checked before the request body is read or validated.
{% endhint %}

```http
POST /umbraco/ai/management/api/v1/decision/ask
```

## Request Body

The `state` property holds the content being judged. The `question` object is polymorphic. Its `$type` property selects the kind of question: `binary`, `choice`, or `score`.

### Binary Question

{% code title="application/json" %}

```json
{
    "profileIdOrAlias": "moderation",
    "state": "Buy cheap watches at example.com",
    "question": {
        "$type": "binary",
        "instructions": "Is this comment spam?",
        "trueCriteria": "Promotional, a scam, or unrelated links",
        "falseCriteria": "A genuine comment from a reader"
    }
}
```

{% endcode %}

### Choice Question

{% code title="application/json" %}

```json
{
    "state": "I was charged twice for my subscription.",
    "question": {
        "$type": "choice",
        "instructions": "Which team should handle this message?",
        "options": [
            { "key": "billing", "description": "Invoices, payments, and refunds" },
            { "key": "technical", "description": "Errors, bugs, and how-to questions" },
            { "key": "sales" }
        ]
    }
}
```

{% endcode %}

### Score Question

{% code title="application/json" %}

```json
{
    "state": "Our new plans give you more storage for the same price.",
    "question": {
        "$type": "score",
        "instructions": "How easy is this summary to read for a general audience?",
        "levels": [
            { "description": "poor" },
            { "description": "ok" },
            { "description": "good" }
        ]
    }
}
```

{% endcode %}

| Property | Type | Required | Description |
| --- | --- | --- | --- |
| `profileIdOrAlias` | string | No | Profile ID or alias. Uses the default Decision profile if omitted. |
| `state` | string | No | The content being judged, such as a comment or a page body. |
| `question` | object | Yes | The question to ask. |
| `question.$type` | string | Yes | `"binary"`, `"choice"`, or `"score"`. |
| `question.instructions` | string | Yes | What to decide. Must not be empty. |
| `question.trueCriteria` | string | No | Binary only. What counts as "yes". |
| `question.falseCriteria` | string | No | Binary only. What counts as "no". |
| `question.options` | array | Choice only | 2 to 255 options. Each has a unique, non-empty `key` and an optional `description`. |
| `question.levels` | array | Score only | 2 to 10 levels, lowest first. Each has a non-empty `description`. |

## Response

The response `$type` matches the question's `$type`. `confidence` is left out when the provider does not report one.

### Binary Response

{% code title="200 OK" %}

```json
{
    "$type": "binary",
    "trueProbability": 0.97,
    "modelId": "jev-latest",
    "usage": {
        "inputTokens": 42,
        "outputTokens": 1,
        "totalTokens": 43
    }
}
```

{% endcode %}

### Choice Response

{% code title="200 OK" %}

```json
{
    "$type": "choice",
    "choice": "billing",
    "confidence": 0.91,
    "probabilities": {
        "billing": 0.91,
        "technical": 0.07,
        "sales": 0.02
    },
    "modelId": "jev-latest",
    "usage": {
        "inputTokens": 58,
        "outputTokens": 1,
        "totalTokens": 59
    }
}
```

{% endcode %}

### Score Response

{% code title="200 OK" %}

```json
{
    "$type": "score",
    "score": 1.8,
    "confidence": 0.8,
    "probabilities": {
        "0": 0.05,
        "1": 0.15,
        "2": 0.8
    },
    "modelId": "jev-latest",
    "usage": {
        "inputTokens": 51,
        "outputTokens": 1,
        "totalTokens": 52
    }
}
```

{% endcode %}

| Property | Type | Applies to | Description |
| --- | --- | --- | --- |
| `$type` | string | All | `"binary"`, `"choice"`, or `"score"`. |
| `trueProbability` | number | Binary | The estimated probability that the answer is "yes", from 0.0 to 1.0. Apply your own threshold to turn it into a yes/no answer. |
| `choice` | string | Choice | The `key` of the chosen option. |
| `score` | number | Score | A 0-based, fractional index into `levels`. |
| `confidence` | number | Choice, Score | The provider's own confidence in the answer, from 0.0 to 1.0. Left out when the provider does not report one. |
| `probabilities` | object | Choice, Score | The estimated probability for every option or level. Choice probabilities are keyed by option `key`. Score probabilities are keyed by level index, from `"0"` for the lowest level. |
| `modelId` | string | All | The model that produced the answer, when known. |
| `usage` | object | All | Token usage (`inputTokens`, `outputTokens`, `totalTokens`), when reported. |

## Status Codes

| Code | Meaning |
| --- | --- |
| 200 | The question was answered. |
| 400 | The question is invalid, or no answer could be produced. See below. |
| 404 | The feature flag is disabled (empty body), or `profileIdOrAlias` did not match a profile (`Profile not found`). |

A `400` response returns `ProblemDetails` in these cases:

- The request body is missing required properties, or `$type` is missing or unknown.
- `instructions` is empty.
- A choice question has fewer than 2 or more than 255 options, or an option key is empty or duplicated.
- A score question has fewer than 2 or more than 10 levels, or a level is empty.
- The profile is not a Decision profile.
- `profileIdOrAlias` is omitted and no default Decision profile is configured.
- The provider call failed, for example because of an invalid API key, rate limiting, or a request the provider rejected.
- The provider's answer was incomplete or inconsistent, for example a missing probability or a choice that is not one of the keys. The call is recorded as failed.

Invalid questions are rejected before any provider is called.

## Example

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/decision/ask" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "state": "Buy cheap watches", "question": { "$type": "binary", "instructions": "Is this comment spam?" } }'
```

{% endcode %}

## Related

- [Decision API overview](README.md)
- [Using the Decision API](../../using-the-api/decision/README.md)
- [Decision Controller](../../frontend/decision-controller.md)
