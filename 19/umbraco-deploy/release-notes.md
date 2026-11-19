---
description: >-
  Get an overview of the things changed and fixed in each version of Umbraco
  Deploy.
---

# Release notes

This section summarizes the changes to Umbraco Deploy and [Deploy Contrib](https://github.com/umbraco/Umbraco.Deploy.Contrib) released in each version. Each version is presented with a link to the [Deploy issue tracker](https://github.com/umbraco/Umbraco.Deploy.Issues/issues) showing a list of issues resolved in the release. The individual issues are also linked from the details.

If there are any breaking changes or other issues to be aware of when upgrading, they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version, you can find the details about the breaking changes in the [Breaking Changes Overview](upgrading/version-specific.md) article.
{% endhint %}

## Release history

This section contains the release notes for Umbraco Deploy 19, including all changes for this version.

### [19.0.0-rc1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F19.0.0) (November 12th 2026)

* Compatibility with Umbraco CMS 19.0.0-rc1 and .NET 11.
  * See full details of breaking changes under [Breaking Changes Overview](upgrading/version-specific.md).
* Only transfer to and restore from environments that run Deploy 19. Upgrade all environments of a project before you transfer or restore again.
* Migrate Data Type and user group artifacts from Deploy 18 and earlier to the Umbraco 19 format when importing them. This covers the Data Type changes in Umbraco 19, such as the single and multiple property editors and the minimum and maximum ranges. User groups get the same Library, Document Blueprint, and shared content access as the Umbraco 19 upgrade grants.
* Include the shared (invariant) property values in a transfer limited to some cultures only when you have the **Allow editing shared content** permission. Previously, access to the default language decided this.
* Add the elements that blocks reuse from the Library as dependencies, so they're transferred along with the content that uses them.
* Group the Deploy actions in the actions menu, above **Notifications**. **Transfer now** has its own group in the menu next to **Save and publish**.
* Add three health checks in a new **Deploy** group on the **Health Check** dashboard in the **Settings** section. Each check offers actions to fix what it reports:
  * **UDA file versions** reports `.uda` files written by another version of Deploy, and files that can't be read. Files from a newer version are errors, files from an older major version are warnings. Use **Migrate** to update outdated files to the installed version. In `ReadOnly` [disk mode](getting-started/deploy-settings.md#disk-mode), Migrate isn't offered: migrate on a development environment and update the files in your build.
  * **Schema comparison** reports schema items without a `.uda` file, `.uda` files without a schema item, and items that differ from their file. Use **Export schema** or **Deploy schema** to bring them in line.
  * **Failed disk operation** reports when the last disk operation failed, such as a schema deployment. Use **Dismiss** to clear the failure. The details stay in the logs.
* Add a **Version** column to the schema comparison, showing whether each `.uda` file was written by the installed version of Deploy.
* Show a **View progress** button on the Deploy dashboard while an operation runs.
* Keep the export queue empty after **Export to Zip** or **Clear queue**. Previously, the exported items returned after reloading the page.
* Offer **Include subitems** when exporting a dictionary item with children, with `TransferDictionaryAsContent` enabled. Items without subitems to export are added to the export queue directly, without opening the dialog.
* Only offer to include the items below in the **Partial Restore** dialog for entity types that support it. Members no longer show this option.
* Show the tree name, such as **Members** or **Dictionary**, in the header of the remote item picker instead of the entity type alias.
* Apply changes to the settings that decide which entity types Deploy handles, such as `TransferDictionaryAsContent`, without restarting the site.
* Only connect to environments on a configured workspace URL, and use the configured URL instead of the URL another environment sends.
* Reject a `BaselineApiSecret` shorter than 64 bytes instead of falling back to the project secret.
* Remove the APIs and settings that were marked as obsolete for removal in Deploy 19, including the `Upstream` project setting and the `RemoteTreeDetail` parameter.

## Umbraco.Deploy.Contrib

### [19.0.0-rc1](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-19.0.0-rc1) (November 13th 2026)

* Compatibility with Umbraco CMS 19.0.0-rc1, Deploy 19.0.0-rc1, and .NET 11.
* Convert legacy dropdown property values when the Data Type is migrated to the `Umbraco.DropDown.Single` editor. Previously, these values were imported without conversion.
  * `AddLegacyMigrators()` registers the five new `*ToSingleDropDownPropertyTypeMigrator` classes. If you register the legacy property type migrators one by one, add the new ones as well. For more information, see the [Migrating from Umbraco 7](deployment-workflow/import-export/import-export-v7.md) article.