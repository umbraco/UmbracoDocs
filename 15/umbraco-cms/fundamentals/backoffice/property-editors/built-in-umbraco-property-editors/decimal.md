# Decimal

`Schema Alias: Umbraco.Decimal`

`UI Alias: Umb.PropertyEditorUi.Decimal`

`Returns: decimal`

## Data Type Definition Example

![Decimal Content Example](images/content-example.png)

In the example above the possible values for the input field would be \[8, 8.5, 9, 9.5, 10]

_All other values will be removed in the content editor when saving or publishing._

If the value of **Step Size** is not set then all decimal values between 8 and 10 is possible to input in the content editor.

## Content Example

![Content Example](../../../../../../10/umbraco-cms/fundamentals/backoffice/property-editors/built-in-property-editors/images/content-example.png)

## MVC View Example

### With Modelsbuilder

```csharp
@Model.MyDecimal
```

### Without Modelsbuilder

```csharp
@Model.Value("MyDecimal")
```

## Add values programmatically

See the example below to see how a value can be added or changed programmatically. To update a value of a property editor you need the [Content Service](https://apidocs.umbraco.com/v14/csharp/api/Umbraco.Cms.Core.Services.ContentService.html).

{% hint style="info" %}
The example below demonstrates how to add values programmatically using a Razor view. However, this is used for illustrative purposes only and is not the recommended method for production environments.
{% endhint %}

```csharp
@inject IContentService Services;
@using Umbraco.Cms.Core.Services;
@{
    // Get access to ContentService
    var contentService = Services;

    // Create a variable for the GUID of the page you want to update
    var guid = Guid.Parse("32e60db4-1283-4caa-9645-f2153f9888ef");

    // Get the page using the GUID you've defined
    var content = contentService.GetById(guid); // ID of your page

    // Set the value of the property with alias 'myDecimal'. 
    content.SetValue("myDecimal", 3);

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

{% include "../../../../.gitbook/includes/obsolete-warning-ipublishedsnapshotaccessor.md" %}

```csharp
@inject IPublishedSnapshotAccessor _publishedSnapshotAccessor;
@using Umbraco.Cms.Core.PublishedCache;
@{
    // Set the value of the property with alias 'myDecimal'
    content.SetValue(Home.GetModelPropertyType(_publishedSnapshotAccessor, x => x.MyDecimal).Alias, 3);
}
```
