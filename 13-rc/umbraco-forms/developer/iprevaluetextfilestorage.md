# Storing Prevalue Text Files With IPreValueTextFileStorage

Umbraco Forms contains a built-in `Get value from textfile` [Prevalue Source Type](extending/adding-a-prevaluesourcetype.md) that stores the uploaded text file into the physical file system (by default in `umbraco\Data\UmbracoForms\PreValueTextFiles`).

You can replace the default implementation by writing your own `IPreValueTextFileStorage` and registering that using e.g. `builder.Services.AddUnique<IPreValueTextFileStorage, CustomPreValueTextFileStorage>()` (in `Startup.cs` or a composer).

You can also use/inherit from `PreValueTextFileSystemStorage` to change the underlying `IFileSystem` that's used to store the prevalue text files.

## Move files to Media file system

You can use the following composer to move the prevalue text files into the media file system. If the media file system is using Azure Blob Storage, this will remove the files from the local physical file system.

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.IO;
using Umbraco.Cms.Core.Scoping;
using Umbraco.Forms.Core.Data;

public class PreValueTextFileSystemStorageComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
        => builder.Services.AddUnique<IPreValueTextFileStorage>(factory => new PreValueTextFileSystemStorage(
            factory.GetRequiredService<MediaFileManager>().FileSystem,
            factory.GetRequiredService<IScopeProvider>(),
            "PreValueTextFiles"));
}
```

You need to manually move the existing files from `umbraco\Data\UmbracoForms\PreValueTextFiles` to your media storage. The final file path/URL will look like `~/media/PreValueTextFiles/{GUID}/{filename.txt}` and be accessible from the browser.

## Move files to Azure Blob Storage

First, install [Umbraco.StorageProviders.AzureBlob](https://github.com/umbraco/Umbraco.StorageProviders) and configure the Forms storage container, for example by adding the following to your `appsettings.json`:

```json
{
  "Umbraco": {
    "Storage": {
      "AzureBlob": {
        "Forms": {
          "ConnectionString": "UseDevelopmentStorage=true",
          "ContainerName": "sample-container"
        }
      }
    }
  }
}
```

Next, add the following composer that adds the Forms storage container and stores the prevalue text files into Azure Blob Storage (in `forms/PreValueTextFiles/{GUID}/{filename.txt}`):

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Infrastructure.Scoping;
using Umbraco.Forms.Core.Data;
using Umbraco.StorageProviders.AzureBlob.IO;

public class PreValueTextFileSystemStorageComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
        => builder.AddAzureBlobFileSystem("Forms", options => options.VirtualPath = "~/forms")
            .Services.AddUnique<IPreValueTextFileStorage>(factory => new PreValueTextFileSystemStorage(
                factory.GetRequiredService<IAzureBlobFileSystemProvider>().GetFileSystem("Forms"),
                factory.GetRequiredService<IScopeProvider>(),
                "PreValueTextFiles"));
}
```

You need to manually move the existing files from `umbraco\Data\UmbracoForms\PreValueTextFiles` to your storage container. If you've disabled public access, the stored files are not accessible from the browser.
