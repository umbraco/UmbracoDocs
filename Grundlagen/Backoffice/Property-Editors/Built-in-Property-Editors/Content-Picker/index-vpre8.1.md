---
versionFrom: 8.0.0
versionTo: 8.1.0
---

# Content Picker

`Alias: Umbraco.ContentPicker`

`Returns: IPublishedContent`

The content picker opens a panel to pick a specific page from the content structure. The value saved is the selected nodes [UDI](../../../../../Reference/Querying/Udi.md "Learn more about UDI's")

## Data Type Definition Example

![Content Picker Data Type Definition](images/Content-Picker-DataType-v8.png)

## Content Example

![Content Picker Content](images/Content-Picker-Content-v8.png)

## Typed Example

```csharp
@{
    IPublishedContent typedContentPicker = Model.Value<IPublishedContent>("featurePicker");
    if (typedContentPicker != null)
    {
        <p>@typedContentPicker.Name</p>
    }
}
```
