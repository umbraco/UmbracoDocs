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

**Find all logs that are from the namespace 'Umbraco.Core'**`StartsWith(SourceContext, 'Umbraco.Core')`

**Find all logs that have the property 'Duration' and the duration is greater than 1000ms**`Has(Duration) and Duration > 1000`

**Find all logs where the message has localhost in it with SQL like**`@Message like '%localhost%'`

## Saved Searches

If you frequently use a custom query, you can save it for quick access. Type your query in the search box and click the heart icon to save it with a friendly name. Saved queries are stored in the `umbracoLogViewerQuery` table in the database.

## Implementing Your Own Log Viewer Source

Umbraco allows you to implement a custom `ILogViewerRepository` and `ILogViewerService` to fetch logs from alternative sources, such as **Azure Table Storage**.

### Creating a Custom Log Viewer Repository

To fetch logs from Azure Table Storage, extend the `LogViewerRepositoryBase` class from `Umbraco.Cms.Infrastructure.Services.Implement`.

{% hint style="info" %}
This implementation requires the `Azure.Data.Tables` NuGet package.
{% endhint %}

```csharp
using Azure;
using Azure.Data.Tables;
using Serilog.Events;
using Serilog.Formatting.Compact.Reader;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Logging.Viewer;
using Umbraco.Cms.Core.Serialization;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Infrastructure.Logging.Serilog;
using Umbraco.Cms.Infrastructure.Services.Implement;

namespace My.Website;

public class AzureTableLogsRepository : LogViewerRepositoryBase
{
    private readonly IJsonSerializer _jsonSerializer;

    public AzureTableLogsRepository(UmbracoFileConfiguration umbracoFileConfig, IJsonSerializer jsonSerializer) : base(
        umbracoFileConfig)
    {
        _jsonSerializer = jsonSerializer;
    }

    protected override IEnumerable<ILogEntry> GetLogs(LogTimePeriod logTimePeriod, ILogFilter logFilter)
    {
        // This example uses a connection string compatible with the Azurite emulator
        // https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azurite
        var client =
            new TableClient(
                "UseDevelopmentStorage=true",
                "LogEventEntity");

        // Filter by timestamp to avoid retrieving all logs from the table, preventing memory and performance issues
        IEnumerable<AzureTableLogEntity> results = client.Query<AzureTableLogEntity>(
            entity => entity.Timestamp >= logTimePeriod.StartTime.Date &&
                      entity.Timestamp <= logTimePeriod.EndTime.Date.AddDays(1).AddSeconds(-1));

        // Read the data and apply logfilters
        IEnumerable<LogEvent> filteredData = results.Select(x => LogEventReader.ReadFromString(x.Data))
            .Where(logFilter.TakeLogEvent);

        return filteredData.Select(x => new LogEntry
        {
            Timestamp = x.Timestamp,
            Level = Enum.Parse<Core.Logging.LogLevel>(x.Level.ToString()),
            MessageTemplateText = x.MessageTemplate.Text,
            Exception = x.Exception?.ToString(),
            Properties = MapLogMessageProperties(x.Properties),
            RenderedMessage = x.RenderMessage(),
        });
    }

    private IReadOnlyDictionary<string, string?> MapLogMessageProperties(
        IReadOnlyDictionary<string, LogEventPropertyValue>? properties)
    {
        var result = new Dictionary<string, string?>();

        if (properties is not null)
        {
            foreach (KeyValuePair<string, LogEventPropertyValue> property in properties)
            {
                string? value;

                if (property.Value is ScalarValue scalarValue)
                {
                    value = scalarValue.Value?.ToString();
                }
                else if (property.Value is StructureValue structureValue)
                {
                    var textWriter = new StringWriter();
                    structureValue.Render(textWriter);
                    value = textWriter.ToString();
                }
                else
                {
                    value = _jsonSerializer.Serialize(property.Value);
                }

                result.Add(property.Key, value);
            }
        }

        return result;
    }

    public class AzureTableLogEntity : ITableEntity
    {
        public required string Data { get; set; }

        public required string PartitionKey { get; set; }

        public required string RowKey { get; set; }

        public DateTimeOffset? Timestamp { get; set; }

        public ETag ETag { get; set; }
    }
}
```

