---
description: A guide to customization of Backoffice Search
---

# Backoffice Search

The search facility of the Umbraco Backoffice allows the searching 'across sections' of different types of Umbraco entities, for example Content, Media, Members. However 'by default' only a small subset of standard fields are searched:

| Node Type    | Propagated Fields      |
| ------------ | ---------------------- |
| All Nodes    | Id, _NodeId_ and _Key_ |
| Media Nodes  | UmbracoFileFieldName   |
| Member Nodes | email, loginName       |

An Umbraco implementation might have additional custom properties that it would be useful to include in a Backoffice Search. For example: an 'Organisation Name' property on a Member Type, or a 'Product Code' field for a 'Product' content item.

## How node names are matched

Backoffice search, including the search in document and media pickers, matches each search word against node names. A search word matches at the start of a word in the name. Words of at least three characters also match anywhere within a word. For example, searching for `4521` finds a media item named `Report ABC004521 2026`.

Names with a word that starts with the search word rank above names with a word that only contains it.

You can change the minimum length, or turn off matching within words, with the [`BackOfficeSearchMinimumMatchWithinWordLength`](../../develop-with-umbraco/configuration/examinesettings.md#backofficesearchminimummatchwithinwordlength) setting.

## Adding custom properties to backoffice search

To add custom properties, it is required to register a custom implementation of `IUmbracoTreeSearcherFields`. We recommend to override the existing `UmbracoTreeSearcherFields`.

Your custom implementation needs to be registered in the container. For example in the `Program.cs` file or in a composer, as an alternative.

```csharp
builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddDeliveryApi()
    .AddComposers()
    .Build();

builder.Services.AddUnique<IUmbracoTreeSearcherFields, CustomUmbracoTreeSearcherFields>();
```

or

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Infrastructure.Examine;
using Umbraco.Extensions;

namespace Umbraco.Docs.Samples.Web.BackofficeSearch;

public class BackofficeSearchComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.AddUnique<IUmbracoTreeSearcherFields, CustomUmbracoTreeSearcherFields>();
    }
}
```

{% hint style="warning" %}
`ILocalizationService` is marked as obsolete and will be removed in a future version. `ILocalizationService` is intended to be replaced by `ILanguageService` and `IDictionaryItemService`.

The example below reflects the current implementation and therefore continues to use `ILocalizationService`.

For new development, you should evaluate whether `ILanguageService` or `IDictionaryItemService` better fits your use case.
{% endhint %}

```csharp
using System.Collections.Generic;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Infrastructure.Examine;
using Umbraco.Cms.Infrastructure.Search;

namespace Umbraco.Docs.Samples.Web.BackofficeSearch;

public class CustomUmbracoTreeSearcherFields : UmbracoTreeSearcherFields, IUmbracoTreeSearcherFields
{
    public CustomUmbracoTreeSearcherFields(ILocalizationService localizationService) : base(localizationService)
    {
    }

    //Adding custom field to search in all nodes
    public new IEnumerable<string> GetBackOfficeFields()
    {
        return new List<string>(base.GetBackOfficeFields()) { "nodeType" };
    }

    //Adding custom field to search in document types
    public new IEnumerable<string> GetBackOfficeDocumentFields()
    {
        return new List<string>(base.GetBackOfficeDocumentFields()) { "nodeType" };
    }

    //Adding custom field to search in media
    public new IEnumerable<string> GetBackOfficeMediaFields()
    {
        return new List<string>(base.GetBackOfficeMediaFields()) { "nodeType" };
    }

    //Adding custom field to search in members
    public new IEnumerable<string> GetBackOfficeMembersFields()
    {
        return new List<string>(base.GetBackOfficeMembersFields()) { "nodeType" };
    }
}
```

{% hint style="warning" %}
You cannot use this to search on integer types in the index, as an example `parentID` does not work.
{% endhint %}
