#Setup Your UaaS site to use Azure Storage for Media and Image Processor Cache
For UaaS sites there are some scenarios when you may want, or need, to consider using Azure Blob Storage for your media.  Particularly if your site contains large amounts of media - about 1GB or more.  Having your site’s media in Azure Storage can also help your deployments complete more quickly and has the potential to positively affect site performance as the Image Processor cache is moved to Azure Storage.  It also allows you to easily serve your media from the Azure CDN.

Setup consists of adding several packages to your site and setting the correct configuration.  Of course, before you begin you’ll need to create an Azure Storage Account and a container for your media and your ImageProcessor cache as well.  In this example we assume your media container is “media” and your cache is “cache”.  You can, optionally, enable an Azure CDN for this storage container and use it in the cache.config below.	

##Media and Deployment
As Umbraco as a Service deployments are done using a web connection, large media deployments can be slow and are subject to timeouts and other restrictions associated with large uploads over a web connection.

If this sounds like you, you should evaluate the Azure Blob Storage provider. It is relatively simple to setup, has very few limitations and can result in better site performance as well as faster media loading times - especially if your media takes advantage of an Azure, or other, CDN.

##Setup
###Packages
####File System Provider for Azure Blob Storage
You’ll replace the default FileSystemProvider with the `Our.Umbraco.FileSystemProviders.Azure.AzureBlobFileSystem` provider.  We recommend doing this first and verifying it behaves as expected before proceeding with the ImageProcessor setup.

Currently this package is available by source code or MyGet:  [https://github.com/JimBobSquarePants/UmbracoFileSystemProviders.Azure](https://github.com/JimBobSquarePants/UmbracoFileSystemProviders.Azure)

There are detailed instructions available on the project page, also summarized here.

Update `~/Config/FileSystemProviders.config` replacing the default provider with the following:
<?xml version="1.0"?>
<FileSystemProviders>
  <Provider alias="media" type="Our.Umbraco.FileSystemProviders.Azure.AzureBlobFileSystem, Our.Umbraco.FileSystemProviders.Azure">
    <Parameters>
      <add key="containerName" value="media" />
      <add key="rootUrl" value="http://[myAccountName].blob.core.windows.net/" />
      <add key="connectionString" value="DefaultEndpointsProtocol=https;AccountName=[myAccountName];AccountKey=[myAccountKey]"/>
      <!--Optional configuration value determining the maximum number of days to cache items in the browser. Defaults to 365 days. -->
      <add key="maxDays" value="365" />
    </Parameters>
  </Provider>
</FileSystemProviders>

In order to use Azure Storage for the ImageProcessor cache, you'll also need the following in `~web.config`

<?xml version="1.0"?>
<configuration>
  <appSettings>
    <!--Disables the built in Virtual Path Provider which allows for relative paths-->
    <add key="AzureBlobFileSystem.DisableVirtualPathProvider" value="true" />
</configuration>

If you are using IISExpress (as with Visual Studio or WebMatrix) you’ll also need to add a static file handler mapping to `~web.config`

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


##Environment and Deployment considerations
By default this provider will use a single blob container for the media used by all sites in a project. So development and live will all use the same media files. If this works with your workflow it is the recommended configuration. If you cannot use the same media across all environments then you will need to set up a different blob storage container for each environments. Each container will have a unique address and access keys.