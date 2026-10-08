# August 2026

## Key Takeaways

* **Custom error pages shown for stopped environments** - Custom error pages are now also shown while an environment is stopped, not only during restarts and deployments.
* **Release Umbraco.Cloud.Cms 13.1.1, 17.2.2, & 18.0.2** - Hides the internal `azurewebsites.net` URL in additional cases. Adds the routes used by Umbraco ID and external login providers to the `ReservedUrls` setting.

## Custom error pages shown for stopped environments

Custom error pages assigned through the [Error Pages](../../build-and-customize-your-solution/handle-deployments-and-environments/error-pages.md) feature are now also shown while an environment is stopped.

When the [Start and stop environments](2026-03-releasenotes.md#start-and-stop-environments) feature was released it did not use the Error Pages feature but instead used a standard platform error page that you could not change. This now ensures you can use a custom error page, matching the behavior during restarts and deployments.

This also makes the two features work well together for planned maintenance. Upload a custom maintenance page, assign it to your hostnames, and stop the environment. Visitors then see your maintenance page until you start the environment again.

## Release Umbraco.Cloud.Cms 13.1.1, 17.2.2, & 18.0.2

New versions of the `Umbraco.Cloud.Cms` package are available: 13.1.1, 17.2.2, and 18.0.2.

All three versions contain two changes.

### Internal URL hidden in additional cases

The internal `azurewebsites.net` URL is now hidden in cases where it could still reach visitors. This follows up on the fix released in 13.1.0, 17.2.1, and 18.0.1.

### Login provider routes added to ReservedUrls

The routes used by Umbraco ID and by external login providers are added to the [`ReservedUrls`](../../../18/umbraco-cms/develop-with-umbraco/configuration/globalsettings.md#reserved-urls) setting. Umbraco leaves these routes alone, so the content request pipeline no longer handles the sign-in callbacks.
