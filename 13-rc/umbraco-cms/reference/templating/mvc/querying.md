# Querying & Traversal

_This section will describe how you can render content from other nodes besides the current page in your MVC Views_

## Querying for content and media by id

The easiest way to get some content by Id is to use the following syntax (where 1234 is the content id you'd like to query for):

```csharp
// to return IPublishedContent
@Umbraco.Content(1234)
```

You can also query for multiple content items using multiple ids:

```csharp
// to return the strongly typed (IEnumerable<Umbraco.Core.Models.IPublishedContent>) collection
@Umbraco.Content(1234, 4321, 1111, 2222)
```

This syntax will support an unlimited number of Ids passed to the method.

You can also retrieve content using the `Guid` Id. In the example "ca4249ed-2b23-4337-b522-63cabe5587d1" is the key of the content.

```csharp
// to return the Umbraco.Core.Models.IPublishedContent
@Umbraco.Content(Guid.Parse("ca4249ed-2b23-4337-b522-63cabe5587d1"))
```

You can also pass a [Udi](../../querying/udi-identifiers.md) to retrieve the content.

```csharp
// to return the Umbraco.Core.Models.IPublishedContent
@Umbraco.Content(Udi.Create("document", Guid.Parse("ca4249ed-2b23-4337-b522-63cabe5587d1")))
```
The same query structures apply to media:

```csharp
@Umbraco.Media(9999)
@Umbraco.Media(9999,8888,7777)
@Umbraco.Media(9999)
@Umbraco.Media(9999,8888,7777)
@Umbraco.Content(Guid.Parse("ca4249ed-2b23-4337-b522-63cabe5587d1"))
@Umbraco.Content(Udi.Create("media", Guid.Parse("ca4249ed-2b23-4337-b522-63cabe5587d1")))
```

## Traversing

All of these extension methods are available on `Umbraco.Core.Models.IPublishedContent` so you can have strongly typed access to all of them with intellisense for both content and media. The following methods return `IEnumerable<IPublishedContent>`

```csharp
Children() // this is the same as using the Children property on the content item.
Ancestors()
Ancestors(int level)
Ancestors(string nodeTypeAlias)
AncestorsOrSelf()
AncestorsOrSelf(int level)
AncestorsOrSelf(string nodeTypeAlias)
Descendants()
Descendants(int level)
Descendants(string nodeTypeAlias)
DescendantsOrSelf()
DescendantsOrSelf(int level)
DescendantsOrSelf(string nodeTypeAlias)
Siblings()
SiblingsAndSelf()
```


Additionally there are other methods that will return a single `IPublishedContent`

```csharp
Ancestor()
AncestorOrSelf()
AncestorOrSelf(int level)
AncestorOrSelf(string nodeTypeAlias)
AncestorOrSelf(Func<IPublishedContent, bool> func)
```

## Complex querying (Where)

With the `IPublishedContent` model we support strongly typed LINQ queries out of the box so you will have intellisense for that.

### Some examples

#### Where children are visible

```csharp
@Model.Children.Where(x => x.IsVisible())
```

#### Traverse for sitemap

```csharp
var items = @Model.Children.Where(x => x.IsVisible() && x.Level <= 4)
```
{% hint style="info" %}
The two examples below have not been verified for Umbraco 9 and 10 yet.

therefore they might not work on the latest versions of Umbraco.
{% endhint %}

#### Content sub menu

```csharp
@Model.AncestorOrSelf(1).Children.Where(x => x.DocumentTypeAlias == "DatatypesFolder").First().Children
```

#### Complex query

With the strongly typed `IPublishedContent` you can do complex queries.

```csharp
// This example gets the top level ancestor for the current node, and then gets
// the first node found that contains "1173" in the array of comma delimited
// values found in a property called 'selectedNodes'.

var result = @Model.Ancestors().OrderBy(x => x.Level)
    .Single()
    .Descendants()
    .FirstOrDefault(x => x.GetPropertyValue("selectedNodes", "").Split(',').Contains("1173"));
```
