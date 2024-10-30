---
description: >-
  We take performance seriously and performance is always on top of mind when
  adding new features to Umbraco Engage.
---

# Performance

Umbraco Engage is optimized for performance and you configure it to optimize the performance further.

## Separate processes for storing, parsing, and reporting

As documented in the [dataflow process](dataflow-pipeline/) there are different steps for [collecting](dataflow-pipeline/data-collection.md), [storing](dataflow-pipeline/data-storage.md), [parsing](dataflow-pipeline/data-parsing.md), and [reporting](dataflow-pipeline/reporting.md) the data. This is primarily done for performance reasons.

The collection is done in memory of the web server (or webservers if you have multiple web servers in a load-balanced

Storing causes the data to flow from the memory to the database. The memory is free again and can be used for other data. The data is stored in the raw data tables at that moment.

## Optimized infrastructure

You can also optimize your server infrastructure to tweak the performance. There are a few options that you could apply:

* You could set up more web servers in [a load-balanced setup](../../getting-started/for-developers/loadbalancing-and-cm-cd-environments.md). Each web server will collect data from the visitor, but you can specify which web server is responsible for parsing the data in the configuration.
* You can also set up one specific server only to parse the data. In that case, the other web servers will have almost no impact on their performance. To set this up you need to set the parameter '`IsProcessingServer`' to '`false`' in [your configuration file](../settings/configuration.md) for all servers that do not need to process the data and set it to '`true`' on the server(s) that is responsible for parsing. If there is no server with this setting set to '`true`' the raw data of Umbraco Engage will take place, but the data will never be processed.
* By default, the Umbraco Engage stores its data in the same database as Umbraco. It uses the default connection string of Umbraco (named '`umbracoDbDSN`'). It is possible to specify a separate database for all Umbraco Engage data. This could be another database on the same server or also another database server. To do this you need to specify a new connection string in your application and give that connection string a name. In [the configuration file](../settings/configuration.md), you can now specify this name in the field '`DatabaseConnectionStringName`'.
