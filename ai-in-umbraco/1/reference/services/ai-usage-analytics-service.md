---
description: >-
    Service for AI usage analytics and reporting.
---

# IAIUsageAnalyticsService

Service for querying aggregated AI usage statistics derived from audit logs.

## Namespace

```csharp
using Umbraco.AI.Core.Analytics.Usage;
```

## Interface

{% code title="IAIUsageAnalyticsService" %}

```csharp
public interface IAIUsageAnalyticsService
{
    Task<AIUsageSummary> GetSummaryAsync(
        DateTime from,
        DateTime to,
        AIUsageGranularity requestedGranularity = AIUsageGranularity.Day,
        AIUsageFilter? filter = null,
        CancellationToken cancellationToken = default);

    Task<IEnumerable<AIUsageTimeSeriesPoint>> GetTimeSeriesAsync(
        DateTime from,
        DateTime to,
        AIUsageGranularity requestedGranularity = AIUsageGranularity.Day,
        AIUsageFilter? filter = null,
        CancellationToken cancellationToken = default);

    Task<IEnumerable<AIUsageBreakdownItem>> GetBreakdownByProviderAsync(
        DateTime from,
        DateTime to,
        AIUsageGranularity requestedGranularity = AIUsageGranularity.Day,
        CancellationToken cancellationToken = default);

    Task<IEnumerable<AIUsageBreakdownItem>> GetBreakdownByModelAsync(
        DateTime from,
        DateTime to,
        AIUsageGranularity requestedGranularity = AIUsageGranularity.Day,
        CancellationToken cancellationToken = default);

    Task<IEnumerable<AIUsageBreakdownItem>> GetBreakdownByProfileAsync(
        DateTime from,
        DateTime to,
        AIUsageGranularity requestedGranularity = AIUsageGranularity.Day,
        CancellationToken cancellationToken = default);

    Task<IEnumerable<AIUsageBreakdownItem>> GetBreakdownByUserAsync(
        DateTime from,
        DateTime to,
        AIUsageGranularity requestedGranularity = AIUsageGranularity.Day,
        CancellationToken cancellationToken = default);
}
```

{% endcode %}

## Methods

### GetSummaryAsync

Gets aggregated usage statistics for a time period.

| Parameter              | Type                 | Description        |
| ---------------------- | -------------------- | ------------------ |
| `from`                 | `DateTime`           | Start of period    |
| `to`                   | `DateTime`           | End of period      |
| `requestedGranularity` | `AIUsageGranularity` | Data granularity   |
| `filter`               | `AIUsageFilter?`     | Optional filter    |
| `cancellationToken`    | `CancellationToken`  | Cancellation token |

**Returns**: `AIUsageSummary` with totals and averages.

{% code title="Example" %}

```csharp
var summary = await _analyticsService.GetSummaryAsync(
    from: DateTime.UtcNow.AddDays(-30),
    to: DateTime.UtcNow);

Console.WriteLine($"Total Requests: {summary.TotalRequests}");
Console.WriteLine($"Total Tokens: {summary.TotalTokens:N0}");
Console.WriteLine($"Success Rate: {summary.SuccessRate:P1}");
Console.WriteLine($"Avg Duration: {summary.AverageDurationMs}ms");
```

{% endcode %}

### GetTimeSeriesAsync

Gets usage metrics over time for trend analysis.

| Parameter              | Type                 | Description        |
| ---------------------- | -------------------- | ------------------ |
| `from`                 | `DateTime`           | Start of period    |
| `to`                   | `DateTime`           | End of period      |
| `requestedGranularity` | `AIUsageGranularity` | Time interval      |
| `filter`               | `AIUsageFilter?`     | Optional filter    |
| `cancellationToken`    | `CancellationToken`  | Cancellation token |

**Returns**: Time series data points.

{% code title="Example" %}

```csharp
var timeSeries = await _analyticsService.GetTimeSeriesAsync(
    from: DateTime.UtcNow.AddDays(-7),
    to: DateTime.UtcNow,
    requestedGranularity: AIUsageGranularity.Day);

foreach (var point in timeSeries)
{
    Console.WriteLine($"{point.Timestamp:d}: {point.RequestCount} requests, {point.TotalTokens:N0} tokens");
}
```

{% endcode %}

### GetBreakdownByProviderAsync

Gets usage distribution by AI provider.

{% code title="Example" %}

