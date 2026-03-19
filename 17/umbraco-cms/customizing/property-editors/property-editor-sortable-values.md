---
description: >-
  Learn how to enable sorting for custom property editors that store complex
  values like JSON in Umbraco collection views.
---

# Sortable Property Values

Property editors that store complex values (such as JSON) in the database may not sort correctly in collection views. For example, a date picker with timezone support stores a JSON object like:

`{"date":"2024-01-21T10:30:00","timeZone":"Europe/Paris"}`

This value cannot be sorted chronologically using standard string comparison.

The `IDataValueSortable` interface allows property editors to opt in to providing a sortable string representation of their values.

The sortable string is stored in the `sortableValue` column of the property data table. Collection views use this column for ordering.

## When to use IDataValueSortable

Implement `IDataValueSortable` on your `DataValueEditor` when:

* The property editor stores JSON or other complex values that do not sort correctly as raw strings.
* The property can usefully be added to a collection view as a custom column.
* The stored value format differs from the intended sort order.

You do not need this interface when:

* The property editor stores plain values (strings, numbers, dates) that already sort correctly.
* Sorting in collection views is not relevant for the property.

## The IDataValueSortable interface

The interface defines a single method:

```csharp
public interface IDataValueSortable
{
    string? GetSortableValue(object? value, object? dataTypeConfiguration);
}
```

**Parameters:**

* `value`: The stored property value from the database.
* `dataTypeConfiguration`: The Data Type configuration for the property.

**Returns:** A string that sorts correctly using lexicographic (string) comparison, or `null` to fall back to default sorting.

## How it works

When a property value is saved, Umbraco checks whether the associated `DataValueEditor` implements `IDataValueSortable`. If it does, the `GetSortableValue` method is called, and the result is stored in the `sortableValue` column. Collection views sort by this column first. When the value is `null`, the default sorting behavior is used.

## Implementation example

The following example shows a `DataValueEditor` that stores a JSON value containing a name and a setting. The sortable value extracts the name for alphabetical sorting in collection views.

The stored JSON value looks like this:

```json
{"name":"Awesome Widget","setting":"advanced"}
```

```csharp
using Umbraco.Cms.Core.IO;
using Umbraco.Cms.Core.PropertyEditors;
using Umbraco.Cms.Core.Serialization;
using Umbraco.Cms.Core.Strings;

public class MyWidgetDataValueEditor : DataValueEditor, IDataValueSortable
{
    private readonly IJsonSerializer _jsonSerializer;

    public MyWidgetDataValueEditor(
        IShortStringHelper shortStringHelper,
        IJsonSerializer jsonSerializer,
        IIOHelper ioHelper,
        DataEditorAttribute attribute)
        : base(shortStringHelper, jsonSerializer, ioHelper, attribute)
    {
        _jsonSerializer = jsonSerializer;
    }

    public string? GetSortableValue(object? value, object? dataTypeConfiguration)
    {
        if (value is not string stringValue || string.IsNullOrWhiteSpace(stringValue))
        {
            return null;
        }

        WidgetValue? widget = _jsonSerializer.Deserialize<WidgetValue>(stringValue);

        // Extract the name and normalize to lowercase for case-insensitive sorting.
        return widget?.Name?.ToLowerInvariant();
    }

    private class WidgetValue
    {
        public string? Name { get; set; }

        public string? Setting { get; set; }
    }
}
```

## Guidelines

Follow these guidelines when implementing `IDataValueSortable`:

* **Lexicographic sorting**: The returned string must sort correctly using standard string comparison. For numeric values, use zero-padded fixed-length strings. For dates, use a fixed-length format like ISO 8601 normalized to Coordinated Universal Time (UTC).
* **Maximum length**: The sortable value is stored in an `nvarchar(512)` column. Keep the returned string within 512 characters.
* **Return null when appropriate**: Return `null` if the value cannot be parsed or sorting is not applicable. The property then falls back to default sorting behavior.

