---
description: >-
  Extract typed values such as text, numbers, dates, and lists from a piece of
  text using an Extraction profile.
---

# Extract Values

{% hint style="warning" %}
Returns **404** with an empty body when the `Umbraco:AI:Experimental:Extraction` feature flag is disabled. The flag is checked before the request body is read or validated.
{% endhint %}

```http
POST /umbraco/ai/management/api/v1/extraction/extract
```

## Request Body

The `state` property holds the text to extract from. Each object in `fields` is polymorphic. Its `$type` property selects the kind of field.

{% code title="application/json" %}
```json
{
    "profileIdOrAlias": "support-extraction",
    "state": "Order A-88412 arrived on 3 October. I paid 701,10 kr, but the mug and the teapot were broken. Please call me before 14:30.",
    "referenceDate": "2026-10-21",
    "fields": [
        { "$type": "text", "id": "orderId", "instructions": "The order number" },
        { "$type": "number", "id": "amount", "instructions": "The amount the customer paid", "unit": "DKK", "decimals": 2 },
        { "$type": "date", "id": "deliveredOn", "instructions": "The date the order was delivered" },
        { "$type": "time", "id": "callBefore", "instructions": "The latest time to call the customer" },
        { "$type": "list", "id": "damagedProducts", "instructions": "Every product that arrived damaged", "itemType": "text" },
        { "$type": "duration", "id": "warranty", "instructions": "How long the warranty lasts", "unit": "months" }
    ]
}
```
{% endcode %}

| Property           | Type   | Required | Description                                                                                      |
| ------------------ | ------ | -------- | ------------------------------------------------------------------------------------------------ |
| `profileIdOrAlias` | string | No       | Profile ID or alias. Uses the default Extraction profile if omitted.                             |
| `state`            | string | Yes      | The text to extract from. Must not be empty.                                                     |
| `referenceDate`    | string | No       | An ISO date (`yyyy-MM-dd`). Relative dates in the text, such as "yesterday", resolve against it. |
| `fields`           | array  | Yes      | The fields to extract. At least one.                                                             |

Every field has these properties:

| Property       | Type   | Required | Description                                                                                                                                                                                      |
| -------------- | ------ | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `$type`        | string | Yes      | `"text"`, `"number"`, `"date"`, `"time"`, `"datetime"`, `"duration"`, or `"list"`. Must be the first property of the field.                                                                      |
| `id`           | string | Yes      | Keys the field's answer in the response. Must start with a letter or underscore, contain only letters, digits, and underscores, and be at most 64 characters. Must be unique within the request. |
| `instructions` | string | Yes      | What the value is. Must not be empty.                                                                                                                                                            |

Some field kinds have extra properties:

| Property   | Applies to           | Type    | Required | Description                                                                                          |
| ---------- | -------------------- | ------- | -------- | ---------------------------------------------------------------------------------------------------- |
| `decimals` | `number`, `duration` | integer | No       | Rounds the value to this many decimal places, from 0 to 6.                                           |
| `integer`  | `number`, `duration` | boolean | No       | When `true`, the value must be a whole number. Defaults to `false`.                                  |
| `unit`     | `number`             | string  | No       | The unit or currency the number is in, such as `"DKK"` or `"kg"`.                                    |
| `unit`     | `duration`           | string  | Yes      | `"seconds"`, `"minutes"`, `"hours"`, `"days"`, `"weeks"`, `"months"`, or `"years"`. Case is ignored. |
| `itemType` | `list`               | string  | No       | `"text"` (default), `"number"`, or `"date"`. Case is ignored.                                        |

## Response

`answers` has one entry per field, keyed by the field `id` exactly as sent. Each answer's `$type` matches its field's `$type`.

