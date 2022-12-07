---
description: >-
  Learn how to access and work with the Content Management API on your Umbraco
  Heartcore project.
---

# Content Management Sample

This sample guide will cover how you can access and work with the [Content Management API](../../api-documentation/content-management/) from the client library.

## Requirements

* .NET/.NET Core (2.0 or newer) or .NET Framework (4.6.1 or newer)

## Getting Started

1.  Add the `Umbraco.Headless.Client.Net` package to your project.

    `dotnet add package Umbraco.Headless.Client.Net`
2.  Add environment variables for your project alias and your API key.

    {% code title="appsettings.json" %}
    ```json
    {
        "Heartcore": {
            "ProjectAlias": "your-project-alias",
            "ApiKey": "your-api-key"
        }
    }
    ```
    {% endcode %}
3.  Register the `ContentManagementService` to your dependency injection container. The registration of the `ContentManagementService` is handled by the `AddUmbracoHeartocore` extension method.

    {% code title="Program.cs / Startup.cs" %}
    ```csharp
    builder.Services.AddUmbracoHeartcore(options =>
    {
        //configure options
    });
    ```
    {% endcode %}
4.  Inject the `ContentManagementService` into your non-static class.

    ```csharp
    private readonly ContentManagementService _contentManagementService;

    public UmbracoService(ContentManagementService contentManagementService)
    {
        _contentManagementService = contentManagementService;
    }
    ```

{% hint style="info" %}
If you don't want to use dependency injection, you can manually create an instance of the `ContentManagementService` class. The constructor requires that you know the project alias and your API key.

{% code overflow="wrap" %}
```csharp
var managementService = new ContentManagementService("your-project-alias", "your-api-key");
```
{% endcode %}
{% endhint %}

Now you are ready to start using the `ContentManagementService`.

## Content

When working with content, the `ContentManagementService` can Get, Create, Update, Publish, Unpublish, and Delete content.

### Get Content

The `ContentManagementService` has three methods for getting content.

#### **`GetRoot()`**&#x20;

Gets all content at the root of the tree.

To use this method, call the method on the `ContentManagementService` instance:

```csharp
var content = await _contentManagementService.Content.GetRoot();
```

<details>

<summary><code>GetById(Guid id)</code> </summary>

Gets a specific content item matching a GUID.

To use this method, call the method on the `ContentManagementService` instance and pass in the GUID of the content item you want to get:

```csharp
var content = await _contentManagementService.Content.GetById(yourGuidObject);
//or
var content = await _contentManagementService.Content.GetById(Guid.Parse("your-guid-as-a-string"));
```

</details>

<details>

<summary><code>GetChildren(Guid id)</code></summary>

Gets all content that is a child of a specific content item.

To use this method, call the method on the `ContentManagementService` instance and pass the GUID of the content item to get the children:

```csharp
var content = await _contentManagementService.Content.GetChildren(yourGuidObject);
//or
var content = await _contentManagementService.Content.GetChildren(Guid.Parse("your-guid-as-a-string"));
```

</details>

### Create Content

The `ContentManagementService` has one method for creating content.

<details>

<summary><code>Create(Content content)</code></summary>

Creates a new content item based on the passed-in `Content` object.

To use this method, call the method on the `ContentManagementService` instance and pass in the content item you want to create:

```csharp
var newContent = await _contentManagementService.Content.Create(yourContentObject);
```

</details>

### Update Content

The `ContentManagementService` has one method for updating content.

<details>

<summary><code>Update(Content content)</code></summary>

Updates an existing content item based on the passed-in `Content` object.

To use this method, call the method on the `ContentManagementService` instance and pass in the content item you want to update:

```csharp
var updatedContent = await _contentManagementService.Content.Update(yourContentObject);
```

</details>

### Publish Content

The `ContentManagementService` has one method for publishing content.

<details>

<summary><code>Publish(Guid id, string culture = "*")</code></summary>

Publishes an existing content item based on the passed-in GUID and culture.

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

</details>

### Unpublish Content

The `ContentManagementService` has one method for unpublishing content.

<details>

<summary><code>Unpublish(Guid id, string culture = "*")</code></summary>

Unpublishes an existing content item based on the passed-in GUID and culture.

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

</details>

### Delete Content

The `ContentManagementService` has one method for deleting content.

<details>

<summary><code>Delete(Guid id)</code></summary>

Deletes an existing content item based on the passed-in GUID.

