---
description: >-
    Get one page of usage counts per provider, model, profile, or user.
---

# Get Usage Breakdown

Returns one page of usage rows for a range of local days, broken down by provider, model, profile, or user. Each row holds raw usage counts. You can also ask for each row's counts in a comparison range.

## Request

{% code title="Endpoint" %}

```http
GET /umbraco/ai/management/api/v1/analytics/usage-breakdown
```

{% endcode %}

### Query Parameters

| Parameter       | Type   | Required | Description |
| --------------- | ------ | -------- | ----------- |
| `dimension`     | string | Yes      | What to break usage down by: `Provider`, `Model`, `Profile`, or `User` |
| `from`          | date   | Yes      | First local day of the range (`yyyy-MM-dd`) |
| `to`            | date   | Yes      | Last local day of the range, inclusive (`yyyy-MM-dd`) |
| `compareFrom`   | date   | No       | First local day of the comparison range. Send it together with `compareTo`. |
| `compareTo`     | date   | No       | Last local day of the comparison range, inclusive |
| `timeZone`      | string | No       | Time zone ID the days are local to, for example `Europe/Copenhagen`. Defaults to UTC. |
| `sort`          | string | No       | What to sort rows by: `Name`, `Requests`, `TotalTokens`, `SuccessRate`, or `AverageDuration`. Defaults to `Requests`. |
| `sortDirection` | string | No       | `Ascending` or `Descending`. Defaults to `Descending`. |
| `query`         | string | No       | Text to find in a row's key or name. The search ignores case. |
| `skip`          | int    | No       | Rows to skip. Defaults to `0`. |
| `take`          | int    | No       | Rows to return, from `1` to `100`. Defaults to `10`. |

A range can be at most 1,830 days long.

## Response

### Success

{% code title="200 OK" %}

```json
{
    "items": [
        {
            "current": {
                "cachedInputTokens": 35500,
                "durationMs": 60336,
                "failed": 0,
                "inputTokens": 88200,
                "nestedRequests": 3,
                "outputTokens": 788,
                "requests": 18,
                "succeeded": 18,
                "totalTokens": 88988
            },
            "key": "gpt-4o",
            "name": null,
            "previous": null
        },
        {
            "current": {
                "cachedInputTokens": null,
                "durationMs": 3504,
                "failed": 1,
                "inputTokens": 300,
                "nestedRequests": 0,
                "outputTokens": 101,
                "requests": 3,
                "succeeded": 2,
                "totalTokens": 401
            },
            "key": "gpt-4o-mini",
            "name": null,
            "previous": null
        }
    ],
    "previousTotals": null,
    "total": 2,
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
}
```

{% endcode %}

### Error Responses

The endpoint returns `400 Bad Request` with problem details when:

* `to` is before `from`, or `compareTo` is before `compareFrom`.
* Only one of `compareFrom` and `compareTo` is sent.
* A range is longer than allowed.
* `timeZone` isn't a known time zone ID.
* `skip` is negative, or `take` isn't from `1` to `100`.

## Examples

### Top Models in the Last Seven Days

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/analytics/usage-breakdown?dimension=Model&from=2026-11-06&to=2026-11-12&timeZone=Europe/Copenhagen" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

### Profiles by Total Tokens, Compared With the Previous Week

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/analytics/usage-breakdown?dimension=Profile&from=2026-11-06&to=2026-11-12&compareFrom=2026-10-30&compareTo=2026-11-05&sort=TotalTokens" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

## Response Properties

| Property         | Type   | Description |
| ---------------- | ------ | ----------- |
| `total`          | int    | How many rows match `query`, before paging |
| `items`          | array  | The rows of the page |
| `totals`         | object | Counts for the whole range, whatever the search and page |
| `previousTotals` | object | Counts for the whole comparison range. `null` when no comparison range was sent. |

Each row has these properties:

| Property   | Type   | Description |
| ---------- | ------ | ----------- |
| `key`      | string | The provider ID, model ID, profile ID, or user ID. Usage with none recorded has the key `unknown` (provider, model, profile) or `anonymous` (user). |
| `name`     | string | The latest friendly name: the profile alias or the user name. `null` for providers and models. |
| `current`  | object | The row's counts for the range |
| `previous` | object | The row's counts for the comparison range, with zeros when it had no usage. `null` when no comparison range was sent. |

The counts have the same properties as in [Get Usage Overview](overview.md#response-properties).

## Related

* [Get Usage Overview](overview.md) - Totals and a time series for a range
* [Analytics API](README.md) - All analytics endpoints
