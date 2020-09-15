---
versionFrom: 8.0.0
---

# Connect to Azure Storage Explorer to upload files manually

:::note
**Important**: All Umbraco 8 projects created after May 6th 2020 will have Azure Blob Storage by default. That means that this guide only applies to your project has been created after May 6th 2020.
:::

In case you want to manually upload files to the blob storage provided to your site, you can take advantage of the software "Microsoft Azure Storage Explorer".

:::warning
**Important**: If you upload your media files manually using this method, they will not be available in the backoffice.
:::

## Getting the credentials
The first thing to sort out, if you want to connect to the blob storage of your site is the credentials of your site. You can find the credentials in KUDU (Power Tools) - under the "Environment" section.

In the environment section, we want to locate the "Environment Variables" and find the following three variables: 

* `APPSETTING_Umbraco.Cloud.StorageProviders.AzureBlob.ContainerName`
* `APPSETTING_Umbraco.Cloud.StorageProviders.AzureBlob.Endpoint` and 
* `APPSETTING_Umbraco.Cloud.StorageProviders.AzureBlob.SharedAccessSignature`. 

Note these down, as we will use them in the upcoming steps.

## Installing Azure Storage Explorer
Next order of business is to have Azure Storage Explorer installed on your local computer. [Download the files from this page](https://azure.microsoft.com/en-us/features/storage-explorer/), and install it on your local machine.

## Connecting to your Azure Blob Storage
In the following we will use the information you have gathered, and Azure Storage Explorer to get you connected to your Blob storage.

1. Click the "Open connect dialogue" button to get the connect dialogue

    ![Connect my machine](images/storage-explorer-connection.png)

2. Select "Use a shared access signature (SAS) URI" in the first prompt
    
    ![Use a shared access signature (SAS) URI](images/select-connection.png)

3. In the URI field, input the information you have gathered earlier in the following format `[Endpoint][ContainerName][SharedAccessSignature]` like the following 

```
https://ucmediastoragewelive.blob.core.windows.net/0e6ee123-5q22-1234-8618-ae7d0043710f?sv=2017-04-17&sr=c&si=umbraco&sig=f84%2F%2FRPPirgdzn15a%2BA12345678901%2FXA%3D&spr=https
```

  ![Attach with SAS URI](images/attach-blob.png)

4. In the "Connection Summary" prompt, ensure that the credentials are correct and press "Connect"

5. Open the media folder, and you now have access to your blob storage account.

    ![Open media folder](images/storage-explorer-connected.png)
