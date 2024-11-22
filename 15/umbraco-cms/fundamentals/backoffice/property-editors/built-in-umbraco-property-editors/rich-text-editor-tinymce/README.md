# Rich Text Editor TinyMce

`Schema alias: Umbraco.RichText`

`UI Alias: Umb.PropertyEditorUi.TinyMCE`

`Returns: HTML`

{% hint style="warning" %}
This article is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

The Rich Text Editor (RTE) is highly configurable and based on [TinyMCE](https://www.tinymce.com/). Depending on the configuration, it will give your content editors more flexibility when working with content that should be more than plain text.

{% hint style="info" %}
**Are you using custom configurations or plugins with TinyMCE?**

In Umbraco 11 the TinyMCE version supported has been upgraded from version 4 to version 6. You need to migrate to the latest version if you are using TinyMCE plugins or custom configuration.

If your site is upgraded from an older version, follow the migration guides below to upgrade the TinyMCE version as well.

* [Migrate from version 4 to version 5](https://www.tiny.cloud/docs/tinymce/5/migration-from-4x/)
* [Migrate from version 5 to version 6](https://www.tiny.cloud/docs/tinymce/6/migration-from-5x/)
{% endhint %}

## [Configuration options](configuration.md)

Customize everything from toolbar options to editor size to where pasted images are saved.

## [Styles](styles.md)

Use CSS to define specific editor styles and add them as formatting options of the Rich Text Editor.

## [Blocks](blocks.md)

Use Blocks to define specific parts that can be added as part of the markup of the Rich Text Editor.

## [Plugins](plugins.md)

Extend the functionality of the Rich Text Editor with plugins.

## Data Type Definition Example

![Rich Text Editor - Data Type](images/rte-datatype-v10.png)

## Content Example

![Rich Text Editor - Content](images/rte-content-11.png)

## MVC View Example

### Without Modelsbuilder

```csharp
@{
    if (Model.HasValue("richText")){
        <p>@(Model.Value("richText"))</p>
    }
}
```

### With Modelsbuilder

```csharp
@{
    if (!string.IsNullOrEmpty(Model.RichText.ToString()))
    {
        <p>@Model.RichText</p>
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
    var guid = Guid.Parse("32e60db4-1283-4caa-9645-f2153f9888ef");

    // Get the page using the GUID you've defined
    var content = contentService.GetById(guid); // ID of your page

    // Create a variable for the desired value
    var htmlValue = new HtmlString("Add some text <strong>here</strong>");

    // Set the value of the property with alias 'richText'.
    content.SetValue("richText", htmlValue);

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

If Modelsbuilder is enabled you can get the alias of the desired property without using a magic string.

```csharp
@using Umbraco.Cms.Core.PublishedCache;
@inject IPublishedSnapshotAccessor _publishedSnapshotAccessor;
@{
    // Set the value of the property with alias 'richText'
        content.SetValue(Home.GetModelPropertyType(_publishedSnapshotAccessor, x => x.RichText).Alias, "Add some text <strong>here</strong>");
}
```
