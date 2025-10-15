---
meta.Title: Umbraco Deploy settings
description: >-
  Learn about the different settings and configurations available in Umbraco
  Deploy.
---

# Configuration

All configuration for Umbraco Deploy is held in the `appSettings.json` file found at the root of your Umbraco website. If the configuration has been customized to use another source, then the same keys and values discussed in this article can be applied there.

The convention for Umbraco configuration is to have package based options stored as a child structure below the `Umbraco` element, and as a sibling of `CMS`. Umbraco Deploy configuration follows this pattern, i.e.:

```json
{
  ...
  "Umbraco": {
    "CMS": {
        ...
    },
    "Deploy": {
        ...
    }
  }
}
```

There are some required settings but most configuration for Umbraco Deploy is optional. In other words, values have defaults that will be applied if no configuration is available for a particular key.

For illustration purposes, the following structure represents the full set of options for configuration of Umbraco Deploy, along with the default values. This will help when you need to provide a different setting to understand where it should be applied.

```json
{
  ...
  "Umbraco": {
    "Deploy": {
        "Settings": {
            "ApiKey": "<your API key here>",
            "Edition": "Default",
            "ExcludedEntityTypes": [],
            "RelationTypes" : [],
            "ValueConnectors": [],
            "SessionTimeout": "0.0:20:00",
            "SourceDeployTimeout": "0.0:20:00",
            "DatabaseCommandTimeout": "0.0:20:00",
            "EnableSignatureCacheReads": true,
            "HttpClientTimeout": "0.0:20:00",
            "DiskOperationsTimeout": "0.0:05:00",
            "SourceDeployBatchSize": null,
            "PackageBatchSize": null,
            "UseDatabaseTransferQueue": true,
            "IgnoreBrokenDependenciesBehavior": "Restore",
            "AcceptInvalidCertificates": false,
            "TransferFormsAsContent": true,
            "TransferDictionaryAsContent": false,
            "SetEmptyDictionaryItemsOnTransfer": true,
            "IgnoreMissingLanguagesForDictionaryItems": false,
            "AllowMembersDeploymentOperations": "None",
            "TransferMemberGroupsAsContent": false,
            "ExportMemberGroups": true,
            "ReloadMemoryCacheFollowingDiskReadOperation": false,
            "AllowDomainsDeploymentOperations": "None",
            "AllowPublicAccessDeploymentOperations": "AddOrUpdate",
            "TrashedContentDeploymentOperations": "Import",
            "PreferLocalDbConnectionString": false,
            "NumberOfSignaturesToUseAllRelationCache": 100,
            "ContinueOnMediaFilePathTooLongException": false,
            "SuppressCacheRefresherNotifications": false,
            "ResolveUserInTargetEnvironment": false
        }
    }
  }
}
```

## ApiKey

The API key is a 10 character random string applied with the same value to all environments in order to authenticate HTTP requests between them.

## Edition

The default value for this setting is `Default`, which configures Umbraco Deploy to work according to how we expect most customers to use the product. Umbraco schema, such as Document and Data Types, are serialized to disk as `.uda` files in save operations. These are checked into source control and used to update the schema in the upstream environments via a trigger from your CI/CD pipeline, or automatically if using Umbraco Cloud.

Items managed by editors - content, media and optionally forms, dictionary items and members - are deployed between environments using the transfer and restore options available in the backoffice.

It is possible to use this method for all Umbraco data, by setting the value of this setting to `BackOfficeOnly`. With this in place, all data, including what is typically considered as schema, are available for transfer via the backoffice.

Our recommended approach is to leave this setting as `Default` and use source control and a deployment pipeline to ensure that structural changes to Umbraco are always aligned with the code and template amends that use them.

However, we are aware that some customers prefer the option to use the backoffice for all data transfers. If that is the case, the `BackOfficeOnly` setting will allow this.

## ExcludedEntityTypes {#excludedentitytypes}

This setting allows you to exclude a certain type of entity from being deployed. This is **not** recommended to set, but sometimes there may be issues with the way a custom media fileprovider works with your site and you will need to set it for media files. Here is an example:

```json
"ExcludedEntityTypes": ["media-file"],
```

## RelationTypes

This setting allows you to manage how relations are deployed between environments. You will need to specify an alias and a mode for each relationtype. The mode can be either:

* `Exclude` - This causes the relation to be excluded and not transferred on deployments.
* `Weak` - This causes the relation to be deployed if both content items are found on the target environment.
* `Strong` - This requires the content item that is related is set as a dependency, so if anything is added as a relation it would also add it as a dependency.

```json
"RelationTypes": [
    {
        "Alias": "relateParentDocumentOnDelete",
        "Mode": "Weak",
    },
    {
        "Alias": "relateShopItemOnCreate",
        "Mode": "Exclude",
    }
],
```

## ValueConnectors

This setting is used by package creators who wants their custom editors to work with Deploy. The packages should be creating this setting automatically. There is a community driven package that has value connectors for Deploy called [Deploy Contrib](https://github.com/umbraco/Umbraco.Deploy.Contrib).

Here is an example of how the setting can look:

```json
"ValueConnectors": [
    {
        "Alias": "nuPickers.DotNetCheckBoxPicker",
        "TypeName": "Umbraco.Deploy.Contrib.Connectors.ValueConnectors.NuPickersValueConnector,Umbraco.Deploy.Contrib.Connectors",
    }
],
```

## Timeout settings {#timeout-settings}

Umbraco Deploy have a few built-in timeouts, which on larger sites might need to be modified. You will usually see these timeouts in the backoffice with an exception mentioning a timeout. It will be as part of a full restore or a full deploy of an entire site. In the normal workflow you should never hit these timeouts.

There are four settings available relating to backoffice deployment operations:

* `SessionTimeout`
* `SourceDeployTimeout`
* `HttpClientTimeout`
* `DatabaseCommandTimeout`

These timeout settings default to 20 minutes, but if you are transferring a lot of data you may need to increase it.

{% hint style="info" %}
It's important that these settings are added to both the source and target environments in order to work.
{% endhint %}

A fifth timeout setting is available from Umbraco Deploy 9.5 and 10.1, allowing for the adjustment of the maximum time allowed for disk operations such as schema updates.

* `DiskOperationsTimeout`

This setting defaults to 5 minutes.

All of these times are configured using [standard timespan format strings](https://docs.microsoft.com/en-us/dotnet/standard/base-types/standard-timespan-format-strings). The values of the settings will have to be the same value on all timeout settings.

## Batch settings {#batch-settings}

Even with appropriate settings of the above timeouts, Deploy's backoffice transfer operations can hit a hard limit imposed by the hosting environment. For Azure, this is around 4 minutes. This will typically only be reached if deploying a considerable amount of items in one go. For example, a media folder with thousands of items can reach this limit.

An error message of "The remote API has returned a response indicating a platform timeout" will be reported.

If encountering this issue, there are two batch settings that can be applied with integer values (for example 500). This will cause Deploy to transfer items in batches, up to a maximum size. This will allow each individual batch to complete within the time available. The higher the value, the bigger the batches.

* `SourceDeployBatchSize` - applies a batch setting for the transfer of multiple selected items to an upstream environment (such as a media folder with many images).
* `PackageBatchSize` - applies a batch setting to the processing of a Deploy "package", which contains all the items selected for a Deploy operation, plus all the determined dependencies and relations.

## UseDatabaseTransferQueue

In earlier versions of Umbraco Deploy, the transfer queue was implemented using in-memory storage. As a result, it would not be persisted across application restarts.

From 9.5 and 10.1, a database backed queue was implemented and is used by default.

If for any reason there was a need to revert to the previous implementation, the value of this setting can be set to `false`.

## TransferFormsAsContent {#transfer-forms-data-as-content}

In order for Deploy to handle Forms data as content, you'll to ensure the `TransferFormsAsContent` setting is set to `true`. To transfer Forms data as schema, i.e. via .uda files committed to source control, use a value of `false`.

{% hint style="info" %}
On changing this value from `false` to `true`, make sure to remove any `.uda` files for Forms entities that have already been serialized to disk. These will no longer be updated. By deleting them you avoid any risk of them being processed in the future and inadvertently reverting a form to an earlier state.
{% endhint %}

## TransferDictionaryAsContent {#transfer-dictionary-items-as-content}

In a similar way, Deploy can be configured to allow for backoffice transfers of dictionary items instead of using files serialized to disk, by setting `TransferDictionaryAsContent` as `true`.

Please see the note above under _TransferFormsAsContent_ on the topic of removing any existing serialized files having changed this value to `true`.

## IgnoreMissingLanguagesForDictionaryItems

When deploying dictionary items, an exception will be thrown if a translation is provided for a language that doesn't exist in the target environment.

Normally this is a useful fail-safe to ensure translations aren't lost in the transfer operation.

If you have deleted languages that have already existing translations, you may want to temporarily remove this check. You can do that by setting this value to `true`.

When this is in place a translation for a language that doesn't exist in the target environment will be ignored. A warning message will be output to the log.

## SetEmptyDictionaryItemsOnTransfer

When deploying dictionary items, Umbraco Deploy follows the approach used for all content, emptying values that are transferred and set.

If you transfer a dictionary item with an empty translation to another environment that already contains a translation, it will be overwritten.

Set this value to `false` to not overwrite already populated values with empty strings.

## AllowMembersDeploymentOperations and TransferMemberGroupsAsContent {#transfer-members}

As of version 9.3.0, it's also possible to transfer members and member groups via the back-office between environments. This is disabled by default as a deliberate decision to make use of the feature needs to be taken, as for most installations it will make sense to have member data created and managed only in production. There are obvious potential privacy concerns to consider too. However, if being able to deploy and restore this information between environments makes sense for the specific workflow of your project, it's a supported scenario.

To enable, you can add or amend the `AllowMembersDeploymentOperations` and `TransferMemberGroupsAsContent` settings.

The `AllowMembersDeploymentOperations` setting can take four values:

* `None` - member deployment operations are not enabled (the default value if the setting is missing)
* `Restore` - restore of members from upstream environments via the backoffice is enabled
* `Transfer` - transfer of members to upstream environments via the backoffice is enabled
* `All` - restore and transfer of members from upstream environments via the backoffice is enabled

With `TransferMemberGroupsAsContent` set to `true`, member groups can also be transferred via the backoffice, and groups identified as dependencies of members being transferred will be automatically deployed.

Please see the note above under _TransferFormsAsContent_ on the topic of removing any existing serialized files having changed this value to `true`.

## ExportMemberGroups {#exporting-member-groups}

This setting is to be defined and set to `false` only if you are using an external membership provider for your members. You will not want to export Member Groups that would no longer be managed by Umbraco but by an external membership provider.

Setting `exportMemberGroups` to `false` will no longer export Member Groups to .uda files on disk. The default for this setting is `true`, as most sites use Umbraco's built-in membership provider and thus will want the membership groups exported.

## IgnoreBrokenDependenciesBehavior {#ignore-broken-dependencies}

When restoring or transferring content, Umbraco Deploy will make checks to ensure that any dependent content, media or other items are either present in the target environment, or can be deployed from the source environment.

For example, you may have a media picker on a content item, referencing media that has been deleted or is in the recycle bin. In this situation the dependency won't be available in the target environment.

Deploy can halt at this point, so you get an error and the deployment won't complete until the issue is resolved. To fix, you would need to remove the reference to the deleted media item.

Alternatively, you can configure Deploy to ignore these issues and proceed with the transfer operation without warning.

To configure the behavior you prefer, amend this value to either `None`, `Transfer`, `Restore` or `All`.

For example, using the following settings, you will have an installation that ignores broken dependencies when restoring from an upstream environment. It will however still prevent deployment and report any dependency issues when attempting a transfer to an upstream environment.

```json
    "IgnoreBrokenDependenciesBehavior": "Restore",
```

When configuring for Deploy 9, an additional `IgnoreBrokenDependencies` setting existed that took a value of `true` or `false`. To achieve the same result as the example above, the following configuration was required:

```json
    "IgnoreBrokenDependencies": true,
    "IgnoreBrokenDependenciesBehavior": "Restore",
```

## Memory cache reload {#memory-cache-reload}

Some customers have reported intermittent issues related to Umbraco's memory cache following deployments, which are resolved by a manual reload of the cache via the _Settings > Published Status > Caches_ dashboard. If you are running into such issues and are able to accommodate a cache clear after deployment, this workaround can be automated via the following setting:

```json
    "ReloadMemoryCacheFollowingDiskReadOperation": true,
```

By upgrading to the most recent available version of the CMS major you are running, you'll be able to benefit from the latest bug fixes and optimizations in this area. That should be your first option if encountering cache related issues. Failing that, or if a CMS upgrade is not an option, then this workaround can be considered.

## Deployment of culture & hostnames settings {#deployment-of-culture--hostnames-settings}

Culture and hostname settings, defined per content item for culture invariant content, are not deployed between environments by default. They can be opted into via configuration.

```json
    "AllowDomainsDeploymentOperations": "None|Culture|AbsolutePath|Hostname|All",
```

To enable this, set the configuration value as appropriate for the types of domains you want to allow:

* `Culture` - the language setting for the content, defined under "Culture"
* `AbsolutePath` - values defined under "Domains" with an absolute path, e.g. "/en"
* `Hostname` - values defined under "Domains" with a full host name, e.g. "en.mysite.com"

Combinations of settings can be applied, e.g. `Hostname,AbsolutePath`.

## Deployment of public access settings {#deployment-of-public-access-settings}

When deploying content items, public access rules based on member groups are transferred. You can amend this behavior using this setting.

```json
    "AllowPublicAccessDeploymentOperations": "None|AddOrUpdate|Remove|All",
```

* `None` - no public access rules will be transferred
* `AddOrUpdate` - public access rules added or updated in a source environment will be transferred to the destination
* `Remove` - public access rules removed a source environment will be removed in the destination
* `All` - all public access information will be transferred

`AddOrUpdate` is the default setting used if no value is configured.

## Deployment of trashed content {#deployment-of-trashed-content}

Specifies options for handling trashed content (documents, media and members) on export or import:

```json
"TrashedContentDeploymentOperations": "None|Export|Import|All"
```

You can amend this behavior using this setting:

* `None` - trashed content will not be exported or imported
* `Export` - trashed content will be included in an export
* `Import` - trashed content will be processed and moved to the recycle bin on import
* `All` - trashed content will be included in an export, processed and moved to the recycle bin on import

## PreferLocalDbConnectionString

When using Umbraco Deploy with Umbraco Cloud, a development database is automatically created when restoring a project into a local environment for the first time.

For Umbraco 10, by default, a SQLite database is created.

If you would prefer to use SQL Server LocalDb when it's available on your local machine, set this value to `true`. If LocalDB isn't reported as being available by Umbraco, it will fallback to using a SQLite database instead.

```json
"PreferLocalDbConnectionString": true
```

## MediaFileChecksumCalculationMethod {#media-file-checksum-calculation-method}

Deploy will do comparisons between the entities in different environments to determine if they match and decide whether to include them in the operation. By default, for media files, a check is made on a portion of the initial bytes of the file.

This corresponds to the default setting of `PartialFileContents`.

If a lot of files need to be checked, this can be slow, and a faster option is available that uses the file metadata. The only downside of changing this option is a marginally increased chance of Deploy considering a media file hasn't changed when it has. This would omit it from the deployment.

To use this method, set the value to `Metadata`.

## NumberOfSignaturesToUseAllRelationCache {#number-of-signatures-to-use-all-relation-cache}

When reviewing a set of items for a deployment operation, Deploy will retrieve and include relations. It does this either via single database lookups, or by bringing all relations into memory in one step, and retrieving them from there.

For small deployment operations, the former is the more optimal approach. It gets slow though when the number of items being transferred is large.

The cut-off before switching methods is set by this configuration value, and it defaults to an operation size of `100` items.

## SuppressCacheRefresherNotifications

When a Deploy operation completes, cache refresher notifications are fired. These are used to update Umbraco's cache and search index.

In production this setting shouldn't be changed from it's default value of `false`, to ensure these additional data stores are kept up to date.

If attempting a one-off, large transfer operation, before a site is live, you could set this value to `true`. That would omit the firing and handling of these notifications and remove their performance overhead. Following which you would need to ensure to rebuild the cache and search index manually via the backoffice _Settings_ dashboards.

## ResolveUserInTargetEnvironment

With this setting assigned a value of `true`, Umbraco Deploy will attempt to resolve users when transfers are made to new environments.

Users and user groups are maintained separately in different environments, so it isn't always the case that an editor has accounts across all environments. When an account exists matching by email address, Deploy will associate the changes made in upstream environments with the user that initiated the transfer. Allowing the expected information about save and publish operations to be available in the audit log of the environment where the data was transferred.

When the setting is set to `false`, or a matching account isn't found, the audit records will be associated with the super-user administrator account.
