# Data storage

When the [data is collected](/the-umarketingsuite-broad-overview/dataflow-pipeline/data-collection/) it is temporarily stored in memory. At some moment in time a threshold is reached and all data is stored in the database. This is down in the step 'Data storage'.

## Flushing the memory

There are two thresholds that can be set and can be reached to trigger the storage of data. If one of these two triggers is reached the data is stored in the database.

- The first threshold is the '**FlushRateInRecords**'. When this number of records is in memory the data will be stored in the database. If you set it to 100 for example, the data will be permanently stored after 100 pagevisits.
- The second threshold is the '**FlushIntervalInSeconds**'. After this number of seconds the data will be sent to the database. If you set it to 30 seconds for example, every 30 seconds the data will be sent to the database. No matter how many records there are in memory.

Both settings can be set in [the configuration file](/installing-umarketingsuite/configuration-options-1-x/) of the uMarketingSuite.

The higher value you set for these thresholds, the more memory the uMarketingSuite is using on your webserver(s) and the less usage of your database connection. Please note that the memory impact is quite low, because it's not a lot of complex data that is stored. It also means that it will take a bit longer for data to appear in the backoffice (because the data is not yet stored and processed).

The lower value you set, the less memory the uMarketingSuite uses on your webserver(s) and the more database calls are made. The upside is that data will appear in more realtime.

## Data storage

The data will be stored as quickly as possible to minimize the needed resources. For this reason the data will be stored in so called raw-tables in a non-normalized or optimized way. This data will be processed in [the next step](/the-umarketingsuite-broad-overview/dataflow-pipeline/data-parsing/) of the data flow.

This data collected from serverside events is stored in the database table **uMarketingSuiteAnalyticsRawPageview**.

The data collected from clientside events is stored in the table **uMarketingSuiteAnalyticsRawClientSideData**.

When the data is stored in these tables the columns **processingStarted**, **processingFinished**, **processingMachine** and **processingFailed** are empty. They will be filled in the parsing step.

## Troubleshooting data storage in the uMarketingSuite

When you think the uMarketingSuite is not working we always recommend to look in these raw-tables, especially the **uMarketingSuiteAnalyticsRawPageview** because this one works automatically.

If there are no new records appearing in this table three things can have happened:

- There is no traffic on the website. You can try to click through the website yourself, but make sure that [your IP is not filtered](/installing-umarketingsuite/settings-section/ip-filtering/). Filtered IP's are never stored in the raw tables.
- You have a high threshold for '**FlushRateInRecords**' and '**FlushIntervalInSeconds**' in [your configuration file](/installing-umarketingsuite/configuration-options-1-x/). This means that the data is flushed only at certain intervals and it could be that these intervals have not been passed yet. Settings both values to 1 will fix this.
- The website URL is not listed in your license or you have reached the threshold of your pageviews. If the URL is not listed in your license the data is not stored in the raw-table. The same is true when you've exceeded the number of pageviews. No data will be stored anymore at that moment. The implication is that also upgrading your license at a later moment does not mean that you will see data in the past again that was not tracked!

## Deleting raw data

The idea of the raw database tables is that this can be stored very fast in the database and can be processed at a later moment. It also allows us to reprocess data at a later moment if that is needed. Reprocessing can be done by deleting all data from the uMarketingSuite and updating the columns **processingStarted**, **processingFinished**, **processingMachine** and **processingFailed** to **NULL**. After a restart of the website the uMarketingSuite will start processing this data again.

This is however not a recommended thing to do as part of a '*normal*' workflow. Only in case of emergency this can be useful.

After the data is processed (in [the next step](/the-umarketingsuite-broad-overview/dataflow-pipeline/data-parsing/)) the raw data can be deleted because it's of no use anymore. This can be done by setting the value '**DeleteRawDataAfterDays**' in [the configuration file](/installing-umarketingsuite/configuration-options-1-x/).