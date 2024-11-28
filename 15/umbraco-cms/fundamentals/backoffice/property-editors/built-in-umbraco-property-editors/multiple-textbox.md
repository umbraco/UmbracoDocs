# Repeatable Textstrings

`Schema Alias: Umbraco.MultipleTextstring`

`UI Alias: Umb.PropertyEditorUi.MultipleTextString`

`Returns: array of strings`

The Repeatable textstrings property editor enables a content editor to make a list of text items. For best use with an unordered-list.

## Data Type Definition Example

![Repeatable textstrings Data Type Definition](images/Repeatable-Textstrings-DataType.png)

## Content Example

![Repeatable textstrings Content](<../../../../../../10/umbraco-cms/fundamentals/backoffice/property-editors/built-in-property-editors/images/Multiple-Textbox-Repeatable-Textstrings-Content (1) (1).png>)

## MVC View Example

### Without Modelsbuilder

```csharp
@{
    if (Model.Value<string[]>("keyFeatureList").Length > 0)
    {
        <ul>
            @foreach (var item in Model.Value<string[]>("keyFeatureList"))
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
    if (Model.KeyFeatureList.Any())
    {
        <ul>
            @foreach (var item in Model.KeyFeatureList)
            {
                <li>@item</li>
            }
        </ul>
    }
}
```

## Add values programmatically

See the example below to see how a value can be added or changed programmatically. To update a value of a property editor you need the [Content Service](https://apidocs.umbraco.com/v15/csharp/api/Umbraco.Cms.Core.Services.ContentService.html).

{% hint style="info" %}
The example below demonstrates how to add values programmatically using a Razor view. However, this is used for illustrative purposes only and is not the recommended method for production environments.
{% endhint %}

```csharp
@using Umbraco.Cms.Core.Services;
@inject IContentService Services;
@{
    // Get access to ContentService
    var contentService = Services;

    // Create a variable for the GUID of the page you want to update
    var guid = new Guid("32e60db4-1283-4caa-9645-f2153f9888ef");

    // Get the page using the GUID you've defined
    var content = contentService.GetById(guid); // ID of your page

    // Set the value of the property with alias 'keyFeatureList'
    content.SetValue("keyFeatureList", "Awesome" + Environment.NewLine + "Super");

    // Save the change
    contentService.Save(content);
}
```

{% hint style="info" %}
To add multiple values to the repeatable text strings property editor you have to put each value on a new line. This can be achieved using either `\r\n\` or `Environment.NewLine`.
{% endhint %}

Although the use of a GUID is preferable, you can also use the numeric ID to get the page:

```csharp
@{
    // Get the page using it's id
    var content = contentService.GetById(1234); 
}
```

If Modelsbuilder is enabled you can get the alias of the desired property without using a magic string:

{% include "../../../../.gitbook/includes/obsolete-warning-ipublishedsnapshotaccessor.md" %}

```csharp
@using Umbraco.Cms.Core.PublishedCache;
@inject IPublishedSnapshotAccessor _publishedSnapshotAccessor;
@{
    // Set the value of the property with alias 'keyFeatureList'
    content.SetValue(Home.GetModelPropertyType(_publishedSnapshotAccessor, x => x.KeyFeatureList).Alias, "Awesome" + Environment.NewLine + "Super");
}
```
