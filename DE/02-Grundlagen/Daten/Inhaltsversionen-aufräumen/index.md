---
meta.Title: "Content version cleanup"
versionFrom: 9.1.0
versionTo: 10.0.0
---

# Content Version Cleanup

When you publish a document a lot of new records are created in the database. All of the property data for each culture variant of a document are duplicated and this can mount up fast taking disk space on your database server.

Umbraco 9.1.0 introduced a feature to clean up historic content versions (inspired by [Our.Umbraco.UnVersion](https://our.umbraco.com/packages/website-utilities/unversion/)).

## How it works

The default cleanup policy is to remove all versions that are more than 4 days old except for the latest version which will be kept for 90 days.

The feature is enabled by default via configuration for new installs starting from 9.1.0 but will require to opt in for 
those upgrading from 9.0.0.

The feature can be configured ni the `appSettings.json`:

```json
{
  "Umbraco": {
    "CMS": {
      "Content": {
        "ContentVersionCleanupPolicy": {
          "EnableCleanup": true,
          "KeepLatestVersionPerDayForDays": 90,
          "KeepAllVersionsNewerThanDays": 7
        }
      }
    }
  }
}
```

For those sites with stricter requirements (or those who do not want the feature) it is possible to opt out both globally 
(see [v9-Config > ContentSettings](/documentation/Reference/v9-Config/ContentSettings/index.md#contentversioncleanuppolicy)) and per Document Type.

Additionally, it is possible to keep the feature enabled but mark specific versions to keep forever.

It is worth noting that whilst we delete rows, we do not shrink database files or rebuild indexes. For upgraded sites with a lot
of history you may wish to perform these tasks, if they are not part of your regular database maintenance plan already.

## Overriding global settings

It is possible to override the global settings per Document Type in the backoffice to prevent unwanted cleanup. This can be managed in the "permissions"
Content App for each Document Type.

![Content Version Cleanup - document type overrides](images/per-doctype-override.png)

## Prevent cleanup of important versions

It is possible to mark important content versions as "prevent cleanup" to ensure they are never removed via the new and improved 
rollback modal which can be found on the "info" content app for each document.

1. Open rollback modal.
![Content Version Cleanup - prevent cleanup part 1](images/prevent-cleanup-part-1.png)

1. Click "prevent cleanup" button for each important version.
![Content Version Cleanup - prevent cleanup part 2](images/prevent-cleanup-part-2.png)
