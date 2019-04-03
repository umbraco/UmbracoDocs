---
versionFrom: 7.0.0
meta.Title: "Reference section for the Umbraco APIs"
meta.Description: "Developers' Reference primarily consists of API references of the different core Umbraco APIs. In many cases, the references come with code snippets with simple examples. For a more in-depth study of the different APIs, consult the using-umbraco and extending-umbraco sections of the documentation."
---

# Developers' Reference

_Developers' Reference primarily consists of API references of the different core Umbraco APIs. In many cases, the references come with code snippets with simple examples. For a more in-depth study of the different APIs, consult the "using-umbraco" and "extending-umbraco" sections of the documentation._

## [Common Pitfalls & Anti-patterns](Common-Pitfalls/index.md)

This section is ultra important! It describes many common pitfalls that developers fall in to. Make sure you read this section - it might just save your site!

## API Documentation

#### [C# API Documentation](https://our.umbraco.com/apidocs/csharp/)

__Note: opens a documentation browser that is different from the documentation section you're viewing now.__

C# API references for the Umbraco Core and Web libraries.

#### [Backoffice UI API documentation](https://our.umbraco.com/apidocs/ui/)

__Note: opens a documentation browser that is different from the documentation section you're viewing now.__

Angular, JavaScript, CSS & Less UI API references for building Umbraco backoffice components.

## [Security](Security/index.md)

Information on Umbraco security, its various security options and configuring how authentication & authorization works in Umbraco.

## [Configuration](Config/index.md)

Information about all of Umbraco's configuration files and options.

## [IoC & Dependency Injection](using-ioc.md)

Info about setting up IoC/Dependency Injection to work with Umbraco

## [Templates](Templating/index.md)

Working with Umbraco templates: views, partial views, child actions, razor syntax, macros and working with JavaScript/Css.

## [Querying & models](Querying/index.md)
 
Information about the data models used to display content in Umbraco and the various ways of querying it.

## [Routing & Controllers](Routing/index.md)

How routing works within Umbraco, how content is mapped to URLs and how URLs are generated for content.
This section also describes the types of Controllers used in Umbraco, how they work and how they get routed.

## [Searching](Searching/index.md)

Details on how to implement search capabilities for your Umbraco website using Examine, which is a Lucene-based search engine for Umbraco.

## [Events](Events/index.md)

Event model covering all major aspects of the system for triggering custom code or automation.  

## [Rest APIs](Routing/WebApi/index.md)

How to use [Web API](https://www.asp.net/web-api) with Umbraco to easily create REST services.

## [Management APIs](Management/index.md)

APIs that focus on creating, updating and deleting.

## [Plugins](Plugins/index.md)

The term 'Plugins' refers to any types in Umbraco that are found in assemblies that are used to extend and/or enhance the Umbraco application.

## [Caching](Cache/index.md)

Describes how to work with caching custom data structures in Umbraco. If you are creating Umbraco packages that have custom data sources and you want to cache some of this data, it's important to understand how caching works in Umbraco and to understand how it affects Umbraco installations in load balanced environments.
