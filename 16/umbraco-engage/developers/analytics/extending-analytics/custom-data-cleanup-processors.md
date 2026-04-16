---
description: >-
  Learn how to add custom analytics data cleanup processors to extend the
  built-in anonymization and data cleanup pipeline.
---

# Custom Data Cleanup Processors

Umbraco Engage includes a data cleanup pipeline that periodically anonymizes and deletes analytics data based on the configured retention periods. You can extend this pipeline with custom processors to perform additional cleanup or anonymization logic.

## The IAnalyticsDataCleanupProcessor interface

To create a custom processor, implement the `IAnalyticsDataCleanupProcessor` interface:

```csharp
using Umbraco.Engage.Infrastructure.Analytics.Cleanup.Processors;

public class MyCustomCleanupProcessor : IAnalyticsDataCleanupProcessor
{
    public AnalyticsDataCleanupType Type => AnalyticsDataCleanupType.DeleteOrphanedData;

    public async IAsyncEnumerable<AnalyticsDataCleanupResult> ProcessAsync()
    {
        // Perform cleanup logic here...

        yield return new AnalyticsDataCleanupResult("MyCustomTable", numberOfRecordsAffected);
    }
}
```

The interface requires two members:

| Member | Description |
| --- | --- |
| `Type` | The type of cleanup operation this processor performs. Determines when the processor runs relative to other processors. |
| `ProcessAsync()` | Performs the cleanup and yields one or more `AnalyticsDataCleanupResult` records indicating the table name and number of affected rows. |

## Cleanup types

The `AnalyticsDataCleanupType` enum controls the execution order. Processors are grouped and executed in this sequence:

| Value | Description |
| --- | --- |
| `Anonymize` | Replaces personally identifiable information with anonymized values for data that has exceeded its retention period. Runs first. |
| `DeleteAnalyticsData` | Deletes analytics data (pageviews, control group data, raw data) that has exceeded its retention period. Runs second. |
| `DeleteOrphanedData` | Deletes orphaned records no longer referenced by any analytics data (for example: sessions, visitors, devices without pageviews). Runs last. |

## Registering a custom processor

Register your processor using the `EngageDataCleanupProcessors()` extension method on `IUmbracoBuilder` inside a composer:

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Engage.Infrastructure.Analytics.Cleanup.Processors;

public class MyCleanupComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.EngageDataCleanupProcessors()
            .Append<MyCustomCleanupProcessor>();
    }
}
```

The collection builder supports the standard Umbraco ordering methods such as `Append<T>()`, `InsertBefore<TBefore, T>()`, and `InsertAfter<TAfter, T>()` to control where your processor runs within its cleanup type group.

## Result type

Each processor yields one or more `AnalyticsDataCleanupResult` records:

```csharp
public record AnalyticsDataCleanupResult(string TableName, int RecordsAffected);
```

These results are logged by the cleanup background job and surfaced in the Engage settings dashboard.
