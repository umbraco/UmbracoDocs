---
description: >-
  If you want to manually upload files to the Azure Blob Storage container
  provided to your Cloud environments, you can use "Microsoft Azure Storage
  Explorer" software.
---

# Connect to Azure Storage Explorer to upload files manually

This article provides the steps you need, to connect to your Azure Blob Storage containers using Azure Storage Explorer.

{% hint style="warning" %}
It is **strongly** recommend that you add all the media items to your Cloud environments through the backoffice. Clone your environment to your local machine to manage the files of your media library.

**Important**: If you upload your media files manually using this method, they will not be available in the backoffice.

All media needs to be added through the Umbraco backoffice.
{% endhint %}

## Getting the credentials

The first thing to sort out, if you want to connect to the Azure Blob Storage container of your environment is the credentials.

To find the connection details for your environment's Blob Storage, follow the steps below:

1. Go to your project on Umbraco Cloud.
2. Go to **Configuration** in the side menu.
3. Go to **Connections.**
4. Scroll down to **Blob Storage Connection Details**
5. Copy down the credentials needed for connecting to Azure Blob Storage.

## Installing Azure Storage Explorer

The next step is to have Azure Storage Explorer installed on your local computer. [Download the storage explorer](https://azure.microsoft.com/en-us/features/storage-explorer/), and run through the installer.

### Configuring the Connection to your Azure Blob Storage

Let's use the information you have gathered, and connect Azure Storage Explorer to the Blob storage container:

1. Click the **Open Connect Dialog** button to get the Connect dialogue.

![Connect my machine](../images/storage-explorer-connection.png)

2. Select the **Blob container** in the first prompt.

<figure><img src="../../../../.gitbook/assets/image (84).png" alt="Select blob container"><figcaption><p>Blob container</p></figcaption></figure>

3. Select **Shared access signature (SAS) URL** in the second prompt.

<figure><img src="../../../../.gitbook/assets/image (85).png" alt="Shared access signature (SAS) URL"><figcaption><p>Shared access signature (SAS) URL</p></figcaption></figure>

4. Input the information you have gathered earlier in the following format `[Endpoint][ContainerName][SharedAccessSignature]`, in the URI field. See below for an example.

```xml
https://ucmediastoragewelive.blob.core.windows.net/92f27eee-eb18-445e-b9e4-c7a98bd209c0?sv=2019-07-07&sr=c&si=umbraco&sig=U92YZXOdzhp7JFLzj6MH%2BeugDgEelgzpB56o1XfD1%2BU%3D&spr=https
```

<figure><img src="../../../../.gitbook/assets/image (86).png" alt="Attach with SAS URI"><figcaption><p>Attach with SAS URI</p></figcaption></figure>

5. Ensure that the credentials are correctly set in the **Connection Summary** prompt.
6. Select **Connect**.

You are now connected to the blob storage for your environment and you can upload your files to Azure Blob Storage through the explorer.

![Open media folder](../images/storage-explorer-connected.png)

{% hint style="warning" %}
**Important**: If you upload your media files manually using this method, they will not be available in the backoffice.

All media needs to be added through the Umbraco backoffice.
{% endhint %}
