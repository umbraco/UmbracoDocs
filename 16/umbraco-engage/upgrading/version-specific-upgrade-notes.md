---
description: Version-specific documentation for upgrading to new major versions of Umbraco Engage.
---

# Version Specific Upgrade Notes

This article provides specific upgrade instructions for migrating to major version of Umbraco Engage

{% hint style="info" %}
When upgrading to a new minor or patch version, learn about the changes in the [Release Notes](../release-notes.md) article.
{% endhint %}

## Breaking changes
#### v13.2.0 (Umbraco Engage) & v13.1.0 (Umbraco Engage Forms)
Introduced Razor Class Library support to serve static files for Engage, removing physical backoffice, views, and assets files from development projects.

While this is not considered a breaking change, it is recommended that such folders be removed from the project to avoid conflicts in the future.

The following folders should be manually removed from your project upon updating Umbraco Engage:

  * `App_Plugins\Umbraco.Engage`
  * `Assets\Umbraco.Engage`
  * `Views\Partials\Umbraco.Engage`

The same changes apply to the Forms add-on `Umbraco.Engage.Forms`.

The following folder should be manually removed from your project upon updating Umbraco Engage Forms:

  * `App_Plugins\Umbraco.Engage.Forms`

Health checks have been added to verify whether these folders are present in your project. If they are, you will receive a warning in the Health Check dashboard.

#### v13.0.0 (Umbraco Engage Launch)

Umbraco Engage contains a number of breaking changes from the previous uMarketingSuite product.

See the [Migrate from uMarketingSuite](migrate-from-umarketingsuite.md) for full details.
