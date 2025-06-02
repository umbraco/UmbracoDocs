---
description: >-
  Version specific documentation for upgrading to new major versions of Umbraco Deploy.
---

# Version Specific Upgrade Details

This article provides specific upgrade documentation for migrating to Umbraco Deploy version 16.

{% hint style="info" %}
If you are upgrading to a minor or patch version, you can find the details about the changes in the [Release Notes](../release-notes.md) article.
{% endhint %}

## Version Specific Upgrade Notes History

Version 16 of Umbraco Deploy has a minimum dependency on Umbraco CMS core of `16.0.0`. It runs on .NET 9.

### Breaking changes

Version 16 contains breaking changes. The breaking changes appear in areas related to extending Deploy to support additional entities. For reference though, the full details are listed here:

#### Entity type registration

The entity type registration has been simplified, removing client-side concerns from the server-side and align behavior between built-in Umbraco CMS entities and custom ones (like Forms and Commerce).

* `IDiskEntityService.RegisterDiskEntityType(...)` - This now only requires the entity type, removing the `name`, `isUmbracoEntity` and `installedUdisGetter` parameters.
* `ITransferEntityService.RegisterTransferEntityType(...)` - This is also simplified, removing the `name`, `isUmbracoEntity`, `treeAlias`, `matchesRoutePath`, `matchesNodeId` and `entitiesGetter` parameters.

The name was only used in the backoffice (as friendly entity type name, e.g. to group items in the transfer queue and the schema comparison dashboard), so this is now using localizations (using `deploy_entityTypes_{entityType}` or `general_{entityType}`, falling back to the plain entity type).

The `isUmbracoEntity` flag was used in the schema comparison dashboard and when setting signatures to get all entities in a different way compared to custom entities. Although we could make the `installedUdisGetter` and `entitiesGetter` parameters mandatory and use those to fetch the required items, this is already possible using the service connectors (using `IServiceConnector.GetRangeAsync()` and `IServiceConnector.GetArtifact()`).

### Dependencies

* Umbraco CMS dependency was updated to `16.0.0`.

## Legacy version-specific upgrade notes

You can find the version-specific upgrade notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-deploy/upgrades/version-specific.md).
