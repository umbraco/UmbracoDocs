---
versionFrom: 7.0.0
---

# (Obsolete) Content Picker

`Alias: Umbraco.ContentPicker`

`Returns: Node Id`

The content picker opens a panel to pick a specific page from the content structure. The value saved is the selected nodes ID.

## Data Type Definition Example

![Content Picker Data Type Definition](images/Content-Picker-DataType.png)

## Content Example

![Content Picker Content](images/Content-Picker-Content.png)

## MVC View Example - [value converters enabled](../../../../Setup/Upgrading/760-breaking-changes.md#property-value-converters-u4-7318)

### Typed Example

```csharp
@{
    IPublishedContent typedContentPicker = Model.Content.GetPropertyValue<IPublishedContent>("contentPicker");
    if (typedContentPicker != null)
    {
        <p>@typedContentPicker.Name</p>
    }
}
```

## MVC View Example - [value converters disabled](../../../../Setup/Upgrading/760-breaking-changes.md#property-value-converters-u4-7318)

### Typed

```csharp
@{
    if (Model.Content.HasValue("contentPicker"))
    {
        var node = Umbraco.TypedContent(Model.Content.GetPropertyValue<int>("contentPicker"));
        <a href="@node.Url">@node.Name</a>
    }
}
```

### Dynamic

```csharp
@{
    if (CurrentPage.HasValue("contentPicker"))
    {
        var node = Umbraco.Content(CurrentPage.contentPicker);
        <a href="@node.Url">@node.Name</a>
    }
}
```
