---
description: >-
  Version-specific documentation for upgrading to new major versions of Umbraco Commerce.
---

# Version Specific Upgrade Notes

This page covers specific upgrade documentation for migrating to version 17 of Umbraco Commerce.

{% hint style="info" %}
If you are upgrading to a new minor or patch version, you can find information about the breaking changes in the [Release Notes](../release-notes/README.md) article.
{% endhint %}

## Version Specific Upgrade Notes History

#### 17.0.0

* The default property aliases for Customer Comments and Internal Notes have changed: `comments` is now `customerNotes`, and `notes` is now `internalNotes`. After upgrading from v13, existing data still lives in the database under the old aliases, so these fields appear empty in the v17 backoffice. To restore visibility without a database migration, remap the fields back to the original aliases in your composer using `OrderPropertyConfig`:

    ```csharp
    builder.WithOrderPropertyConfigs()
        .UpdateDefault(cfg => cfg
            .For(x => x.Notes.CustomerNotes).MapFrom("comments")
            .For(x => x.Notes.InternalNotes).MapFrom("notes"));
    ```

    Or scope to a single store with `.Update("yourStoreAlias", cfg => …)` instead of `UpdateDefault`. This remap covers both reads (backoffice display) and writes (saving edits).

## Legacy version specific upgrade notes

You can find the version-specific upgrade notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/tree/umbraco-eol-versions).&#x20;
