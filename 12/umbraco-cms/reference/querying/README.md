# Querying & Models

_Overview of multiple ways of querying, filtering, and searching published content for use on your website._

## [UDI identifiers](udi-identifiers.md)

Umbraco stores identifiers in UDI format for most Umbraco object types. This identifier stores all of the metadata required to retrieve an Umbraco object and is parse-able within text. Example: `umb://document/4fed18d8c5e34d5e88cfff3a5b457bf2`. UDI's can be used in many of the querying APIs.

## [IPublishedContent](ipublishedcontent/)

`IPublishedContent` is strongly typed model for content, media and members that is used to render content in your views for your website.

## [UmbracoHelper](umbracohelper.md)

UmbracoHelper is the unified way to work with published content/media on your website.
Whether you are using MVC or WebForms you will be able to use UmbracoHelper to query/traverse Umbraco published data.

## [IMemberManager](imembermanager.md)

`IMemberManager` is an user manager interface for accessing member data in the form of `MemberIdentityUser` and converting it to `IPublishedContent`.

## [IPublishedContentQuery](ipublishedcontentquery.md)

The `IPublishedContentQuery` interface contains query methods for accessing strongly typed content in services etc.

## [ITagQuery](itagquery.md)

The `ITagQuery` interface allows to work with tags in Umbraco.

## [UmbracoContext](umbraco-context.md)

The UmbracoContext is a simplified way to work with the current request on your website.
