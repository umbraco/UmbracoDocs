---
description: A guide to creating custom file systems in Umbraco
---

# Custom File Systems (IFileSystem)

## Media Filesystem

{% hint style="info" %}
Before considering a custom media file system, be sure to first read about the configuration options for `UmbracoMediaPath` and `UmbracoMediaPhysicalRootPath` in the [configuration reference docs](../../../develop-with-umbraco/configuration/globalsettings.md). These configurations may save you from creating your own media file system entirely.
{% endhint %}

By default, Umbraco uses an instance of `PhysicalFileSystem` to handle the storage location of the media archive (wwwroot/media).

This can be configured by composition:

```csharp
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Core.Hosting;
using Umbraco.Cms.Core.IO;
using Umbraco.Cms.Infrastructure.DependencyInjection;

namespace UmbracoExamples.Composition;

public class SetMediaFileSystemComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.SetMediaFileSystem((factory) =>
        {
            IHostingEnvironment hostingEnvironment = factory.GetRequiredService<IHostingEnvironment>();
            var folderLocation = "~/CustomMediaFolder";
            var rootPath = hostingEnvironment.MapPathWebRoot(folderLocation);
            var rootUrl = hostingEnvironment.ToAbsolute(folderLocation);

            return new PhysicalFileSystem(
                factory.GetRequiredService<IIOHelper>(),
                hostingEnvironment,
                factory.GetRequiredService<ILogger<PhysicalFileSystem>>(),
                rootPath,
                rootUrl);
        });
    }
}
```

When creating a `PhysicalFileSystem` it takes some dependencies like `IIOHelper`, but the last two parameters are what we're interested in.

The `rootPath` is where your media will be stored on the disk. Since netcore by default stores files in the `wwwroot`, we must put our desired folder somewhere within `wwwroot` to ensure that we use `hostingEnvironment.MapPathWebRoot(~/CustomMediaFolder)`. The `~` will be mapped to your `wwwroot` folder, so the final `rootPath` will be `your/project/path/wwwroot/CustomMediaFolder`. The `~` is therefore important.

The `rootUrl` is the base URL that your media files will be served from. In this case, your image URL could look something like `mysite.com/CustomMediaFolder/MyAwesomePicture.png`. Again the `~` is important. With the code sample above, the `rootUrl` must map to the same physical location as `rootPath`, otherwise, you will get 404's for your images.

### Storing media outside the webroot

A custom media file system is not the right tool for storing media on a physical or network path outside `wwwroot`. Use the `UmbracoMediaPhysicalRootPath` setting instead:

```json
{
  "Umbraco": {
    "CMS": {
      "Global": {
        "UmbracoMediaPath": "~/media",
        "UmbracoMediaPhysicalRootPath": "C:\\storage\\umbracoMedia"
      }
    }
  }
}
```

Umbraco builds a `PhysicalFileSystem` from these settings, exactly as in the sample above. It also composes the folder into the webroot file provider for you. This keeps both static file serving and image processing working. See [FileSystemProviders Configuration](../../../develop-with-umbraco/configuration/filesystemproviders.md) for details.

{% hint style="warning" %}
**Do not register the media folder as an additional static file provider.** A pattern sometimes used for this scenario is to add a `PhysicalFileProvider` for the media folder in `Program.cs`:

```csharp
// Do not do this - it silently disables image resizing.
app.UseStaticFiles(new StaticFileOptions
    {
        FileProvider = new PhysicalFileProvider(Path.Combine("C:", "storage", "umbracoMedia")),
        RequestPath = "/CustomPath"
    });
```

There are two problems with this:

* Umbraco registers the ImageSharp middleware inside `app.UseUmbraco()`. A static file middleware registered before that call handles the request first and ignores the querystring, so `?width=500` returns the full-size original.
* ImageSharp resolves images only through the webroot file provider. Files served from a separate `PhysicalFileProvider` are invisible to it, so resizing still does not work even if the registration is moved after `app.UseUmbraco()`.

Every image is then served at its original size, including backoffice thumbnails. To check whether a site is affected, request an image with and without a resizing querystring. `?width=50` must return a smaller response than the same URL without the querystring.
{% endhint %}

Reserve a custom media file system for storage that is genuinely of a different kind, such as Azure Blob Storage or Amazon S3.

### Creating a custom file system

You can replace `PhysicalFileSystem` with a custom file system implementation - eg. if you want your media files stored on Amazon S3 or elsewhere outside your site.

To achieve this, you must first create your own file system by implementing the interfaces `IFileSystem` and `IFileProviderFactory` (the interfaces that are implemented by `PhysicalFileSystem`).

{% hint style="info" %}
Implementing `IFileProviderFactory` allows Umbraco to compose your media file system into the webroot file provider during startup. It is mounted at the URL configured in `UmbracoMediaPath`.

Without it, Umbraco cannot serve or process media from your file system through that path. Image processing resolves media only through the webroot file provider.
{% endhint %}

You then replace the media filesystem by composition using `IUmbracoBuilder.SetMediaFileSystem(...)` (as is demonstrated in the paragraphs above), but instead of returning a `PhysicalFileSystem`, you return your own file system implementation.

