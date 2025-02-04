---
description: Understanding and Extending ModelsBuilder in Umbraco
---


# Introduction

Umbraco’s Models Builder automatically generates strongly typed models for content types, allowing developers to work with Umbraco data in a structured and efficient manner. This article explains how models are generated, how composition and inheritance work, and best practices for extending models without causing issues.

## Models Generation Process

Models Builder generates each content type as a partial class. For example, a content type named `TextPage` results in a `TextPage.generated.cs` file with a structure like this:

```csharp
/// <summary>TextPage</summary>
[PublishedModel("textPage")]
public partial class TextPage : PublishedContentModel
{
  //static helpers
  public new const string ModelTypeAlias = "textPage";

  public new const PublishedItemType ModelItemType = PublishedItemType.Content;

  public new static IPublishedContentType GetModelContentType(IPublishedSnapshotAccessor publishedSnapshotAccessor)
    => PublishedModelUtility.GetModelContentType(publishedSnapshotAccessor, ModelItemType, ModelTypeAlias);

  public static IPublishedPropertyType GetModelPropertyType<TValue>(IPublishedSnapshotAccessor publishedSnapshotAccessor, Expression<Func<TextPage, TValue>> selector)
    => PublishedModelUtility.GetModelPropertyType(GetModelContentType(publishedSnapshotAccessor), selector);

  private IPublishedValueFallback _publishedValueFallback;

  //constructor
  public TextPage(IPublishedContent content, IPublishedValueFallback publishedValueFallback)
    : base(content, publishedValueFallback)
  {
    _publishedValueFallback = publishedValueFallback;
  }

  // properties

  ///<summary>
  /// Header
  ///</summary>
  [ImplementPropertyType("header")]
  public virtual string Header => this.Value<string>(_publishedValueFallback, "header");
}
```

In the above code:

* The model includes a constructor and static helpers to fetch the content type (`PublishedContentType`) and property type (`PublishedPropertyType`).
* The most important part is the property definition (`Header`), which retrieve values from Umbraco.

You can use helper methods to access content and property types:

```csharp
var contentType = TextPage.GetModelContentType(_publishedSnapshotAccessor); // is a PublishedContentType
var propertyType = TextPage.GetModelPropertyType(_publishedSnapshotAccessor, x => x.Header); // is a PublishedPropertyType
```

## Composition and Inheritance

### Composition

Umbraco content types can be composed of multiple other content types. Unlike traditional C# inheritance, Umbraco allows a content type to inherit properties from multiple sources.

For example, a `TextPage` might be composed of:

* **MetaInfo** content type (inherits `Author` and `Keywords` properties).
* **PageInfo** content type (inherits `Title` and `MainImage` properties).

Each content type in a composition is generated both as a class and as an interface. The `MetaInfo` content type would be generated as:

```csharp
// The composition interface
public partial interface IMetaInfo : IPublishedContent
{
  public string Author { get; }
  public IEnumerable<string> Keywords { get; }
}

// The composition class
public partial class MetaInfo : PublishedContentModel
{
  // the "static mixin getter" for the property
  public static string GetAuthor(IMetaInfo that)
  {
    return that.GetPropertyValue<string>("author");
  }

  public string Author { get { return MetaInfo.GetAuthor(this, _publishedValueFallback); } }
}
```

And the `TextPage` model would be generated as:

```csharp
public partial class TextPage : PublishedContentModel, IMetaInfo
{
  // get the property value from the "static mixin getter"
  public string Author { get { return MetaInfo.GetAuthor(this, _publishedValueFallback); } }
}
```

### Inheritance

In addition to composition, content types can have a parent-child relationship. In the Umbraco backoffice, a content type appears underneath its parent.

By convention, a content type is always **composed of its parent** and therefore inherits its properties. However, the parent content type is treated differently, and the child content type *directly inherits* (as in C# inheritance) from the parent class.

If `AboutPage` is a child of TextPage, its generated model would inherit directly from `TextPage`:

```csharp
// Note: Inherits from TextPage
public partial class AboutPage : TextPage
{
  ...
}
```

## Extending Models

Since models are partial classes, developers can extend them by adding additional properties.

For Example:

```csharp
public partial class TextPage
{
    public string WrappedHeader => $"[{Header}]";
}
```

Models Builder does not recognize custom partial classes during regeneration. If your custom class conflicts with the generated class (e.g., overriding a constructor), it will cause compilation errors.

Overloaded constructors will not be used because models are always instantiated using the default constructor.

For more complex customizations, use the full version of [Models Builder](https://github.com/zpqrtbnk/Zbu.ModelsBuilder).

### Custom Model Generation with IModelsGenerator

From Umbraco 11.4, you can implement the `IModelsGenerator` interface hto customize how models are generated. This allows you to replace Umbraco’s default implementation using dependency injection:

The interface can be accessed via `Infrastructure.ModelsBuilder.Building.ModelsGenerator`.

## Best Practices for Extending Models

Extending models should be used to add stateless, local features to models. It should not be used to transform *content* models into view models or manage trees of content.

### Good practices

A customer has "posts" that has two "release date" properties. One is a true date picker property and is used to specify an actual date and to order the posts. The other is a string that is used to specify dates such as "Summer 2015" or "Q1 2016". Alongside the title of the post, the customer wants to display the text date, if present, else the actual date. If none of those are present, the Umbraco update date should be used. Keep in mind that each view can contain code to deal with the situation, but it is much more efficient to extend the `Post` model:

```csharp
    public partial class Post
    {
        public string DisplayDate
        {
            get
            {
                if(!TextDate.IsNullOrWhiteSpace())
                {
                    return TextDate;
                }

                if (ActualDate != default)
                {
                    return ActualDate.ToString();
                }

                return UpdateDate.ToString();
            }
        }
    }
```

Simplified view:

```csharp
<div class="title">
  <div class="title-text">@Model.Title</div>
  <div class="title-date">@Model.DisplayDate</div>
</div>
```

### Bad practices

Because, by default, the content object is passed to views, one can be tempted to add view-related properties to the model. Some properties that do *not* belong to a *content* model would be:

* A `HomePage` property that retrieves the "home page" content item.
* A `Menu` property that lists navigation items.

Generally speaking, anything that is tied to the current request, or that depends on more than the modeled content, is a bad idea. There are much cleaner solutions, such as using true *view model* classes that would be populated by a true controller and look like:

```csharp
public class TextPageViewModel
{
  public TextPage Content; // The content model
  public HomePage HomePage; // The home page content model
  public IEnumerable<MenuItem> Menu; // The menu content models
}
```

One can also extend Umbraco's views to provide a special view helper that gives access to important elements of the website:

```csharp
<a href="@MySite.HomePage.Url">@MySite.HomePage.Title</a>
```

### Ugly practices

The model's scope and lifecycle are *unspecified*. It may exist only for your request or be cached and shared across all requests.

The code has a major issue: the `TextPage` model caches a `HomePageDocument` model that will not update when the home page is re-published.

```csharp
private HomePageDocument _homePage;
public HomePageDocument HomePage
{
    get
    {
        if (_homePage is null)
        {
            _homePage = this.AncestorOrSelf<HomePageDocument>(1);
        }
        return _homePage;
    }
}
```

As a rule of thumb, models should never reference and cache other models.
