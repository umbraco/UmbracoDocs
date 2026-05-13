# DateTime

`Schema Alias: Umbraco.DateTime`

`UI Alias: Umb.PropertyEditorUi.DatePicker`

`Returns: DateTime`

Displays a calendar UI for selecting dates which are saved as a DateTime value.

{% hint style="info" %}
New [Date Time property editors](date-time-editor/) are available. They offer more focused functionality and time zone support. These editors will eventually replace the current Date Time property editor, so consider using them for new implementations.
{% endhint %}

## Data Type Definition Example

![Data Type Definiton](../../../../.gitbook/assets/Date-time-picker-v16.png)

There is one setting available for manipulating the DateTime property.

The setting involves defining the format. The default date format in the Umbraco backoffice is `YYYY-MM-DD HH:mm:ss`, but you can change it to a different format. See [MomentJS.com](https://momentjs.com/) for the supported formats.

## Content Example

![Content Example](../../../../.gitbook/assets/Date-picker-with-content-v16.png)

## MVC View Example - displays a datetime

### With Models Builder

```csharp
@Model.DatePicker
```

### Without Models Builder

```csharp
@Model.Value("datePicker")
```

## Add values programmatically

See the example below to see how a value can be added or changed programmatically. To update a value of a property editor you need the [Content Service](https://apidocs.umbraco.com/v17/csharp/api/Umbraco.Cms.Core.Services.ContentService.html).

{% hint style="info" %}
The example below demonstrates how to add values programmatically using a Razor view. However, this is used for illustrative purposes only and is not the recommended method for production environments.
{% endhint %}

```csharp
@using Umbraco.Cms.Core.Services
@inject IContentService ContentService
@{
    // Create a variable for the GUID of the page you want to update
    var guid = new Guid("32e60db4-1283-4caa-9645-f2153f9888ef");

    // Get the page using the GUID you've defined
    var content = ContentService.GetById(guid); // ID of your page

    // Set the value of the property with alias 'datePicker'
    content.SetValue("datePicker", DateTime.Now);

    // Save the change
    ContentService.Save(content);
}
```

Although the use of a GUID is preferable, you can also use the numeric ID to get the page:

```csharp
@{
    // Get the page using it's id
    var content = ContentService.GetById(1234); 
}
```

If Models Builder is enabled you can get the alias of the desired property without using a magic string:

```csharp
@using Umbraco.Cms.Core.PublishedCache
@inject IPublishedContentTypeCache PublishedContentTypeCache
@{

    // Set the value of the property with alias 'datePicker'
    content.SetValue(Home.GetModelPropertyType(PublishedContentTypeCache, x => x.DatePicker).Alias, DateTime.Now);
}
```
