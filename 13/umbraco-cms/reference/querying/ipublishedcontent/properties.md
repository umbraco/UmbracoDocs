# IPublishedContent Property Access & Extension Methods

## Umbraco Properties

Built-in properties, which exists on all content objects by default

Common Examples

```csharp
@* gets the current page Url *@
@Model.Url(PublishedUrlProvider)

@* gets the Creation date, and formats it to a short date *@
@Model.CreateDate.ToString("D")

@* Outputs the name of the parent if it exists *@
@if(Model.Parent != null){
    <h1>@Model.Parent.Name</h1>
}
```

### .Id

Returns the unique Id for the current content item

```csharp
@Model.Id
```

### .Name

Returns the Name of the current content item in the current culture

```csharp
@Model.Name
```

### .Name(IVariationContextAccessor, string culture = null)

Returns the Name of the current content item in the specified culture, null falls back to the current culture

```csharp
@Model.Name(VariationContextAccessor, "dk-dk")
```

### .ContentType

Returns a strongly typed 'PublishedContentType' object representing the content type the IPublishedContent item is based on, that gives access to the alias

```csharp
@Model.ContentType
@Model.ContentType.Alias
```

### .GetCultureFromDomains(IUmbracoContextAccessor, ISiteDomainHelper, Uri current = null)

Returns a culture from a configured domain in the content tree.

```csharp
@Model.GetCultureFromDomains(ContextAccessor, DomainHelper)
```

### .Parent

Returns the parent content item

```csharp
@Model.Parent
@Model.Parent.Name
```

### .Path

Returns a comma delimited string of Node Ids that represent the path of content items back to root.

```csharp
@Model.Path
```

### .Level

Returns the Level (depth) this content item is in its tree path

```csharp
@Model.Level
```

### .TemplateId

Returns the id of the default Template object used with this content item.

```csharp
@Model.TemplateId
```

There are extension methods to retrieve template alias (Model.GetTemplateAlias())

### .SortOrder

Returns the index the page is on, compared to its siblings

```csharp
@Model.SortOrder
```

### .Url(PublishedUrlProvider, culture = null, UrlMode mode = UrlMode.Default) - (Extension method)

Returns the Url to the page.

```csharp
@Model.Url(PublishedUrlProvider)
```

**Example:** Getting a Danish Url for a site where a Danish language has been set up.

```csharp
@Model.Url(PublishedUrlProvider, "dk")
```

**Example:** Getting an Absolute Danish Url for a site where a Danish language has been set up.

```csharp
@Model.Url(PublishedUrlProvider, "dk", UrlMode.Absolute)
```

### .UrlSegment

Returns the Url encoded name of the page (slug) of the current culture

```csharp
@Model.UrlSegment
```

### .UrlSegment(IVariationContextAccessor, string culture = null)

Returns the Url encoded name of the page (slug) of the specified culture

```csharp
@Model.UrlSegment(VariationContextAccessor)
```

### .WriterId

Returns the id of the Umbraco backoffice user that performed the last update operation on the content item.

```csharp
@Model.WriterId
```

### .WriterName(IUserService)

Returns the name of the Umbraco backoffice user that initially created the content item.

```csharp
@Model.WriterName(UserService)
```

### .CreatorId

Returns the id of the Umbraco backoffice user that initially created the content item

```csharp
@Model.CreatorId
```

### .CreatorName(IUserService)

Returns the name of the Umbraco backoffice user that initially created the content item.

```csharp
@Model.CreatorName(UserService)
```

### .CreateDate

Returns the DateTime the page was created

```csharp
@Model.CreateDate
@* gets the Creation date, and formats it to a short date *@
@Model.CreateDate.ToString("D")
```

### .UpdateDate

Returns the DateTime the page was modified

```csharp
@Model.UpdateDate
@* gets the Update/Modified date, and formats it to a short date *@
@Model.UpdateDate.ToString("D")
```

***

## Custom properties

All content and media items contain a reference to all the data defined by their Document Type. Custom property access is achieved using variations of the method: `Value`

### Model.Value(IPublishedValueFallback, string)

Returns the property value for the specified property alias

```csharp
@*Get the property with alias: "siteName" from the current page  *@
@Model.Value(PublishedValueFallback, "siteName")
```

The type returned of this property value is `object`. This is fine in most cases since when using the above syntax, Razor will automatically execute a `ToString()` on the result value.

See `Model.Value<T>(string)` for how to return a strongly typed object for the property

### Model.Value\<T>(string)

Returns the property value for the specified property alias converted to 'T' - the requested output type of the property value.

For example, to return the `string` result of "siteName":

```csharp
@(Model.Value<string>(PublishedValueFallback, "siteName"))
```

```csharp
var mediaItems = Model.Value<IEnumerable<IPublishedContent>>(PublishedValueFallback, "mediaIds");
```

## Fallbacks

If the current content item doesn't have the requested value, use an alternative 'fallback' value in its place.

Each of the examples below make use of an injected PublishedValueFallback. This is achieved by adding the following at the top of your Razor file:

```csharp
@inject IPublishedValueFallback PublishedValueFallback
```

This parameter is optional, but can make unit testing easier.

### Fallback to Default Value

If a content page has a 'title' property, to fallback to use the 'Name' of the content item if the 'title' is not populated. Set the Fallback type to be Fallback.ToDefaultValue, and set the DefaultValue accordingly:

```csharp
@(Model.Value<string>(PublishedValueFallback, "title", fallback: Fallback.ToDefaultValue, defaultValue: Model.Name));
```

or to a specific value

```csharp
@(Model.Value<string>(PublishedValueFallback, "author", fallback: Fallback.ToDefaultValue, defaultValue: "Team Reporter"));
```

### Fallback to Ancestors

Look for a property value on the current page. If it doesn't exist look for the property value on the parent page. Then the parent's parent page and so on. This approach allows specifying 'global property values' all the way up the content tree. These values can be overridden in different sections or individual pages.

```csharp
@(Model.Value(PublishedValueFallback, "propertyAlias", fallback: Fallback.ToAncestors))
```

### Fallback to Language

If working with variants - fallback to a different language value - if perhaps the value hasn't been populated yet for the current language:

```csharp
@(Model.Value(PublishedValueFallback, "pageTitle", "fr", fallback: Fallback.ToLanguage))
```

### Combining the Fallback options

Use Fallback.To() to 'combine' Fallback options.

The following would first look for a 'title' property on all ancestors, before defaulting to the current page's name:

```csharp
@Model.Value(PublishedValueFallback, "title", fallback: Fallback.To(Fallback.Ancestors, Fallback.DefaultValue), defaultValue: Model.Name)
```

## Property Methods

**There are a few helpful methods to help check if a property exists, has a value or is null.**

### .HasProperty(string propertyAlias)

Returns a boolean value representing if the IPublishedContent has a property with the specified alias.

### .HasValue(string propertyAlias)

Returns a boolean value representing if the IPublishedContent property has had a value set.

It's possible to use 'Fallbacks' with HasValue:

```csharp
bool hasPageTitleSetSomewhere = Model.HasValue(PublishedValueFallback, "pageTitle", fallback: Fallback.ToAncestors);
```
