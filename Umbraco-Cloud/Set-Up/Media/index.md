---
versionFrom: 7.0.0
meta.Title: "Azure Blob Storage on Umbraco Cloud"
meta.Description: "All Media files for Umbraco Cloud projects are stored in Azure Blob Storage contaiers. Each environment has a separate container linked to it."
meta.RedirectLink: "/umbraco-cloud/setup/media"
---

# Media on Umbraco Cloud

All media files on your Umbraco Cloud projects are stored using Azure Blob Storage. This means that the media files are not stored with the rest of your project files but in an external storage system.

In order to access the media files on your Umbraco Cloud project you can either

* [Clone your Cloud environment to your local machine](../Working-Locally) (**Recommended**)
* [Connect using Azure Storage Explorer](Connect-to-Azure-Storage-Explorer)

## About Azure Blob Storage

Azure Blob Storage is an external storage system, that the Umbraco Cloud service uses to store all media files on Umbraco Cloud projects. This includes everything that is added to the Media library through the Umbraco backoffice, eg. images, PDFs, and other document formats.

You can learn more about what Azure Blob Storage is in [the official documentation on Microsoft Docs](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blobs-overview).

## Working with media locally

When you clone one of your Cloud environments to your local machine, you will need to run a content restore from the backoffice to get a copy of all the media files from the Azure Blob Storage container connected to that environment.

You can learn more about how this works in the [Restoring content](../../Deployment/Restoring-content) article.

When you add new media files to your project while working on a local clone, the files will automatically be added to the Azure Blob Storage container connected to the environment you deploy to.

## One storage per environment

Each environment on your Umbraco Cloud project has a separate Azure Blob Storage container. This means that each of your environments will be using a storage container specific to that environment.

When you deploy between two environments on your Umbraco Cloud project the media files will be copied from one storage to the other, depending on which environment is being transferred to and from.

As an example, imagine that you are transferring new content changes from your Development environment to your Live environment. When you initiate the transfer, all media files from the Azure Blog Storage container connected to your Development environment will be copied and pasted into the container connected to your Live environment. Once all content changes have also been transferred, and the transfer is complete, your Media libraries on the two environments will now be in sync.

## Media folder

You will notice that there is a Media (`/media`) folder in the root of your project files. This folder usually holds all media files associated with a Umbraco project. As your Umbraco Cloud environments are all configured with Azure Blob Storage, the media files are not in this media folder.

Instead, you will find a `web.config` file in the folder. This file is used to connect the Media library on your Cloud environment to an Azure Blob Storage container.

Below is an example of how the `/media/web.config` file should look by default.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
  <system.webServer>
    <handlers>
      <clear />
      <add name="AzureBlobStorageFile" path="*" verb="*" type="Umbraco.Cloud.StorageProviders.AzureBlob.FileHandler, Umbraco.Cloud.StorageProviders.AzureBlob" />
    </handlers>
  </system.webServer>
</configuration>
```

## Environment variables

In some cases, you might want to connect to your Azure Blob Storage container for the environments on your Umbraco Cloud project. This could be to clean up unwanted media files or to download the current contents of the library.

:::note
Instead of connecting to your Azure Blob Storage container using the following approach, you can clone your Cloud environment to your local machine and access the files from there.

You should only use the following approach, when you do not have the option to clone down the environment to your local machine.
:::

In order to do this, you need to know some details about the connection between the environment and the Azure Blob Storage containers. Below are the steps you need to follow, in order to locate the necessary variables:

1. Access [Kudu](../Power-Tools) on your Cloud environment.
2. Locate the "Environment" page in the top navigation.
3. Scroll to the section containing "Environment variables".

There is a total of 5 variables related to the Azure Blob Storage container on your environment:

* `APPSETTING_Umbraco.Cloud.AzureBlob.BlobStorageAccountName`
* `APPSETTING_Umbraco.Cloud.StorageProviders.AzureBlob.ContainerAlias`
* `APPSETTING_Umbraco.Cloud.StorageProviders.AzureBlob.ContainerName`
* `APPSETTING_Umbraco.Cloud.StorageProviders.AzureBlob.Endpoint`
* `APPSETTING_Umbraco.Cloud.StorageProviders.AzureBlob.SharedAccessSignature`

Once you have the variables, use the ["Connect to Azure Storage Explorer"](Connect-to-Azure-Storage-Explorer) guide to connect to your storage container. 

:::links
## Related articles
- [Rewrites will impact your media rendering as well - read about the best practices in here](https://our.umbraco.com/documentation/Umbraco-Cloud/Set-Up/Manage-Hostnames/Rewrites-on-Cloud/)
- [To get the media files from Blob storage in a stream, you can use the IMediaFileSystem interface - read more about that here](https://our.umbraco.com/Documentation/Reference/Config/fileSystemProviders/#get-the-contents-of-a-file-as-a-stream)
:::