To use this method, call the method on the `ContentManagementService` instance and pass in the GUID of the content item you want to delete:

```csharp
var deletedContent = await _contentManagementService.Content.Delete(yourGuidObject);
//or
var deletedContent = await _contentManagementService.Content.Delete(Guid.Parse("your-guid-as-a-string"));
```

</details>

## Media

When working with media, the `ContentManagementService` can Get, Create, Update and Delete media.

{% hint style="info" %}
**For Media you create programmatically**, you have to use the "raw" property values that Umbraco expects for the specific property editor.

The different scenarios are:

1.  File Upload (A File Upload property editor)

    When uploading a file, you must specify the file name for the `umbracoFile` property alias.

    ```csharp
    var media = new Umbraco.Headless.Client.Net.Management.Models.Media {
        Name = "name-of-media", 
        MediaTypeAlias = "File", 
        ParentId = parentFolderGuidObject};
    media.SetValue(
        "umbracoFile", 
        fileName, 
        new FileInfoPart(new FileInfo(imagePath), 
        fileName, 
        $"image/{Path.GetExtension(imagePath).Trim('.')}"));
    ```
2.  Image Upload (A Image Cropper property editor)

    When uploading an Image (by default, it uses the Image Cropper property editor), you must specify the source's file name for the `umbracoFile` property alias.

    ```csharp
    var media = new Umbraco.Headless.Client.Net.Management.Models.Media {
        Name = "name-of-media", 
        MediaTypeAlias = "Image", 
        ParentId = parentFolderGuidObject};
    media.SetValue(
        "umbracoFile", 
        new { src = fileName }, 
        new FileInfoPart(new FileInfo(imagePath), 
        fileName, 
        $"image/{Path.GetExtension(imagePath).Trim('.')}"));
    ```
{% endhint %}

### Get Media

The `ContentManagementService` has three methods for getting media.

<details>

<summary><code>GetRoot()</code></summary>

Gets all media at the root of the tree.

To use this method, call the method on the `ContentManagementService` instance:

```csharp
var rootMedia = await _contentManagementService.Media.GetRoot();
```

</details>

<details>

<summary><code>GetById(Guid id)</code></summary>

Gets a specific media item matching a GUID.

To use this method, call the method on the `ContentManagementService` instance and pass in the GUID of the media item you want to get:

```csharp
var media = await _contentManagementService.Media.GetById(yourGuidObject);
//or
var media = await _contentManagementService.Media.GetById(Guid.Parse("your-guid-as-a-string"));
```

</details>

<details>

<summary><code>GetChildren(Guid id)</code></summary>

Gets all media that is a child of a specific media item.

To use this method, call the method on the `ContentManagementService` instance and pass in the GUID of the media item to get the children:

```csharp
var mediaChildren = await _contentManagementService.Media.GetChildren(yourGuidObject);
//or
var mediaChildren = await _contentManagementService.Media.GetChildren(Guid.Parse("your-guid-as-a-string"));
```

</details>

### Create Media

The `ContentManagementService` has one method for creating media.

<details>

<summary><code>Create(Media media)</code></summary>

Creates a new media item based on the passed-in `Media` object.

To use this method, call the method on the `ContentManagementService` instance and pass in the media item you want to create:

```csharp
var newMedia = await _contentManagementService.Media.Create(yourMediaObject);
```

</details>

### Update Media

The `ContentManagementService` has one method for updating media.

<details>

<summary><code>Update(Media media)</code></summary>

Updates an existing media item based on the passed-in `Media` object.

To use this method, call the method on the `ContentManagementService` instance and pass in the media item you want to update:

```csharp
var updatedMedia = await _contentManagementService.Media.Update(yourMediaObject);
```

</details>

### Delete Media

The `ContentManagementService` has one method for deleting media.

<details>

<summary><code>Delete(Guid id)</code></summary>

Deletes an existing media item based on the passed-in GUID.

To use this method, call the method on the `ContentManagementService` instance and pass in the GUID of the media item you want to delete:

```csharp
var deletedMedia = await _contentManagementService.Media.Delete(yourGuidObject);
//or
var deletedMedia = await _contentManagementService.Media.Delete(Guid.Parse("your-guid-as-a-string"));
```

</details>

## Further reading

* Learn how to [Create content programmatically](../../../umbraco-cms/reference/management/services/contentservice/create-content-programmatically.md).
