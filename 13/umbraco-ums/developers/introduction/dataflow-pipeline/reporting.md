---
description: >-
  Now that the data is collected, stored, and parsed it's finally time to browse
  through the reports in the Umbraco backoffice.
---

# Reporting

The data is visualized in two parts in Umbraco:

* The Umbraco [uMS section](../../../marketers-and-editors/introduction/the-umarketingsuite-section.md) gives an overview of all data that is recorded. The data is visualized for the entire installation and all pages and visitors. These reports give a perfect overview on a top level.
* For more detailed reports on an individual page (Umbraco node), you can go to the Analytics [Content app](../../../marketers-and-editors/introduction/content-apps.md).

## Source of data

All reports query the data of the normalized tables that are filled in the [data parsing step](../../../../../the-umarketingsuite-broad-overview/dataflow-pipeline/data-parsing/). The data of the raw data tables is not used anymore.

By following the steps of collection, storing, and parsing, it probably makes sense that you can determine how real-time your data is. The lower the thresholds in the [configuration file](../../../getting-started/for-developers/configuration-options-2-x.md) the faster the data is displayed and the more real-time your data is.
