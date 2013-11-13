#Developers Reference
_Developers reference primarily consists of API references of the different core umbraco APIS. In many cases, the references comes with code snippets with simple exemples. However, for a more in-depth study of the different APIs, consult the "using-umbraco" and "extending-umbraco" sections of the documentation_ 

##[Templating](Templating/index.md)

How to use **templates** and **macros**. Covers the basic definitions of templates/macros to advanced techniques and API usage.

*This section contains all of the details about both templates types: MVC & WebForms* 

##[Querying](Querying/index.md)

Umbraco comes with several ways of querying, filtering and searching content which you can use in your code.

##[Searching](Searching/index.md)

Details on how to implement search capabilities for your Umbraco website using Examine, which is a Lucene based search engine for umbraco.

##Events
###[Events](Events-v6/index.md) (v6+)

Umbraco 6.x or later: event model covering all mayor aspects of the system for triggering custom code or automation.  

###[Legacy Events](Events/index.md) (v4)

Umbraco 4 and earlier, comes with a complete event model, covering all mayor aspects of the system for triggering custom code or automation.

## Rest Apis

###[Web API](WebApi/index.md) 

Introduced in **Umbraco 6.1.0+**
How to use Web API in Umbraco to easily create REST services.

###[/Base](Api/Base/Index.md)

/Base is a extendable system for creating raw feeds directly from Umbraco using very basic Url's. This enables developers to access umbraco data through javascript, flash or any other client. It even allows you to modify umbraco data directly via simple url's.

## Management Api's

Api's around create, update and deleting  

###[Management APIs](Management-v6/index.md) (V6+)

Specific to version 6.x or later: Create, update, delete all build-in system objects like content, media, templates, content types and so on. 

###[Legacy Management APIs](Management/index.md)  (v4)

Specific to version 4.x or earlier: Create, update, delete all build-in system objects like documents, media, templates, document types and so on.

## [Request Pipeline](Request-Pipeline/index.md)
This section explains how the url generation is done (outbound pipeline) and how umbraco finds back a node using a url (inbound pipeline).
_This functionality was introduced in v6_

##[Plugins](Plugins/index.md) 

Introduced in **Umbraco 4.10.0+**
The term 'Plugins' is refering to any types in Umbraco that are found in assemblies that are used to extend and/or enhance the Umbraco application.

##[Umbraco.Library](Api/UmbracoLibrary/index.md)

Umbraco.Library is a Xslt extension library, built specifically for xslt macros in umbraco 4. It contains many utility methods which are strictly for use in Xslt, but also has a number of more general purpous methods, which can used more broadly.