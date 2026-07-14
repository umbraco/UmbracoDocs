---
description: Information on the plugins settings section
---

# Plugins settings

The Plugins settings allow you to configure how Umbraco handles plugins. You can configure which file extensions plugins are allowed to serve, and a cache buster for plugin assets.

## Browsable file extensions

This setting allows you to customize what file types plugins are allowed to use for the front end. The default configuration looks like this:

{% code title="appsettings.json" %}
```json
"Umbraco": {
  "CMS": {
    "Plugins": {
      "BrowsableFileExtensions": [
        ".html",
        ".css",
        ".js",
        ".jpg", ".jpeg", ".gif", ".png", ".svg",
        ".eot", ".ttf", ".woff", ".woff2",
        ".xml", ".json", ".config",
        ".lic",
        ".map"
      ]
    }
  }
}
```
{% endcode %}

As you can see above, by default, markup, styles, scripts, source maps, images, fonts, configurations, and license type are included. If you were to, for example, remove the ".html" entry, then plugins would no longer be allowed to use HTML files.

## Cachebuster

{% hint style="info" %}
The `Cachebuster` setting is available from Umbraco 17.6.
{% endhint %}

This setting lets you force browsers to re-fetch all package assets served from `/App_Plugins`. It is empty by default and has no effect until you set it.

Set it to a value that changes with each deployment, for example a build number or a git commit hash:

{% code title="appsettings.json" %}
```json
"Umbraco": {
  "CMS": {
    "Plugins": {
      "Cachebuster": "build-20260713.1"
    }
  }
}
```
{% endcode %}

A short hash of the value is included in the cache-busting query string that Umbraco appends to package asset URLs. When the value changes, the asset URLs of every package change at once. The value is resolved on the server, so it stays consistent across servers in a load-balanced setup.

Read more about how packages are cache busted in the [Umbraco Package](../../extend-your-project/backoffice-extensions/umbraco-package.md#cache-busting) article.
