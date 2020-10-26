---
versionFrom: 7.0.0
---

# Setup Your Site to use Azure Blob Storage for Media and Image Processor Cache

For Umbraco sites there are some scenarios when you may want, or need, to consider using Azure Blob Storage for your media.  Particularly if your site contains large amounts of media.  Having your site’s media in Azure Storage can also help your deployments complete more quickly and has the potential to positively affect site performance as the Image Processor cache is moved to Azure Blob Storage.  It also allows you to serve your media from the Azure CDN.

Setup consists of adding several packages to your site and setting the correct configuration. Before you begin you’ll need to create an Azure Storage Account and a container for your media and your ImageProcessor cache as well.  In this example we assume your media container is “media” and your cache is “cache”.  You can, optionally, enable an Azure CDN for this storage container and use it in the cache.config below.

## Packages

These packages are only available via NuGet, so ideally you’ll have your site setup to use Visual Studio. You can copy/paste the `PM>` commands into the Package Manager Console. If you don't see the Package Manager Console window, you can open it from the menu View -> Other Windows -> Package Manager Console.

### File System Provider for Azure Blob Storage

You’ll replace the default FileSystemProvider with the `UmbracoFileSystemProviders.Azure` provider.  We recommend doing this first and verifying it behaves as expected before proceeding with the ImageProcessor setup.

```PM> Install-Package UmbracoFileSystemProviders.Azure```

The package is also available on [Our Umbraco](https://our.umbraco.com/projects/collaboration/umbracofilesystemprovidersazure/)
The project source can be found here [https://github.com/JimBobSquarePants/UmbracoFileSystemProviders.Azure](https://github.com/JimBobSquarePants/UmbracoFileSystemProviders.Azure)

There are detailed instructions available on the project page, also summarized here.

Update `~/Config/FileSystemProviders.config` replacing the default provider with the following:

```xml
<?xml version="1.0"?>
<FileSystemProviders>
  <!-- Media -->
  <Provider alias="media" type="Our.Umbraco.FileSystemProviders.Azure.AzureBlobFileSystem, Our.Umbraco.FileSystemProviders.Azure">
    <Parameters>
    <add key="containerName" value="media"/>
    <add key="rootUrl" value="http://[myAccountName].blob.core.windows.net/"/>
    <add key="connectionString" value="DefaultEndpointsProtocol=https;AccountName=[myAccountName];AccountKey=[myAccountKey]"/>
    <!--
        Optional configuration value determining the maximum number of days to cache items in the browser.
        Defaults to 365 days.
    -->
    <add key="maxDays" value="365"/>
    <!--
        When true this allows the VirtualPathProvider to use the default "media" route prefix regardless
        of the container name.
    -->
    <add key="useDefaultRoute" value="true"/>
    <!--
        When true blob containers will be private instead of public what means that you can't access the original blob file directly from its blob url.
    -->
    <add key="usePrivateContainer" value="false"/>
    </Parameters>
  </Provider>
</FileSystemProviders>
```

If you are using IISExpress (as with Visual Studio) you’ll need to add a static file handler mapping to `~web.config` - this should be added automatically, but you should check that it's there.

```xml
<?xml version="1.0"?>
  <configuration>
    <location path="Media">
    <system.webServer>
        <handlers>
        <remove name="StaticFileHandler" />
        <add name="StaticFileHandler" path="*" verb="*" preCondition="integratedMode" type="System.Web.StaticFileHandler" />
        </handlers>
    </system.webServer>
    </location>
  </configuration>
```

### ImageProcessor

The ImageProcessor is already a part of Umbraco.

Are you using a version of Umbraco older than v7.6, installing the FileSystemProvider will give you a warning and you will need to update ImageProcessor.Web and install ImageProcessor.Web.Config from NuGet.

To update ImageProcessor.Web:
```PM> Update-Package ImageProcessor.Web```

To install ImageProcessor.Web.Config:
```PM> Install-Package ImageProcessor.Web.Config```

### Configuration

Once the package(s) have been installed you need to set your configuration as below.

**Update `~web.config`**

```xml
<configuration>
  <configSections>
    <sectionGroup name="imageProcessor">
    <section name="security" requirePermission="false" type="ImageProcessor.Web.Configuration.ImageSecuritySection, ImageProcessor.Web" />
    <section name="processing" requirePermission="false" type="ImageProcessor.Web.Configuration.ImageProcessingSection, ImageProcessor.Web" />
    <section name="caching" requirePermission="false" type="ImageProcessor.Web.Configuration.ImageCacheSection, ImageProcessor.Web" />
    </sectionGroup>
  </configSections>
  <imageProcessor>
    <security configSource="config\imageprocessor\security.config" />
    <caching configSource="config\imageprocessor\cache.config" />
    <processing configSource="config\imageprocessor\processing.config" />
    </imageProcessor>
</configuration>
```

**Update `~/config/imageprocessor/security.config`**

You have to manually add `prefix="media/"` to the service element, otherwise ImageProcessor will not run and the original image will be served.

```xml
<?xml version="1.0" encoding="utf-8"?>
<security>
  <services>
    <!--<service name="LocalFileImageService" type="ImageProcessor.Web.Services.LocalFileImageService, ImageProcessor.Web" />-->
    <service prefix="media/" name="CloudImageService" type="ImageProcessor.Web.Services.CloudImageService, ImageProcessor.Web">
    <settings>
        <setting key="Container" value="[container name]"/>
        <setting key="MaxBytes" value="8194304"/>
        <setting key="Timeout" value="30000"/>
        <setting key="Host" value="https://[your blob account].blob.core.windows.net/"/>
    </settings>
    </service>
    <service prefix="remote.axd" name="RemoteImageService" type="ImageProcessor.Web.Services.RemoteImageService, ImageProcessor.Web">
    <settings>
        <setting key="MaxBytes" value="4194304" />
        <setting key="Timeout" value="3000" />
        <setting key="Protocol" value="http" />
    </settings>
    <whitelist>
        <add url="https://[your Azure CDN].vo.msecnd.net/" />
        <add url="https://[your blob account].blob.core.windows.net/" />
        <add url="https://[your Umbraco site]" />
        <add url="http://localhost" />
        <add url="http://127.0.0.1" />
    </whitelist>
    </service>
  </services>
</security>
```

You have now successfully setup Azure Blob Storage with your Umbraco site.

## Existing Media files

Any media files you already have on your site will not automatically be added to the Blob Storage. You will need to copy the contents on the `/Media` folder and upload it to the `media` folder on your Blob account. Once you've done that you can safely delete the `/Media` folder locally, as it is no longer needed.

Any new media files you upload to the site, will automatically be added to the Blob Storage.

## Using Azure Blob Cache

In some cases, you might also want to use the Azure Blob Cache to cache your media files. One scenario for this could be a load balancing setup where you have a lot of media files. Using the Azure Blob Cache will make sure that your media files are still cached and can be used effectively as the generated images are stored to blobs and served via a CDN instead of local disk.

More information on can be found on the ImageProcessor website: [Azure Blob Cache](https://imageprocessor.org/imageprocessor-web/plugins/azure-blob-cache/).
