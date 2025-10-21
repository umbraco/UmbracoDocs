# Checkbox List

`Alias: Umbraco.CheckBoxList`

`Returns: IEnumerable<string>`

Displays a list of preset values as a list of checkbox controls. The text saved is an IEnumerable collection of the text values.

{% hint style="info" %}
Unlike other property editors, the Prevalue IDs are not directly accessible in Razor.
{% endhint %}

## Data Type Definition Example

![True/Checkbox List Definition](../built-in-property-editors/images/checkbox-list-setup-v8.png)

{% hint style="info" %}
You can use dictionary items to translate the values of a Checkbox List property editor in a multilingual setup. For more details, see the [Creating a Multilingual Site](../../../../tutorials/multilanguage-setup.md#translating-multi-value-property-editors) article.
{% endhint %}

## Content Example

![Checkbox List Example](../built-in-property-editors/images/checkbox-list-content.png)

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

See the example below to see how a value can be added or changed programmatically. To update a value of a property editor you need the [Content Service](../../../../reference/management/services/contentservice/).

{% hint style="info" %}
The example below demonstrates how to add values programmatically using a Razor view. However, this is used for illustrative purposes only and is not the recommended method for production environments.
{% endhint %}

```csharp
@inject IContentService Services;
@using Umbraco.Cms.Core.Services;
@using Newtonsoft.Json
@{
    // Get access to ContentService
    var contentService = Services;

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
@inject IPublishedSnapshotAccessor _publishedSnapshotAccessor;
@using Umbraco.Cms.Core.PublishedCache;
@{

// Set the value of the property with alias 'superHeros'
content.SetValue(Home.GetModelPropertyType(_publishedSnapshotAccessor,x => x.SuperHeros).Alias, JsonConvert.SerializeObject(new[] { "Umbraco", "CodeGarden"}));
}
```
