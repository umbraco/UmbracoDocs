# Examine

_Examine uses Lucene as its search and index engine. Searching using Examine with Lucene can be powerful and fast._

## What is Examine?

The Examine documentation is found here [https://shazwazza.github.io/Examine/](https://shazwazza.github.io/Examine/) and the source code repository for Examine is here [https://github.com/Shazwazza/Examine](https://github.com/Shazwazza/Examine).

Examine allows you to index and search data quickly. Examine is a library that sits on top of [Lucene.Net](https://lucenenet.apache.org/), a high performance search engine library. Examine provides APIs to make searching and indexing as straight forward as possible. Umbraco provides a further layer on top, UmbracoExamine. This opens up the Umbraco-specific APIs for indexing and searching content and media out of the box.

Examine is provider based so it is extensible and allows you to configure your own custom indexes if required. The backoffice search in Umbraco also uses this same search engine, so you can trust that you're in good hands.

## [Quick start](quick-start.md)

Get up and running with Examine straight away with this quick start guide.

## [Customizing indexes](indexing.md)

Learn how to customize the built in Umbraco indexes and how to create your own Lucene indexes using Examine in Umbraco.

## [PDF indexing and multisearchers](pdfindex-multisearcher.md)

Learn how to index PDF files in Examine and how to create a multisearcher that searches through both the External Index and the Pdf Index.

## [Examine Management in the backoffice](examine-management.md)

Provides an overview of the available Examine functionality available directly within the Umbraco backoffice.

Details about subscribing to Examine events which can provide a way to modify the data being indexed.

## [API - Examine Manager](examine-manager.md)

Describes the singleton object which exposes all of the index and search providers which are registered in the configuration of the Umbraco application.
