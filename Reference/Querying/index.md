# Querying & Models

_Overview of various ways of querying, filtering and searching published content for use on your website._

## [UDI identifiers](Udi.md)
**Umbraco 7.6.0+** Umbraco stores identifiers in UDI format for most Umbraco object types. This identifier stores all of the metadata required to retrieve an Umbraco object and is parse-able within text. Example: `umb://document/4fed18d8c5e34d5e88cfff3a5b457bf2`. UDI's can be used in many of the querying APIs.

## [IPublishedContent](IPublishedContent/index.md)

`IPublishedContent` is strongly typed model for content, media and members that is used to render content in your views for your website. 

## [DynamicPublishedContent](DynamicPublishedContent/index.md)

`DynamicPublishedContent` is the dynamic version of `IPublishedContent`. It has most of the same features as IPublishedContent but allows 
for slightly more elegant syntax to render user defined properties with the tradeoff that it is not strongly typed and does not support intellisense.

## [UmbracoHelper](UmbracoHelper/index.md)

UmbracoHelper is the unified way to work with published content/media on your website. 
Whether you are using MVC or WebForms you will be able to use UmbracoHelper to query/traverse Umbraco published data.

## [MembershipHelper](MemberShipHelper/index.md)

MembershipHelper is a helper class for accessing member data in the form of `IPublishedContent`
