---
description: "All Media files for Umbraco Cloud projects are stored in Azure Blob Storage containers. Each environment has a separate container linked to it."
---

# Connect to Azure Storage Explorer to upload files manually

In case, you want to manually upload files to the Azure Blob Storage container provided to your Umbraco Cloud environments, you can take advantage of the "Microsoft Azure Storage Explorer" software.

This article provides the steps you need, to connect to your Azure Blob Storage containers using Azure Storage Explorer.

{% hint style="warning" %}
We strongly recommend that you add all the media items to your Cloud environments through the backoffice. Clone your environment to your local machine to manage the files of your media library.

**Important**: If you upload your media files manually using this method, they will not be available in the backoffice.

All media needs to be added through the Umbraco backoffice.
{% endhint %}

## Getting the credentials

The first thing to sort out, if you want to connect to the Azure Blob Storage container of your environment is the credentials. You can find the credentials under the **Connection Details**`section from the **Settings** dropdown on the Umbraco Cloud portal for your Umbraco Cloud project.

![Blob storage connection details GIF](images/blob.gif)

## Installing Azure Storage Explorer

The next step is to have Azure Storage Explorer installed on your local computer. [Download the storage explorer](https://azure.microsoft.com/en-us/features/storage-explorer/), and run through the installer.

### Configuring the Connection to your Azure Blob Storage

Let's use the information you have gathered, and connect Azure Storage Explorer to the Blob storage container:

1. Click the **Open connect dialogue** button to get the Connect dialogue.

    ![Connect my machine](images/storage-explorer-connection.png)

2. Select **Blob container** in the first prompt.

    ![Blob container](images/select-resource.png)

3. Select **Shared access signature URL (SAS)** in the second prompt.

    ![Shared access signature URL (SAS)](images/select-shared-access-signature.png)

4. Input the information you have gathered earlier in the following format `[Endpoint][ContainerName][SharedAccessSignature]`, in the URI field. See below for an example.

    ```xml
    https://ucmediastoragewelive.blob.core.windows.net/92f27eee-eb18-445e-b9e4-c7a98bd209c0?sv=2019-07-07&sr=c&si=umbraco&sig=U92YZXOdzhp7JFLzj6MH%2BeugDgEelgzpB56o1XfD1%2BU%3D&spr=https
    ```

    ![Attach with SAS URI](images/connection-info.png)

5. Ensure that the credentials are correctly set in the **Connection Summary** prompt.

6. Select **Connect**.

7. Open the media folder. You now have access to the Azure Blob Storage container for your environment.

    ![Open media folder](images/storage-explorer-connected.png)
