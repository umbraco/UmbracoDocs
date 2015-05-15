#Developers' Reference
_Developers' Reference primarily consists of API references of the different core Umbraco APIs. In many cases, the references come with code snippets with simple examples. For a more in-depth study of the different APIs, consult the "using-umbraco" and "extending-umbraco" sections of the documentation._

##[Templating](Templating/index.md)

How to use **templates** and **macros**. Covers templates and macros from the basic definitions to advanced techniques and using APIs.

*This section contains all of the details about both templates types: MVC & WebForms.*

##[Querying](Querying/index.md)

Umbraco comes with various ways of querying, filtering and searching published content for use on your website.

##[Searching](Searching/index.md)

Details on how to implement search capabilities for your Umbraco website using Examine, which is a Lucene-based search engine for Umbraco.

##[Events](Events-v6/index.md)

Event model covering all major aspects of the system for triggering custom code or automation.  

##[Rest APIs](WebApi/index.md)

How to use [Web API](http://www.asp.net/web-api) with Umbraco to easily create REST services.

##[Management APIs](Management-v6/index.md)

APIs that focus on creating, updating and deleting.

## [Routing](Request-Pipeline/index.md)

This section explains how routing and URLs work in Umbraco ('request pipeline'). 

It explains how to generate URLs (outbound pipeline) and how Umbraco finds a node from a given URL (inbound pipeline). 

Custom routing is also described in this section.

##[Plugins](Plugins/index.md)

The term 'Plugins' refers to any types in Umbraco that are found in assemblies that are used to extend and/or enhance the Umbraco application.

##[Caching](Cache/index.md)

Describes how to work with caching custom data structures in Umbraco. If you are creating Umbraco packages that have custom data sources and you want to cache some of this data, it's important to understand how caching works in Umbraco and to understand how it affects Umbraco installations in load balanced environments.

## Legacy reference

The below links refer to old deprecated code, you can safely ignore the below information in most cases if you are working with Umbraco versions 6+

###[Umbraco.Library](Api/UmbracoLibrary/index.md)

Umbraco.Library is a legacy XSLT extension library, built specifically for XSLT macros in Umbraco 4. It contains many utility methods which are strictly for use in XSLT.

###[Legacy Events](Events/index.md) (v4)

Umbraco 4 and earlier comes with a complete event model, covering all major aspects of the system for triggering custom code or automation.

###[Legacy Management APIs](Management/index.md) (v4)

Specific to version 4.x or earlier: Create, update, and delete all build-in system objects like documents, media, templates, document types and so on.

###[/Base](Api/Base/Index.md) (Legacy)

_/Base has been superseded by Web API above_

/Base is a extendable system for creating raw feeds directly from Umbraco using very basic URLs. This enables developers to access Umbraco data through javascript, flash or any other client. It even allows you to modify Umbraco data directly via simple URLs.
