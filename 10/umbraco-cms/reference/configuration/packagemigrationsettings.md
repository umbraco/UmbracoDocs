---
versionFrom: 9.0.1

meta.Title: "Umbraco Package Migration Settings"
description: "Information on the package migration settings section"
---

# Package Migration

This settings section provides control over how package migrations are executed in different environments (local, development, live etc.)

Package migrations are defined by package developers allowing them to add functionality to their package that enhances the Umbraco CMS.  There can be various types of migrations applied, including creating custom database tables and installing Umbraco schema and content.

They run on start-up, thus ensuring that the functionality of the package has the necessary infrastructure, schema, and content in place when it is used.

Migration steps that are explicitly created by the package developer to make database schema changes will always run in all environments.

Depending on your workflow, for those steps that install Umbraco data - whether schema such as document types, content, or media - you may want them run in all environments, or you may prefer to only do this in certain ones.

The default behavior for Umbraco CMS is for all package migrations to run in all environments.

If using Umbraco Cloud, the default is to run package migrations fully _only in local environments_.  By doing this, for schema, `.uda` files will be generated in the `/umbraco/Deploy/Revision` folder, which when pushed to a Cloud environment will be used to install the schema and content there.  For content and media, the "queue for transfer" operation can be used.  With this behavior, we avoid any issues caused by both a package migration and a deployment operation attempting to create schema and content.

If different behavior is required, or if using Umbraco Deploy On-Premises, the following settings can be applied:

```json
{
  "$schema": "https://json.schemastore.org/appsettings.json",
  "Umbraco": {
    "CMS": {
      "PackageMigration": {
        "RunSchemaAndContentMigrations": true,
        "AllowComponentOverrideOfRunSchemaAndContentMigrations": true
      }
    }
  }
}
```

## RunSchemaAndContentMigrations

If set to `true`, the default behavior described above for Umbraco CMS on-premises and Umbraco Cloud will be applied.  By setting to `false`, the installation of Umbraco schema and content from a package migration will be skipped.  If missing the default value is `true`.

## AllowComponentOverrideOfRunSchemaAndContentMigrations

If this is set to the default value of `true`, Umbraco Cloud (or other deployment tools) can override the configured value of `RunSchemaAndContentMigrations` as is appropriate for their operation.  By setting to `false` such tools should respect this setting, not make any overrides and use the configured value.
