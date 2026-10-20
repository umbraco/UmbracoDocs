---
description: Information on FileSystemProviders and how to configure them in Umbraco
---

# FileSystemProviders Configuration

Filesystem providers are configured via code, you can either configure it in a composer, or in the `Program.cs` file.

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Core.IO;
using Umbraco.Cms.Infrastructure.DependencyInjection;
using IHostingEnvironment = Umbraco.Cms.Core.Hosting.IHostingEnvironment;

namespace FilesystemProviders;

public class FilesystemComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder) =>
        builder.SetMediaFileSystem(factory =>
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
```

By default Umbraco will save Media in a folder called `/media` within the webroot on the Physical file system. The code snippet above will change the location to instead save the media in a folder called `/CustomMediaFolder` within the webroot.

The media provider can be of many types, for example in case you want to store media on Azure, Amazon or even DB. But the provider that comes by default with the installation of Umbraco is the `PhysicalFileSystem` provider.

## PhysicalFileSystem Configuration

The physical file system provider manages the interaction of Umbraco with the local file system. It can be configured for two different scenarios:

* Media files stored inside a virtual folder of the site
* Media files stored somewhere else outside of the site and accessed via a custom URL

### Virtual Folder

To configure the PhysicalFileSystem for a virtual folder, create a new filesystem with a root path and URL within the wwwroot folder. Refer to the example above and [Extending FileSystemProviders](../../extending/filesystemproviders/) for more information.

### Physical path

To store the media files in a folder outside the webroot, configure a physical root path in `appsettings.json`. You do not need a custom file system for this.

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

* `UmbracoMediaPhysicalRootPath` is the full filesystem path where the media files are stored. Both absolute server paths (`C:\storage\umbracoMedia` or `\\servername\path`) and paths relative to the webroot (`../../Shared/Media`) are supported.
* `UmbracoMediaPath` is the relative URL that media is served from. It defaults to `~/media`, and only needs changing if you also want media served from a different URL.

From these settings Umbraco builds the same `PhysicalFileSystem` you would otherwise write by hand. It also composes that folder into the webroot file provider, so both static file serving and image processing continue to work.

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

Every image is then served at its original size, including backoffice thumbnails. The problem only surfaces once media is stored outside the webroot.

To check whether a site is affected, request an image with and without a resizing querystring. `?width=50` must return a smaller response than the same URL without the querystring.
{% endhint %}

For a different kind of storage, such as Azure Blob Storage or Amazon S3, replace the media file system instead. For more information see [Extending FileSystemProviders](../../extending/filesystemproviders/).

## Custom providers

To store media files in different systems, the type of provider must be changed. You can learn [how to build a custom filesystem provider](../../extending/filesystemproviders/#custom-file-systems-ifilesystem) in the Extending Umbraco section.

{% hint style="info" %}
At the moment when a file is saved, its full URL is stored as node property. This means that a configuration change will not apply to pre-existing media files but only to the ones saved after that.

If you want all your media files in the same location, you have to copy all pre-existing files to the new path. Additionally, you need to update the path property of the media item to the new URL. This can be either directly inside the database or by using the `MediaService`.
{% endhint %}

## Get the contents of a file as a stream

The recommended approach to obtain a file's content as a stream is to utilize the `MediaFileManager`. It is advised to avoid reading the file directly from the server using methods like `Server.MapPath`. This will ensure that, regardless of the file system provider, the stream will be returned correctly. TThis example demonstrates using MediaFileManager to validate file existence and stream it back from a controller.

```csharp
using System.IO;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.StaticFiles;
using Umbraco.Cms.Core.Cache;
using Umbraco.Cms.Core.Hosting;
using Umbraco.Cms.Core.IO;
using Umbraco.Cms.Core.Logging;
using Umbraco.Cms.Core.Routing;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Core.Web;
using Umbraco.Cms.Infrastructure.Persistence;
using Umbraco.Cms.Web.Website.Controllers;

namespace FilesystemProviders;

public class MediaController : SurfaceController
{
    private readonly MediaFileManager _mediaFileManager;
    private readonly IHostingEnvironment _hostingEnvironment;

    public MediaController(
        IUmbracoContextAccessor umbracoContextAccessor,
        IUmbracoDatabaseFactory databaseFactory,
        ServiceContext services,
        AppCaches appCaches,
        IProfilingLogger profilingLogger,
        IPublishedUrlProvider publishedUrlProvider,
        MediaFileManager mediaFileManager,
        IHostingEnvironment hostingEnvironment)
        : base(umbracoContextAccessor, databaseFactory, services, appCaches, profilingLogger, publishedUrlProvider)
    {
        _mediaFileManager = mediaFileManager;
        _hostingEnvironment = hostingEnvironment;
    }

    public IActionResult Index(string id, string file)
    {
        var path = _hostingEnvironment.MapPathWebRoot($"/media/{id}/{file}");

        if (_mediaFileManager.FileSystem.FileExists(path))
        {
            var stream = _mediaFileManager.FileSystem.OpenFile(path);
            stream.Seek(0, SeekOrigin.Begin);

            var provider = new FileExtensionContentTypeProvider();
            string contentType;
            if (!provider.TryGetContentType(file, out contentType))
            {
                contentType = "application/octet-stream";
            }

            return new FileStreamResult(stream, contentType);
        }

        return new NotFoundResult();
    }
}
```
