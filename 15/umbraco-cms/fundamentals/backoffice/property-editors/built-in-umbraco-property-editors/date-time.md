# DateTime

`Alias: Umbraco.DateTime`

`Returns: DateTime`

Displays a calendar UI for selecting dates which are saved as a DateTime value.

## Data Type Definition Example

![Data Type Definiton](images/date-time.png)

There are two settings available for manipulating the DateTime property.

One is to set a format. By default the format of the date in the Umbraco backoffice will be `YYYY-MM-DD HH:mm:ss`, but you can change this to something else. See [MomentJS.com](https://momentjs.com/) for the supported formats.

The second setting is "Offset time". When enabling this setting the displayed time will be offset with the servers timezone. This can be useful in cases where an editor is in a different timezone than the hosted server.

## Content Example

![Content Example](../../../../../../10/umbraco-cms/fundamentals/backoffice/property-editors/built-in-property-editors/images/date-picker-v8.png)

## MVC View Example - displays a datetime

### With Modelsbuilder

```csharp
@Model.DatePicker
```

### Without Modelsbuilder

```csharp
@Model.Value("datePicker")
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
    var guid = new Guid("32e60db4-1283-4caa-9645-f2153f9888ef");

    // Get the page using the GUID you've defined
    var content = contentService.GetById(guid); // ID of your page

    // Set the value of the property with alias 'datePicker'
    content.SetValue("datePicker", DateTime.Now);

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
@using Umbraco.Cms.Core.PublishedCache;
@inject IPublishedSnapshotAccessor _publishedSnapshotAccessor;
@{

    // Set the value of the property with alias 'datePicker'
    content.SetValue(Home.GetModelPropertyType(_publishedSnapshotAccessor, x => x.DatePicker).Alias, DateTime.Now);
}
```
