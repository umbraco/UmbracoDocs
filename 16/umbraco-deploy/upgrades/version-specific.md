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

Entity type registration is simplified by removing client-side concerns from the server and aligning built-in Umbraco CMS and custom entities (like Forms and Commerce).

* `IDiskEntityService.RegisterDiskEntityType(...)` - This now only requires the entity type, removing the `name`, `isUmbracoEntity` and `installedUdisGetter` parameters.
* `ITransferEntityService.RegisterTransferEntityType(...)` - This is also simplified, removing the `name`, `isUmbracoEntity`, `treeAlias`, `matchesRoutePath`, `matchesNodeId` and `entitiesGetter` parameters.

The name was only used in the backoffice, for example, to group items in the transfer queue and schema comparison dashboard. It now uses localizations (`deploy_entityTypes_{entityType}` or `general_{entityType}`), falling back to the plain entity type if no translation is provided.

The `isUmbracoEntity` flag was used when fetching entities in the schema comparison dashboard and for setting signatures. This could only be enabled for built-in Umbraco entities directly supported by Deploy. Custom entities required providing the `installedUdisGetter` or `entitiesGetter` parameter for these features to work correctly. However, getting all entities is already possible via the service connectors (`IServiceConnector.GetRangeAsync()` and `IServiceConnector.GetArtifact()`), making these parameters redundant.

The `treeAlias`, `matchesRoutePath`, and `matchesNodeId` parameters are removed because the client-side already tracks the entity types. It's recommended to use the same entity types on both the client (in workspaces and routes) and the server (in UDIs, artifacts, and service connectors). If different, Deploy supports mapping the client-side entity types to their server-side counterpart using a `deployEntityTypeMapping` manifest, as shown in the following example:

```json
{
  "id": "Umbraco.Commerce.Deploy",
  "name": "Umbraco Commerce Deploy",
  "version": "16.0.0",
  "extensions": [
    {
      "type": "localization",
      "alias": "Uc.Deploy.Localization.En",
      "weight": -100,
      "name": "English",
      "meta": {
        "culture": "en",
        "localizations": {
          "deploy_entityTypes": {
            "umbraco-commerce-product-attribute": "Umbraco Commerce Product Attribute",
            "umbraco-commerce-product-attribute-preset": "Umbraco Commerce Product Attribute Preset",
          }
        }
      }
    },
    {
      "type": "deployEntityTypeMapping",
      "alias": "Uc.Deploy.EntityTypeMapping",
      "name": "Umbraco Commerce Deploy Entity Type Mapping",
      "entityTypes": {
        "uc:product-attribute": "umbraco-commerce-product-attribute",
        "uc:product-attributes": "umbraco-commerce-product-attribute",
        "uc:product-attribute-preset": "umbraco-commerce-product-attribute-preset",
        "uc:product-attribute-presets": "umbraco-commerce-product-attribute-preset"
      }
    }
  ]
}
```

### Dependencies

* Umbraco CMS dependency was updated to `16.0.0`.

## Legacy version-specific upgrade notes

You can find the version-specific upgrade notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-deploy/upgrades/version-specific.md).
