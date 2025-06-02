---
description: >-
  Version specific documentation for upgrading to new major versions of Umbraco
  Forms.
---

# Version Specific Upgrade Notes

This article provides specific upgrade documentation for migrating to Umbraco Forms version 16.

{% hint style="info" %}
If you are upgrading to a minor or patch version, you can find the details about the changes in the [Release Notes](../release-notes.md) article.
{% endhint %}

## Version Specific Upgrade Notes History

Version 16 of Umbraco Forms has a minimum dependency on Umbraco CMS core of `16.0.0`. It runs on .NET 9.

### Breaking changes

Version 16 contains a number of breaking changes. If you do run into any, they should be straightforward to adjust and recompile.

For reference, the full details are listed here:

#### Removed EPPlus dependency

Previous versions of Forms had a dependency on EPPlus version 4, the last version that was released under the LGPL license and not supported anymore. Newer, supported versions of this dependency require a commerce license, which we don't want to have as requirement for any built-in features in Forms: in this case for exporting form entries into a nicely formatted Excel-document. The built-in export now uses CsvHelper to export to a CSV-file instead.

## Legacy version specific upgrade notes

You can find the version specific upgrade notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-forms/installation/version-specific.md).
