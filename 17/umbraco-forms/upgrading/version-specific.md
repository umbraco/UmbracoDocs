---
description: >-
  Version specific documentation for upgrading to new major versions of Umbraco
  Forms.
---

# Version Specific Upgrade Notes

This article provides specific upgrade documentation for migrating to Umbraco Forms version 17.

{% hint style="info" %}
If you are upgrading to a minor or patch version, you can find the details about the changes in the [Release Notes](../release-notes.md) article.
{% endhint %}

## Version Specific Upgrade Notes History

Version 17 of Umbraco Forms has a minimum dependency on Umbraco CMS core of `17.0.0`. It runs on .NET 10.

### License Validation Configuration

When upgrading to Umbraco Forms 17 (alongside Umbraco CMS 17+), there is a strict requirement for the `UmbracoApplicationUrl` to be explicitly configured in your environment's `appsettings.json`. 

Without this setting, backoffice license validation for Umbraco Forms will fail (often returning a "Pending" or `ResultIsNull` status) because the application URL is no longer auto-detected from the host header by default. 

Ensure the following configuration is added and properly set for each environment:

```json
"Umbraco": {
  "CMS": {
    "WebRouting": {
      "UmbracoApplicationUrl": "[https://your-site-url.com/](https://your-site-url.com/)"
    }
  }
}
```

## Legacy version specific upgrade notes

You can find the version specific upgrade notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-forms/installation/version-specific.md).
