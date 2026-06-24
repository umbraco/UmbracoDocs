---
description: >-
    Get usage metrics over time.
---

# Get Time Series

Returns usage metrics grouped by time intervals for trend analysis.

## Request

```http
GET /umbraco/ai/management/api/v1/analytics/usage-time-series
```

### Query Parameters

| Parameter     | Type     | Required | Description                                                              |
| ------------- | -------- | -------- | ------------------------------------------------------------------------ |
| `from`        | datetime | Yes      | Start of period (inclusive)                                              |
| `to`          | datetime | Yes      | End of period (exclusive)                                                |
| `granularity` | string   | No       | Aggregation granularity: `Hourly` or `Daily` (auto-selected if omitted)  |

## Response

### Success

{% code title="200 OK" %}

```json
[
    {
        "timestamp": "2024-01-01T00:00:00Z",
        "requestCount": 520,
        "totalTokens": 117000,
        "inputTokens": 85000,
        "outputTokens": 32000,
        "successCount": 515,
        "failureCount": 5
    },
    {
        "timestamp": "2024-01-02T00:00:00Z",
        "requestCount": 612,
        "totalTokens": 139000,
        "inputTokens": 98000,
        "outputTokens": 41000,
        "successCount": 608,
        "failureCount": 4
    }
]
```

{% endcode %}

## Examples

### Daily Usage for Last Week

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/analytics/usage-time-series?from=2024-01-18T00:00:00Z&to=2024-01-25T23:59:59Z&granularity=Daily" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

### Hourly Usage for Today

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/analytics/usage-time-series?from=2024-01-25T00:00:00Z&to=2024-01-25T23:59:59Z&granularity=Hourly" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

{% code title="C#" %}

```csharp
var from = DateTime.UtcNow.Date.AddDays(-7);
var to = DateTime.UtcNow;

var response = await httpClient.GetAsync(
    $"/umbraco/ai/management/api/v1/analytics/usage-time-series?from={from:O}&to={to:O}&granularity=Daily");

var timeSeries = await response.Content.ReadFromJsonAsync<UsageTimeSeriesPointModel[]>();

foreach (var point in timeSeries)
{
    Console.WriteLine($"{point.Timestamp:d}: {point.RequestCount} requests, {point.TotalTokens:N0} tokens");
}
```

{% endcode %}

## Response Properties

### Time Series Point

| Property       | Type     | Description                         |
| -------------- | -------- | ----------------------------------- |
| `timestamp`    | datetime | Start of the time interval          |
| `requestCount` | int      | Number of requests in this interval |
| `totalTokens`  | long     | Total tokens in this interval       |
| `inputTokens`  | long     | Input tokens in this interval       |
| `outputTokens` | long     | Output tokens in this interval      |
| `successCount` | int      | Successful requests                 |
| `failureCount` | int      | Failed requests                     |

## Granularity Options

| Value    | Description      | Best For         |
| -------- | ---------------- | ---------------- |
| `Hourly` | Hourly intervals | Last 24-48 hours |
| `Daily`  | Daily intervals  | Last 7-30 days   |

{% hint style="info" %}
If `granularity` is omitted, it is auto-selected based on the date range. Large date ranges with `Hourly` granularity produce many data points.
{% endhint %}
