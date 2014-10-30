#Custom file systems (IFileSystem)

By default, Umbraco uses an instance of `PhysicalFileSystem` to handle the media archive. The configuration for this can be found in `/config/FileSystemProviders.config`.

    <Provider alias="media" type="Umbraco.Core.IO.PhysicalFileSystem, Umbraco.Core">
        <Parameters>
            <add key="virtualRoot" value="~/media/" />
        </Parameters>
    </Provider>
    
`PhysicalFileSystem` implements the `IFileSystem` interface, and it is possible to replace it with a custom class - eg. if you want your media files stored on Azure or something similar.

If you configure Umbraco to use a custom file system provider for media, you most likely won't need to access the implementation directly. Umbraco uses a wrapper class called `MediaFileSystem`. Uou can get a reference to this wrapper class with the following code:

    MediaFileSystem media = FileSystemProviderManager.Current.GetFileSystemProvider<MediaFileSystem>();

This will be enough in most cases and is the way Umbraco will access the file system provider. The wrapper class implements the same interface `IFileSystem` as any custom providers should do, so you will be able to call the same methods.

If your custom file system provider has some extra logic that you need to access, you can of course get a reference to the actual instance of IFileSystem. This can be archieved through the following code:

    IFileSystem fs = FileSystemProviderManager.Current.GetUnderlyingFileSystemProvider("media");
    
Or alternately something like:

    CustomFileSystem fs = FileSystemProviderManager.Current.GetUnderlyingFileSystemProvider("media") as CustomFileSystem;
    
    if (fs != null) {
        // Do some stuff here
    }
    
Both `IFileSystem` and `FileSystemProviderManager` are located in the `Umbraco.Core.IO` namespace.

**Custom providers**

[Azure Blob Storage Provider](http://our.umbraco.org/projects/backoffice-extensions/azure-blob-storage-provider) by Dirk Seefeld
