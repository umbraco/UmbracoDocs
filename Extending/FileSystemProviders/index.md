---
versionFrom: 9.0.0
verified-against: beta-1
meta.Title: "Umbraco File System Providers"
meta.Description: "A guide to creating custom file systems in Umbraco"
---

# Custom file systems (IFileSystem)

## Media Filesystem

By default, Umbraco uses an instance of `PhysicalFileSystem` to handle the storage location of the media archive (wwwroot/media).

This can be configured during composition:

```csharp
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Core.Hosting;
using Umbraco.Cms.Core.IO;
using Umbraco.Cms.Infrastructure.DependencyInjection;

namespace UmbracoExamples.Composition
{
    public class SetMediaFileSystemComposer : IUserComposer
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
}
```

When creating a PhyscialFileSystem it takes some dependencies like IIOHelper, but the last two parameters are what we're interested in. The `rootPath` is where your media will be stored on the disk. Since netcore by default store files in the `wwwroot`, we must put our desired folder somewhere within `wwwroot`, to ensure that we use `hostingEnvironment.MapPathWebRoot(~/CustomMediaFolder)`. The `~` will be mapped to your `wwwroot` folder, so the final `rootPath` will be `your/project/path/wwwroot/CustomMediaFolder`. The `~` is therefore important.

The other part of the puzzle is the `rootUrl`, which is the base URL your media files will be served from. In this case, your image URL could look something like `mysite.com/CustomMediaFolder/MyAwesomePicture.png`. Again the `~` is important. Another thing worth mentioning with the `rootUrl` is that it must be the same as the folder location, otherwise, you will get 404's for your images.

This is all great if you want to change the location within the `wwwroot` folder of your project, but what if you want to store the media files outside `wwwroot`? This is possible but requires an extra step.

As mentioned, netcore stores static files such as media and CSS, in the `wwwroot` folder by default, but we can register an additional location in the `configure` section of our startup.

In the `configure` method in `startup.cs`, register a new static file location like so:

```c#
public void Configure(IApplicationBuilder app)
{
    ...

    app.UseStaticFiles(new StaticFileOptions
    {
        FileProvider = new PhysicalFileProvider(Path.Combine("D:", "storage", "umbracoMedia")),
        RequestPath = "/CustomPath"
    });
}
```

The PhysicalFileProvider takes a single parameter, the **RootPath** - the rooted, filesystem path, using directory separator chars, not ending with a separator `//`, eg `c:`, `c:\path\to\site` or `\\server\path`. The safest way to achieve this is using `Path.Combine`.

You also have to specify the  **RequestPath** - the relative URL, where the media will be served, using URL separator chars, not ending with a separator `/`, eg "", `/Views` or `/Media`.

Now you can use your newly registered static file location as if it was `wwwroot`. Notice how you no longer need to use `hostingEnvironment.MapPathWebRoot(folderLocation)`, since you're no longer trying to map the location to somewhere within `wwwroot`, but instead use your newly registered static file location.

```csharp
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
```

This is almost the same as when registering a location within the `wwwroot` folder. The only difference is that `rootPath` is now set to the path we gave the `PhysicalFileProvider` and the `rootUrl` is the same as we set as the `RequestPath` in the `StaticFileOption`.

Our media is now stored in `C:\storage\umbracoMedia`, and is served from the base URL `/CustomPath`, so an image URL will look something like `mysite.com/CustomPath/MyAwesomePicture.png`.

### IFileSystem

`PhysicalFileSystem` implements the `IFileSystem` interface, and it is possible to replace it with a custom class - eg. if you want your media files stored on Azure or something similar. You replace the media filesystem using the `SetMediafileSystem` method in a composer like shown in the `MediaFileSystem` section, but instead of returning a `PhysicalFileSystem`, you return whatever implementation of `IFileSystem` you want.

If you configure Umbraco to use a custom file system provider for media, you shouldn't access the implementation directly. Umbraco uses a manager class called `MediaFileManager`. You can get a reference to this manager class via dependency injection in the constructor for your custom class or controller:

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

By default the MediaPath scheme used by Umbraco is the `UniqueMediaPathScheme` this generates a unique 'folder' to place the uploaded image in eg.

`/media/dozdrg2f/mylovelyimage.jpg`

`/media` is defined by the PhysicalFileSystem and 'dozdrg2f' is generated by the `UniqueMediaPathScheme`.

:::note
In Umbraco 7 the integer ids were used in the path, and this approach is still possible using the 'OriginalMediaPathScheme'
:::

You can set the `MediaPathScheme` during composition, for example if you wanted to revert back to the V7 methodology in a migrated site:

```c#
  builder.Services.AddUnique<IMediaPathScheme, OriginalMediaPathScheme>();
```

And you could create your own logic for the path by implementing `IMediaPathScheme`.

## Other IFileSystems

Umbraco also registers instances of `PhysicalFileSystem` for the following parts of Umbraco that persist to 'files':

- `MacroPartialsFileSystem`
- `PartialViewsFileSystem`
- `StylesheetsFileSystem`
- `ScriptsFileSystem`
- `MvcViewsFileSystem`

These are accessible via dependency injection.

```csharp
public class FileSystemLocations 
{
    private readonly FileSystems _fileSystems;
    public FileSystemLocations(FileSystems fileSystems)
    {
        _fileSystems = fileSystems;
        var macroPartialsFileSystem = _fileSystems.MacroPartialsFileSystem;
    }     
```

`IFileSystem`, `MediaFileManager`, and `FileSystems` are located in the `Umbraco.Cms.Core.IO` namespace.

### Stylesheet Filesystem

Like with the media file system it is also possible to replace the stylesheet filesystem with your own implementation of `IFileSystem` in a composer. It's important to note here that, unlike media file system, you cannot replace the filesystem with a `PhysicalFileSystem` using a different root path or root URL, this will not work, and will cause issues since the root path is coupled to the virtual path, given by the frontend, e.g. `/css/MyBeautifulStyle.css`.

When replacing the stylesheet filesystem, you don't need to register it, since it's only available through Filesystems, what you need to do instead is configure the `FileSystems` to use your implementation for the `StylesheetsFileSystem`.

The IUmbracoBuilder has an extension method for configuring the `FileSystems`, you need to invoke this method with an action that accepts an `IServiceProvider` and the `FileSystems` you will configure, configuring the `FileSystems` can look like this:

```c#
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Configuration.Models;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Core.Hosting;
using Umbraco.Cms.Core.IO;
using Umbraco.Cms.Infrastructure.DependencyInjection;

namespace UmbracoExamples.Composition
{
    public class FileSystemComposer : IUserComposer
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
                var fileSystem = new YourFileSystemImplementaion(ioHelper, hostingEnvironment, logger, rootPath, rootUrl);

                systems.SetStylesheetFilesystem(fileSystem);
            });
        }
    }
}
```

Where `YourFileSystemImplementation` is a class that implements `IFileSystem`. This should always be done in a composer, since we do not recommend trying to change filesystems on the fly.

After the `SetStylesheetFileSystem` method has run, `FileSystems.StylesheetsFileSystem` will return the instance that was created in the `ConfigureFileSystems` extension method.

## Custom providers

There is an Azure Blob Storage provider:

* [Azure Blob Storage](Azure-Blob-Storage/index.md)