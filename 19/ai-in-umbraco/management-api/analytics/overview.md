---
description: >-
    Get usage totals and a time series for a date range and an optional comparison range.
---

# Get Usage Overview

Returns raw usage counts for a range of local days, and a time series of the same counts. You can also ask for the same figures for a comparison range, such as the previous week.

The counts are raw sums. Work out rates and averages from them, for example the success rate as `succeeded / requests`.

## Request

{% code title="Endpoint" %}

```http
GET /umbraco/ai/management/api/v1/analytics/usage-overview
```

{% endcode %}

### Query Parameters

| Parameter     | Type   | Required | Description |
| ------------- | ------ | -------- | ----------- |
| `from`        | date   | Yes      | First local day of the range (`yyyy-MM-dd`) |
| `to`          | date   | Yes      | Last local day of the range, inclusive (`yyyy-MM-dd`) |
| `compareFrom` | date   | No       | First local day of the comparison range. Send it together with `compareTo`. |
| `compareTo`   | date   | No       | Last local day of the comparison range, inclusive |
| `timeZone`    | string | No       | Time zone ID the days are local to, for example `Europe/Copenhagen`. Defaults to UTC. |
| `groupBy`     | string | No       | Bucket size of the time series: `Hour`, `Day`, `Week`, or `Month`. Defaults to `Day`. |
| `weekStart`   | int    | No       | Day weeks start on when `groupBy` is `Week`, from `1` (Monday) to `7` (Sunday). Defaults to `1`. |

A range can be at most 1,830 days long.

With `groupBy=Hour`, a range and a comparison range can each be at most two days long. Hourly counts come from the hourly usage statistics, so hours older than their retention period read as zeros. For more information, see the [Usage Analytics](../../backoffice/usage-analytics.md#configuration) article.

## Response

### Success

{% code title="200 OK" %}

```json
{
    "current": {
        "buckets": [
            {
                "cachedInputTokens": null,
                "durationMs": 0,
                "failed": 0,
                "inputTokens": 0,
                "nestedRequests": 0,
                "outputTokens": 0,
                "requests": 0,
                "start": "2026-11-11",
                "succeeded": 0,
                "totalTokens": 0
            },
            {
                "cachedInputTokens": 35500,
                "durationMs": 63840,
                "failed": 1,
                "inputTokens": 88500,
                "nestedRequests": 3,
                "outputTokens": 889,
                "requests": 21,
                "start": "2026-11-12",
                "succeeded": 20,
                "totalTokens": 89389
            }
        ],
        "from": "2026-11-11",
        "hourlyBuckets": [],
        "to": "2026-11-12",
        "totals": {
            "cachedInputTokens": 35500,
            "durationMs": 63840,
            "failed": 1,
            "inputTokens": 88500,
            "nestedRequests": 3,
            "outputTokens": 889,
            "requests": 21,
            "succeeded": 20,
            "totalTokens": 89389
        }
    },
    "previous": {
        "buckets": [
            {
                "cachedInputTokens": null,
                "durationMs": 12500,
                "failed": 0,
                "inputTokens": 16000,
                "nestedRequests": 1,
                "outputTokens": 250,
                "requests": 5,
                "start": "2026-11-09",
                "succeeded": 5,
                "totalTokens": 16250
            },
            {
                "cachedInputTokens": null,
                "durationMs": 17600,
                "failed": 0,
                "inputTokens": 24200,
                "nestedRequests": 1,
                "outputTokens": 360,
                "requests": 7,
                "start": "2026-11-10",
                "succeeded": 7,
                "totalTokens": 24560
            }
        ],
        "from": "2026-11-09",
        "hourlyBuckets": [],
        "to": "2026-11-10",
        "totals": {
            "cachedInputTokens": null,
            "durationMs": 30100,
            "failed": 0,
            "inputTokens": 40200,
            "nestedRequests": 2,
            "outputTokens": 610,
            "requests": 12,
            "succeeded": 12,
            "totalTokens": 40810
        }
    }
}
```

{% endcode %}

### Error Responses

The endpoint returns `400 Bad Request` with problem details when:

* `to` is before `from`, or `compareTo` is before `compareFrom`.
* Only one of `compareFrom` and `compareTo` is sent.
* A range is longer than allowed.
* `timeZone` isn't a known time zone ID.
* `weekStart` isn't from `1` to `7`.

## Examples

### Last Two Days Compared With the Two Days Before

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/analytics/usage-overview?from=2026-11-11&to=2026-11-12&compareFrom=2026-11-09&compareTo=2026-11-10&timeZone=Europe/Copenhagen" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

### Today by Hour

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/analytics/usage-overview?from=2026-11-12&to=2026-11-12&groupBy=Hour&timeZone=Europe/Copenhagen" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

## Response Properties

| Property   | Type   | Description |
| ---------- | ------ | ----------- |
| `current`  | object | The requested range |
| `previous` | object | The comparison range. `null` when no comparison range was sent. |

Each range has these properties:

| Property        | Type   | Description |
| --------------- | ------ | ----------- |
| `from`          | date   | First local day of the range |
| `to`            | date   | Last local day of the range, inclusive |
| `totals`        | object | Counts for the whole range |
| `buckets`       | array  | One bucket per day, week, or month, in order. Buckets without usage hold zeros. Empty when grouped by hour. |
| `hourlyBuckets` | array  | One bucket per hour, in order. Hours without usage hold zeros. Empty unless grouped by hour. |

A bucket in `buckets` has a `start` date: the day itself, the first day of its week, or the first day of its month. The first week or month bucket can start before the range does.

A bucket in `hourlyBuckets` has a `start` date and time with the time zone's offset, for example `2026-11-12T09:00:00+01:00`. A day with a clock change has 23 or 25 hourly buckets.

Totals and buckets hold these counts:

| Property            | Type | Description |
| ------------------- | ---- | ----------- |
| `requests`          | int  | Number of requests |
| `nestedRequests`    | int  | How many of the requests ran inside another tracked AI operation, for example a guardrail check |
| `succeeded`         | int  | Successful requests |
| `failed`            | int  | Failed or blocked requests |
| `inputTokens`       | long | Input tokens consumed |
| `cachedInputTokens` | long | The part of `inputTokens` served from a provider's prompt cache. `null` when no provider reported it. |
| `outputTokens`      | long | Output tokens generated |
| `totalTokens`       | long | Input and output tokens together |
| `durationMs`        | long | Time spent in requests, in milliseconds |

## Related

* [Get Usage Breakdown](breakdown.md) - Usage per provider, model, profile, or user
* [Analytics API](README.md) - All analytics endpoints
