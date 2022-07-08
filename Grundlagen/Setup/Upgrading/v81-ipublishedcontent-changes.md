# IPublishedContent breaking changes in 8.1.0

## Why

The `IPublishedContent` interface is very central in Umbraco, as it represents published content and media items at rendering layer level, for instance in controllers or views. In other words, it is the interface that is used everywhere when building sites.

The introduction of multilingual support in version 8 required changes to the interface. For instance, a property value could be obtained in version 7 with `GetPropertyValue(alias)`. Version 8 required a new parameter for culture, and the call thus became `Value(alias, culture)`.

In the excitement of the version 8 release, we assumed that `IPublishedContent` was "done". By our tests, everything was looking good. However, feedback from early testers showed that the interface was in some places odd or inconsistent, or had issues.

## What

Fixing the bugs is a requirement. Unfortunately, some of the required bug fixes could not be achieved without introducing some breaking changes.

At that point, we had decided to give `IPublishedContent` some love: fix the bugs, make it clean, friendly, discoverable and predictable, for the entire life of version 8.

Breaking changes to such a central interface is not something we take lightly. Even though they do not impact the "concepts" nor require heavy refactoring, they may demand an amount of small fixes here and there.

The general idea underlying these changes is that:

* The proper way to retrieve "something" from an `IPublishedContent` instance is always through a method, for example: `Children()`. And, when that method can be multilingual, the method accepts a `culture` parameter, which can be left `null` to get the "current" culture value.
* To reduce the amount of breaking changes, and to simplify things for non-multilingual sites, existing properties such as `document.Name` and `document.Children` (and others) still exist, and return the value for the current culture. In other words, these properties are now implemented as `document.Name => document.Name()` or `document.Children => document.Children()`.

The rest of this document presents each change in details.

## When

In Umbraco version 8.1.

## How

### More interfaces

It was possible to mock and test the `IPublishedContent` interface in version 7. It has been improved in version 8, but it still relies on concrete `PublishedContentType` and `PublishedPropertyType` classes to represent the content types, which complicates things.

In version 8.1, these two classes are abstracted as `IPublishedContentType` and `IPublishedPropertyType`, thus making `IPublishedContent` easier to mock and test.

>**CHANGE**: This impacts every method accepting or returning a content type. For instance, the signature of most `IPropertyValueConverter` methods changes. References to `PublishedContentType` must be replaced with references to `IPublishedContentType`.

### IPublishedContent

The following `IPublishedContent` members change:

#### Name

The `document.Name` property is complemented by the `document.Name(string culture = null)` extension method. The property returns the name for the current culture. The `document.GetCulture(...).Name` syntax is removed.

>**CHANGE**: Calls to `document.GetCulture(culture).Name` must be replaced with `document.Name(culture)`.

#### UrlSegment

The `document.UrlSegment` property is complemented by the `document.UrlSegment(string culture = null)` extension method. The property returns the Url segment for the current culture. The `document.GetCulture(...).UrlSegment` syntax is removed.

>**CHANGE**: Calls to `document.GetCulture(culture).UrlSegment` must be replaced with `document.UrlSegment(culture)`.

#### Culture

The `document.GetCulture()` method is removed. The proper way to get a culture date is `document.CultureDate(string culture = null)`. The `document.Cultures` property now returns the invariant culture, for invariant documents.

>**CHANGE**: Calls to `document.GetCulture(culture).Date` must be replaced with `document.CultureDate(culture)`. Calls to `document.Cultures` must take into account the invariant culture.

#### Children

The `document.Children` property is complemented by the `document.Children(string culture = null)` extension method which, when a culture is specified always return children available for the specified culture. The property returns the children available for the current culture.

A new `document.ChildrenForAllCultures` property is introduced, which returns *all* children, regardless of whether they are available for a culture or not.

>**CHANGE**: Calls to `document.Children` may have to be replaced by `document.ChildrenForAllCultures` depending on if the 8.0.x usage of this was relying on it returning unfiltered/all children regardless of the current routed culture.

#### Url

The `document.Url` property is complemented by the `document.Url(string culture = null, UrlMode mode = UrlMode.Auto)` extension method. The `document.GetUrl(...)` and `document.UrlAbsolute()` methods are removed. The `UrlProviderMode` enumeration is renamed `UrlMode`.

>**CHANGE**: Calls to `document.GetUrl(...)` must be replaced with `document.Url(...)`. Calls to `document.UrlAbsolute()` must be replaced with `document.Url(mode: UrlMode.Absolute)`.

### UmbracoContext

Due to the `UrlProviderMode` enumeration being renamed `UrlMode`, the signature of some overloads of the `Url(...)` method has changed. Methods that do not have a mode parameter remain unchanged.

>**CHANGE**: Code such as `context.Url(1234, UrlProviderMode.Absolute)` must become `context.Url(1234, UrlMode.Absolute)`.

The `UmbracoContext` class gives access to the rendering layer, which is more than a "cache". To reflect this, its `ContentCache` and `MediaCache` properties are renamed `Content` and `Media`. However, the old properties remain as obsolete properties.

>**CHANGE**: None required in 8.1, but code such as `context.ContentCache.GetById(1234)` should eventually be converted to `context.Content.GetById(1234)` as the obsolete properties may be removed in a further release.

### GetCulture

Version 7 had a `document.GetCulture()` method that was deriving a culture from domains configured in the tree. Somehow, that method was lost during version 8 development (issue [#5269](https://github.com/umbraco/Umbraco-CMS/issues/5269)).

Because that method is useful, especially when building traditional, non-multilingual sites, it has been re-introduced in version 8.1 as `document.GetCultureFromDomains()`.

>**CHANGE**: None.

### DomainHelper

`DomainHelper` has been replaced with a static `DomainUtilities` class.

>**CHANGE**: It is rare that `DomainHelper` is used in code since it only contains one public method but if developers are using this, it can no longer be injected since it's now a static class called `DomainUtilities`.
