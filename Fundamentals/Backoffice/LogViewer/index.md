---
meta.Title: "Log Viewer"
meta.Description: "Information on using the Umbraco log viewer in version 8"
keywords: logging logviewer logs serilog messagetemplates logs v8 version8
versionFrom: 8.0.0

---

# Log Viewer
From version 8 we are shipping a built-in Log Viewer feature. This allows you to filter and view log entries and perform much more complex search queries to help you find the log entries that you are interested in your Umbraco site.
You can find the log viewer in the settings section.

## Benefits
Have you ever wanted to find all log entries which contains the same request ID or find all items in the log where a property called duration is greater than 1000ms?
With the power of structured logging and a query language we are able to search and find log items for very specific scenarios. When debugging the client site you should now have more power to see and find patterns in your log files and get rid of those pesky errors.

## Example queries
Here are a handful example queries to get you started, however the saved searches contain some further examples. For more details on the syntax head over to the https://github.com/serilog/serilog-filters-expressions project.

**Find all logs that are from the namespace 'Umbraco.Core'**<br/>
`StartsWith(SourceContext, 'Umbraco.Core')`<br/>

**Find all logs that have the property 'Duration' and the duration is greater than 1000ms**<br/>
`Has(Duration) and Duration > 1000`<br/>

**Find all logs where the message has localhost in it with SQL like**<br/>
`@Message like '%localhost%'`<br/>

## Saved Searches
When writing a custom query that you wish to use often, it is possible to save this and use the dropdown to re-use your saved search. To add a new saved search, use the search box to type your query and click the star icon. In doing so you can give it a friendly name. The default location of the saved searches are persisted as JSON to the following file: `/config/logviewer.searches.config.js`

## Implementing your own Log Viewer
With the flexibility of Umbraco, we give you the power to implement your own `ILogViewer` where you are able to fetch logs and the saved searched from a different location such as Azure table storage.

### Create your own implementation
To do this we can implement a base class `LogViewerSourceBase` from `Umbraco.Core.Logging.Viewer` like so.
*Note:* This uses the `WindowsAzure.Storage` nuget package

```csharp
using System;
using System.Collections.Generic;
using Serilog.Events;
using Serilog.Formatting.Compact.Reader;
using Umbraco.Core.Logging.Viewer;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Table;

namespace My.Website
{
    public class AzureTableLogViewer : LogViewerSourceBase
    {
        public override bool CanHandleLargeLogs => true;

        public override bool CheckCanOpenLogs(DateTimeOffset startDate, DateTimeOffset endDate)
        {
            // This method will not be called - as we have indicated that this 'CanHandleLargeLogs'
            throw new NotImplementedException();
        }

        protected override IReadOnlyList<LogEvent> GetLogs(DateTimeOffset startDate, DateTimeOffset endDate, ILogFilter filter, int skip, int take)
        {
            var cloudStorage = CloudStorageAccount.Parse("DefaultEndpointsProtocol=https;AccountName=ACCOUNT_NAME;AccountKey=KEY;EndpointSuffix=core.windows.net");
            var tableClient = cloudStorage.CreateCloudTableClient();
            var table = tableClient.GetTableReference("LogEventEntity");

            var logs = new List<LogEvent>();
            var count = 0;

            // Create the table query
            // TODO: Use a range query to filter by start & end date on the Timestamp
            var query = new TableQuery<LogEventEntity>();
            var results = table.ExecuteQuery(query);

            // Loop through the results, displaying information about the entity.
            foreach (var entity in results)
            {
                // Reads the compact JSON format stored in the 'Data' column back to a LogEvent
                // Same as the JSON txt files does
                var logItem = LogEventReader.ReadFromString(entity.Data);

                if (count > skip + take)
                {
                    break;
                }

                if (count < skip)
                {
                    count++;
                    continue;
                }

                if (filter.TakeLogEvent(logItem))
                {
                    logs.Add(logItem);
                }

                count++;
            }

            return logs;
        }

        public override IReadOnlyList<SavedLogSearch> GetSavedSearches()
        {
            //TODO: Fetch from Azure Table
            return base.GetSavedSearches();
        }

        public override IReadOnlyList<SavedLogSearch> AddSavedSearch(string name, string query)
        {
            //TODO: Add to Azure Table
            return base.AddSavedSearch(name, query);
        }

        public override IReadOnlyList<SavedLogSearch> DeleteSavedSearch(string name, string query)
        {
            //TODO: Remove from Azure Table
            return base.DeleteSavedSearch(name, query);
        }
    }
}
```

### Register implementation
Umbraco needs to be made aware that there is a new implementation of an `ILogViewer` to register and replace the default JSON LogViewer that we ship in the core of Umbraco.

```csharp
using Umbraco.Core;
using Umbraco.Core.Composing;

namespace My.Website
{
    [RuntimeLevel(MinLevel = RuntimeLevel.Run)]
    public class LogViewerSavedSearches : IUserComposer
    {
        public void Compose(Composition composition)
        {
            composition.SetLogViewer<AzureTableLogViewer>();
        }
    }
}
```

### Configure Umbraco to log to Azure Table Storage
Now with the above two classes we have the plumbing in place to view logs from an Azure Table, however we are not persisting our logs into the Azure table storage account. So we need to configure the Serilog logging pipeline to store our logs into Azure table storage.

* Install Serilog.Sinks.AzureTableStorage from Nuget (Latest pre-release)
* Update `config/serilog.user.config` with credentials (so logs persist to Azure)

```xml
<add key="serilog:using:AzureTableStorage" value="Serilog.Sinks.AzureTableStorage" />
<add key="serilog:write-to:AzureTableStorage.connectionString" value="DefaultEndpointsProtocol=https;AccountName=ACCOUNT_NAME;AccountKey=KEY;EndpointSuffix=core.windows.net" />
<add key="serilog:write-to:AzureTableStorage.formatter" value="Serilog.Formatting.Compact.CompactJsonFormatter, Serilog.Formatting.Compact" />
```

For more in depth information about logging and how to configure it, please read the [logging documentation](../../Code/Debugging/Logging/).

### Compact Log Viewer - Desktop App
This is a desktop tool for viewing & querying JSON log files from disk in the same way as the built in logviewer dashboard of Umbraco.

<a href='//www.microsoft.com/store/apps/9N8RV8LKTXRJ?cid=storebadge&ocid=badge'>
<img src='badge\English_get.png' alt='English badge' style='height: 38px;' height="38" />
</a>
