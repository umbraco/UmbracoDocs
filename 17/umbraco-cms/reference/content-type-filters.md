---
description: Describes how to use Content Type Filters to restrict the allowed content options available to editors.
---
{% hint style="info" %}
The use cases supported here are similar to those where the `SendingAllowedChildrenNotification` would be used in Umbraco 13 or earlier.
{% endhint %}

# Filtering Allowed Content Types

When content editors add new content they are presented with a dialog where they must select the type of content they want to create. The options available are defined when setting up the Document, Media, and Member types in the **Settings** section.

Implementors and package creators can add additional logic to determine which options are available to the editors.

This is possible using Content Type Filters.

## Implementing a Content Type Filter

To create a Content Type Filter you use a class that implements the `IContentTypeFilter` interface (found in the `Umbraco.Cms.Core.Services.Filters` namespace).

There are two methods you can implement:

* One for filtering the content types allowed at the content root
* One for the content types allowed below a given parent node.

If you don't want to filter using one of the two approaches, you can return the provided collection unmodified.

### Example Use Case

The following example shows a typical use case. Often websites will have a "Home Page" Document Type which is created at the root. Normally, only one of these is required. You can enforce that using the following Content Type Filter.

The code below is querying the existing content available at the root. Normally you can create a "Home Page" here, but if one already exists that option is removed:

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

    public Task<IEnumerable<ContentTypeSort>> FilterAllowedChildrenAsync(
        IEnumerable<ContentTypeSort> contentTypes,
        Guid parentContentTypeKey,
        Guid? parentContentKey)
        => Task.FromResult(contentTypes);
}
```

Content Type Filters are registered as a collection, making it possible to have more than one in the solution or an installed package.

The filters need to be registered in a composer:

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
