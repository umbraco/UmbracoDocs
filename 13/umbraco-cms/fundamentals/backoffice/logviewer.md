---
description: Information on using the Umbraco log viewer
---

# Log Viewer

Umbraco ships with a built-in Log Viewer feature. This allows you to filter, view log entries, perform complex search queries, and analyze logs for debugging. You can find the Log viewer in the **Settings** section of the Umbraco backoffice.

{% embed url="https://youtu.be/PDqIRVygAQ4?t=102" %}
Learn how to use the Log Viewer to read and understand logs for your Umbraco CMS website.
{% endembed %}

## Benefits

Ever needed to find all log entries containing the same request ID? Or locate all logs where a property called `Duration` exceeds 1000ms?

With structured logging and a query language, you can efficiently search and identify log items for specific scenarios. This helps in debugging and finding patterns in your logs, making it easier to resolve issues.

## Example Queries

Here are some example queries to help you get started. For more details on the syntax, see the https://github.com/serilog/serilog-filters-expressions project.

**Find all logs that are from the namespace 'Umbraco.Core'**
`StartsWith(SourceContext, 'Umbraco.Core')`

**Find all logs that have the property 'Duration' and the duration is greater than 1000ms**
`Has(Duration) and Duration > 1000`

**Find all logs where the message has localhost in it with SQL like**
`@Message like '%localhost%'`

## Saved Searches

If you frequently use a custom query, you can save it for quick access. Type your query in the search box and click the heart icon to save it with a friendly name. Saved queries are stored in the `umbracoLogViewerQuery` table in the database.

## Implementing Your Own Log Viewer

Umbraco allows you to implement a customn `ILogViewer` to fetch logs from alternative sources, such as **Azure Table Storage**.

### Creating a Custom Log Viewer

To fetch logs from Azure Table Storage, implement the `SerilogLogViewerSourceBase` class from `Umbraco.Cms.Core.Logging.Viewer`.

{% hint style="info" %}
This implementation requires the `Azure.Data.Tables` NuGet package.
{% endhint %}

```csharp
using Azure;
using Azure.Data.Tables;
using Serilog.Events;
using Serilog.Formatting.Compact.Reader;
using Serilog.Sinks.AzureTableStorage;
using Umbraco.Cms.Core.Logging.Viewer;
using ITableEntity = Azure.Data.Tables.ITableEntity;

namespace My.Website;

public class AzureTableLogViewer : SerilogLogViewerSourceBase
{
    public AzureTableLogViewer(ILogViewerConfig logViewerConfig, Serilog.ILogger serilogLog, ILogLevelLoader logLevelLoader)
        : base(logViewerConfig, logLevelLoader, serilogLog)
    {
    }

    public override bool CanHandleLargeLogs => true;

    // This method will not be called - as we have indicated that this 'CanHandleLargeLogs'
    public override bool CheckCanOpenLogs(LogTimePeriod logTimePeriod) => throw new NotImplementedException();

    protected override IReadOnlyList<LogEvent> GetLogs(LogTimePeriod logTimePeriod, ILogFilter filter, int skip, int take)
    {
        //Replace ACCOUNT_NAME and KEY with your actual Azure Storage Account details. The "Logs" parameter refers to the table name where logs will be stored and retrieved from.
        var client =
            new TableClient(
                "DefaultEndpointsProtocol=https;AccountName=ACCOUNT_NAME;AccountKey=KEY;EndpointSuffix=core.windows.net",
                "Logs");

        // Table storage does not support skip, only take, so the best we can do is to not fetch more entities than we need in total.
        // See: https://learn.microsoft.com/en-us/rest/api/storageservices/writing-linq-queries-against-the-table-service#returning-the-top-n-entities for more info.
        var requiredEntities = skip + take;
        IEnumerable<AzureTableLogEntity> results = client.Query<AzureTableLogEntity>().Take(requiredEntities);

		return results
			.Skip(skip)
			.Take(take)
			.Select(x => LogEventReader.ReadFromString(x.Data))
            // Filter by timestamp to avoid retrieving all logs from the table, preventing memory and performance issues
			.Where(evt => evt.Timestamp >= logTimePeriod.StartTime.Date &&
				evt.Timestamp <= logTimePeriod.EndTime.Date.AddDays(1).AddSeconds(-1))
			.Where(filter.TakeLogEvent)
			.ToList();
    }

    public override IReadOnlyList<SavedLogSearch>? GetSavedSearches()
    {
        //This method is optional. If you store saved searches in Azure Table Storage, implement fetching logic here.
        return base.GetSavedSearches();
    }

    public override IReadOnlyList<SavedLogSearch>? AddSavedSearch(string? name, string? query)
    {
        //This method is optional. If you store saved searches in Azure Table Storage, implement adding logic here.
        return base.AddSavedSearch(name, query);
    }

    public override IReadOnlyList<SavedLogSearch>? DeleteSavedSearch(string? name, string? query)
    {
        //This method is optional. If you store saved searches in Azure Table Storage, implement deleting logic here.
        return base.DeleteSavedSearch(name, query);
    }
}

public class AzureTableLogEntity : LogEventEntity, ITableEntity
{
    public DateTimeOffset? Timestamp { get; set; }

    public ETag ETag { get; set; }
}
```

Azure Table Storage requires entities to implement the `ITableEntity` interface. Since Umbraco’s default log entity does not implement this, a custom entity (`AzureTableLogEntity`) must be created to ensure logs are correctly fetched and stored.

### Register implementation

Umbraco needs to be made aware that there is a new implementation of an `ILogViewer` to register. We also need to replace the default JSON LogViewer that we ship in the core of Umbraco.

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Infrastructure.DependencyInjection;

namespace My.Website;

public class LogViewerSavedSearches : IComposer
{
    public void Compose(IUmbracoBuilder builder) => builder.SetLogViewer<AzureTableLogViewer>();
}
```

### Configuring Logging to Azure Table Storage

With the above two classes, the setup is in place to view logs from an Azure Table. However, logs are not yet persisted into the Azure Table Storage account. To enable persistence, configure the Serilog logging pipeline to store logs in Azure Table Storage.

* Install `Serilog.Sinks.AzureTableStorage` from NuGet.
* Add a new sink to `appsettings.json` with credentials to persist logs to Azure.

The following sink needs to be added to the [`Serilog:WriteTo`](https://github.com/serilog/serilog-sinks-azuretablestorage#json-configuration) array.

```json
{
"Name": "AzureTableStorage",
"Args": {
  "storageTableName": "LogEventEntity",
  "formatter": "Serilog.Formatting.Compact.CompactJsonFormatter, Serilog.Formatting.Compact",
  "connectionString": "DefaultEndpointsProtocol=https;AccountName=ACCOUNT_NAME;AccountKey=KEY;EndpointSuffix=core.windows.net"}
}
```

For more in-depth information about logging and how to configure it, see the [Logging](../code/debugging/logging.md) article.

### Compact Log Viewer - Desktop App

[Compact Log Viewer](https://www.microsoft.com/store/apps/9N8RV8LKTXRJ?cid=storebadge\&ocid=badge) - A desktop tool is available for viewing and querying JSON log files in the same way as the built-in Log Viewer in Umbraco.
