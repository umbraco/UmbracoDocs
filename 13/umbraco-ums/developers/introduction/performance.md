---
description: >-
  We take performance seriously and performance is always on top of mind when
  adding new features to Umbraco uMS.
---

# Performance

Within the Umbraco uMS we have implemented several performance optimizations and there are also some configurations you can do yourself to optimize the performance of your Umbraco solution with uMarketingSuite.

## Separate processes for storing, parsing, and reporting

As documented in the [dataflow process](../../../../the-umarketingsuite-broad-overview/dataflow-pipeline/) there are different steps for [collecting](../../../../the-umarketingsuite-broad-overview/dataflow-pipeline/data-collection/), [storing](../../../../the-umarketingsuite-broad-overview/dataflow-pipeline/data-storage/), [parsing](../../../../the-umarketingsuite-broad-overview/dataflow-pipeline/data-parsing/), and [reporting](../../../../the-umarketingsuite-broad-overview/dataflow-pipeline/reporting/) the data. This is primarily done for performance reasons.

The collection is done in memory of the web server (or webservers if you have multiple web servers in a load-balanced

Storing causes the data to flow from the memory to the database. The memory is free again and can be used for other data. The data is stored at that moment in the raw data tables.

In our production websites we see that the average data size per record in the table `uMarketingSuiteAnalyticsRawPageView` is 0,9 kb. This means that every visitor stores 0,9 kb of data.

For the `uMarketingSuiteRawClientSideData` it depends a bit on the implementation of the clientside events. If you track a lot of [custom events](../../../../the-umarketingsuite-broad-overview/dataflow-pipeline/data-collection/) this table will probably be bigger. On average we see that this is around 0,4 kb per visitor that can execute JavaScript (all bots are excluded because of this).

This data can be found for your database with the following SQL Statement:

```
/***
Copied and applied for the raw data tables from https://support.managed.com/kb/a227/how-to-find-large-tables-in-sql-database.aspx
* Find the number of rows and the size of tables
***/

CREATE TABLE #temp (table_name sysname ,row_count INT,reserved_size VARCHAR(50),data_size VARCHAR(50),index_size VARCHAR(50),unused_size VARCHAR(50))SET NOCOUNT ONINSERT #tempEXEC sp_msforeachtable 'sp_spaceused ''?'''

SELECT a.table_name,a.row_count,COUNT(*) AS col_count,a.data_sizeFROM #temp aINNER JOIN information_schema.columns bON a.table_name collate database_default = b.table_name collate database_defaultOR REPLACE(REPLACE(a.table_name, '[dbo].[',''),']','') = b.table_name collate database_defaultWHERE a.table_name LIKE 'uMarketingSuite%raw%'GROUP BY a.table_name, a.row_count, a.data_sizeORDER BY CAST(REPLACE(a.data_size, ' KB', '') AS integer) DESC

DROP TABLE #temp
```

### Data parsing

In the data parsing the data is fetched from the raw data tables and stored in normalized tables. At that moment the raw data could be deleted and only the normalized data tables are needed. The data parsing is the heaviest step of the total process so this is where we put most of our performance TLC in.

The data parsing process runs in a background job on the webserver. Within [the configuration file](../../../../installing-umarketingsuite/configuration-options-1-x/) you can specify how many records are fetched to parse and how often the process needs to run. It's also possible to specify which server(s) need to be responsible for the parsing process.

On average we see that the amount of stored data is only 0,1 kb per visit. This is only 10% of the original amount in the raw data tables.

The SQL Script for determining that is:

```
/***
* Copied and applied for the Umbraco uMS data tables from https://support.managed.com/kb/a227/how-to-find-large-tables-in-sql-database.aspx
* Find the number of rows and the size of tables
***/

CREATE TABLE #temp (table_name sysname ,row_count INT,reserved_size VARCHAR(50),data_size VARCHAR(50),index_size VARCHAR(50),unused_size VARCHAR(50))SET NOCOUNT ONINSERT #tempEXEC sp_msforeachtable 'sp_spaceused ''?'''

SELECT SUM(a.row_count) as [total number of rows],SUM(CAST(REPLACE(a.data_size, ' KB','') as integer)) as [total data size]FROM #temp aWHERE a.table_name LIKE 'uMarketingSuiteAnalytics%' AND NOT a.table_name LIKE 'uMarketingSuiteAnalytics%raw%'

SELECT a.table_name,a.row_count,COUNT(*) AS col_count,a.data_sizeFROM #temp aINNER JOIN information_schema.columns bON a.table_name collate database_default = b.table_name collate database_defaultOR REPLACE(REPLACE(a.table_name, '[dbo].[',''),']','') = b.table_name collate database_default WHERE a.table_name LIKE 'uMarketingSuiteAnalytics%' AND NOT a.table_name LIKE 'uMarketingSuiteAnalytics%raw%' GROUP BY a.table_name, a.row_count, a.data_sizeORDER BY CAST(REPLACE(a.data_size, ' KB', '') AS integer) DESC

DROP TABLE #temp
```

## Show me more numbers

With the two SQL scripts above you can find out how much data is used by the Umbraco uMS. If you want to see how long the processing step takes you can run this script to see the processing speed for the raw pageviews:

```
SELECT AVG(isnull(datediff(ms, processingStarted, processingFinished),0))
  , CAST(processingStarted as DATE)
  FROM [uMarketingSuiteAnalyticsRawPageView]
  WHERE processingstarted IS NOT NULL
  AND processingFinished IS NOT NULL
  AND processingFailed = 0
  GROUP BY CAST(processingStarted as DATE)
  ORDER BY CAST(processingStarted as DATE)
```

and for the raw clientsidedata:

```
    SELECT AVG(isnull(datediff(ms, processingStarted, processingFinished),0))
  , CAST(processingStarted as DATE)
  FROM [uMarketingSuiteAnalyticsRawClientSideData]
  WHERE processingstarted IS NOT NULL
  AND processingFinished IS NOT NULL
  AND processingFailed = 0
  GROUP BY CAST(processingStarted as DATE)
  ORDER BY CAST(processingStarted as DATE)
```

We try to keep the average parsing **speed under 100 ms**. Please let us know if you see anything different.

## Optimized infrastructure

You can also optimize your server infrastructure to tweak the performance. There are a few options that you could apply:

* You could set up more webservers in [a load-balanced setup](https://our.umbraco.com/Documentation/Getting-Started/Setup/Server-Setup/Load-Balancing/). Each of these web servers will collect data from the visitor, but you can specify in the configuration which web server (s) is responsible for the parsing of the data. You could also set up one specific server only for parsing the data. In that case, the other web servers will have almost no impact on their performance. To set this up you need to set the parameter '`IsProcessingServer`' to '`false`' in [your configuration file](../../../../installing-umarketingsuite/settings-section/the-configuration-file/) for all servers that do not need to process the data and set it to '`true`' on the server(s) that is responsible for parsing. If there is no server with this setting set to '`true`' the raw data of the Umbraco uMS will take place, but the data will never be processed.
* By default the uMarketingSuite stores its data in the same database as Umbraco. It uses the default connection string of Umbraco (named '`umbracoDbDSN`'). It is possible to specify a separate database for all uMarketingSuite data. This could be another database on the same server but also another database server. To do this you need to specify a new connection string in your application and give that connection string a name. In [the configuration file](../../../../installing-umarketingsuite/configuration-options-1-x/), you can now specify this name in the field '`DatabaseConnectionStringName`'.
