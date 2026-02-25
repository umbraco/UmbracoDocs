# February 2026

## Key Takeaways

* **Release Umbraco.Cloud.Cms 13.0.1, 16.0.2 & 17.0.2** - Adds middleware that ensures the internal Azure URL remains hidden on initial requests.

## Release Umbraco.Cloud.Cms 13.0.1, 16.0.2 & 17.0.2

This release resolved an issue where Cloud sites end up using `localhost` or `*.azurewebsites.net` as their root domain. The issue was caused by early Azure platform requests during site startup being persisted as the site's base URL.

We fixed this by using early middleware and forwarded headers to ensure the [`umbracoApplicationUrl`](../../../17/umbraco-cms/reference/configuration/webroutingsettings.md) overrides Azure hostnames before they are persisted.
