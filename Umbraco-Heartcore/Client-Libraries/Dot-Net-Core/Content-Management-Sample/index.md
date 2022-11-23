# Content Management Sample

This sample guide will cover how you can access and work with the [Content Management API](../../../API-Documentation/Content-Management) from the client library.

## Requirements

- .NET/.NET Core (2.0 or newer) or .NET Framework (4.6.1 or newer)

## Getting Started

1. Add the `Umbraco.Headless.Client.Net` package to your project.

    `dotnet add package Umbraco.Headless.Client.Net`

2. Add environment variables for your project alias and your Api key.

    ```json
    // appsettings.json
    {
        "Heartcore": {
            "ProjectAlias": "your-project-alias",
            "ApiKey": "your-api-key"
        }
    }
    ```

3. Register the `ContentManagementService` to your dependency injection container. The registration of the `ContentManagementService` is handled by the `AddUmbracoHeartocore` extension method.

    ```csharp
    // Program.cs or Startup.cs
    builder.Services.AddUmbracoHeartcore(options =>
    {
        //configure options
    });
    ```

4. Inject the `ContentManagementService` into your non-static class.

    ```csharp
    private readonly ContentManagementService _contentManagementService;

    public UmbracoService(ContentManagementService contentManagementService)
    {
        _contentManagementService = contentManagementService;
    }
    ```

:::note
If you don't want to use dependency injection, you can manually create an instance of the `ContentManagementService` class. The constructor requires that you know the project alias and your API key.

```csharp
var managementService = new ContentManagementService("your-project-alias", "your-api-key");
```

:::

Now you are ready to start using the `ContentManagementService`.

## Content

First, we will look at how to work with content. The `ContentManagementService` allows you to Get, Create, Update, Publish, Unpublish and Delete content.

### Get Content

The `ContentManagementService` has three methods for getting content.

1. `GetRoot()` - Gets all content at the root of the tree.

    To use this method, simply call the method on the `ContentManagementService` instance:

    ```csharp
    var content = await _contentManagementService.Content.GetRoot();
    ```

2. `GetById(Guid id)` - Gets a specific content item matching a GUID.

    To use this method, call the method on the `ContentManagementService` instance and pass in the GUID of the content item you want to get:

    ```csharp
    var content = await _contentManagementService.Content.GetById(yourGuidObject);
    //or
    var content = await _contentManagementService.Content.GetById(Guid.Parse("your-guid-as-a-string"));
    ```

3. `GetChildren(Guid id)` - Gets all content that is a child of a specific content item matching a GUID.

    To use this method, call the method on the `ContentManagementService` instance and pass in the GUID of the content item you want to get the children of:

    ```csharp
    var content = await _contentManagementService.Content.GetChildren(yourGuidObject);
    //or
    var content = await _contentManagementService.Content.GetChildren(Guid.Parse("your-guid-as-a-string"));
    ```

### Create Content

The `ContentManagementService` has one method for creating content.

1. `Create(Content content)` - Creates a new content item based on the passed-in `Content` object.

    To use this method, call the method on the `ContentManagementService` instance and pass in the content item you want to create:

    ```csharp
    var newContent = await _contentManagementService.Content.Create(yourContentObject);
    ```

    :::note
    You can create content programmatically by following the [Create content programmatically](../../../../Reference/Management/Services/ContentService/create-content-programmatically.md) guide.
    :::

### Update Content

The `ContentManagementService` has one method for updating content.

1. `Update(Content content)` - Updates an existing content item based on the passed-in `Content` object.

    To use this method, call the method on the `ContentManagementService` instance and pass in the content item you want to update:

    ```csharp
    var updatedContent = await _contentManagementService.Content.Update(yourContentObject);
    ```

    :::note
    You can create content programmatically by following the [Create content programmatically](../../../../Reference/Management/Services/ContentService/create-content-programmatically.md) guide.
    :::

### Publish Content

The `ContentManagementService` has one method for publishing content.

1. `Publish(Guid id, string culture = "*")` - Publishes an existing content item based on the passed-in GUID and culture.

    To use this method, call the method on the `ContentManagementService` instance and pass in the GUID of the content item you want to publish:

    ```csharp
    var publishedContent = await _contentManagementService.Content.Publish(yourGuidObject);
    //or
    var publishedContent = await _contentManagementService.Content.Publish(Guid.Parse("your-guid-as-a-string"));
    ```

    Optionally, you can also pass in the culture of the content item you want to publish:

    ```csharp
    var publishedContent = await _contentManagementService.Content.Publish(yourGuidObject, "en-US");
    //or
    var publishedContent = await _contentManagementService.Content.Publish(Guid.Parse("your-guid-as-a-string"), "en-US");
    ```

