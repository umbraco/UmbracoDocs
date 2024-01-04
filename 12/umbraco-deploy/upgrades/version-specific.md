---
description: >-
  Version specific documentation for upgrading to new major versions of Umbraco
  Deploy.
---

# Version Specific Upgrade Details

This page covers specific upgrade documentation for when upgrading to major 12 of Umbraco Deploy.

{% hint style="info" %}
If you are upgrading to a minor or patch of Deploy you can find the details about the changes in the [release notes](../release-notes.md) article.
{% endhint %}

## Version Specific Upgrade Notes History

Version 12 of Umbraco Deploy has a minimum dependency on Umbraco CMS core of `12.0.0`. It runs on .NET 7.

The forms deployment component has a minimum dependency on Umbraco Forms of `12.0.0`.

#### **Breaking changes**

Version 12 contains a number of breaking changes. We don't expect many projects to be affected by them as they are in areas that are not typical extension points. For reference though, the full details are listed here:

#### **License**

For anyone using Umbraco Deploy On-Premise, we've updated the licensing system in use for Umbraco 12.

Please [reach out to your partner or sales representative](https://umbraco.com/products/umbraco-deploy/umbraco-deploy-on-premises/#order) to obtain a new license for an existing subscription.

Use of Umbraco Deploy on Umbraco Cloud is not affected.

#### **Code**

* The obsolete constructor on `ConfigurePackageMigrationOptions` was removed.
* The obsolete properties on `FormArtifact` were removed.
* The obsolete constructor on `FileConnector` was removed.
* The obsolete constructor and method on `ArtifactRelator` were removed. An unused parameter in the retained constructor was removed.
* The `CreateSetSignatures` method was added to the `IDiskWorkItemFactory` interface.
* The `DiskWorkItemFactory` was made internal and an obsolete constructor removed.
* All methods in `UmbracoFormsCompatibility` were removed.
* Removed the unused class `TransferServiceExtensions`.
* Added the extension method available on `TransferEntityServiceExtensions` to `ITransferEntityService` and removed the class implementing the extension method.

## Legacy version specific upgrade notes

You can find the version specific upgrade notes for versions out of support in the [Legacy documentation on Github](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-deploy/upgrades/version-specific.md).&#x20;
