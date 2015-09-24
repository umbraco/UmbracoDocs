#Media in Umbraco as a Service
We'll cover the optional use of Azure Blob Storage for your media and why you may want or need to consider this. In general, you can use Umbraco media with the default configuration for your sites. If you have many images, your images are very large in size, or you store large video files as part of your site you'll want to consider using the Azure Blob Storage provider for Umbraco.

[More information](https://our.umbraco.org/projects/backoffice-extensions/azure-blob-storage-provider) 	

##Media and Deployment
As Umbraco as a Service deployments are done using a web connection, large media deployments can be slow and are subject to timeouts and other restrictions associated with large uploads over a web connection.

If this sounds like you, you should evaluate the Azure Blob Storage provider. It is relatively simple to setup, has very few limitations and can result in better site performance as well as faster media loading times - especially if your media takes advantage of an Azure, or other, CDN.

##Setup
You can find details on how to setup and configure the Azure Blob Storage provider [here](https://our.umbraco.org/projects/backoffice-extensions/azure-blob-storage-provider).

At the time this documentation was updated (July 2015) there are a few items to be aware of when considering using this provider.

- You will need to create your own Azure Storage container or contact us if you are on an Enterprise plan that may include this
- You can not mix this provider with the default provider
- This provider works **really** well with [ImageProcessor.Web plugin for Azure cache]
(http://imageprocessor.org/imageprocessor-web/plugins/azure-blob-cache/)
- The CropUp package does not work properly with this provider
- Copy of document types with an upload field as a property will not work.

##Environment and Deployment considerations
By default this provider will use a single blob container for the media used by all sites in a project. So development, staging, a live will all use the same media files. If this works with your workflow it is the recommended configuration. If you cannot use the same media across all environments then you will need to set up a different blob storage container for each environments. Each container will have a unique address and access keys.

A common arrangement for Umbraco as a Service users who use the Azure Blob Storage provider and cannot use the same container for all environments is to create one container for development/staging and one for live. The specific container settings are then applied to development/staging environments and to the live environment.

When Umbraco as a Service deploys media it will use the settings for each environment to create or update the media in the correct container.