For inspiration on building a custom file system, have a look at the [Azure Blob Storage file system implementation](https://github.com/umbraco/Umbraco.StorageProviders#umbracostorageprovidersazureblob).

### Accessing the media file system from code

{% hint style="warning" %}
`UmbracoAuthorizedApiController` has been removed from Umbraco 14. Use`ManagementApiControllerBase` class instead.

Read the [Creating a Backoffice API article](../../tutorials/creating-a-backoffice-api/) for a comprehensive guide to writing APIs for the Management API.
{% endhint %}

Since the default media file system can be swapped with custom implementations, you should never access the implementation directly. Umbraco uses a manager class called `MediaFileManager`. You can get a reference to this manager class via dependency injection in the constructor for your custom class or controller:

```csharp
public class ImagesController : UmbracoAuthorizedApiController
{
    private readonly MediaFileManager _mediaFileManager;

    public ImagesController(MediaFileManager mediaFileManager)
    {
        _mediaFileManager = mediaFileManager;
    }

{...}
```

You can then access the configured file system provider through `_mediaFileManager.FileSystem`, which is the same way Umbraco will access the file system provider.

## MediaPath Scheme

The MediaPath Scheme defines the current set of rules that decide the format of the Media Path when it is saved into the media archive wherever it is located.

By default the MediaPath scheme used by Umbraco is the `UniqueMediaPathScheme` this generates a 'folder' to place the uploaded image in, for example:

`/media/dozdrg2f/mylovelyimage.jpg`

`/media` is defined by the PhysicalFileSystem and `dozdrg2f` is generated by the `UniqueMediaPathScheme`.

{% hint style="info" %}
The folder generated by `UniqueMediaPathScheme` is not strictly unique, as it's based on the first eight characters of the GUID for the media item. In practice, with randomly generated GUIDs, a collision is unlikely.

There is an increased possibility of generating colliding paths if creating media programmatically and setting keys using version 7 "ordered" GUIDs via `Guid.CreateVersion7()`. As such these should be avoided. `UniqueMediaPathScheme` will throw an exception if it detects they have been used. Any manually created keys should use `Guid.NewGuid()`.
{% endhint %}

You can create your own logic for the path by implementing `IMediaPathScheme` and setting it during composition with:

```csharp
builder.Services.AddUnique<IMediaPathScheme, MyCustomMediaPathScheme>();
```

## Other IFileSystems

Umbraco also registers instances of `PhysicalFileSystem` for the following parts of Umbraco that persist to 'files':

* `PartialViewsFileSystem`
* `StylesheetsFileSystem`
* `ScriptsFileSystem`
* `MvcViewsFileSystem`

These are accessible via dependency injection.

`IFileSystem`, `MediaFileManager`, and `FileSystems` are located in the `Umbraco.Cms.Core.IO` namespace.

### Stylesheet Filesystem

Like with the media file system it is also possible to replace the stylesheet filesystem with your own implementation of `IFileSystem` in a composer. It's important to note here that, unlike media file system, you cannot replace the filesystem with a `PhysicalFileSystem` using a different root path or root URL, this will not work, and will cause issues since the root path is coupled to the virtual path, given by the frontend, e.g. `/css/MyBeautifulStyle.css`.

When replacing the stylesheet filesystem, you don't need to register it, since it's only available through Filesystems, what you need to do instead is configure the `FileSystems` to use your implementation for the `StylesheetsFileSystem`.

The IUmbracoBuilder has an extension method for configuring the `FileSystems`, you need to invoke this method with an action that accepts an `IServiceProvider` and the `FileSystems` you will configure, configuring the `FileSystems` can look like this:

```csharp
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Configuration.Models;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Core.Hosting;
using Umbraco.Cms.Core.IO;
using Umbraco.Cms.Infrastructure.DependencyInjection;

namespace UmbracoExamples.Composition;

public class FileSystemComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.ConfigureFileSystems((factory, systems) =>
        {
            IIOHelper ioHelper = factory.GetRequiredService<IIOHelper>();
            IHostingEnvironment hostingEnvironment = factory.GetRequiredService<IHostingEnvironment>();
            ILogger<PhysicalFileSystem> logger = factory.GetRequiredService<ILogger<PhysicalFileSystem>>();
            GlobalSettings settings = factory.GetRequiredService<IOptions<GlobalSettings>>().Value;

            var path = settings.UmbracoCssPath;
            var rootPath = hostingEnvironment.MapPathWebRoot(path);
            var rootUrl = hostingEnvironment.ToAbsolute(path);
            var fileSystem = new YourFileSystemImplementation(ioHelper, hostingEnvironment, logger, rootPath, rootUrl);

            systems.SetStylesheetFilesystem(fileSystem);
        });
    }
}

```

Where `YourFileSystemImplementation` is a class that implements `IFileSystem`. This should always be done in a composer, since we do not recommend trying to change filesystems on the fly.

After the `SetStylesheetFileSystem` method has run, `FileSystems.StylesheetsFileSystem` will return the instance that was created in the `ConfigureFileSystems` extension method.

## Custom providers

There is an Azure Blob Storage provider:

* [Azure Blob Storage](azure-blob-storage.md)
