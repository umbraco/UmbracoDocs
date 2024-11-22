---
meta.Title: Import and export with Umbraco Deploy
description: How to import and export content and schema between Umbraco environments and projects
---

# Import and Export

## What is import and export?

The import and export feature of Umbraco Deploy allows you to transfer content and schema between Umbraco environments. Exports are made from one environment to a `.zip` file. And this file is imported into another environment to update the Umbraco data there.

## When to use import and export

Umbraco Deploy provides two primary workflows for managing different types of Umbraco data:

- Umbraco schema (such as document types and data types) are transferred [as `.uda` files serialized to disk](./deploying-changes.md). They are deployed to refresh the schema information in a destination environment along with code and template updates.
- Umbraco content (such as content and media) are [transferred by editors using backoffice operations](./content-transfer.md).

We recommend using these approaches for day-to-day editorial and developer activities.

Import and export is intended more for larger transfer options, project upgrades, or one-off tasks when setting up new environments.

As import and export is a two-step process, it doesn't require inter-environment communication. This allows us to process much larger batches of information without running into hard limits imposed by Cloud hosting platforms.

We are also able provide hooks to allow for migrations of artifacts (such as data types) and property data when importing. This should allow you to migrate your Umbraco data from one Umbraco major version to a newer one.

## Exporting content and schema

To export content and schema, you can select either a specific item of content, or a whole tree or workspace.

When exporting, you can choose to include associated media files. Bear in mind that including media files for a large site can lead to a big zip file. So even with this option, you might want to consider a different method for transferring large amounts of media. For example using direct transfer between Cloud storage accounts or File Transfer Protocol (FTP).

If your account has access to the Settings section, you can also choose to include the schema information and related files as well.

![Tree export](images/tree-export-modal.png)

When doing an environment export, you also have the option to include *all* schema in the export, regardless of whether it is in use by any content.

![Environment export](images/environment-export-modal.png)

Umbraco Deploy will then serialize all the selected items to individual files, archive them into a zip file and make that available for download. You can download the file using the _Download_ button.

After the download, you should also delete the archive file from the server. You can do this immediately via the _Delete_ button available in the dialog.

![Export complete](images/export-complete.png)

If you miss doing this, you can also clean up archive files from the Umbraco Deploy dashboard in the _Settings_ section.

![Delete exports](images/delete-exports.png)

{% hint style="info" %}
The exported archive files are saved to the Umbraco temp folder in the `Deploy\Export` sub-directory. This is a temporary (non-persistent) location, local to the backoffice server and therefore shouldn't be used for long-term storage of exports. You can also only download the file from the export dialog in the backoffice.
{% endhint %}

## Importing content and schema

Having previously exported content and schema to a zip file, you can import this into a new environment.

![Import (step 1)](images/import-modal.png)

You can upload the file via the browser.

Similar to when exporting, you can choose to import everything from the archive file, or only content, schema or files.

