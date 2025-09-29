---
description: Describes how to use provide flags in management API responses for use in presenting additional details to consumers.
---

# Flag Providers

The Umbraco management APIs for trees, collections, and items include a `flags` collection for each item. These indicate additional information for the item that can be presented to users.

The Umbraco backoffice will use this to provide additional overlay icons on tree, collection and item presentations. This core behavior and extension point is described in the article on [backoffice signs](../customizing/back-office-signs.md).

## Core Flag Providers

Umbraco ships with four flag providers that will provide indications of the following document or media states:

- **Is Protected** - indicates the document is not available for public access.
- **Has Pending Changes** - indicates that the document is published but has changes in draft waiting for publication
- **Has Schedule** - indicates that the document is scheduled for publishing in the future
- **Has Collection** - indicates that the document or media is based on a content type that is configured for display as a collection

For example, an item that is scheduled for publication would contain the following in the tree, collection or item API response:

```json
  "flags": [
    {
      "alias": "Umb.ScheduledForPublish"
    }
  ],
```

## Providing a Custom Flag Provider

If your package or project needs to present additional information for a tree, collection or item value, a custom flag provider can be created. This will be coupled with a presentation extension to determine how the information is interpreted for display as a [backoffice sign](../customizing/back-office-signs.md).

To create a flag provider, implement the `IFlagProvider` interface. There are two methods to implement:

- `CanProvideFlags<TItem>` - returns `bool` indicating whether this provider can provide flags for the tree, collection or item view model.
- `PopulateFlagsAsync<TItem>(IEnumerable<TItem> itemViewModels)` - populates the `Flags` property for the provided collection of view models.

An illustrative implementation is as follows:

```csharp
using Umbraco.Cms.Api.Management.ViewModels;
using Umbraco.Cms.Core;

internal class MyDocumentFlagProvider : IFlagProvider
{
    private const string Alias = Constants.Conventions.Flags.Prefix + "MyDocumentFlag";

    // Indicate that this flag provider only provides flags for documents.
    public bool CanProvideFlags<TItem>()
        where TItem : IHasFlags =>
        typeof(TItem) == typeof(DocumentTreeItemResponseModel) ||
        typeof(TItem) == typeof(DocumentCollectionResponseModel) ||
        typeof(TItem) == typeof(DocumentItemResponseModel);

    public Task PopulateFlagsAsync<TItem>(IEnumerable<TItem> itemViewModels)
        where TItem : IHasFlats
    {
        foreach (TItem item in itemViewModels)
        {
            if (ShouldAddFlag(item))
            {
                item.AddFlag(Alias);
            }
        }

        return Task.CompletedTask;
    }

    private bool ShouldAddFlag(TItem item) => return true; // Provide custom logic here.
}
```

The flag provider needs to be registered with Umbraco in a composer or application startup with:

```csharp
  builder.FlagProviders()
    .Append<MyDocumentFlagProvider>();
```

For some flags, there may be sufficient information on the view models to map whether a flag should be created.

For an example of this, please see the core flag provider `IsProtectedFlagProvider` whose [source code can be found here](https://github.com/umbraco/Umbraco-CMS/blob/main/src/Umbraco.Cms.Api.Management/Services/Flags/IsProtectedFlagProvider.cs).

More complex flags will require additional information, using the identifiers of the view models to retrieve the necessary data. Note here that it's important to try to avoid "N+1" issues. The aim should be to retrieve all the data needed to populate the flags for the whole collection in one step.

In core, the flag provider `HasScheduleFlagProvider` shows a good example of this. The [source code can be found here](https://github.com/umbraco/Umbraco-CMS/blob/main/src/Umbraco.Cms.Api.Management/Services/Flags/HasScheduleFlagProvider.cs).
