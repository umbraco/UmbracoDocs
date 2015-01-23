#Querying

_Umbraco comes with various ways of querying, filtering and searching published content for use on your website. Published content is content/media that is available to end-users viewing your website._

_This section describes how to work with the read-only cached data for use on the front-end. If you are loking for documentation on how to work with Umbraco persisted (database) data, see [Management Apis](../Management-v6/index.md)_

##[MembershipHelper](MemberShipHelper/index.md)

MembershipHelper is a general helper class for access asp.net membership data, as well as Umbraco Member data, which are stored in a format similiar to Umbraco content and media

##[UmbracoHelper](UmbracoHelper/index.md)

UmbracoHelper is the unified way to work with published content/media on your website. Whether you are using MVC or WebForms you will be able to use UmbracoHelper to query/traverse Umbraco published data. 


##Legacy APIs

_The following APIs have been superceded by UmbracoHelper, they should not be used unless you are using a very old version of Umbraco_

###[DynamicNode](DynamicNode/index.md)

DynamicNode is similar to the dynamic models that UmbracoHelper exposes but is available only to the legacy Razor Macros and inline razor macros. If you are using DynamicNode and Razor Macros, it is recommended to upgrade them to Partial View Macros and UmbracoHelper. 

DynamicNode provides dynamic way to query content which resides in the website cache. It can be used on Templates and Macros and accessable via the Model. DynamicNode extends this Model by exposing the properties of the current page as dynamic properties, and also adds [tree traversal and filtering methods](http://our.umbraco.org/projects/developer-tools/razor-dynamicnode-cheat-sheet).

###[uQuery](uQuery/index.md)

uQuery was originally created in the uComponents project primarily to overcome some of the missing features of the legacy NodeFactory and other query techniques that came out of the box with Umbraco. uQuery was eventually integrated into Umbraco's core. Just like DynamicNode, uQuery has been superceded by UmbracoHelper. 

_**NOTE**: If there are features of uQuery that are not available via UmbracoHelper, please create a task/issue on the [tracker](http://issues.umbraco.org/) so we can implement it._

uQuery is similar to DynamicNode in that is adds tree traversal/filtering methods and acts as a wrapper to the website cache. uQuery extends the NodeFactory, Document, Media, Member and Relations apis and can be queried using LINQ.

The property accessor syntax is heavier, but is strongly typed, so there's intellisense.
