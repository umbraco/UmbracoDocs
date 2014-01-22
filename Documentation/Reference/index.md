#Developers' Reference
_Developers' Reference primarily consists of API references of the different core Umbraco APIs. In many cases, the references come with code snippets with simple exemples. For a more in-depth study of the different APIs, consult the "using-umbraco" and "extending-umbraco" sections of the documentation._

##[Templating](Templating/index.md)

How to use **templates** and **macros**. Covers templates and macros from the basic definitions to advanced techniques and using APIs.

*This section contains all of the details about both templates types: MVC & WebForms.*

##[Querying](Querying/index.md)

Umbraco comes with various ways of querying, filtering and searching published content for use on your website.

##[Searching](Searching/index.md)

Details on how to implement search capabilities for your Umbraco website using Examine, which is a Lucene-based search engine for Umbraco.

##Events
###[Events](Events-v6/index.md) (v6+)

Umbraco 6.x or later: event model covering all major aspects of the system for triggering custom code or automation.  

###[Legacy Events](Events/index.md) (v4)

Umbraco 4 and earlier comes with a complete event model, covering all major aspects of the system for triggering custom code or automation.

## Rest APIs

###[Web API](WebApi/index.md) 

Introduced in **Umbraco 6.1.0+**
How to use [Web API](http://www.asp.net/web-api) in Umbraco to easily create REST services.

###[/Base](Api/Base/Index.md)

/Base is a extendable system for creating raw feeds directly from Umbraco using very basic URLs. This enables developers to access Umbraco data through javascript, flash or any other client. It even allows you to modify Umbraco data directly via simple URLs.

## Management APIs

APIs that focus on creating, updating and deleting.

###[Management APIs](Management-v6/index.md) (V6+)

Specific to version 6.x or later: Create, update, and delete all build-in system objects like content, media, templates, content types and so on. 

###[Legacy Management APIs](Management/index.md)  (v4)

Specific to version 4.x or earlier: Create, update, and delete all build-in system objects like documents, media, templates, document types and so on.

## [Request Pipeline](Request-Pipeline/index.md)
This section explains how to generate URLs (outbound pipeline) and how Umbraco finds back a node using an URL (inbound pipeline).
_This functionality was introduced in v6._

##[Plugins](Plugins/index.md) 

Introduced in **Umbraco 4.10.0+**
The term 'Plugins' refers to any types in Umbraco that are found in assemblies that are used to extend and/or enhance the Umbraco application.

##[Umbraco.Library](Api/UmbracoLibrary/index.md)

Umbraco.Library is a XSLT extension library, built specifically for XSLT macros in Umbraco 4. It contains many utility methods which are strictly for use in XSLT, but also a number of more general purpose methods which can be used more broadly.