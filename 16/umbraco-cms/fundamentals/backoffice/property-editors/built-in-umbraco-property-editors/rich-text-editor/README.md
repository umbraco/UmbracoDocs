# Rich Text Editor

`Schema Alias: Umbraco.RichText`

`UI Alias: Umb.PropertyEditorUi.Tiptap`

`Returns: HTML`

{% hint style="warning" %}
With the release of Umbraco 16, [the TinyMCE UI option for the Rich Text Editor is removed](../../../../setup/upgrading/version-specific/#breaking-changes).
{% endhint %}

The Rich Text Editor property editor is highly configurable and based on [Tiptap](https://tiptap.dev/). Depending on the configuration setup, it provides editors a lot of flexibility when working with content.

## [Configuration options](configuration.md)

Customize everything from toolbar options to editor size to where pasted images are saved.

## [Style Menu](style-menu.md)

Define a cascading text formatting and style menu for the Rich Text Editor toolbar.

## [Blocks](blocks.md)

Use Blocks to define specific parts that can be added as part of the markup of the Rich Text Editor.

## [Extensions](extensions.md)

Extend the functionality of the Rich Text Editor with extensions.

## [Custom CSS properties](css-properties.md)

Customize the appearance of the Rich Text Editor with custom CSS properties.

## Data Type Definition Example

![Rich Text Editor - Data Type](images/rte-tiptap-datatypedefinition.png)

## Content Example

![Rich Text Editor - Content Example](images/rte-tiptap-contentexample.png)

## MVC View Example

### With Models Builder

```csharp
@{
    if (!string.IsNullOrEmpty(Model.RichText.ToString()))
    {
        <p>@Model.RichText</p>
    }
}
```

### Without Models Builder

```csharp
@{
    if (Model.HasValue("richText")){
        <p>@(Model.Value("richText"))</p>
    }
}
```

## Add values programmatically

See the example below to see how a value can be added or changed programmatically. To update a value of a property editor you need the [Content Service](https://apidocs.umbraco.com/v15/csharp/api/Umbraco.Cms.Core.Services.ContentService.html).

{% hint style="info" %}
The example below demonstrates how to add values programmatically using a Razor view. However, this is used for illustrative purposes only and is not the recommended method for production environments.
{% endhint %}

```csharp
@using Umbraco.Cms.Core.Services
@inject IContentService ContentService
@{
    // Create a variable for the GUID of the page you want to update
    var guid = Guid.Parse("32e60db4-1283-4caa-9645-f2153f9888ef");

    // Get the page using the GUID you've defined
    var content = ContentService.GetById(guid); // ID of your page

    // Create a variable for the desired value
    var htmlValue = new HtmlString("Add some text <strong>here</strong>");

    // Set the value of the property with alias 'richText'.
    content.SetValue("richText", htmlValue);

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

If Models Builder is enabled you can get the alias of the desired property without using a magic string.

```csharp
@using Umbraco.Cms.Core.PublishedCache
@inject IPublishedContentTypeCache PublishedContentTypeCache
@{
    // Set the value of the property with alias 'richText'
    content.SetValue(Home.GetModelPropertyType(PublishedContentTypeCache, x => x.RichText).Alias, htmlValue);
}
```
