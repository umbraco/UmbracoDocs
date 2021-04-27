---
v8-equivalent: "https://github.com/umbraco/UmbracoDocs/edit/main/Reference/Querying/IPublishedContent/index.md"
state: complete
updated-links: true
verified-against: alpha-3
versionFrom: 9.0.0
---

# IPublishedContent

_`IPublishedContent` is a strongly typed model for content, media and members and is used to render content in your views for your website._

## Get started

To access the current page in your templates, copy-paste the below Razor code.

```csharp
@{
    var pageName = Model.Name;
    var childPages = Model.Children;
}

<h1>@pageName</h1>
```

## [Properties & Extension Methods](properties-extension-methods.md)

Listing and explanation of IPublishedContent properties and standard helpers for Content and Media.

## Collections & Filtering

Methods for IPublishedContent collections and filtering.

## IsHelpers

A library of extension methods to simplify working with IPublishedContent in collections to modify your HTML output. Examples of using `IsHelpers` could be injecting CSS classes for alternating rows or to modify margins.
