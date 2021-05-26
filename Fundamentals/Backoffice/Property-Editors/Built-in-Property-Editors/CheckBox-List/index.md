---
versionFrom: 8.0.0
---

# Checkbox List

`Alias: Umbraco.CheckBoxList`

`Returns: IEnumerable<string>`

Displays a list of preset values as a list of checkbox controls. The text saved is a IEnumerable collection of the text values.

:::note
Unlike other property editors, the Prevalue IDs are not directly accessible in Razor.
:::

## Data Type Definition Example

![True/Checkbox List Definition](images/checkbox-list-setup-v8.png)

## Content Example

![Checkbox List Example](images/checkbox-list-content.png)

## MVC View Example

### Without Modelsbuilder

```csharp
@{
    if (Model.HasValue("superHeros"))
    {
        <ul>
            @foreach (var item in Model.Value<IEnumerable<string>>("superHeros"))
            {
                <li>@item</li>
            }
        </ul>
    }
}
```

### With Modelsbuilder

```csharp
@{
    if (Model.SuperHeros.Any())
    {
        <ul>
            @foreach (var item in Model.SuperHeros)
            {
                <li>@item</li>
            }
        </ul>
    }
}
```

## Add values programmatically

See the example below to see how a value can be added or changed programmatically. To update a value of a property editor you need the [Content Service](../../../../../Reference/Management/Services/ContentService/index.md).

```csharp
@using Newtonsoft.Json
@{
    // Get access to ContentService
    var contentService = Services.ContentService;

    // Create a variable for the GUID of the page you want to update
    var guid = Guid.Parse("32e60db4-1283-4caa-9645-f2153f9888ef");

    // Get the page using the GUID you've defined
    var content = contentService.GetById(guid); // ID of your page

    // Set the value of the property with alias 'superHeros'. 
    content.SetValue("superHeros", JsonConvert.SerializeObject(new[] { "Umbraco", "CodeGarden"}));

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
    // Set the value of the property with alias 'superHeros'
    content.SetValue(Home.GetModelPropertyType(x => x.SuperHeros).Alias, JsonConvert.SerializeObject(new[] { "Umbraco", "CodeGarden"}));
}
```
