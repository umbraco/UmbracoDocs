# Content Picker 2 #

`Alias: Umbraco.ContentPicker2`

`Returns: IPublishedContent`

The content picker opens a panel to pick a specific page from the content structure. The value saved is the selected nodes UDI

## Typed Example: ##

```c#
    @{
        IPublishedContent typedContentPicker = Model.Content.GetPropertyValue<IPublishedContent>("contentPicker");
        if (typedContentPicker != null)
        {
            <p>@typedContentPicker.Name</p>                                                
        } 
    }
```