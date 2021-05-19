---
versionFrom: 8.0.0
---

# Slider

`Alias: Umbraco.Slider`

Returns: `decimal` or `Umbraco.Core.Models.Range<decimal>`

Pretty much like the name indicates this Data type enables editors to choose a value with a range using a slider.

There are two flavors of the slider. One with a single value picker. One with a minimum and maximum value.

## Data Type Definition Example

![Slider Data Type Definition](images/Slider-Data-Type-Definition-Example.png)

## Content Example

![Slider Content](images/Slider-Content-Example-No-Range.png)
![Slider Content](images/Slider-Content-Example-With-Range.png)

## MVC View Example

### Without Modelsbuilder

```csharp
@if (Model.HasValue("singleValueSlider"))
{
    var value = Model.Value<decimal>("singleValueSlider");
    <p>@value</p>
}

@if (Model.HasValue("multiValueSlider"))
{
    var value = Model.Value<Umbraco.Core.Models.Range<decimal>>("multiValueSlider");
    <p>@(value.Minimum) and @(value.Maximum)</p>
}
```

### With Modelsbuilder

```csharp
// with a range off
@if (Model.SingleRangeSlider != null)
{
    var value = Model.SingleRangeSlider;
    <p>@value</p>
}

// with a range on
@if (Model.MultiValueSlider != null)
{
    var minValue = Model.MultiValueSlider.Minimum;
    var maxValue = Model.MultiValueSlider.Maximum;
    <p>@minValue and @maxValue</p>
}
```

## Add values programmatically

See the example below to see how a value can be added or changed programmatically. To update a value of a property editor you need the [Content Service](../../../../../Reference/Management/Services/ContentService/index.md).

### With a range off

```csharp
@{
    // Get access to ContentService
    var contentService = Services.ContentService;

    // Create a variable for the GUID of the page you want to update
    var guid = Guid.Parse("32e60db4-1283-4caa-9645-f2153f9888ef");

    // Get the page using the GUID you've defined
    var content = contentService.GetById(guid); // ID of your page

    // Set the value of the property with alias 'singleValueSlider'. 
    content.SetValue("singleValueSlider", 10);

    // Save the change
    contentService.Save(content);
}
```

### With a range on

```csharp
@{
    // Get access to ContentService
    var contentService = Services.ContentService;

    // Create a variable for the GUID of the page you want to update
    var guid = Guid.Parse("32e60db4-1283-4caa-9645-f2153f9888ef");

    // Get the page using the GUID you've defined
    var content = contentService.GetById(guid); // ID of your page

    // Create a variable for the desired value of the 'multiValueSlider' property
    var range = new Range<decimal> {Minimum = 10, Maximum = 12};

    // Set the value of the property with alias 'multiValueSlider'. 
    content.SetValue("multiValueSlider", range);

    // Save the change
    contentService.Save(content);
}
```

Although the use of a GUID is preferable, you can also use the numeric ID to get the page:

```csharp
@{
    // Get the page using it's id
    var content = contentService.GetById(1234); 
}
```

If Modelsbuilder is enabled you can get the alias of the desired property without using a magic string:

```csharp
@{
    // Set the value of the property with alias 'singleValueSlider'
    content.SetValue(Home.GetModelPropertyType(x => x.SingleValueSlider).Alias, 10);

    // Set the value of the property with alias 'multiValueSlider'
    content.SetValue(Home.GetModelPropertyType(x => x.MultiValueSlider).Alias, new Range<decimal> {Minimum = 10, Maximum = 12});
}
```
