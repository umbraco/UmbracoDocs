---
description: >-
  Version specific documentation for upgrading to new major versions of Umbraco
  Deploy.
---

# Version Specific Upgrade Details

This page covers specific upgrade documentation for when migrating to major 13 of Umbraco Deploy.

{% hint style="info" %}
If you are upgrading to a minor or patch of Deploy you can find the details about the changes in the [release notes](../release-notes.md) article.
{% endhint %}

## Version Specific Upgrade Notes History

Version 13 of Umbraco Deploy has a minimum dependency on Umbraco CMS core of `13.0.0`. It runs on .NET 8.

#### **Breaking changes**

Version 13 contains a number of breaking changes. We don't expect many projects to be affected by them as they are in areas that are not typical extension points. For reference though, the full details are listed here:

#### **Behavior**

* The default value for the configuration option `ResolveUserInTargetEnvironment` was changed to `true`.

#### **Configuration**

* [Configuration of relations](../getting-started/deploy-settings.md#relationtypes) was changed from a list to a dictionary.

```json
// Before
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

// After
"RelationTypes": {
  "relateParentDocumentOnDelete": "Weak",
  "relateShopItemOnCreate": "Exclude"
},
```

* [Configuration of value connectors](../getting-started/deploy-settings.md#valueconnectors) was changed from a list to a dictionary.

```json
// Before
"ValueConnectors": [
  {
    "Alias": "nuPickers.DotNetCheckBoxPicker",
    "TypeName": "Umbraco.Deploy.Contrib.Connectors.ValueConnectors.NuPickersValueConnector,Umbraco.Deploy.Contrib.Connectors",
  }
],

// After
"ValueConnectors": {
  "nuPickers.DotNetCheckBoxPicker": "Umbraco.Deploy.Contrib.Connectors.ValueConnectors.NuPickersValueConnector, Umbraco.Deploy.Contrib.Connectors"
},
```

#### **Code**

The following updates describe the more significant changes to the codebase and public API:

* Moved value connectors for core property editors from `Umbraco.Deploy.Contrib` into `Umbraco.Deploy.Infrastructure`.
* Renamed the Deploy add-on for Umbraco Forms from `Umbraco.Deploy.Forms` to `Umbraco.Forms.Deploy`.

These updates are more minor. We don't expect many projects to be affected by them as they are in areas that are not typical extension points:

* Removed the obsolete `IsHeadless` property from \`UmbracoCloudClientConfigurationInfo\`\`.
* Made the `ProcessX` methods for each step of content connectors private.
* Removed the obsolete overload of `SaveContentType` on `ContentTypeConnectorBase`.
* An obsolete constructor was removed from `DictionaryItemConnector`.
* `QueueItemDto` was moved into the `Umbraco.Deploy.Infrastructure.Persistence` namespace.
* `DocumentConnector` has a changed constructor such that we can use redirect tracking logic now exposed from CMS.
* Remove now unnecessary interfaces and extension methods for rich text parsing. These were introduced to ensure backward compatibility in older versions: `IMacroParser2`, `IImageSourceParser2` and `ILocaLinkParser2`.

## Legacy version specific upgrade notes

You can find the version specific upgrade notes for versions out of support in the [Legacy documentation on Github](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-deploy/upgrades/version-specific.md).
