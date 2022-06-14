---
versionFrom: 8.0.0
versionTo: 8.0.0
---

# Examine

_Examine uses Lucene as its search and index engine. Searching using Examine with Lucene can be very powerful and fast._

:::note
The majority of the Examine documentation in this section, is last verified for Umbraco 8 or 7.

We recommend that you refer to the official [Examine](https://shazwazza.github.io/Examine/) and [Lucene](https://lucenenet.apache.org/) documentation when using Umbraco 9 or later versions.

Since Examine 1.2.1, special characters (like æ, ø, å etc.) are now indexed by default.
This version of Examine ships with Umbraco CMS 8.18 and above.
Reference [here](https://github.com/umbraco/Umbraco-CMS/issues/11871#issuecomment-1153923424). 

Do you have any specific questions or queries regarding the above, please feel free to report on the official [UmbracoDocs Github Issue Tracker](https://github.com/umbraco/UmbracoDocs/issues).
:::

## What is Examine?

The Examine documentation is found here [https://shazwazza.github.io/Examine/](https://shazwazza.github.io/Examine/) and the source code repository for Examine is here [https://github.com/Shazwazza/Examine](https://github.com/Shazwazza/Examine).

Examine allows you to index and search data quickly. Examine is a library that sits on top of [Lucene.Net](https://lucenenet.apache.org/), a high performance search engine library. Examine provides APIs to make searching and indexing as straight forward as possible. Umbraco provides a further layer on top, UmbracoExamine, that opens up the Umbraco-specific APIs for indexing and searching content and media out of the box.

Examine is provider based so it is extensible and allows you to configure your own custom indexes if required. The backoffice search in Umbraco also uses this same search engine, so you can trust that you're in good hands.

## [Quick start](quick-start/index.md)

Get up and running with Examine straight away with this quick start guide.

## [Customizing indexes](indexing/index.md)

Learn how to customize the built in Umbraco indexes and how to create your own Lucene indexes using Examine in Umbraco 8.

## [PDF indexing and multisearchers](pdf-index.md)

Learn how to index PDF files in Examine and how to create a multisearcher that searches through both the External Index and the Pdf Index.

## [Terminology](terminology.md)

Describes the different terms and objects used in Examine such as Indexers, Searchers, Index Set, etc...

## [Examine Management in the backoffice](examine-management.md)

Provides an overview of the available Examine functionality available directly within the Umbraco backoffice.

## [Examine events](examine-events.md)

Details about subscribing to Examine events which can provide a way to modify the data being indexed.

## [API - Examine Manager](examine-manager.md)

Describes the singleton object which exposes all of the index and search providers which are registered in the configuration of the Umbraco application.
