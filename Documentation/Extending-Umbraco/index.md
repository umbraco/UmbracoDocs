#Extending Umbraco

##[Dashboards](Dashboards/index.md)

A Dashboard is a component for displaying elements on the right-hand side of the backoffice UI area.

##[Version 7+ assets](version7-assets.md)

Version 7+ specific information on extending Umbraco, details such as dealing with server variables, service URLs, JavaScript and CSS assets, etc....

##[Sections & Trees](Section-Trees/index.md)

The Umbraco back office consists of sections (sometimes referred to as applications) which contain trees. For example, when you load the back office you'll see that the 'Content' section contains one tree: the content tree whereas the 'Settings' section contains a number of trees: Stylesheets, Content Types, Media Types, etc...

Both sections and trees can be created to extend Umbraco.

##[Property Editors](Property-Editors/index.md)

A property editor is the editor used to insert content into Umbraco. [See here for definition.](../using-umbraco/backoffice-overview/property-editors/index.md)

This section will describe how to work with and create Property Editors.

##[Macro Parameter Editors](Macro-Parameter-Editors/index.md)

A Parameter Editor is the editor used to insert values into a [Macro](../reference/templating/macros/index.md).

This section will describe how to work with and create Parameter Editors.

##[Packaging](Packaging/index.md)

Information on the packaging manifest format and how assets should be packaged as a zip file for easy distribution
**(coming soon)**

##Menu items

*coming soon*

##Image Url providers

*coming soon*

##Thumbnail providers

*coming soon*

##Custom file systems (IFileSystem)

By default, Umbraco uses an instance of *PhysicalFileSystem* to handle the media archive. The configuration for this can be found in */config/FileSystemProviders.config*:

    <Provider alias="media" type="Umbraco.Core.IO.PhysicalFileSystem, Umbraco.Core">
        <Parameters>
            <add key="virtualRoot" value="~/media/" />
        </Parameters>
    </Provider>
    
*PhysicalFileSystem* implements the *IFileSystem* interface, and it is possible to replace it with a custom class - eg. if you want your media files stored on Azure or something similar.

If you need access to the instance of IFileSystem, this can be archieved through the following code:

    IFileSystem fs = FileSystemProviderManager.Current.GetUnderlyingFileSystemProvider("media");
    
Both *IFileSystem* and *FileSystemProviderManager* are located in the *Umbraco.Core.IO* namespace.

**Custom providers**

[Azure Blob Storage Provider](http://our.umbraco.org/projects/backoffice-extensions/azure-blob-storage-provider) by Dirk Seefeld