```csharp
var byProvider = await _analyticsService.GetBreakdownByProviderAsync(
    from: DateTime.UtcNow.AddDays(-30),
    to: DateTime.UtcNow);

foreach (var item in byProvider.OrderByDescending(x => x.Percentage))
{
    Console.WriteLine($"{item.DimensionName}: {item.Percentage:P0} ({item.TotalTokens:N0} tokens)");
}
```

{% endcode %}

### GetBreakdownByModelAsync

Gets usage distribution by AI model.

{% code title="Example" %}

```csharp
var byModel = await _analyticsService.GetBreakdownByModelAsync(
    from: DateTime.UtcNow.AddDays(-30),
    to: DateTime.UtcNow);
```

{% endcode %}

### GetBreakdownByProfileAsync

Gets usage distribution by profile.

{% code title="Example" %}

```csharp
var byProfile = await _analyticsService.GetBreakdownByProfileAsync(
    from: DateTime.UtcNow.AddDays(-30),
    to: DateTime.UtcNow);
```

{% endcode %}

### GetBreakdownByUserAsync

Gets usage distribution by user.

{% code title="Example" %}

```csharp
var byUser = await _analyticsService.GetBreakdownByUserAsync(
    from: DateTime.UtcNow.AddDays(-30),
    to: DateTime.UtcNow);
```

{% endcode %}

## Model Classes

### AIUsageSummary

| Property            | Type     | Description             |
| ------------------- | -------- | ----------------------- |
| `TotalRequests`     | `int`    | Number of operations    |
| `InputTokens`       | `long`   | Total input tokens      |
| `OutputTokens`      | `long`   | Total output tokens     |
| `TotalTokens`       | `long`   | Combined tokens         |
| `SuccessCount`      | `int`    | Successful operations   |
| `FailureCount`      | `int`    | Failed operations       |
| `SuccessRate`       | `double` | Success ratio (0.0-1.0) |
| `AverageDurationMs` | `int`    | Average operation time  |

### AIUsageTimeSeriesPoint

| Property       | Type       | Description          |
| -------------- | ---------- | -------------------- |
| `Timestamp`    | `DateTime` | Interval start       |
| `RequestCount` | `int`      | Requests in interval |
| `InputTokens`  | `long`     | Input tokens         |
| `OutputTokens` | `long`     | Output tokens        |
| `TotalTokens`  | `long`     | Total tokens         |
| `SuccessCount` | `int`      | Successes            |
| `FailureCount` | `int`      | Failures             |

### AIUsageBreakdownItem

| Property        | Type      | Description    |
| --------------- | --------- | -------------- |
| `Dimension`     | `string`  | Identifier     |
| `DimensionName` | `string?` | Display name   |
| `RequestCount`  | `int`     | Requests       |
| `TotalTokens`   | `long`    | Tokens used    |
| `Percentage`    | `double`  | Share of total |

### AIUsageGranularity

| Value   | Description       |
| ------- | ----------------- |
| `Hour`  | Hourly intervals  |
| `Day`   | Daily intervals   |
| `Week`  | Weekly intervals  |
| `Month` | Monthly intervals |

## Usage Example

{% code title="UsageDashboard.cs" %}

```csharp
public class UsageDashboard
{
    private readonly IAIUsageAnalyticsService _analyticsService;

    public UsageDashboard(IAIUsageAnalyticsService analyticsService)
    {
        _analyticsService = analyticsService;
    }

    public async Task<DashboardData> GetDashboardDataAsync()
    {
        var from = DateTime.UtcNow.AddDays(-30);
        var to = DateTime.UtcNow;

        var summary = await _analyticsService.GetSummaryAsync(from, to);
        var timeSeries = await _analyticsService.GetTimeSeriesAsync(from, to);
        var byProvider = await _analyticsService.GetBreakdownByProviderAsync(from, to);
        var byProfile = await _analyticsService.GetBreakdownByProfileAsync(from, to);

        return new DashboardData
        {
            Summary = summary,
            DailyTrend = timeSeries.ToList(),
            ProviderDistribution = byProvider.ToList(),
            ProfileDistribution = byProfile.ToList()
        };
    }
}
```

{% endcode %}

## Related

- [Usage Analytics Backoffice](../../backoffice/usage-analytics.md) - Viewing analytics
- [Audit Logs](../services/ai-audit-log-service.md) - Raw audit data
