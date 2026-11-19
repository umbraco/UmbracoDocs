---
description: >-
  Now that the data is collected, stored, and parsed it's finally time to browse
  through the reports in the Umbraco backoffice.
---

# Reporting

The data is visualized in two parts in Umbraco:

* The Umbraco Engage section gives an overview of all data that is recorded. The data is visualized for the entire installation and all pages and visitors. These reports give a perfect overview on a top level.
* For more detailed reports on an individual page (Umbraco node), you can go to the Analytics [Workspace View](../../../marketers-and-editors/introduction/workspace-views.md).

## Source of data

All the data for the reports is generated once a night. By default, Umbraco Engage picks a random time between 01:00 and 05:00 in the reporting time zone. Set a fixed time with the `Engage:Reporting:DataGenerationTime` setting, described in the [Configuration](../../settings/configuration.md) article. During this process all the relational data is turned into a star scheme for quick reporting in the different Umbraco Engage sections.&#x20;
