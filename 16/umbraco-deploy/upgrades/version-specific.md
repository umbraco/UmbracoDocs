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

Entity type registration is simplified by removing client-side concerns from the server and aligning built-in and custom Umbraco CMS entities (like Forms and Commerce).

* `IDiskEntityService.RegisterDiskEntityType(...)` - This now only requires the entity type, removing the `name`, `isUmbracoEntity` and `installedUdisGetter` parameters.
* `ITransferEntityService.RegisterTransferEntityType(...)` - This is also simplified, removing the `name`, `isUmbracoEntity`, `treeAlias`, `matchesRoutePath`, `matchesNodeId` and `entitiesGetter` parameters.

The name was only used in the backoffice, for example, to group items in the transfer queue and schema comparison dashboard. It now uses localizations (`deploy_entityTypes_{entityType}` or `general_{entityType}`), falling back to the plain entity type.

The `isUmbracoEntity` flag was used in the schema comparison dashboard and for setting signatures to fetch entities differently from custom ones. Making `installedUdisGetter` and `entitiesGetter` mandatory could fetch these items, but this is already possible via service connectors (`IServiceConnector.GetRangeAsync()` and `IServiceConnector.GetArtifact()`).

### Dependencies

* Umbraco CMS dependency was updated to `16.0.0`.

## Legacy version-specific upgrade notes

You can find the version-specific upgrade notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-deploy/upgrades/version-specific.md).
