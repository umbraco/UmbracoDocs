# Reporting

Now that the data is [collected](/the-umarketingsuite-broad-overview/dataflow-pipeline/data-collection/), [stored](/the-umarketingsuite-broad-overview/dataflow-pipeline/data-storage/) and [parsed](/the-umarketingsuite-broad-overview/dataflow-pipeline/data-parsing/) it's finally time for the most interesting phase; browsing through the reports in the Umbraco backoffice.

The data is visualized in two parts in Umbraco:

- The [uMarketingSuite section](unpublished-item-51de601d-1366-488a-8ad8-0b7f52c02be5) gives an overview of all data that is recorded. The data is visualized for the entire installation and all pages and visitors. These reports give a perfect overview on a toplevel.
- For more detailed reports on an individual page (Umbraco node) you can go to the Analytics [Content app](/the-umarketingsuite-broad-overview/content-apps/).

## Source of data

All reports query the data of the normalized tables that are filled in the [data parsing step](/the-umarketingsuite-broad-overview/dataflow-pipeline/data-parsing/). The data of the raw datatables is not used anymore.

By following the steps of collection, storage and parsing, it probably makes sense that you can determine yourself how 'realtime' your data is. The lower the thresholds in [the configuration file](/installing-umarketingsuite/configuration-options-1-x/) the faster the data is displayed and the more realtime your data is.