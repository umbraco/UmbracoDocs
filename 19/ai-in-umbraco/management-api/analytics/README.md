---
description: >-
    API endpoints for AI usage analytics and reporting.
---

# Analytics API

The Analytics API provides aggregated usage statistics for AI operations. Use these endpoints to understand AI usage patterns, costs, and performance across your application.

## Endpoints

| Method | Endpoint                                                                     | Description |
| ------ | ---------------------------------------------------------------------------- | ----------- |
| GET    | [`/umbraco/ai/management/api/v1/analytics/usage-overview`](overview.md)       | Totals and a time series for a range and a comparison range |
| GET    | [`/umbraco/ai/management/api/v1/analytics/usage-breakdown`](breakdown.md)     | One page of usage per provider, model, profile, or user |

The backoffice [Usage Analytics](../../backoffice/usage-analytics.md) dashboard uses these two endpoints.

## Base URL

```
/umbraco/ai/management/api/v1
```

## Common Query Parameters

Both endpoints take these parameters:

| Parameter     | Type   | Required | Description |
| ------------- | ------ | -------- | ----------- |
| `from`        | date   | Yes      | First local day of the range (`yyyy-MM-dd`) |
| `to`          | date   | Yes      | Last local day of the range, inclusive (`yyyy-MM-dd`) |
| `compareFrom` | date   | No       | First local day of a comparison range. Send it together with `compareTo`. |
| `compareTo`   | date   | No       | Last local day of the comparison range, inclusive |
| `timeZone`    | string | No       | Time zone ID the days are local to, for example `Europe/Copenhagen`. Defaults to UTC. |

## Analytics Concepts

### Raw Counts

Both endpoints return raw counts: requests, succeeded and failed requests, input, cached input, output, and total tokens, and time spent in milliseconds. Work out rates and averages from the sums. For example, the success rate is `succeeded / requests` and the average duration is `durationMs / requests`.

### Comparison Ranges

Send `compareFrom` and `compareTo` to get the same counts for a second range, such as the previous period. The response then holds both ranges, so you can show the change between them.

### Time Series

The overview endpoint returns a bucket for every hour, day, week, or month of the range. Buckets without usage hold zeros, so a chart has no gaps.

### Breakdowns

Breakdowns show how usage is distributed across a dimension:

- **Provider** - Which AI providers are used most
- **Model** - Which models consume most tokens
- **Profile** - Which profiles are most active
- **User** - Who uses AI features most

## Example: Dashboard Query

To fill a usage dashboard, call the overview endpoint once and the breakdown endpoint for each dimension you show:

{% code title="UsageDashboardQuery.cs" %}

```csharp
using System.Net.Http.Json;
using System.Text.Json;

public static class UsageDashboardQuery
{
    public static async Task PrintUsageAsync(HttpClient httpClient)
    {
        var range = "from=2026-11-06&to=2026-11-12&timeZone=Europe/Copenhagen";

        // Totals and a daily time series
        var overview = await httpClient.GetFromJsonAsync<JsonElement>(
            $"/umbraco/ai/management/api/v1/analytics/usage-overview?{range}&groupBy=Day");

        var totals = overview.GetProperty("current").GetProperty("totals");
        Console.WriteLine($"Requests: {totals.GetProperty("requests").GetInt32()}");

        // The ten models with the most requests
        var byModel = await httpClient.GetFromJsonAsync<JsonElement>(
            $"/umbraco/ai/management/api/v1/analytics/usage-breakdown?{range}&dimension=Model&take=10");

        foreach (var row in byModel.GetProperty("items").EnumerateArray())
        {
            var requests = row.GetProperty("current").GetProperty("requests").GetInt32();
            Console.WriteLine($"{row.GetProperty("key").GetString()}: {requests}");
        }
    }
}
```

{% endcode %}

The `HttpClient` needs a base address for your site and a Management API access token. For more information, see the [Authentication](../management-api/authentication.md) article.

## Obsolete Endpoints

These endpoints still work, but they are obsolete and will be removed in version 20:

| Obsolete endpoint | Use instead |
| --- | --- |
| [`usage-summary`](summary.md) | [`usage-overview`](overview.md) |
| [`usage-time-series`](timeseries.md) | [`usage-overview`](overview.md) |
| [`usage-by-provider`](breakdown-provider.md) | [`usage-breakdown`](breakdown.md) with `dimension=Provider` |
| [`usage-by-model`](breakdown-model.md) | [`usage-breakdown`](breakdown.md) with `dimension=Model` |
| [`usage-by-profile`](breakdown-profile.md) | [`usage-breakdown`](breakdown.md) with `dimension=Profile` |
| [`usage-by-user`](breakdown-user.md) | [`usage-breakdown`](breakdown.md) with `dimension=User` |

## Related

- [Audit Logs](../audit-logs/README.md) - Raw operation data
- [Usage Analytics Backoffice](../../backoffice/usage-analytics.md)
