---
versionFrom: 8.0.0
---

# Connect to Azure Storage Explorer to upload files manually

In case you want to manually upload files to the Azure Blob Storage container provided to your Umbraco Cloud environments, you can take advantage of the "Microsoft Azure Storage Explorer" software.

This article provides the steps you need, in order to connect to your Azure Blob Storage containers using Azure Storage Explorer.

:::warning
**Important**: If you upload your media files manually using this method, they will not be available in the backoffice.

All media needs to be added through the Umbraco backoffice.
:::

## Getting the credentials

The first thing to sort out, if you want to connect to the Azure Blob Storage container of your environment is the credentials. You can find the credentials in [Kudu (Power Tools)](../../Power-Tools) - under the "Environment" section.

In the environment section, we want to locate the "Environment Variables" and find the following three variables:

* `APPSETTING_Umbraco.Cloud.StorageProviders.AzureBlob.ContainerName`,
* `APPSETTING_Umbraco.Cloud.StorageProviders.AzureBlob.Endpoint`, and
* `APPSETTING_Umbraco.Cloud.StorageProviders.AzureBlob.SharedAccessSignature`.

Note these down, as we will use them in the upcoming steps.

## Installing Azure Storage Explorer

The next order of business is to have Azure Storage Explorer installed on your local computer. [Download the files from this page](https://azure.microsoft.com/en-us/features/storage-explorer/), and run through the installer.

## Connecting to your Azure Blob Storage

In the following, we will use the information you have gathered, and Azure Storage Explorer to get you connected to your Blob storage container.

1. Click the "Open connect dialogue" button to get the Connect dialogue.

    ![Connect my machine](images/storage-explorer-connection.png)

2. Select "Use a shared access signature (SAS) URI" in the first prompt.

    ![Use a shared access signature (SAS) URI](images/select-connection.png)

3. Input the information you have gathered earlier in the following format `[Endpoint][ContainerName][SharedAccessSignature]`, in the URI field. See below for an example.

    ```xml
    https://ucmediastoragewelive.blob.core.windows.net/0e6ee123-5q22-1234-8618-ae7d0043710f?sv=2017-04-17&sr=c&si=umbraco&sig=f84%2F%2FRPPirgdzn15a%2BA12345678901%2FXA%3D&spr=https
    ```

    ![Attach with SAS URI](images/attach-blob.png)

4. Ensure that the credentials are correctly set in the "Connection Summary" prompt.

5. Select "Connect".

6. Open the media folder, and you now have access to the Azure Blob Storage container for your environment.

    ![Open media folder](images/storage-explorer-connected.png)
