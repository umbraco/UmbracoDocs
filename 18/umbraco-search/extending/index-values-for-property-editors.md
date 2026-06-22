---
description: >-
  How to provide index values for Umbraco Search, and how to replace the
  built-in values
---

# Index Values: Property Editors

In the world of search, a full-text searchable string behaves a lot differently than a keyword for filtering. Integer and decimal values also have their own special traits, and dates add yet another layer of complexity.

To understand the intent of the Umbraco property editor values, Umbraco Search employs a concept called _property value handlers_.

## The property value handler

A property value handler for search is analogous to a property value converter for rendering. With one crucial exception: If a property editor does _not_ supply a property value handler, properties of that type will be skipped when indexing.

If you have built a custom property editor that should supply index values, you must create a property value handler for it.

The property value handler is created by implementing the `IPropertyValueHandler` interface:

{% code title="MyPropertyEditorPropertyValueHandler.cs" %}
```csharp
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Search.Core.Models.Indexing;
using Umbraco.Cms.Search.Core.PropertyValueHandlers;

namespace My.Site.PropertyValueHandlers;

public class MyPropertyEditorPropertyValueHandler : IPropertyValueHandler
{
    public bool CanHandle(string propertyEditorAlias)
        => propertyEditorAlias is "My.PropertyEditor";

    public IEnumerable<IndexField> GetIndexFields(
        IProperty property,
        string? culture,
        string? segment,
        bool published,
        IContentBase contentContext)
        => property.GetValue(culture, segment, published) is string { Length: > 0 } value
            ? [
                new IndexField(
                    property.Alias,
                    new IndexValue
                    {
                        // Index the value as a text for full text search.
                        Texts = [value]
                    },
                    culture,
                    segment)
            ]
            : [];
}
```
{% endcode %}

{% hint style="info" %}
The property value handler can produce multiple index fields. Each index field can contain any combination of data in its index value.
{% endhint %}

For example, a complex property editor might yield an index value with data in both the `Texts` and `Integers` collections.

{% hint style="info" %}
Umbraco Search automatically detects property value handlers, so you do not need to register them explicitly.
{% endhint %}

## Replacing the default property value handlers

[This list](../getting-started/built-in-property-editors.md) shows how the default Umbraco property editors transform their values to index data.

You can change this by replacing the default property value handlers you require to work differently.

The following example makes the radio button list produce _both_ searchable `Texts` _and_ `Keywords` for filtering and faceting:

{% code title="MyRadioButtonListPropertyValueHandler.cs" %}
```csharp
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Search.Core.Models.Indexing;
using Umbraco.Cms.Search.Core.PropertyValueHandlers;

namespace My.Site.PropertyValueHandlers;

public class MyRadioButtonListPropertyValueHandler : IPropertyValueHandler
{
    public bool CanHandle(string propertyEditorAlias)
        => propertyEditorAlias is Umbraco.Cms.Core.Constants.PropertyEditors.Aliases.RadioButtonList;

    public IEnumerable<IndexField> GetIndexFields(
        IProperty property,
        string? culture,
        string? segment,
        bool published,
        IContentBase contentContext)
        => property.GetValue(culture, segment, published) is string { Length: > 0 } value
            ? [
                new IndexField(
                    property.Alias,
                    new IndexValue
                    {
                        // Index the value as both keyword for filtering and as text for full text search.
                        Keywords = [value],
                        Texts = [value],
                    },
                    culture,
                    segment)
            ]
            : [];
}
```
{% endcode %}

## Property value handler results are cached

The property value handlers are invoked when the [content indexers](gathering-data-with-content-indexers.md) gather content. This means their values are cached at indexing time, for re-use when rebuilding an index.

Effectively, this means any changes to property value handlers won't be reflected in an index rebuild. Only explicit reindexing of single content items will trigger content gathering again.

You can read more about the index value cache and how to work with it in [the Database Cache for Index Values article](database-cache-for-index-values.md).
