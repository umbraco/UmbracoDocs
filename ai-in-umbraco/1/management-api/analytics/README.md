---
description: >-
    API endpoints for AI usage analytics and reporting.
---

# Analytics API

The Analytics API provides aggregated usage statistics derived from audit logs. Use these endpoints to understand AI usage patterns, costs, and performance across your application.

## Endpoints

| Method | Endpoint                                                 | Description                    |
| ------ | -------------------------------------------------------- | ------------------------------ |
| GET    | [`/analytics/summary`](summary.md)                       | Get usage summary for a period |
| GET    | [`/analytics/timeseries`](timeseries.md)                 | Get usage over time            |
| GET    | [`/analytics/breakdown/provider`](breakdown-provider.md) | Usage breakdown by provider    |
| GET    | [`/analytics/breakdown/model`](breakdown-model.md)       | Usage breakdown by model       |
| GET    | [`/analytics/breakdown/profile`](breakdown-profile.md)   | Usage breakdown by profile     |
| GET    | [`/analytics/breakdown/user`](breakdown-user.md)         | Usage breakdown by user        |

## Base URL

```
/umbraco/ai/management/api/v1
```

## Common Query Parameters

All analytics endpoints support these parameters:

| Parameter     | Type     | Required | Description                                      |
| ------------- | -------- | -------- | ------------------------------------------------ |
| `from`        | datetime | Yes      | Start of period (inclusive)                      |
| `to`          | datetime | Yes      | End of period (inclusive)                        |
| `granularity` | string   | No       | Data granularity: `hour`, `day`, `week`, `month` |

## Analytics Concepts

### Summary Metrics

| Metric              | Description                         |
| ------------------- | ----------------------------------- |
| `totalRequests`     | Number of AI operations             |
| `inputTokens`       | Total tokens in requests            |
| `outputTokens`      | Total tokens in responses           |
| `totalTokens`       | Combined token count                |
| `successCount`      | Successful operations               |
| `failureCount`      | Failed operations                   |
| `successRate`       | Success percentage (0.0-1.0)        |
| `averageDurationMs` | Mean operation time in milliseconds |

### Time Series

Time series data shows metrics over time, useful for trend analysis and identifying usage patterns.

### Breakdowns

Breakdowns show how usage is distributed across different dimensions:

- **By Provider** - Which AI providers are used most
- **By Model** - Which models consume most tokens
- **By Profile** - Which profiles are most active
- **By User** - Who uses AI features most

## Example: Dashboard Query

To populate a usage dashboard, you might call multiple endpoints:

{% code title="C#" %}

```csharp
var from = DateTime.UtcNow.AddDays(-30);
var to = DateTime.UtcNow;
var query = $"from={from:O}&to={to:O}";

// Get overall summary
var summary = await httpClient.GetFromJsonAsync<AIUsageSummary>(
    $"/umbraco/ai/management/api/v1/analytics/summary?{query}");

// Get daily time series
var timeSeries = await httpClient.GetFromJsonAsync<List<AIUsageTimeSeriesPoint>>(
    $"/umbraco/ai/management/api/v1/analytics/timeseries?{query}&granularity=day");

// Get provider breakdown
var byProvider = await httpClient.GetFromJsonAsync<List<AIUsageBreakdownItem>>(
    $"/umbraco/ai/management/api/v1/analytics/breakdown/provider?{query}");
```

{% endcode %}

## Related

- [Audit Logs](../audit-logs/README.md) - Raw operation data
- [Usage Analytics Backoffice](../../backoffice/usage-analytics.md)
