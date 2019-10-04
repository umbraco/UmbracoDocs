---
versionFrom: 7.0.0
---

# Azure Blob Storage on Umbraco Cloud

As Umbraco Cloud deployments are done using a web connection, large media deployments can be slow and are subject to timeouts and other restrictions associated with large uploads over a web connection.

If this sounds like you, you should evaluate the Azure Blob Storage provider. It has very few limitations and can result in better site performance as well as faster media loading times - especially if your media takes advantage of an Azure CDN.

## [FileSystemProviders: Azure Blob Storage](../../../Extending/FileSystemProviders/Azure-Blob-Storage)

Setting up Azure Blob Storage requires you to install a few packages and follow a few steps which we've outline in a thorough guide on how to set it up.

In this article you will find more specific information about setting up Azure Blob Storage on your Umbraco Cloud environments.

## Environment and Deployment considerations
By default this provider will use a single blob container for the media used by all sites in a project. So development and live will all use the same media files. If this works with your workflow it is the recommended configuration. If you cannot use the same media across all environments then you will need to set up a different blob storage container for each environments. Each container will have a unique address and access keys.

## Excluding media from deployments
This is not something that should be done unless you really have a good reason to do it. But if nothing works and you wish to deploy changes without getting a lot of errors related to media files you can set the following in the `~/config/UmbracoDeploy.Settings.config` file:
```xml
<?xml version="1.0" encoding="utf-8"?>
<settings xmlns="urn:umbracodeploy-settings">
  <excludedEntityTypes>
    <add type="media-file" />
  </excludedEntityTypes>
</settings>
```
