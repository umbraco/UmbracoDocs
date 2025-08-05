---
description: >-
  On this page you can find information about Data parsing and how to store the
  data in a normalized and efficiant way.
---

# Data Parsing

Now that the data is [persisted in the database](data-storage.md) it is time for the next step.

## Getting the data

There is a background process constantly running on the webserver to check whether there are unprocessed pageviews in memory or records in the table `umbracoEngageAnalyticsRawClientSideData`.

The records in the table `umbracoEngageAnalyticsRawClientSideData` can be identified because the column `processingStarted` is `NULL`.

If the background process finds unprocessed pageviews in memory or one of these unprocessed records it fetches the rows of data and starts processing it. Once it has finished processing it updates the record in the table by setting values in the columns '`processingFinished`' and '`processingMachine`'.

## Parsing

When the data is fetched Umbraco Engage will perform some different actions:

### Normalize the data

All data is stored in a normalized way in the tables with the prefix: `umbracoEngageAnalytics`**.**

For example; each browser is only stored once in the table `umbracoEngageAnalyticsBrowser` and each browser version is stored once in the table `umbracoEngageAnalyticsBrowserVersion`.

The session is now related to the primary key ID of the browser version instead of storing the full-text string. This way, data can be queried effortlessly and is stored more efficiently (only an integer per browser instead of a text string).

This happens for all data:

* Browser and browser version
* Operating system
* Visitor type

### Relate data to Umbraco nodes

When the data was [stored in the raw database tables](data-storage.md) only the URL was stored. In the parsing step, we try to identify which Umbraco node and which culture is served on this URL. This is an important step to [report at a later point](reporting.md) what happened on which page within the Umbraco backoffice.

### Goals

Within Umbraco Engage you can [set up goals](../../settings/custom-goals-scoring.md) via a specific page that is reached or an event that has been triggered. When parsing data Umbraco Engage checks whether one of the goals is reached with this record.

## Configuration options

How frequently the data is processed can be set in [the configuration file](../../settings/configuration.md). Two parameters can be set:

* The `IntervalInRecords` setting specifies how many unprocessed records should be fetched per parsing process.
* The `IntervalInSeconds` setting specifies how often the background process is triggered and how often the parsing happens.

The higher you set these amounts the less frequent the parsing takes place.

It is possible to specify which web server should execute the processing step. The processing step is the **heaviest** in the data flow process. Most likely it will not have any impact, but for optimization reasons, you can specify which server is responsible for processing the raw data. This can be one web server, multiple web servers, or even a dedicated web server that does not serve the website itself. This can be set with the setting `IsProcessingServer`.

{% hint style="info" %}
If using [Umbraco in a load-balanced configuration](../../../getting-started/for-developers/loadbalancing-and-cm-cd-environments.md) ensure the front-end servers have the configuration setting for `IsProcessingServer` set to false. Also, make sure that the backend (Umbraco backoffice) server should only have this setting enabled.
{% endhint %}

## Cleaning up the data

There is probably no or little reason to store this data forever. That is why we have two settings to clean up this data.

* The first setting is '`AnonymizeDataAfterDays`'. After the set number of days, the data will be anonymized. This means the data will still be shown in aggregate reports like pageviews, used browsers, number of visitors, etcetera, but it can not be related to an individual visitor anymore.
* The second setting is '`DeleteDataAfterDays`'. With this setting the data will be deleted after a set number of days. The reason is that it does not make sense to store your data for all eternity.
