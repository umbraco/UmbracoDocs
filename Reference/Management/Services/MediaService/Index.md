---
versionFrom: 8.0.0
---

# MediaService

The MediaService acts as a "gateway" to Umbraco data for operations which are related to media.

[Browse the API documentation for IMediaService interface](https://our.umbraco.com/apidocs/v8/csharp/api/Umbraco.Core.Services.IMediaService.html).

 * **Namespace:** `Umbraco.Core.Services` 
 * **Assembly:** `Umbraco.Core.dll`

 All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following using statements:

```csharp
using Umbraco.Core;
using Umbraco.Core.Models;
using Umbraco.Core.Services;
```

## Getting the service

### Services property

If you wish to use use the media service in a class that inherits from one of the Umbraco base classes (eg. `SurfaceController`, `UmbracoApiController` or `UmbracoAuthorizedApiController`), you can access the media service through a local `Services` property:

```csharp
IMediaService mediaService = Services.MediaService;
```

### Dependency Injection

In other cases, you may be able to use Dependency Injection. For instance if you have registered your own class in Umbraco's dependency injection, you can specify the `IMediaService` interface in your constructor:

```csharp
public class MyClass
{

    private IMediaService _mediaService;
    
    public MyClass(IMediaService mediaService)
    {
        _mediaService = mediaService;
    }

}
```

### Static accessor

If neither a `Services` property or Dependency Injection is available, you can also reference the static `Current` class directly:

```csharp
IMediaService mediaService = Umbraco.Core.Composing.Current.Services.MediaService;
```

## Samples

### Creating a new folder

To create a new folder at the root of the media archive, your code could look like the following:

```csharp
// Initialize a new media at the root of the media archive
IMedia folder = Services.MediaService.CreateMedia("My Folder", Constants.System.Root, Constants.Conventions.MediaTypes.Folder);

// Save the folder
Services.MediaService.Save(folder);
```

For the `CreateMedia` method, the first parameter is the name of the folder to be created.

The second parameter is the ID of the parent media item. `Constants.System.Root` is a constant defined in Umbraco with the value of `-1`, which is used for indicating the root of the media archive. Instead of specifying the numeric ID of the parent, you may instead specify either a `Guid` ID or an `IMedia` instance representing the parent media.

The third parameter is the alias of the Media Type. As Umbraco comes with a Folder Type by default, we can use the `Constants.Conventions.MediaTypes.Folder` constant to specify that the alias of the Media Type is `Folder`.

In addition to the three mandatory parameters as shown above, you may also specify a numeric ID for a user to which the creation of the media should be attributed. If not specified, the media will be attributed to the user with ID `-1`.


### Creating a new media from an uploaded file

The example below shows how to create a new file (in this case, an image) from a HTTP upload. For illustrative purposes the example is a Razor view.



```csharp
@inherits Umbraco.Web.Mvc.UmbracoViewPage<IPublishedContent>

<form method="post" enctype="multipart/form-data">
    <input type="file" name="file" />
    <input type="submit" value="Upload Image" name="submit" />
</form>

@if (IsPost)
{

    // Get a reference to the uploaded file
    HttpPostedFileBase file = Request.Files["file"];

    // Did the user actually select a file?
    if (file != null)
    {

        // TODO: Add validation to prevent malicious file uploads
        
        // Initialize a new image at the root of the media archive
        IMedia media = Services.MediaService.CreateMedia("Hello", Constants.System.Root, Constants.Conventions.MediaTypes.Image);
        
        // Set the property value (Umbraco will automatically update related properties)
        media.SetValue(Services.ContentTypeBaseServices, Constants.Conventions.Media.File, "hello.jpg", file);
        
        // Save the media
        Services.MediaService.Save(media);

    }

}
```

:::note
When creating a new media from a file (eg. of the types **Image** or **File**), you must specify an instance of `IContentTypeBaseServiceProvider` (here accessed via `Services.ContentTypeBaseServices`) when setting the property value with the file reference.

Umbraco uses this instance to determine the type of the media you're creating, as well as handling a few things "under the hood" so you don't have to. For instance Umbraco will automatically set other properties related to the file - such as file size and image dimensions.
:::


### Creating a new media item from a stream

Similar to specifying a `HttpPostedFileBase` as shown in the example above, you can instead specify a `Stream` for the contents of the file that should be created.

As an example, if you have a file on disk, you can open a new stream for a file on the disk, and then create a new media for that file in Umbraco:

```csharp
// Open a new stream to the file
using (Stream stream = File.OpenRead("C:/path/to/my-image.jpg"))
{

    // Initialize a new image at the root of the media archive
    IMedia media = Services.MediaService.CreateMedia("My image", Constants.System.Root, Constants.Conventions.MediaTypes.Image);

    // Set the property value (Umbraco will handle the underlying magic)
    media.SetValue(Services.ContentTypeBaseServices, Constants.Conventions.Media.File, "my-image.jpg", stream);

    // Save the media
    Services.MediaService.Save(media);

}
```

Again Umbraco will make sure the necessary properties are updated.
