---
description: "The troubleshooting section for Umbraco Deploy"
---
# Troubleshooting

In this troubleshooting section, you can find help to resolve issues that you might run into when using Umbraco Deploy.

If you are unable to find the issue you are having, then please reach out to our friendly support team at contact@umbraco.com.

## Schema mismatches

When transferring or restoring content between two Umbraco Deploy environments, you might run into **Schema mismatch** errors. For more information on how to resolve schema mismatch issues, see the [Schema Mismatches](../umbraco-cloud/troubleshooting/deployments/schema-mismatches.md) article.

Umbraco Deploy maintains a cached set of signatures that represent each schema and content item. They are used when transferring or restoring content between environments to aid performance.

If having resolved schema mismatches you still have reports of errors, it might be that the signatures are out of date. In other words, Deploy is using a cached representation of an item that no longer matches the actual item stored in Umbraco.

This should not be necessary in normal use, but can occur after upgrades. If you have this situation, you can clear the cached signatures in both the upstream and downstream environments.  You do this via the *Clear Cached Signatures* operation available on the _Settings > Deploy_ dashboard:

![Clear cached signatures](images/clear-cached-sigs.png)

## Slow responses or timeouts when restoring or transferring

When transferring or restoring content between environments, Deploy needs to ensure that all related items are updated together.  It also checks that any schema dependencies an item has also exist in the target environment. When a large amount of content is selected for transfer or restore, this process of determining all the dependent items can take some time.

If you find the process slow or timing out, there are a few options you can take.

### Review timeouts

Firstly, you can review and update the [timeout settings available with Deploy](./deploy-settings.md#timeout-settings). Increasing these from the default values may help, but won't necessarily resolve all issues. This is because some timeouts are fixed values set by the hosting environment.

### Use batch configuration for transfers to upstream environments

If transferring items from a downstream environment to an upstream one, it's possible to [configure a batch size](./deploy-setings#batch-settings).  With this in place, transfers will be batched into separate operations, allowing each single operation to complete before any hosting environment-enforced timeout.

### Ensure signatures are pre-cached

For transfer or restore operations, it's worth ensuring Deploy's cached signatures are fully populated in both the upstream and downstream environments.  This can be done via the *Set Cached Signatures* operation available on the _Settings > Deploy_ dashboard:

![Set cached signatures](images/set-cached-sigs.png)

Now the checks Deploy has to do to figure out the items and dependencies to process will complete much more quickly.

### Modify the checksum calculation method for media files

Deploy will do comparisons between the entities in different environments to determine if they match and decide whether to include them in the operation. By default, for media files, a check is made on a portion of the intial bytes of the file.

If a lot of files need to be checked, this can be slow, and a faster option is available that uses the file metadata. The only downside of changing this option is a marginally increased chance of Deploy considering a media file hasn't changed when it has.  This would omit it from the deployment.

This option can be [set in configuration](./deploy-setings#mediafilechecksumcalculationmethod).

### Review relation types included in deploy operations

As well as transferring entities between environments Deploy will also include the relations between them. As of 10.1.2 and 11.0.1, two relation types used for usage tracking are omitted by default. These do not need to be transferred as they are recreated by the CMS as part of the save operation on the entity.

If using an earlier version, or to make further adjustements, modify the [settings for relation types](./deploy-setings#relationtypes) in configuration.

## Path too long exceptions

When restoring between different media systems exceptions can occur due to file paths. They can happen between a local file system and a remote system based on blob storage. What is accepted on one system may be rejected on another as the file path is too long. Normally this will only happen for files with particularly long names.

If you are happy to continue without throwing exceptions in these instances you can [modify the configuration](./deploy-setings#continuennmediafilepathtoolongexception). If this is done such files will be skipped, and although the media item will exist there will be no associated file.

## Schema files following upgrades

When Umbraco schema items are created, a representation of them is saved to disk as a `.uda` file in the `/data/revision/` folder.  The representation is known as an artifact. It will be refreshed on further updates to represent the current state of the schema item.

Following an upgrade, it's possible the contents of the file will no longer match what would be generated by the current version.  For example, if a property has been added to an artifact, this will be absent in the file. It would be added if the file was recreated following the upgrade.

This can lead to situations where Deploy continues to process a file it considers changed, even though the item represented is up-to-date. This in turn means slow updates of Umbraco schema, as Deploy is processing more files than it needs to do.

To resolve this situation, following an upgrade it is good practice to resave the `.uda` files in the "left-most" environment.  This will usually be the local one, or if not using that, the Development environment.  You can do this via the *Export Schema To Data Files* operation available on the _Settings > Deploy_ dashboard:

![Export schema](images/export-schema.png)

The updated files should be committed to source control and deployed to upstreamm environments.
