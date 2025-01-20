---
description: Describes how to use Content Type Filters to restrict the allowed content options available to editors.
---

# Filtering Allowed Content Types

When creating content editors are presented with a dialog where they select the type of content they want to create. The options available are defined when setting up the document, media and member types in the _Settings_ section.

Sometimes implementors or packages have a requirement to use some additional logic to determine which options are available.

This is possible using content type filters.

{% hint style="info" %}
The uses cases supported here are similar to those where the `SendingAllowedChildrenNotification` would be used in Umbraco 13 or earlier.
{% endhint %}

## Implementing a Content Type Filter

To create a content type filter you use a class that implements the `IContentTypeFilter` interface (found in the `Umbraco.Cms.Core.Services.Filters` namespace).

There are two methods you can implement. One is for filtering the content types allowed at the content root. The other is for the content types allowed below a given parent node.

If you don't want to filter for one or other method, you can return the provided collection unmodified.

The following example shows a typical use case. Often websites will have a "Home Page" Document Type which is created at the root. Normally, only one of these is required. You can enforce that using the following Content Type Filter.

Here we are querying the existing content available at the root. Normally we can create a "Home Page" here, but if one already exists, we remove the option:

```csharp
internal class OneHomePageOnlyContentTypeFilter : IContentTypeFilter
{
    private readonly IContentService _contentService;

    public OneHomePageOnlyContentTypeFilter(IContentService contentService) => _contentService = contentService;

    public Task<IEnumerable<TItem>> FilterAllowedAtRootAsync<TItem>(IEnumerable<TItem> contentTypes)
        where TItem : IContentTypeComposition
    {
        var docTypeAliasesToExclude = new List<string>();

        const string HomePageDocTypeAlias = "homePage";
        var docTypeAliasesAtRoot = _contentService.GetRootContent()
            .Select(x => x.ContentType.Alias)
            .Distinct()
            .ToList();
        if (docTypeAliasesAtRoot.Contains(HomePageDocTypeAlias))
        {
            docTypeAliasesToExclude.Add(HomePageDocTypeAlias);
        }

        return Task.FromResult(contentTypes
            .Where(x => docTypeAliasesToExclude.Contains(x.Alias) is false));
    }

    public Task<IEnumerable<ContentTypeSort>> FilterAllowedChildrenAsync(IEnumerable<ContentTypeSort> contentTypes, Guid parentKey)
        => Task.FromResult(contentTypes);
}
```

Content Type Filters are registered as a collection, so it's possible to have more than one either in the solution or an installed package.

You use a composer to register the filters:

```csharp
public class MyComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.ContentTypeFilters()
            .Append<OneHomePageOnlyContentTypeFilter>();
    }
}
```