### Unpublish Content

The `ContentManagementService` has one method for unpublishing content.

1. `Unpublish(Guid id, string culture = "*")` - Unpublishes an existing content item based on the passed-in GUID and culture.

    To use this method, call the method on the `ContentManagementService` instance and pass in the GUID of the content item you want to unpublish:

    ```csharp
    var unpublishedContent = await _contentManagementService.Content.Unpublish(yourGuidObject);
    //or
    var unpublishedContent = await _contentManagementService.Content.Unpublish(Guid.Parse("your-guid-as-a-string"));
    ```

    Optionally, you can also pass in the culture you want to unpublish the content item in:

    ```csharp
    var unpublishedContent = await _contentManagementService.Content.Unpublish(yourGuidObject, "en-US");
    //or
    var unpublishedContent = await _contentManagementService.Content.Unpublish(Guid.Parse("your-guid-as-a-string"), "en-US");
    ```

### Delete Content

The `ContentManagementService` has one method for deleting content.

1. `Delete(Guid id)` - Deletes an existing content item based on the passed-in GUID.

    To use this method, call the method on the `ContentManagementService` instance and pass in the GUID of the content item you want to delete:

    ```csharp
    var deletedContent = await _contentManagementService.Content.Delete(yourGuidObject);
    //or
    var deletedContent = await _contentManagementService.Content.Delete(Guid.Parse("your-guid-as-a-string"));
    ```

## Media

First, we will look at how to work with media. The `ContentManagementService` allows you to Get, Create, Update and Delete media.

:::note
For Media you create programmatically, you have to use the "raw" property values that Umbraco expects for the specific property editor.

The different scenarios are:

1. File Upload (A File Upload property editor)

    When uploading a file, you must specify the file name for the the `umbracoFile` property alias.

    ```csharp
    media.SetValue("umbracoFile", fileName, new FileInfoPart(new FileInfo(imagePath), fileName, $"image/{Path.GetExtension(imagePath).Trim('.')}"));
    ```

2. Image Upload (A Image Cropper property editor)

    When uploading an Image (by default, it uses the Image Cropper property editor), you must specify source's file name for the `umbracoFile` property alias.

    ```csharp
    media.SetValue("umbracoFile", new { src = fileName }, new FileInfoPart(new FileInfo(imagePath), fileName, $"image/{Path.GetExtension(imagePath).Trim('.')}"));
    ```

:::

### Get Media

The `ContentManagementService` has three methods for getting media.

1. `GetRoot()` - Gets all media at the root of the tree.

    To use this method, simply call the method on the `ContentManagementService` instance:

    ```csharp
    var rootMedia = await _contentManagementService.Media.GetRoot();
    ```

2. `GetById(Guid id)` - Gets a specific media item matching a GUID.

    To use this method, call the method on the `ContentManagementService` instance and pass in the GUID of the media item you want to get:

    ```csharp
    var media = await _contentManagementService.Media.GetById(yourGuidObject);
    //or
    var media = await _contentManagementService.Media.GetById(Guid.Parse("your-guid-as-a-string"));
    ```

3. `GetChildren(Guid id)` - Gets all media that is a child of a specific media item matching a GUID.

    To use this method, call the method on the `ContentManagementService` instance and pass in the GUID of the media item you want to get the children of:

    ```csharp
    var mediaChildren = await _contentManagementService.Media.GetChildren(yourGuidObject);
    //or
    var mediaChildren = await _contentManagementService.Media.GetChildren(Guid.Parse("your-guid-as-a-string"));
    ```

### Create Media

The `ContentManagementService` has one method for creating media.

1. `Create(Media media)` - Creates a new media item based on the passed-in `Media` object.

    To use this method, call the method on the `ContentManagementService` instance and pass in the media item you want to create:

    ```csharp
    var newMedia = await _contentManagementService.Media.Create(yourMediaObject);
    ```

### Update Media

The `ContentManagementService` has one method for updating media.

1. `Update(Media media)` - Updates an existing media item based on the passed-in `Media` object.

    To use this method, call the method on the `ContentManagementService` instance and pass in the media item you want to update:

    ```csharp
    var updatedMedia = await _contentManagementService.Media.Update(yourMediaObject);
    ```

### Delete Media

The `ContentManagementService` has one method for deleting media.

1. `Delete(Guid id)` - Deletes an existing media item based on the passed-in GUID.

    To use this method, call the method on the `ContentManagementService` instance and pass in the GUID of the media item you want to delete:

    ```csharp
    var deletedMedia = await _contentManagementService.Media.Delete(yourGuidObject);
    //or
    var deletedMedia = await _contentManagementService.Media.Delete(Guid.Parse("your-guid-as-a-string"));
    ```