Azure Table Storage requires entities to implement the `ITableEntity` interface. Since Umbraco's default log entity does not implement this, a custom entity (`AzureTableLogEntity`) must be created to ensure logs are correctly fetched.

### Creating a custom log viewer service

The next thing we need to do is create a new implementation of `ILogViewerService`. Amongst other things, this is responsible for figuring out whether a provided log query is allowed. Again a base class is available.

```csharp
public class AzureTableLogsService : LogViewerServiceBase
{
    public AzureTableLogsService(
        ILogViewerQueryRepository logViewerQueryRepository,
        ICoreScopeProvider provider,
        ILogViewerRepository logViewerRepository)
        : base(logViewerQueryRepository, provider, logViewerRepository)
    {
    }

    // Change this to what you think is sensible.
    // As an example we check whether more than 5 days off logs are requested.
    public override Task<Attempt<bool, LogViewerOperationStatus>> CanViewLogsAsync(LogTimePeriod logTimePeriod)
    {
        return logTimePeriod.EndTime - logTimePeriod.StartTime < TimeSpan.FromDays(5)
            ? Task.FromResult(Attempt.SucceedWithStatus(LogViewerOperationStatus.Success, true))
            : Task.FromResult(Attempt.FailWithStatus(LogViewerOperationStatus.CancelledByLogsSizeValidation, false));
    }

    public override ReadOnlyDictionary<string, LogLevel> GetLogLevelsFromSinks()
    {
        var configuredLogLevels = new Dictionary<string, LogLevel>
        {
            { "Global", GetGlobalMinLogLevel() },
            { "AzureTableStorage", LogViewerRepository.RestrictedToMinimumLevel() },
        };

        return configuredLogLevels.AsReadOnly();
    }
}
```

### Register implementations

Umbraco needs to be made aware that there is a new implementation of an `ILogViewerRepository` and an `ILogViewerService`. These need to replace the default ones that are shipped with Umbraco.

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Infrastructure.DependencyInjection;
using Umbraco.Cms.Core.Services;

namespace My.Website;

public class AzureTableLogsComposer : IComposer
    {
        public void Compose(IUmbracoBuilder builder)
        {
            builder.Services.AddUnique<ILogViewerRepository, AzureTableLogsRepository>();
            builder.Services.AddUnique<ILogViewerService, AzureTableLogsService>();
        }
    }
}
```

### Configuring Logging to Azure Table Storage

With the above three classes, the setup is in place to view logs from an Azure Table. However, logs are not yet persisted into the Azure Table Storage account. To enable persistence, configure the Serilog logging pipeline to store logs in Azure Table Storage.

-   Install `Serilog.Sinks.AzureTableStorage` from NuGet.
-   Add a new sink to `appsettings.json` with credentials to persist logs to Azure.

The following sink needs to be added to the [`Serilog:WriteTo`](https://github.com/serilog/serilog-sinks-azuretablestorage#json-configuration) array.

```json
{
    "Name": "AzureTableStorage",
    "Args": {
        "storageTableName": "LogEventEntity",
        "formatter": "Serilog.Formatting.Compact.CompactJsonFormatter, Serilog.Formatting.Compact",
        "connectionString": "DefaultEndpointsProtocol=https;AccountName=ACCOUNT_NAME;AccountKey=KEY;EndpointSuffix=core.windows.net"
    }
}
```

For more in-depth information about logging and how to configure it, see the [Logging](../code/debugging/logging.md) article.

### Compact Log Viewer - Desktop App

[Compact Log Viewer](https://www.microsoft.com/store/apps/9N8RV8LKTXRJ?cid=storebadge&ocid=badge). A desktop tool is available for viewing and querying JSON log files in the same way as the built-in Log Viewer in Umbraco.
