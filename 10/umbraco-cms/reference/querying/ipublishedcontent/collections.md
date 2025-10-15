---


---

# IPublishedContent Collections

All collections of `IPublishedContent` are `IEnumerable<IPublishedContent>`. This means that all C# LINQ statements can be used to filter and query the collections.

## Collections

### .Children

Returns a collection of child items available in the current culture, below the current content item.

```csharp
<ul>
    @foreach(var item in Model.Children)
    {
        <li><a href="@item.Url()">@item.Name</a></li>
    }
</ul>
```

### .ChildrenForAllCultures

Returns a collection of child items for all cultures, below the current content item, regardless of whether they are available for the current culture.

```csharp
<ul>
    @foreach(var item in Model.ChildrenForAllCultures)
    {
        <li><a href="@item.Url()">@item.Name</a></li>
    }
</ul>
```

### .Children(string culture = null)

Returns a collection of child items available in the specified culture with a default of the current one, below the current content item.

```csharp
<ul>
    @foreach(var item in Model.Children("dk-dk"))
    {
        <li><a href="@item.Url()">@item.Name</a></li>
    }
</ul>
```

### .Ancestors()

Returns all ancestors of the current page (parent page, grandparent and so on)

```csharp
<ul>
    @*Order items by their Level*@
    @foreach(var item in Model.Ancestors().OrderBy(x => x.Level))
    {
        <li><a href="@item.Url()">@item.Name</a></li>
    }
</ul>
```

### .Ancestor()

Returns the first ancestor of the current page

```csharp
@* return the first ancestor item from the current page *@
var nodes = Model.Ancestor();

@* return the first item, of a specific type, from the current page *@
var nodes = Model.Ancestor<DocumentTypeAlias>();
```

### .AncestorsOrSelf()

Returns a collection of all ancestors of the current page (parent page, grandparent and so on), and the current page itself

```csharp
@* Get the top item in the content tree, this will always be the Last ancestor found *@
var websiteRoot = Model.AncestorsOrSelf().Last();
```

### .Descendants()

Returns all descendants of the current page (children, grandchildren etc)

```csharp
<ul>
    @* Filter collection by content that has a template assigned *@
    @foreach(var item in Model.Descendants().Where(x => x.TemplateId > 0))
    {
        <li><a href="@item.Url()">@item.Name</a></li>
    }
</ul>
```

### .DescendantsOrSelf()

Returns all descendants of the current page (children, grandchildren etc), and the current page itself

```csharp
<ul>
    @* Filter collection by content that has a template assigned *@
    @foreach(var item in Model.DescendantsOrSelf().Where(x => x.TemplateId > 0))
    {
        <li><a href="@item.Url()">@item.Name</a></li>
    }
</ul>
```

### .OfTypes

Filters a collection of content by content type alias

```csharp
<ul>
    @* Filter collection by content type alias (you can pass in any number of aliases) *@
    @foreach(var item in Model.DescendantsOrSelf().OfTypes("widget1", "widget2"))
    {
        <li><a href="@item.Url()">@item.Name</a></li>
    }
</ul>
```



## Filtering, Ordering & Extensions

Filtering and Ordering are done with LINQ.

Some examples:

### .Where

```csharp
@* Returns all items in the collection that have a template assigned and have a name starting with 'S' *@
var nodes = Model.Descendants().Where(x => x.TemplateId > 0 && x.Name.StartsWith("S"))
```

### .OrderBy

```csharp
@* Orders a collection by the property name "title" *@
var nodes = Model.Children.OrderBy(x => x.GetProperty("title"))
```

### .GroupBy

Groups collection by content type alias

```csharp
@{
    var groupedItems = Model.Descendants().GroupBy(x => x.ContentType);
    foreach (var group in groupedItems)
    {
        <h2>@group.Key.Alias</h2>
        foreach(var item in group)
        {
            <h3>@item.Name</h3>
        }
    }
}
```

### .Take(int)

Return only the number of items for a collection specified by the integer value.

```csharp
@* return the first 3 items from the child collection *@
var nodes = Model.Children.Take(3);
```

### .Skip(int)

Return items from the collection after skipping the specified number of items.

```csharp
@* Skip the first 3 items in the collection and return the rest *@
var nodes = Model.Children.Skip(3);
```

{% hint style="info" %}
You can combine Skip and Take when using for paging operations
{% endhint %}

```csharp
@* using skip and take together you can perform paging operations *@
var nodes = Model.Children.Skip(10).Take(10);
```

### .Count()

Returns the number of items in the collection

```csharp
int numberOfChildren =  Model.Children.Count();
```

### .Any()

Returns a boolean True/False value determined by whether there are any items in the collection

```csharp
bool hasChildren =  Model.Children.Any();
```

## Filtering Conventions

Some filtering and routing behaviour is dependent upon a set of special naming conventions for certain properties. [See also: Routing Property Conventions](../../routing/routing-properties.md)

### .IsVisible()

If you create a checkbox property on a document type with an alias `umbracoNaviHide` then the value of this property is used by the `IsVisible()` extension method when filtering.

```csharp
IEnumerable<IPublishedContent> sectionPages =  Model.Children.Where(x => x.IsVisible());
```

Use case: When displaying a navigation menu for a section of the site, following this convention gives editors the option to 'hide' certain pages from appearing in the section navigation. (hence the unusual _umbracoNaviHide_ property alias!)
