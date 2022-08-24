---
versionFrom: 8.0.0
versionTo: 10.0.0
---

# Querying & Models

_Overview of various ways of querying, filtering and searching published content for use on your website._

## [UDI identifiers](UDI-identifiers/index.md)

**Umbraco 7.6.0+** Umbraco stores identifiers in UDI format for most Umbraco object types. This identifier stores all of the metadata required to retrieve an Umbraco object and is parse-able within text. Example: `umb://document/4fed18d8c5e34d5e88cfff3a5b457bf2`. UDI's can be used in many of the querying APIs.

## [IPublishedContent](IPublishedContent/index.md)

`IPublishedContent` is strongly typed model for content, media and members that is used to render content in your views for your website.

## [UmbracoHelper](UmbracoHelper/index.md)

UmbracoHelper is the unified way to work with published content/media on your website.
Whether you are using MVC or WebForms you will be able to use UmbracoHelper to query/traverse Umbraco published data.

## [MembershipHelper](MemberShipHelper/index.md) (Available on version 8 and below)

MembershipHelper is a helper class for accessing member data in the form of `IPublishedContent`.

## [IMemberManager](IMemberManager/index.md) (Available on version 9 and above)

`IMemberManager` is an user manager interface for accessing member data in the form of `MemberIdentityUser` and converting it to `IPublishedContent`.

## [IPublishedContentQuery](IPublishedContentQuery/index.md)

`IPublishedContentQuery` interface contains query methods for accessing strongly typed content in templates.

## [ITagQuery](ITagQuery/index.md)

The `ITagQuery` interface allows to work with tags in Umbraco.

## [UmbracoContext](UmbracoContext/index.md)

The UmbracoContext is a simplified way to work with the current request on your website.
