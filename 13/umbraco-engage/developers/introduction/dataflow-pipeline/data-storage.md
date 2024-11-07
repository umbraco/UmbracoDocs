---
description: >-
  Information about Data Storage and how to work with and troubleshoot it in
  Umbraco Engage.
---

# Data Storage

When the [data is collected](data-collection.md) it is temporarily stored in memory. At some point, a threshold is reached and all data is stored in the database.

## Flushing the memory

Two thresholds can be set and reached which will trigger the storage of data. If one of these two is reached the data will be stored in the database.

* The first threshold is the '`FlushRateInRecords`'.
  * When this number of records is in memory the data will be stored in the database. An example could be if you set it to 100, the data will be permanently stored after 100 page visits.
* The second threshold is the `FlushIntervalInSeconds`.
  * After this number of seconds, the data will be sent to the database. If you set it to 30 seconds, for example, every 30 seconds the data will be sent to the database. No matter how many records there are in memory.

Both settings can be set in the [configuration](../../settings/configuration.md) file of Umbraco Engage.

The higher the value set for these thresholds, the more memory Umbraco Engage uses on your web server(s) and less of your database connection. Please be aware the memory impact is low because there is not a lot of complex data stored.

The lower the value you set, the less memory Umbraco Engage uses on your web server(s), and the more database calls are made.

## Data storage

The data will be stored as quickly as possible to minimize the needed resources. For this reason, the the data collected from client-side events will be stored in so-called raw tables in a non-normalized. This data will be processed in [the next step](data-parsing.md) of the data flow.

The data collected from clientside events is stored in the table `umbracoEngageAnalyticsRawClientSideData`.

When the data is stored in these tables the columns `processingStarted`, `processingFinished`, `processingMachine`**,** and `processingFailed` are empty. They will be filled in the parsing step.
