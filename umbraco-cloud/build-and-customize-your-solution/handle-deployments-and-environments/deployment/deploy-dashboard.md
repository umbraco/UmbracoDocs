---
description: >-
  With the Deploy Dashboard, we have made it possible to get an overview of your
  Umbraco Deploy installation and perform Deploy operations.
---

# Deploy Dashboard

In this article, we will show the different sections on the Deploy dashboard and how they can be used.

## Deploy Status

Here you can see whether the latest deployment has been completed or failed. You can see the version of Umbraco Deploy you are running, and the last time an operation was run.

<figure><img src="images/image (8).png" alt=""><figcaption><p>Umbraco Deploy status</p></figcaption></figure>

## Deploy Operations

With the Deploy operations, you can run different operations in Umbraco Deploy.

<figure><img src="images/image (3).png" alt=""><figcaption><p>The different Deploy operations.</p></figcaption></figure>

Below you can read what each operation will do when run through the dashboard.

### Update Umbraco Schema From Data Files

Running this operation will update the Umbraco Schema based on the information in the `.uda` files on disk.

### Export Schema To Data Files

Running this operation will extract the schema from Umbraco and output it to the `.uda` files on disk.

### Clear Cached Signatures

Running this operation will clear the cached artifact signatures from the Umbraco environment. This should not be necessary, however, it may resolve reports of schema mismatches when transferring content that has been aligned.

### Set Cached Signatures

This operation will set the cached artifact signatures for all entities within the Umbraco environment. Use this when signatures have been cleared and you want to ensure they are pre-generated before attempting a potentially longer restore or transfer operation.

## Download Deploy Artifacts

Running this operation will download a zip file with all the Deploy artifacts representing the Umbraco schema in the form of `.uda` files.

This operation is useful if you want to move to another Umbraco instance and migrate the data with you.

<figure><img src="images/image (9).png" alt=""><figcaption><p>Download the Deploy artifacts</p></figcaption></figure>

## Configuration Details

In the Configuration details, you can see how Umbraco Deploy has been [configured](https://docs.umbraco.com/umbraco-deploy/deploy-settings) on your environment. You get an overview of the Setting options, the current value(s), and notes help you understand each of the settings. Updates to the need to be applied in the `appsettings.json` file.

<figure><img src="images/image (2).png" alt=""><figcaption><p>Example of Umbraco Deploy configuration.</p></figcaption></figure>

## Schema Comparison

The Schema Comparison table shows the schema information managed by Umbraco Deploy.

You can see a comparison between the information that is held in Umbraco and the information in the `.uda` files on disk.

The table shows:

* The name of the schema
* The file name
* Whether the file exists in Umbraco
* Whether the file exists
* Whether the file is up-to-date

<figure><img src="images/image (5).png" alt=""><figcaption><p>Document type schema comparison</p></figcaption></figure>

You can also view details about a certain element by selecting "View Details".

This will show the difference between entities stored in Umbraco and the `.uda` file stored on disk.

<figure><img src="images/image (7).png" alt=""><figcaption><p>Showing how you can compare schema in the deploy dashboard</p></figcaption></figure>
