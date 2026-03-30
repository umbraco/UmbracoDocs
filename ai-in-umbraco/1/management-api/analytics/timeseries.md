---
description: >-
    Get usage metrics over time.
---

# Get Time Series

Returns usage metrics grouped by time intervals for trend analysis.

## Request

```http
GET /umbraco/ai/management/api/v1/analytics/timeseries
```

### Query Parameters

| Parameter     | Type     | Required | Default | Description                              |
| ------------- | -------- | -------- | ------- | ---------------------------------------- |
| `from`        | datetime | Yes      | -       | Start of period (inclusive)              |
| `to`          | datetime | Yes      | -       | End of period (inclusive)                |
| `granularity` | string   | No       | `day`   | Interval: `hour`, `day`, `week`, `month` |
| `profileId`   | guid     | No       | null    | Filter by specific profile               |
| `providerId`  | string   | No       | null    | Filter by specific provider              |

## Response

### Success

{% code title="200 OK" %}

```json
{
    "items": [
        {
            "timestamp": "2024-01-01T00:00:00Z",
            "requestCount": 520,
            "inputTokens": 85000,
            "outputTokens": 32000,
            "totalTokens": 117000,
            "successCount": 515,
            "failureCount": 5
        },
        {
            "timestamp": "2024-01-02T00:00:00Z",
            "requestCount": 612,
            "inputTokens": 98000,
            "outputTokens": 41000,
            "totalTokens": 139000,
            "successCount": 608,
            "failureCount": 4
        }
    ],
    "granularity": "day"
}
```

{% endcode %}

## Examples

### Daily Usage for Last Week

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/analytics/timeseries?from=2024-01-18T00:00:00Z&to=2024-01-25T23:59:59Z&granularity=day" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

### Hourly Usage for Today

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/analytics/timeseries?from=2024-01-25T00:00:00Z&to=2024-01-25T23:59:59Z&granularity=hour" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

{% code title="C#" %}

```csharp
var from = DateTime.UtcNow.Date.AddDays(-7);
var to = DateTime.UtcNow;

var response = await httpClient.GetAsync(
    $"/umbraco/ai/management/api/v1/analytics/timeseries?from={from:O}&to={to:O}&granularity=day");

var timeSeries = await response.Content.ReadFromJsonAsync<AIUsageTimeSeriesResult>();

foreach (var point in timeSeries.Items)
{
    Console.WriteLine($"{point.Timestamp:d}: {point.RequestCount} requests, {point.TotalTokens:N0} tokens");
}
```

{% endcode %}

## Response Properties

### Time Series Result

| Property      | Type   | Description             |
| ------------- | ------ | ----------------------- |
| `items`       | array  | Time series data points |
| `granularity` | string | The granularity used    |

### Time Series Point

| Property       | Type     | Description                         |
| -------------- | -------- | ----------------------------------- |
| `timestamp`    | datetime | Start of the time interval          |
| `requestCount` | int      | Number of requests in this interval |
| `inputTokens`  | long     | Input tokens in this interval       |
| `outputTokens` | long     | Output tokens in this interval      |
| `totalTokens`  | long     | Total tokens in this interval       |
| `successCount` | int      | Successful requests                 |
| `failureCount` | int      | Failed requests                     |

## Granularity Options

| Value   | Description       | Best For         |
| ------- | ----------------- | ---------------- |
| `hour`  | Hourly intervals  | Last 24-48 hours |
| `day`   | Daily intervals   | Last 7-30 days   |
| `week`  | Weekly intervals  | Last 8-12 weeks  |
| `month` | Monthly intervals | Last 6-12 months |

{% hint style="info" %}
Choose granularity based on your date range. Too fine granularity with large ranges produces many data points.
{% endhint %}
