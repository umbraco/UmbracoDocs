# August 2026

## Key Takeaways

* **Release Umbraco.Cloud.Cms 13.1.1, 17.2.2, & 18.0.2** - Hides the internal `azurewebsites.net` URL in additional cases. Adds the routes used by Umbraco ID and external login providers to the `ReservedUrls` setting.

## Release Umbraco.Cloud.Cms 13.1.1, 17.2.2, & 18.0.2

New versions of the `Umbraco.Cloud.Cms` package are available: 13.1.1, 17.2.2, and 18.0.2.

All three versions contain two changes.

### Internal URL hidden in additional cases

The internal `azurewebsites.net` URL is now hidden in cases where it could still reach visitors. This follows up on the fix released in 13.1.0, 17.2.1, and 18.0.1.

### Login provider routes added to ReservedUrls

The routes used by Umbraco ID and by external login providers are added to the [`ReservedUrls`](../../../18/umbraco-cms/develop-with-umbraco/configuration/globalsettings.md#reserved-urls) setting. Umbraco leaves these routes alone, so the content request pipeline no longer handles the sign-in callbacks.
