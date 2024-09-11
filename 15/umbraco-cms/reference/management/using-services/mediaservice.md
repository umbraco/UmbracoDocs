---
description: Examples on how to create a new folder and a new media item from a stream by using the MediaService.
---

# Media Service

In this article, you can find some examples on how to create a new media folder and a media item from a stream programmatically.

Samples in this document will require the following using statements:

```csharp
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.IO;
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Core.PropertyEditors;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Core.Strings;
using Umbraco.Extensions;
```

## Creating a new folder

To create a new folder at the root of the media archive, your code could look like the following:

```csharp
// Initialize a new media at the root of the media archive
IMedia folder = _mediaService.CreateMedia("Samples Media Item Folder", Constants.System.Root, Constants.Conventions.MediaTypes.Folder);

// Save the folder
var result = _mediaService.Save(folder);
```

Alternatively, you can replace the Constants in the above sample with hardcoded values.

```csharp
// Initialize a new media at the root of the media archive
IMedia folder = _mediaService.CreateMedia("Samples Media Item Folder", -1, "Folder");

// Save the folder
var result = _mediaService.Save(folder);
```

For the `CreateMedia` method, the first parameter is the name of the folder to be created.

The second parameter is the ID of the parent media item. `Constants.System.Root` is a constant defined in Umbraco with the value of `-1`, which is used for indicating the root of the media archive. Instead of specifying the numeric ID of the parent, you may instead specify either a `Guid` ID or an `IMedia` instance representing the parent media.

The third parameter is the alias of the Media Type. As Umbraco comes with a Folder Type by default, we can use the `Constants.Conventions.MediaTypes.Folder` constant to specify that the alias of the Media Type is `Folder`.

Besides the three mandatory parameters, you can specify a user's numeric ID for media creation attribution. Unspecified cases default to the "Administrator" user with ID `-1`.

## Creating a new media item from a stream

You can specify a `Stream` for the contents of the file that should be created.

As an example, if you have an image on disk named `unicorn.jpg` in the images folder of `wwwroot`. You can open a new stream for a file on the disk, and then create a new media item for that file in Umbraco:

Please be aware that you will need to inject the following services:

* `MediaFileManager _mediaFileManager`
* `IShortStringHelper _shortStringHelper`
* `IContentTypeBaseServiceProvider _contentTypeBaseServiceProvider`
* `MediaUrlGeneratorCollection _mediaUrlGeneratorCollection`
* `IMediaService _mediaService`
* `IWebHostEnvironment _webHostEnvironment`

```csharp
string webRootPath = _webHostEnvironment.WebRootPath;
var path = Path.Combine(webRootPath, "images", "unicorn.jpg");

// Open a new stream to the file
using (Stream stream = System.IO.File.OpenRead(path))
{
    // Initialize a new image at the root of the media archive
    IMedia media = _mediaService.CreateMedia("Unicorn", Constants.System.Root, Constants.Conventions.MediaTypes.Image);
    // Set the property value (Umbraco will handle the underlying magic)
    media.SetValue(_mediaFileManager, _mediaUrlGeneratorCollection, _shortStringHelper, _contentTypeBaseServiceProvider, Constants.Conventions.Media.File, "unicorn.jpg", stream);

    // Save the media
    var result = _mediaService.Save(media);
}
```

Again Umbraco will make sure the necessary properties are updated.
