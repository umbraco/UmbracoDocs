---
description: >-
  Information about Data Storage and how to work with and troubleshoot it in
  Umbraco Ums.
---

# Data Storage

When the [data is collected](../../../../../the-umarketingsuite-broad-overview/dataflow-pipeline/data-collection/) it is temporarily stored in memory. At some point, a threshold is reached and all data is stored in the database.&#x20;

## Flushing the memory

Two thresholds can be set and reached which will trigger the storage of data. If one of these two is reached the data will be stored in the database.

* The first threshold is the '**FlushRateInRecords**'.&#x20;
  * When this number of records is in memory the data will be stored in the database. An example could be if you set it to 100, the data will be permanently stored after 100 page visits.
* The second threshold is the **FlushIntervalInSeconds**.&#x20;
  * After this number of seconds, the data will be sent to the database. If you set it to 30 seconds, for example, every 30 seconds the data will be sent to the database. No matter how many records there are in memory.

Both settings can be set in the [configuration](../../../getting-started/for-developers/configuration-options-2-x.md) file of the Umbraco uMS.

The higher the value set for these thresholds, the more memory Umbraco uMS uses on your web server(s) and less of your database connection. Please be aware the memory impact is low because there is not a lot of complex data stored. It also means that it will take a bit longer for data to appear in the backoffice (because the data is not yet stored and processed).

The lower the value you set, the less memory the Umbraco uMS uses on your web server(s), and the more database calls are made. The upside is that data will appear in more real-time.

## Data storage

The data will be stored as quickly as possible to minimize the needed resources. For this reason, the data will be stored in so-called raw tables in a non-normalized or optimized way. This data will be processed in [the next step](../../../../../the-umarketingsuite-broad-overview/dataflow-pipeline/data-parsing/) of the data flow.

This data collected from serverside events is stored in the database table `uMarketingSuiteAnalyticsRawPageview`.

The data collected from clientside events is stored in the table `uMarketingSuiteAnalyticsRawClientSideData`.

When the data is stored in these tables the columns `processingStarted`, `processingFinished`, `processingMachine`**,** and `processingFailed` are empty. They will be filled in the parsing step.

## Troubleshooting data storage

When you think Umbraco uMS is not working the recommendation is always to look in these raw tables, especially the **uMarketingSuiteAnalyticsRawPageview** because it works automatically.

If no new records appear in this table three things can have happened:

* There is no traffic on the website.&#x20;
  * You can try to click through the website. Ensure [your IP is not filtered](../../../../../installing-umarketingsuite/settings-section/ip-filtering/). Filtered IPs are never stored in the raw tables.
* You have a high threshold for '**FlushRateInRecords**' and '**FlushIntervalInSeconds**' in the [configuration file](../../../getting-started/for-developers/configuration-options-2-x.md).&#x20;
  * This means that the data is flushed only at certain intervals and it could be that these intervals have not been passed yet. Setting both values to 1 will fix this.
* The website URL is not listed in your license or you have reached the threshold of your pageviews.&#x20;
  * If the URL is not listed in your license the data is not stored in the raw-table. The same is true when you have exceeded the number of page views. No more data will be stored at that point. The implication is that upgrading your license later does not mean you will see data in the past that was not tracked again.

## Deleting raw data

The idea of the raw database tables is that they can be stored fast in the database and processed at a later point.

It also allows us to reprocess data at a later moment if that is needed. Reprocessing can be done by deleting all data from Umbraco uMS and updating the columns **processingStarted**, **processingFinished**, **processingMachine,** and **processingFailed** to **NULL**.&#x20;

After a restart of the website, Umbraco uMS will start processing this data again. However, this is not recommended as part of a '_normal_' workflow. Only in case of emergency, can this be useful.

After the data is processed (in the [Data Parsing article](data-parsing.md)) the raw data can be deleted because it is of no use anymore. This can be done by setting the value **DeleteRawDataAfterDays** in the configuration file
