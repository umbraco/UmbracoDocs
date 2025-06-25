---
description: >-
  All Media files for Umbraco Cloud projects are stored in Azure Blob Storage
  containers. Each environment has a separate container linked to it.
---

# Media

All media files on your Umbraco Cloud projects are stored using Azure Blob Storage. This means that the media files are not stored with the rest of your project files but in an external storage system.

To access the media files on your Umbraco Cloud project you can either:

* [Clone your Cloud environment to your local machine](build-and-customize-your-solution/working-locally.md) (**Recommended**)
* [Connect using Azure Storage Explorer](azure-blob-storage/connect-to-azure-storage-explorer.md)

## About Azure Blob Storage <a href="#about-azure-blob-storage" id="about-azure-blob-storage"></a>

Azure Blob Storage is an external storage system, that the Umbraco Cloud service uses to store all media files on Umbraco Cloud projects. To learn how you can connect to your Blob Storages, read the [Azure Blob Storage](azure-blob-storage/) article.

## Working with media locally

When you clone one of your Cloud environments to your local machine, you will need to run a content restore from the backoffice to get a copy of all the media files from the Azure Blob Storage container connected to that environment.

You can learn more about how this works in the [Restoring content](restoring-content.md) article.

When you add new media files to your project while working on a local clone, the files will automatically be added to the Azure Blob Storage container connected to the environment you deploy to.

## One Storage per Environment

Each environment on your Umbraco Cloud project has a separate Azure Blob Storage container. Each of your environments uses a storage container specific to that environment.

When you deploy between two environments on your Umbraco Cloud project the media files will be copied from one storage to the other, depending on which environment is being transferred to and from.

As an example, imagine that you are transferring new content changes from your left-most mainline environment to your Live environment. When you initiate the transfer, all media files from the Azure Blob Storage container connected to your left-most mainline environment will be copied and pasted into the container connected to your Live environment. Once all content changes have also been transferred, and the transfer is complete, your Media libraries on the two environments will now be in sync.

## Media Folder

You will notice that there is a Media (`wwwroot/media`) folder in your project files. This folder usually holds all media files associated with a Umbraco project. As your Umbraco Cloud environments are all configured with Azure Blob Storage, the media files are not in this media folder.

Instead, you will find a `project.assets.json` file in the `obj` folder. This file is used to connect the Media library on your Cloud environment to an Azure Blob Storage container.

## Environment Variables

In some cases, you might want to connect to your Azure Blob Storage container for the environments on your Umbraco Cloud project. This could be to clean up unwanted media files or to download the current contents of the library.

{% hint style="info" %}
Instead of connecting to your Azure Blob Storage container using the following approach, you can clone your Cloud environment to your local machine and access the files from there.

You should only use the following approach when you do not have the option to clone down the environment to your local machine.
{% endhint %}

To do this, you need to know some details about the connection between the environment and the Azure Blob Storage containers. Below are the steps you need to follow, to locate the necessary variables:

1. Access [Kudu](power-tools/) on your Cloud environment.
2. Locate the **Environment** page in the top navigation.
3. Scroll to the section containing **Environment variables**.

There are 4 variables related to the Azure Blob Storage container in your environment:

* `APPSETTING_UMBRACO__CLOUD__STORAGE__AZUREBLOB__CONTAINERALIAS`
* `APPSETTING_UMBRACO__CLOUD__STORAGE__AZUREBLOB__CONTAINERNAME`
* `APPSETTING_UMBRACO__CLOUD__STORAGE__AZUREBLOB__ENDPOINT`
* `APPSETTING_UMBRACO__CLOUD__STORAGE__AZUREBLOB__SHAREDACCESSSIGNATURE`

Once you have the variables, use the ["Connect to Azure Storage Explorer"](azure-blob-storage/connect-to-azure-storage-explorer.md) guide to connect to your storage container.

## Related Articles

* [Rewrites will impact your media rendering as well - read about the best practices](going-live/manage-hostnames/rewrites-on-cloud.md)
* [To get the media files from Blob storage in a stream, you can use the IMediaFileSystem interface](https://docs.umbraco.com/umbraco-cms/reference/configuration/filesystemproviders#get-the-contents-of-a-file-as-a-stream)
