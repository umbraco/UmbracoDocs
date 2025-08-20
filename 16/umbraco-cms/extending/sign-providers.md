---
description: Describes how to use provide signs in management API responses for use in presenting additional details to consumers.
---

# Sign Providers

The Umbraco management APIs for trees, collections and items include a `signs` collection for each item. These indicate additional flags of information for the item that can presented to users.

The Umbraco backoffice will use this information to provide additional overlay icons on tree, collection and item presentations. This core behavior and extension point is described in the article on [backoffice signs](../customizing/back-office-signs.md).

## Core Sign Providers

Umbraco ships with four sign providers that will provide indications of the following document or media states:

- **Is Protected** - indicates the document is not available for public access.
- **Has Pending Changes** - indicates that the document is published but has changes in draft waiting for publication
- **Has Schedule** - indicates that the document is scheduled for publishing in the future
- **Has Collection** - indicates that the document or media is based on a content type that is configured for display as a collection

For example, an item that is scheduled for publication would contain the following in the tree, collection or item API response:

```json
  "signs": [
    {
      "alias": "Umb.ScheduledForPublish"
    }
  ],
```

## Providing a Custom Sign Provider

If your package or project needs to present additional information for a tree, collection or item value, a custom sign provider can be created. This will be coupled with a presentation extension to determine how the information is interpreted for display as a [backoffice sign](../customizing/back-office-signs.md).

To create a sign provider, implement the `ISignProvider` interface. There are two methods to implement:

- `CanProvideSigns<TItem>` - returns `bool` indicating whether this provider can provide signs for the tree, collection or item view model.
- `PopulateSignsAsync<TItem>(IEnumerable<TItem> itemViewModels)` - populates the `Signs` property for the provided collection of view models.

An illustrative implementation is as follows:

```csharp
using Umbraco.Cms.Api.Management.ViewModels;
using Umbraco.Cms.Core;

internal class MyDocumentSignProvider : ISignProvider
{
    private const string Alias = Constants.Conventions.Signs.Prefix + "MyDocumentSign";

    // Indicate that this sign provider only provides signs for documents.
    public bool CanProvideSigns<TItem>()
        where TItem : IHasSigns =>
        typeof(TItem) == typeof(DocumentTreeItemResponseModel) ||
        typeof(TItem) == typeof(DocumentCollectionResponseModel) ||
        typeof(TItem) == typeof(DocumentItemResponseModel);

    public Task PopulateSignsAsync<TItem>(IEnumerable<TItem> itemViewModels)
        where TItem : IHasSigns
    {
        foreach (TItem item in itemViewModels)
        {
            if (ShouldAddSign(item))
            {
                item.AddSign(Alias);
            }
        }

        return Task.CompletedTask;
    }

    private bool ShouldAddSign(TItem item) => return true; // Provide custom logic here.
}
```

The sign provider needs to be registered with Umbraco in a composer or application startup with:

```csharp
  builder.SignProviders()
    .Append<MyDocumentSignProvider>();
```

For simple signs, there may be sufficient information on the view models to map whether a sign should be created.

For an example of this, please see the core sign provider `IsProtectedSignProvider` whose [source code can be found here](https://github.com/umbraco/Umbraco-CMS/blob/main/src/Umbraco.Cms.Api.Management/Services/Signs/IsProtectedSignProvider.cs).

More complex signs will require additional information, using the identifiers of the view models to retrieve the necessary data. Note here that it's important to try to avoid "N+1" issues, by retrieving all the data needed to populate the signs for the whole collection in one step.

In core, the sign provider `HasScheduleSignProvider` shows a good example of this. The [source code can be found here](https://github.com/umbraco/Umbraco-CMS/blob/main/src/Umbraco.Cms.Api.Management/Services/Signs/HasScheduleSignProvider.cs).
