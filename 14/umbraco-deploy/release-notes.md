---
description: >-
  Get an overview of the things changed and fixed in each version of Umbraco
  Deploy.
---

# Release notes

In this section we have summarised the changes to Umbraco Deploy and [Deploy Contrib](https://github.com/umbraco/Umbraco.Deploy.Contrib) released in each version. Each version is presented with a link to the [Deploy issue tracker](https://github.com/umbraco/Umbraco.Deploy.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version you can find the details about the breaking changes in the [version specific updates](upgrades/version-specific.md) article.
{% endhint %}

## Release History

This section contains the release notes for Umbraco Deploy 13 including all changes for this version.

#### [14.0.1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.0.1) (June 6th 2024)

* Ensure remote tree uses correct entity type (if multiple entities like folders and items are present in a tree):
  * `ITransferEntityService.RegisterTransferEntityType(...)` accepts an optional `RemoteTreeDetail` that now exposes the entity type when getting remote entities;
* Fix `GetMaxRequestLength` endpoint (misaligned HTTP method) preventing file transfers/uploads from local environments;
* Fix data type deployment due to missing `EditorUiAlias` (requires a schema extraction/data type save to fix);
* Fix JSON serialization errors in trigger endpoints (extract and status report);
* Obsolete and hide `NestedContentValueConnector` and add import migrators for unsupported legacy editors by default:
  * Adds `ReplaceMediaPickerDataTypeArtifactMigrator` and `ReplaceNestedContentDataTypeArtifactMigrator` artifact migrators to replace the data types with the Media Picker v3 and Block List respectively;
  * Adds `MediaPickerPropertyTypeMigrator` and `NestedContentPropertyTypeMigrator` property type migrators to ensure content (property data) is migrated as well;
* Support import with unknown UDI types (like macro, macroscript and partial-view-macro);
* Fix JSON serialization error in value connectors for `BlockValue`.

#### [14.0.0](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.0.0) (May 30th 2024)

* Compatibility with Umbraco 14
  * See full details of breaking changes under the [Version-specific Upgrade Guide](upgrades/version-specific.md).

## Deploy Contrib

#### [14.0.0](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-14.0.0) (May 30th 2024)

* Compatibility with Umbraco 14 and Deploy 14.

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation on Github](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-deploy/release-notes.md) and [Umbraco Deploy Package page](https://our.umbraco.com/packages/developer-tools/umbraco-deploy/)
