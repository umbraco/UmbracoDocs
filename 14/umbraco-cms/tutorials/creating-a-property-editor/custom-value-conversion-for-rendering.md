---
description: Add a Property Value Converter for custom Property Editor value conversion.
---

# Custom value conversion for rendering

## Overview

In the previous steps, we created a custom Property Editor for the Umbraco backoffice client. In this step, we will discuss how to convert the Property Editor values for use when rendering the website.

To this end, we will create a Property Value Converter that converts the stored suggestion text into a custom rendering model.

## When should I use a Property Value Converter?

A Property Value Converter is usually not necessary. Based on the chosen `propertyEditorSchemaAlias`, Umbraco will automatically provide appropriately typed models for rendering the Property Editor. For more information, see the [Default Property Editor Schema Alias options](default-property-editor-schema-aliases.md) article.

The most common use-cases for building a Property Value Converter are:

* Property Editors that store values which require server-side conversion, in order to render an appropriate output.
* Property Editors with specific caching requirements.
* Tailoring the Property Editor output value specifically for the [Content Delivery API](https://docs.umbraco.com/umbraco-cms/reference/content-delivery-api).

## Implementing a Property Value Converter

A Property Value Converter must meet a few required responsibilities:

1. Identifying itself as being able to convert values for a given Property Editor.
2. Declaring the concrete runtime type it will be outputting.
3. Performing the value conversion from the stored

The following code snippet outlines how these could be solved for our `suggestion` Property Editor.

{% code title="MySuggestionsPropertyValueConverter.cs" %}
```csharp
using Umbraco.Cms.Core.Models.PublishedContent;
using Umbraco.Cms.Core.PropertyEditors;

namespace Umbraco.Docs.PropertyEditors;

// the Property Value Converter that handles the suggestions Property Editor
public class MySuggestionsPropertyValueConverter : PropertyValueConverterBase
{
    // 1. converts properties with the property type editor UI alias "My.PropertyEditorUi.Suggestions"
    public override bool IsConverter(IPublishedPropertyType propertyType)
        => propertyType.EditorUiAlias == "My.PropertyEditorUi.Suggestions";

    // 2. yields outputs of type MySuggestionsModel
    public override Type GetPropertyValueType(IPublishedPropertyType propertyType)
        => typeof(MySuggestionsModel);

    // 3. converts the suggestion (string) to the output type (MySuggestionsModel)
    public override object? ConvertIntermediateToObject(
        IPublishedElement owner,
        IPublishedPropertyType propertyType,
        PropertyCacheLevel referenceCacheLevel,
        object? inter,
        bool preview)
        => inter is string suggestion
            ? new MySuggestionsModel
            {
                Suggestion = $"Here's a suggestion for you: {suggestion}"
            }
            : null;
}

// the custom rendering model for the suggestions Property Editor
public class MySuggestionsModel
{
    public required string Suggestion { get; init; }
}
```
{% endcode %}

{% hint style="info" %}
We have used the property type editor UI alias from `umbraco-package.json` in the implementation of `IsConverter()`.
{% endhint %}

For more advanced Property Value Converter techniques (for example, controlling caching), see the [Property Value Converters](https://docs.umbraco.com/umbraco-cms/extending/property-editors/property-value-converters) article.
