# Multinode Treepicker

`Alias: Umbraco.MultiNodeTreePicker`

`Returns: IEnumerable<IPublishedContent>`

## Settings

The Multinode Treepicker allows you to configure the type of tree to render and what part of the tree that should be rendered. For content it allows you to select a dynamic root node based on the current document using the multinode tree picker.

**Node type:** set the type of node, the root node of the tree, or query for the root node

For querying for a root node, you can use dynamic placeholders in the XPath query, following the below sample queries

```
// get the first textpage below the current document
$current/textpage: current page or closest found ancestor

// get a descendant of type news article somewhere below the parent
$parent//newsArticle: parent page or closest found ancestor

// go to the root of the content tree
$root

// go the ancestor at @level=1 where your website root usually is.
$site: Ancestor node at level 1
```

It is important to notice that all placeholders above act against published content only. So if you, therefore, try to fetch `$parent` of the current document, then Umbraco will return that or its closest published ancestor. So in case, the parent is not published, it will try the parent of that parent, and so on.

**Filter out items with type:** allow or disallow tree nodes with a certain content type alias.

Enter `typeAlias,altTypeAlias` to only allow selecting nodes with those alias'. Enter `!typeAlias,altTypeAlias` to only allow selecting nodes **not** with those alias'.

**Minimum/maximum number of items:** set a limit on the number of items allowed to be selected.

## Data Type Definition Example

![Multinode Treepicker Data Type Definition](../built-in-property-editors/images/Multinode-Treepicker-DataType-8\_1.png)

## Content Example

![Multinode Treepicker](../built-in-property-editors/images/Multinode-Treepicker-Content-v8.png)

## MVC View Example

### Without Modelsbuilder

```csharp
@{
    var typedMultiNodeTreePicker = Model.Value<IEnumerable<IPublishedContent>>("featuredArticles");
    if (typedMultiNodeTreePicker != null) {
        foreach (var item in typedMultiNodeTreePicker)
        {
            <p>@item.Name</p>
        }
}
```

### With Modelsbuilder

```csharp
@{
    var typedMultiNodeTreePicker = Model.FeaturedArticles;
    foreach (var item in typedMultiNodeTreePicker)
    {
        <p>@item.Name</p>
    }
}
```

## Add values programmatically

See the example below to see how a value can be added or changed programmatically. To update a value of a property editor you need the [Content Service](../../../../reference/management/services/contentservice/).

{% hint style="info" %}
The example below demonstrates how to add values programmatically using a Razor view. However, this is used for illustrative purposes only and is not the recommended method for production environments.
{% endhint %}

```csharp
@inject IContentService Services;
@using Umbraco.Cms.Core;
@using Umbraco.Cms.Core.Services 

@{
    // Get access to ContentService
    var contentService = Services;

    // Create a variable for the GUID of the page you want to update
    var guid = Guid.Parse("32e60db4-1283-4caa-9645-f2153f9888ef");

    // Get the page using the GUID you've defined
    var content = contentService.GetById(guid); // ID of your page

    // Get the pages you want to assign to the Multinode Treepicker
    var page = Umbraco.Content("665d7368-e43e-4a83-b1d4-43853860dc45");
    var anotherPage = Umbraco.Content("1f8cabd5-2b06-4ca1-9ed5-fbf14d300d59");

    // Create Udi's of the pages
    var pageUdi = Udi.Create(Constants.UdiEntityType.Document, page.Key);
    var anotherPageUdi = Udi.Create(Constants.UdiEntityType.Document, anotherPage.Key);

    // Create a list of the page udi's
    var udis = new List<string>{pageUdi.ToString(), anotherPageUdi.ToString()};

    // Set the value of the property with alias 'featuredArticles'. 
    content.SetValue("featuredArticles", string.Join(",", udis));

    // Save the change
    contentService.Save(content);
}
```

Although the use of a GUID is preferable, you can also use the numeric ID to get the page:

```csharp
@{
    // Get the page using it's id
    var content = contentService.GetById(1234); 
}
```

If Modelsbuilder is enabled you can get the alias of the desired property without using a magic string:

```csharp
@inject IPublishedSnapshotAccessor _publishedSnapshotAccessor;
@using Umbraco.Cms.Core.PublishedCache;

@{
    // Set the value of the property with alias 'featuredArticles'
    content.SetValue(Home.GetModelPropertyType(_publishedSnapshotAccessor ,x => x.FeaturedArticles).Alias, string.Join(",", udis));
}
```
