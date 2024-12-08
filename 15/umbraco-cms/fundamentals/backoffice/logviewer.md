---
description: Information on using the Umbraco log viewer
---

# Log Viewer

Umbraco ships with a built-in Log Viewer feature. This allows you to filter and view log entries and perform much more complex search queries. This helps you find the log entries that you are interested in. You can find the Log viewer in the Settings section.

{% embed url="https://youtu.be/PDqIRVygAQ4?t=102" %}
Learn how to use the Log Viewer to read and understand logs for your Umbraco CMS website.
{% endembed %}

## Benefits

Have you ever wanted to find all log entries which contain the same request ID? Or find all items in the log where a property called duration is greater than 1000ms?

With the power of structured logging and a query language, we are able to search and find log items for specific scenarios. When debugging the site you should now have more power to see and find patterns in your log files and get rid of those errors.

## Example queries

Here are a handful of example queries to get you started, however, the saved searches contain some further examples. For more details on the syntax head over to the https://github.com/serilog/serilog-filters-expressions project.

**Find all logs that are from the namespace 'Umbraco.Core'**\
`StartsWith(SourceContext, 'Umbraco.Core')`\\

**Find all logs that have the property 'Duration' and the duration is greater than 1000ms**\
`Has(Duration) and Duration > 1000`\\

**Find all logs where the message has localhost in it with SQL like**\
`@Message like '%localhost%'`\\

## Saved Searches

Sometimes you want to use a custom query more often. It is possible to save a query and use the dropdown to re-use your saved search. To add a new saved search, use the search box to type your query and click the star icon. In doing so you can give it a friendly name. The saved queries are saved in the database in the table `umbracoLogViewerQuery`.

## Implementing your own Log Viewer

With the flexibility of Umbraco, we give you the power to implement your own `ILogViewer`. This makes it possible to fetch logs and the saved searches from a different location such as Azure table storage.

### Create your own implementation

To do this we can implement a base class `SerilogLogViewerSourceBase` from `Umbraco.Cms.Core.Logging.Viewer` like so.

{% hint style="info" %}
This uses the `Azure.Data.Tables` NuGet package.
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
        // Optional: If you want to store saved searches in the Azure Table Storage, implement here a method to fetch from the Azure Table.
        return base.GetSavedSearches();
    }

    public override IReadOnlyList<SavedLogSearch>? AddSavedSearch(string? name, string? query)
    {
        //Optional: If you want to store saved searches in the Azure Table Storage, implement here a method to add to the Azure Table.
        return base.AddSavedSearch(name, query);
    }

    public override IReadOnlyList<SavedLogSearch>? DeleteSavedSearch(string? name, string? query)
    {
        //Optional: If you want to store saved searches in the Azure Table Storage, implement here a method to remove from the Azure Table.
        return base.DeleteSavedSearch(name, query);
    }
}

public class AzureTableLogEntity : LogEventEntity, ITableEntity
{
    public DateTimeOffset? Timestamp { get; set; }

    public ETag ETag { get; set; }
}
```

Keep in mind that we have to implement our own version of a `LogEventEntity`. This is because the `TableClient` needs whatever it is fetching to implement the `ITableEntity` interface.

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

### Configure Umbraco to log into Azure Table Storage

Now with the above two classes, we have the plumbing in place to view logs from an Azure Table. However, we are not persisting our logs into the Azure table storage account. So we need to configure the Serilog logging pipeline to store our logs in Azure table storage.

* Install Serilog.Sinks.AzureTableStorage from Nuget
* Add a new sink to the appsettings with credentials (so logs persist to Azure)

The following sink needs to be added to the array [`Serilog:WriteTo`](https://github.com/serilog/serilog-sinks-azuretablestorage#json-configuration).

```json
{
"Name": "AzureTableStorage",
"Args": {
  "storageTableName": "LogEventEntity",
  "formatter": "Serilog.Formatting.Compact.CompactJsonFormatter, Serilog.Formatting.Compact",
  "connectionString": "DefaultEndpointsProtocol=https;AccountName=ACCOUNT_NAME;AccountKey=KEY;EndpointSuffix=core.windows.net"}
}
```

For more in-depth information about logging and how to configure it, please read the [logging documentation](../code/debugging/logging.md).

### Compact Log Viewer - Desktop App

This is a desktop tool for viewing & querying JSON log files from disk in the same way as the built-in logviewer dashboard of Umbraco.

[<img src="../../../../10/umbraco-cms/fundamentals/backoffice/images/English_get.png" alt="English badge" data-size="line">](https://www.microsoft.com/store/apps/9N8RV8LKTXRJ?cid=storebadge\&ocid=badge)
