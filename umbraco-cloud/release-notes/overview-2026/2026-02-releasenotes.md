# February 2026

## Key Takeaways

* **Release Umbraco.Cloud.Cms 13.0.1, 16.0.2 & 17.0.2** - Adds middleware that ensures the underlying AzureWebsites url remains hidden on initial requests.

## Release Umbraco.Cloud.Cms 13.0.1, 16.0.2 & 17.0.2

We identified an issue where Cloud sites could end up using `localhost` or `*.azurewebsites.net` as their root domain. This was caused by early Azure platform requests during site startup being persisted as the site's base URL.
We've resolved this by introducing early middleware that ensures the [`umbracoApplicationUrl`](../../../17/umbraco-cms/reference/configuration/webroutingsettings.md) is used as the host from the start, using forwarded headers to override the internal Azure hostnames before they can be persisted.
