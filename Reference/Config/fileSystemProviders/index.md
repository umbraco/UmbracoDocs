---
versionFrom: 8.0.0
meta.Title: "FileSystemProviders in Umbraco"
meta.Description: "Information on FileSystemProviders and how to configure them in Umbraco"
---

# FileSystemProviders Configuration

In Umbraco V8 FileSystemProviders are no longer configured via the `fileSystemProviders.config` file.

These configuration settings can be set in code during 'Composition' using an `IUserComponent`

```csharp
using Umbraco.Core.Composing;
using Umbraco.Core;
using Umbraco.Core.IO;

namespace Umbraco8Examples.Composition
{
    public class SetMediaFileSystemComposer : IUserComposer
    {
        public void Compose(Umbraco.Core.Composing.Composition composition)
        {
            composition.SetMediaFileSystem(() => new PhysicalFileSystem("~/media"));
        }
    }
}
```

By default Umbraco will save Media in an application folder called `/media` on the Physical file system.

The media provider can be of many types, for example in case you want to store media on Azure, Amazon or even DB. But the provider that comes by default with the installation of Umbraco is the `PhysicalFileSystem` provider.

## PhysicalFileSystem Configuration

The physical file system provider manages the interaction of Umbraco with the local file system. It can be configured for two different scenarios:

 - Media files stored inside a virtual folder of the site
 - Media files stored somewhere else outside of the site and accessed via a custom url

### Virtual Folder
To configure the PhysicalFileSystem to work with a virtual folder there not much to do, change the value of the `virtualRoot` parameter to the virtual folder you want to use. By default it is configured to store media files in  `~/media`.

```csharp
using Umbraco.Core.Composing;
using Umbraco.Core;
using Umbraco.Core.IO;

namespace Umbraco8Examples.Composition
{
    public class SetMediaFileSystemComposer : IUserComposer
    {
        public void Compose(Umbraco.Core.Composing.Composition composition)
        {
            composition.SetMediaFileSystem(() => new PhysicalFileSystem("~/custommediafolder"));
        }
    }
}
```

### Physical path
If you want to store the media files in a separate folder, outside of the Umbraco website, maybe on a NAS/SAN you have to remove the `virtualRoot` property and add two new properties:

 - `rootPath` is the full filesystem path where you want media files to be stored. It has to be rooted, must use directory separators (`\`) and must not end with a separator. For example, `Z:` or `C:\path\to\folder` or `\\servername\path`.
 - `rootUrl` is the url where the files will be accessible from. It must use url separators (`/`) and must not end with a separator. It can either be a folder, like `/UmbracoMedia`, in which case it will considered as subfolder of the main domain (`example.com/UmbracoMedia`) or can be a fully qualified url, with also domain name and protocol (for ex `http://media.example.com/media`).

```csharp
using Umbraco.Core.Composing;
using Umbraco.Core;
using Umbraco.Core.IO;

namespace Umbraco8Examples.Composition
{
    public class SetMediaFileSystemComposer : IUserComposer
    {
        public void Compose(Umbraco.Core.Composing.Composition composition)
        {
            composition.SetMediaFileSystem(() => new PhysicalFileSystem("Z:\Storage\UmbracoMedia","http://media.example.com/media" ));
        }
    }
}
```

## Custom providers
To store media files in different systems, the type of provider must be changed. You can learn [how to build a custom filesystem provider](/documentation/Extending/Custom-File-Systems) in the Extending Umbraco section.

:::note
At the moment when a file is saved, its full url is stored as node property, so a configuration change will not apply to pre-existing media files but only to the ones saved after that.

If you want all your media files in the same location you have to copy all pre-existing files to the new path, and update the `path` property of the media item to the new url. This can be either directly inside the database or by using the `MediaService`.
:::
