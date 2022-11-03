---
versionFrom: 9.0.0
versionTo: 10.0.0
meta.Title: "FileSystemProviders in Umbraco"
meta.Description: "Information on FileSystemProviders and how to configure them in Umbraco"
---

# FileSystemProviders Configuration

Filesystem providers are configured via code, you can either configure it in a composer, or in the `Startup.cs` file.


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

By default Umbraco will save Media in a folder called `/media` within the webroot on the Physical file system, the code snippet above will change the location to instead save the media in a folder called `/CustomMediaFolder` within the webroot.

The media provider can be of many types, for example in case you want to store media on Azure, Amazon or even DB. But the provider that comes by default with the installation of Umbraco is the `PhysicalFileSystem` provider.

## PhysicalFileSystem Configuration

The physical file system provider manages the interaction of Umbraco with the local file system. It can be configured for two different scenarios:

 - Media files stored inside a virtual folder of the site
 - Media files stored somewhere else outside of the site and accessed via a custom url

### Virtual Folder

To configure the PhysicalFileSystem to work with a virtual folder, you must create a new filesystem with a root path and root url that points within the `wwwroot` folder, see the example above, this can then be used to configure the media filesystem. For information see [Extending FileSystemProviders](../../extending/filesystemproviders/).

### Physical path
If you want to store the media files in a separate folder, outside of the webroot folder, maybe on a NAS/SAN, there's a few more steps.

First you must register the folder as a static file provider in your `Startup.cs` file like so:

```C#
public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
{
    {...}

    app.UseStaticFiles(new StaticFileOptions
    {
        FileProvider = new PhysicalFileProvider(Path.Combine("C:", "storage", "umbracoMedia")),
        RequestPath = "/CustomPath"
    });
}
```

Now you can register the folder as the media filesystem

```C#
using System.IO;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Core.Hosting;
using Umbraco.Cms.Core.IO;
using Umbraco.Cms.Infrastructure.DependencyInjection;

namespace FilesystemProviders
{
    public class FilesystemComposer : IComposer
    {
        public void Compose(IUmbracoBuilder builder)
        {
            builder.SetMediaFileSystem((factory) =>
            {
                IHostingEnvironment hostingEnvironment = factory.GetRequiredService<IHostingEnvironment>();
                var rootPath = Path.Combine("C:", "storage", "umbracoMedia");
                var rootUrl = hostingEnvironment.ToAbsolute("/CustomPath");

                return new PhysicalFileSystem(
                    factory.GetRequiredService<IIOHelper>(),
                    hostingEnvironment,
                    factory.GetRequiredService<ILogger<PhysicalFileSystem>>(),
                    rootPath,
                    rootUrl);
            });
        }
    }
}
```

This is much the same as when you register it within the wwwroot with a virutal folder, the only differnce is that now you provide an absolute root path and root url to the physical filesystem.

 - `rootPath` is the full filesystem path where you want media files to be stored. It has to be rooted, must use directory separators (`\`) and must not end with a separator. For example, `Z:` or `C:\path\to\folder` or `\\servername\path`.
 - `rootUrl` is the url where the files will be accessible from. It must use url separators (`/`) and must not end with a separator. It can either be a folder, like `/UmbracoMedia`, in which case it will considered as subfolder of the main domain (`example.com/UmbracoMedia`) or can be a fully qualified url, with also domain name and protocol (for ex `http://media.example.com/media`).

For more information see [Extending FileSystemProviders](../../extending/filesystemproviders/).

## Custom providers

To store media files in different systems, the type of provider must be changed. You can learn [how to build a custom filesystem provider](../../extending/filesystemproviders/README.md#custom-file-systems-ifilesystem) in the Extending Umbraco section.

{% hint style="info" %}
At the moment when a file is saved, its full url is stored as node property, so a configuration change will not apply to pre-existing media files but only to the ones saved after that.

If you want all your media files in the same location you have to copy all pre-existing files to the new path, and update the `path` property of the media item to the new url. This can be either directly inside the database or by using the `MediaService`.
{% endhint %}

## Get the contents of a file as a stream

To get the content of a file as a stream, the best practice is to use the `MediaFileManager` to do so, rather than reading the file from the server using something like `Server.MapPath`. This will ensure that, regardless of the file system provider, the stream will be returned correctly.
This is an example of how you can, on one hand - use `MediaFileManager` to check whether the file exist, and on the other hand return the file as a stream in a controller.

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

namespace FilesystemProviders
{
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
}
```
