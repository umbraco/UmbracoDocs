---
description: >-
  Learn how to configure and use the Element Picker property editor in Umbraco CMS.
---

# Element Picker

`Schema Alias: Umbraco.ElementPicker`

`UI Alias: Umb.PropertyEditorUi.ElementPicker`

`Returns: IEnumerable<IPublishedElement>`

The Element Picker enables you to choose a specific element to display as part of your content. Elements are built as [Element Types](../../content-types-and-structure/data/defining-content/elements.md) in the Settings section and managed from the Library section.

## Data Type Definition Example

![Element Picker Data Type Settings](../../../.gitbook/assets/elementpicker-data-type-definition.png)

### Amount

Define how many elements should be allowed to pick via the Element Picker.

### Start Node

Choose a start node for the Element Picker. Use this option when your Library section is organized into folders.

### Ignore User Start Nodes

Checking this field allows users to choose nodes they normally cannot access.

## MVC View Example

### Without Models Builder

```csharp
@{
    IEnumerable<IPublishedElement>? elements = Model.Value<IEnumerable<IPublishedElement>>("elementPicker");
    if (elements != null) {
        foreach (var element in elements)
        {
            <h1>@element.Name</h1>
            <p>@element.Value("featuredText")</p>
        }
    }
}
```

### With Models Builder

```csharp
@{
    IEnumerable<IPublishedElement>? elements = Model.ElementPicker;
    if (elements != null) {
        foreach (var element in elements)
        {
            <h1>@element.Name</h1>
            <p>@element.Value("featuredText")</p>
        }
    }
}
```

## Add values programmatically

The Element Picker stores an array of Element keys (`Guid[]`). The example below illustrates how an Element Picker value can be added or changed programmatically.

