---
versionFrom: 7.0.0
---

# IPublishedContent

_`IPublishedContent` is a strongly typed model for content, media and members and is used to render content in your views for your website._

## Get started
To access the current page in your macros or templates, copy-paste the below Razor code.

```csharp
@{
    var pageName = Model.Content.Name;
    var childPages = Model.Content.Children;
}

<h1>@pageName</h1>
```

## [Properties](Properties/index-v7.md)
Listing and explanation of IPublishedContent properties and standard helpers for Content and Media.

## [Collections & Filtering](Collections/index-v7.md)
Methods for IPublishedContent collections and filtering.

## [IsHelpers](IsHelpers/index-v7.md)
A library of extension methods to simplify working with IPublishedContent in collections to modify your HTML output. Examples of using `IsHelpers` could be injecting CSS classes for alternating rows or to modify margins.

## [Extension Methods](https://our.umbraco.com/apidocs/v7/csharp/api/Umbraco.Web.PublishedContentExtensions.html)
Extension methods available for IPublishedContent.
