# Examine

_Examine uses Lucene as its search and index engine. Searching using Examine with Lucene can be very powerful and fast and it can also be really simple to setup and use._

## What is Examine?

Examine allows you to index and search data quickly and easily. It is a library that sits on top of Lucene, a very high performance search engine library written in Java. Examine is built on top of a .NET-implementation of Lucene to provide very efficient APIs to make searching and indexing as straight forward as possible. Umbraco provides a further layer on top, UmbracoExamine, that opens up the Umbraco-specific APIs for indexing and searching content and media out of the box.

Examine is provider based so is very extensible and allows you to configure as many indexes as you like and each may be configured individually. The backoffice search in Umbraco also uses this same search engine, so you can trust that you're in good hands.

## [Quick start](quick-start.md)

Get up and running with Examine straight away with this quick start guide

## [Terminology](terminology.md)

Describes the different terms and objects used in Examine such as Indexers, Searchers, Index Set, etc...

## [Examine Management in the backoffice](examine-management.md)

Provides an overview of the available Examine functionality available directly within the Umbraco backoffice

## [Overview & Explanation - "Examining Examine by Peter Gregory"](overview-explanation.md)

A detailed overview from top to bottom of how to use Examine

## [Full configuration markup example](../../Config/ExamineSettings/index.md)

Shows all configuration options with an explanation for each

## [API - Examine Manager](examine-manager.md)

Describes the singleton object which exposes all of the index and search providers which are registered in the configuration of the Umbraco application.