{% hint style="info" %}
Deploy does not touch the default maximum upload size, but you can [configure this yourself by following the CMS documentation](https://docs.umbraco.com/umbraco-cms/reference/configuration/maximumuploadsizesettings).
 On Umbraco Cloud, the upload size limit is 500 MB.
{% endhint %}

![Import (step 2)](images/import-modal-2.png)

We validate the file before importing. Schema items that content depends on must either be in the upload itself or already exist on the target environment with the same details. If there are any issues that mean the import cannot proceed, it will be reported. You may also be given warnings for review. You can choose to ignore these and proceed if they aren't relevant to the action you are carrying out.

The import then proceeds, processing all the items provided in the zip file.

![Import complete](images/import-complete.png)

Once complete or on close of the dialog, the imported file will be deleted from the server. If this is missed, perhaps via a closed browser, you can also delete archive files from the Umbraco Deploy dashboard in the _Settings_ section.

## Migrating whilst importing

It is possible to migrate schema and content whilst importing. For example, to change Data Type using Nested Content to Block List and ensure content data is imported to the correct Block Editor format.

Deploy contains base classes and implementations to handle common migrations that need to be registered in code, as explained in [Import with migrations](./import-with-migrations.md).

### Migrating from Umbraco 7

The import and export feature is not available in Deploy 2 for Umbraco 7. We have though released a package to allow creating an export. This needs to be done in code and requires additional legacy migrators to be able to import into a newer version. This is explained in [Migrating from Umbraco 7](./import-export-v7.md).

## Service details (programmatically importing and exporting)

Underlying the functionality of import/export with Deploy is the import/export service, defined by the `IArtifactImportExportService`.

You may have need to make use of this service directly if building something custom with the feature. For example you might want to import from or export to some custom storage.

The service interface defines two methods:

- `ExportArtifactsAsync` - takes a collection of artifacts and a storage provider defined by the `IArtifactExportProvider` interface. The artifacts are serialized and exported to storage.
  - `IArtifactExportProvider` defines methods for creating streams for writing serialized artifacts or files handled by Deploy (media, templates, stylesheets etc.).
- `ImportArtifactsAsync` - takes storage provider containing an import defined by the `IArtifactImportProvider` interface. The artifacts from storage are imported into Umbraco.
  - `IArtifactImportProvider` defines methods for creating streams for reading serialized artifacts or files handled by Deploy (media, templates, stylesheets etc.).

Implementations for `IArtifactExportProvider` and `IArtifactImportProvider` are provided for:

- A physical directory.
- An Umbraco file system.
- A zip file.

These are all accessible for use via extension methods available on `IArtifactImportExportService` found in the `Umbraco.Deploy.Infrastructure.Extensions` namespace.

The following example shows this service in use, importing and exporting from a zip file on startup:

<details>
<summary><code>ArtifactImportExportComposer.cs</code> (import and export on startup)</summary>

```csharp
using System.IO.Compression;
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Deploy;
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Extensions;
using Umbraco.Cms.Core.Notifications;
using Umbraco.Deploy.Core;
using Umbraco.Deploy.Core.Connectors.ServiceConnectors;
using Umbraco.Deploy.Infrastructure;
using Umbraco.Deploy.Infrastructure.Extensions;
​
internal class ArtifactImportExportComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
        => builder.AddNotificationAsyncHandler<UmbracoApplicationStartedNotification, ArtifactImportExportStartedAsyncHandler>();
​
    private sealed class ArtifactImportExportStartedAsyncHandler : INotificationAsyncHandler<UmbracoApplicationStartedNotification>
    {
        private readonly IHostEnvironment _hostEnvironment;
        private readonly IArtifactImportExportService _diskImportExportService;
        private readonly IServiceConnectorFactory _serviceConnectorFactory;
        private readonly IFileTypeCollection _fileTypeCollection;
​
        public ArtifactImportExportStartedAsyncHandler(IHostEnvironment hostEnvironment, IArtifactImportExportService diskImportExportService, IServiceConnectorFactory serviceConnectorFactory, IFileTypeCollection fileTypeCollection)
        {
            _hostEnvironment = hostEnvironment;
            _diskImportExportService = diskImportExportService;
            _serviceConnectorFactory = serviceConnectorFactory;
            _fileTypeCollection = fileTypeCollection;
        }
​
        public async Task HandleAsync(UmbracoApplicationStartedNotification notification, CancellationToken cancellationToken)
        {
            var deployPath = _hostEnvironment.MapPathContentRoot(Constants.SystemDirectories.Data + "/Deploy");
            await ImportAsync(Path.Combine(deployPath, "import.zip"));
​
            Directory.CreateDirectory(deployPath);
            await ExportAsync(Path.Combine(deployPath, $"export-{DateTimeOffset.UtcNow.ToUnixTimeSeconds()}.zip"));
        }
​
        private async Task ImportAsync(string zipFilePath)
        {
            if (File.Exists(zipFilePath))
            {
                using ZipArchive zipArchive = ZipFile.OpenRead(zipFilePath);
                await _diskImportExportService.ImportArtifactsAsync(zipArchive);
            }
        }
​
        private async Task ExportAsync(string zipFilePath)
        {
            using ZipArchive zipArchive = ZipFile.Open(zipFilePath, ZipArchiveMode.Create);
​
            IEnumerable<Udi> udis = DeployEntityTypes.GetEntityTypes(_fileTypeCollection, DeployEntityTypeCategories.ContentAndSchema).Select(Udi.Create);
            var contextCache = new DictionaryCache();
            string[] dependencyEntityTypes = DeployEntityTypes.GetEntityTypes(_fileTypeCollection, DeployEntityTypeCategories.All);
​
            await _diskImportExportService.ExportArtifactsAsync(_serviceConnectorFactory, udis, Constants.DeploySelector.ThisAndDescendants, contextCache, zipArchive, dependencyEntityTypes: dependencyEntityTypes);
        }
    }
}
```

</details>
