# Content Picker #

`Alias: Umbraco.ContentPicker2`

`Returns: IPublishedContent`

The content picker opens a panel to pick a specific page from the content structure. The value saved is the selected nodes [UDI](../../../../Reference/Querying/Udi.md "Learn more about UDI's")

## Data Type Definition Example

![Content Picker Data Type Definition](images/Content-Picker2-DataType.png)

## Content Example 

![Content Picker Content](images/Content-Picker2-Content.png)

## Typed Example: ##

    @{
        IPublishedContent typedContentPicker = Model.Content.GetPropertyValue<IPublishedContent>("featurePicker");
        if (typedContentPicker != null)
        {
            <p>@typedContentPicker.Name</p>                                                
        } 
    }
