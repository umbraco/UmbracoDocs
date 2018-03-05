# FileSystemProviders.config

The `fileSystemProviders.config` file contains the configuration for the file system providers used by Umbraco to interact with file systems.

Following is the configuration installed with Umbraco.


  <?xml version="1.0"?>
  <FileSystemProviders>

    <!-- Media -->
    <Provider alias="media" type="Umbraco.Core.IO.PhysicalFileSystem, Umbraco.Core">
      <Parameters>
        <add key="virtualRoot" value="~/media/" />
      </Parameters>
    </Provider>

  </FileSystemProviders>


The media provider can be of many types, for example in case you want to store media on Azure, Amazon or even DB. But the provider that comes by default with the installation of Umbraco is the `PhysicalFileSystem` provider.

## PhysicalFileSystem Configuration

The physical file system provider manages the interaction of Umbraco with the local file system. It can be configured for two different scenarios:

 - media files stored inside a virtual folder of the site
 - media files stored somewhere else outside of the site and accessed via a custom url
 
### Virtual Folder
To configure the PhysicalFileSystem to work with a virtual folder there not much to do, just change the value of the `virtualRoot` parameter to the virtual folder you want to use. By default it is configured to store media files in  `~/media`.

  <add key="virtualRoot" value="~/media/" />


### Physical path
If you want to store the media files in a separate folder, outside of the Umbraco website, maybe on a NAS/SAN you have to remove the `virtualRoot` property and add two new properties:

 - `rootPath` is the full filesystem path where you want media files to be stored. It has to be rooted, must use directory separators (`\`) and must not end with a separator. For example, `Z:` or `C:\path\to\folder` or `\\servername\path`.
 - `rootUrl` is the url where the files will be accessible from. It must use url separators (`/`) and must not end with a separator. It can either be just a folder, like `/UmbracoMedia`, in which case it will considered as subfolder of the main domain (`example.com/UmbracoMedia`) or can be a fully qualified url, with also domain name and protocol (for ex `http://media.example.com/media`).
 

   <Provider alias="media" type="Umbraco.Core.IO.PhysicalFileSystem, Umbraco.Core">
    <Parameters>
      <add key="rootPath" value="Z:\Storage\UmbracoMedia" />
      <add key="rootUrl" value="http://media.example.com/media" />
    </Parameters>
  </Provider>


## Custom providers
To store media files in different systems, the type of provider must be changed. You can learn [how to build a custom filesystem provider](/documentation/Extending/Custom-File-Systems) in the Extending Umbraco section.

## Note
At the moment when a file is saved, its full url is stored as node property, so a configuration change will not apply to pre-existing media files but only to the ones saved after that.

If you want all your media files in the same location you have to copy all pre-existing files to the new path, and update the `path` property of the media item to the new url. This can be either directly inside the database or by using the `MediaService`.
