# Data parsing

Now that the data is [persisted in the database](/the-umarketingsuite-broad-overview/dataflow-pipeline/data-storage/) it's time for the next step. As you may record the data is stored in two 'raw' database tables. These database tables are 'just' a representation of all data we've recorded from the visitor. In this step we want to store the data in a normalized (and more efficient) way, relate this data to the data in Umbraco, and verify whether goals are reached.

## Getting the data that needs to be parsed

There is a background process constantly running on the webserver to check whether there are unprocessed records in the table **uMarketingSuiteAnalyticsRawPageView** and **uMarketingSuiteAnalyticsRawClientSideData**. These records can be identified because the column '**processingStarted**' is **NULL**.

If the backgroundprocess finds one of these records it fetches the data of the row and starts processing. Once it has finished processing (or had an error) it updates the record in the table by setting values in the columns '**processingFinished**' and '**processingMachine**'.

## Parsing steps

When the data is fetched the uMarketingSuite performs several actions.

### Normalize the data

All data is stored in a normalized way in the tables with the prefix '**uMarketingSuiteAnalytics**'. For example; each browser is only stored once in the table **uMarketingSuiteAnalyticsBrowser** and each browser version is also stored once in the table **uMarketingSuiteAnalyticsBrowserVersion**. The session is now related to the primary key Id of the browserversion instead of storing the fulltext string. In this way data can be queried easily and it's store more efficient (only an integer per browser instead of a textstring).

This happens for all data:

- Browser and browser version
- Operating system
- Visitor type (a 'real' visitor, a bot or a monitoring tool)

### Relate data to Umbraco nodes

When the data was [stored in the raw databasetables](/the-umarketingsuite-broad-overview/dataflow-pipeline/data-storage/) only the url was stored. In the parsing step we try to identify which Umbraco node and which culture is served on this url. This is an important step to [report at a later moment](/the-umarketingsuite-broad-overview/dataflow-pipeline/reporting/) what has happened on which page within the Umbraco backoffice.

### Is a goal reached?

Within the uMarketingSuite you can [setup goals](/analytics/setting-up-goals/) via a specific page that is reached or an event that has been triggered. When parsing data the uMarketingSuite checks whether one of the goals is reached with this record.

## Configuration options

How frequent the data is processed can be set in [the configuration file](/installing-umarketingsuite/configuration-options-1-x/). Two parameters can be set:

- The '**IntervalInRecords**' setting specifies how many unprocessed records should be fetched per parsing process.
- The '**IntervalInSeconds**' setting specifies how often the backgroundprocess is triggered and how often the parsing takes place.

The higher you set these amounts the less frequent the parsing takes place.

It's also possible to specify which webserver should execute the processing step. The processing step is the 'heaviest' step in the dataflowprocess. 'Heaviest' is between quotes because it's relatively heavy. Probably you will not have any impact, but for optimization reasons you could also specify which server is responsible for processing the raw data. This can be one webserver, multiple webserver or even a dedicated webserver that does not serve the website itself. This can be set with the setting '**IsProcessingServer**'.

Note: If you are using [Umbraco in a load balanced configuration](https://docs.umbraco.com/umbraco-cms/fundamentals/setup/server-setup/load-balancing#how-umbraco-load-balancing-works), then ensure the front end servers have the configuration setting for **IsProcessingServer** set to false and that the back end (Umbraco backoffice) server should only have this setting enabled.

## Cleaning up all this data

There is probably no or little reasons to store this data for ever. That is why we have two settings to clean up this data.

- The first setting is '**AnonymizeDataAfterDays**'. After the set number of days the data will be anonymized. This means that the data will still show up in aggregate reports like pageviews, used browsers, number of visitors, etcetera, but it can not be related to an individual visitor anymore. How GDPR is that :)!
- The second setting is '**DeleteDataAfterDays**'. For most of us maybe a scary setting, but it doesn't make any sense to store data for all eternity. It makes sense to clean your data up once in a while, because how relevant is data of 8 years ago when you entire website has totally changed?

## Performance of the parsing step

We're constantly optimizing the performance of the parsing step because this is the heaviest step in the total process. To show the impact we have two columns in the raw tables called 'processingStarted' and 'processingFinished'. We try to keep the difference between these under 100 ms so that the impacted is minimal.