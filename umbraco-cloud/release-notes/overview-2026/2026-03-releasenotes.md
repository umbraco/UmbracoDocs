# March 2026

## Key Takeaways

* **Release Umbraco.Cloud.Identity.Cms 13.2.6, Umbraco.Cloud.Cms 16.0.3 & 17.0.3** - Retains current user group if user already exists, and allows for mapping a single role to multiple Umbraco user groups.

## Release Umbraco.Cloud.Identity.Cms 13.2.6, Umbraco.Cloud.Cms 16.0.3 & 17.0.3

Added functionality that ensures if a user already exists with the same email as the one from an External Login Provider, then we no longer overwrite their user groups but keeps them the same. [#993](https://github.com/umbraco/Umbraco.Cloud.Issues/issues/993)

Added functionality that allows you to map a single role in your External Login Provider to multiple Umbraco user groups. [#990](https://github.com/umbraco/Umbraco.Cloud.Issues/issues/990)