{% code title="200 OK" %}
```json
{
    "answers": {
        "orderId": {
            "$type": "text",
            "value": "A-88412",
            "span": { "start": 6, "end": 13 },
            "confidence": 0.99,
            "nullProbability": 0.01,
            "isFound": true
        },
        "amount": {
            "$type": "number",
            "value": 701.1,
            "confidence": 0.99,
            "nullProbability": 0.01,
            "isFound": true
        },
        "deliveredOn": {
            "$type": "date",
            "value": "2026-10-03",
            "confidence": 0.97,
            "nullProbability": 0.02,
            "isFound": true
        },
        "callBefore": {
            "$type": "time",
            "value": "14:30:00",
            "confidence": 0.95,
            "nullProbability": 0.04,
            "isFound": true
        },
        "damagedProducts": {
            "$type": "list",
            "values": ["mug", "teapot"],
            "spans": [
                { "start": 62, "end": 65 },
                { "start": 74, "end": 80 }
            ],
            "confidence": 0.96,
            "nullProbability": 0.02,
            "isFound": true
        },
        "warranty": {
            "$type": "duration",
            "value": null,
            "unit": "months",
            "confidence": 0.93,
            "nullProbability": 0.95,
            "isFound": false
        }
    },
    "modelId": "clairic",
    "usage": {
        "inputTokens": 512,
        "outputTokens": 0,
        "totalTokens": 512
    }
}
```
{% endcode %}

Every answer has these properties:

| Property          | Type    | Description                                                                                                                           |
| ----------------- | ------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| `$type`           | string  | Matches the field's `$type`.                                                                                                          |
| `isFound`         | boolean | `true` when a value was found. A value that is not in the text comes back as `null`, or an empty list, with `isFound` set to `false`. |
| `confidence`      | number  | The model's confidence in the answer, from 0.0 to 1.0. Left out when the provider does not report one.                                |
| `nullProbability` | number  | The model's estimated chance that the value is not in the text, from 0.0 to 1.0. Left out when not reported.                          |

Each answer also has its own value:

| `$type`    | Value properties                                                                                                                                                           |
| ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `text`     | `value` (string or `null`), and `span` (`start` and `end` character offsets into `state`, with `end` exclusive). `span` is left out when the provider does not report one. |
| `number`   | `value` (number or `null`)                                                                                                                                                 |
| `date`     | `value` (`yyyy-MM-dd` or `null`)                                                                                                                                           |
| `time`     | `value` (`HH:mm:ss` or `null`)                                                                                                                                             |
| `datetime` | `value` (ISO 8601 date and time, or `null`)                                                                                                                                |
| `duration` | `value` (number or `null`), and `unit`, which is always the unit the field asked for.                                                                                      |
| `list`     | `values` (array of strings, empty when none are found), and `spans` (one per value in the same order, or empty).                                                           |

The response also has:

| Property  | Type   | Description                                                                                                                                                                                |
| --------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `modelId` | string | The model that produced the answers, as the provider reports it. `null` when unknown. Cloudflare reports Clairic as `clairic`, although profiles use the full ID `@cf/cloudflare/clairic`. |
| `usage`   | object | Token usage (`inputTokens`, `outputTokens`, `totalTokens`) for the whole call. `null` when the provider does not report usage.                                                             |

## Status Codes

| Code | Meaning                                                                                                         |
| ---- | --------------------------------------------------------------------------------------------------------------- |
| 200  | The values were extracted. Fields that were not found are still answered, with `isFound` set to `false`.        |
| 400  | The request is invalid, or no answer could be produced. See below.                                              |
| 404  | The feature flag is disabled (empty body), or `profileIdOrAlias` did not match a profile (`Profile not found`). |

A `400` response returns `ProblemDetails` in these cases:

* The request body is missing required properties, or a `$type` is missing, unknown, or not the first property of its field.
* `state` is empty, or `fields` is empty.
* A field `id` is empty, invalid, or used twice.
* `instructions` is empty.
* `decimals` is outside 0 to 6.
* A duration `unit` or a list `itemType` is not one of the allowed values.
* The profile is not an Extraction profile.
* `profileIdOrAlias` is omitted and no default Extraction profile is configured.
* The provider call failed, for example because of an invalid API token, rate limiting, or a request the provider rejected.
* The provider's answers did not match the fields, for example a missing answer. The call is recorded as failed.

Invalid requests are rejected before any provider is called.

## Example

{% code title="cURL" %}
```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/extraction/extract" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "state": "Order A-88412 arrived on 3 October.", "fields": [ { "$type": "text", "id": "orderId", "instructions": "The order number" } ] }'
```
{% endcode %}

## Related

* [Extraction API overview](./)
* [Using the Extraction API](../../using-the-api/extraction.md)
* [Extraction Controller](../../frontend/extraction-controller.md)
