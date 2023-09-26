---


meta.Title: "URL Redirect Management"
description: "URL redirect management in Umbraco"
---

# URL Redirect Management

## User Overview

Whenever a document is published, and this causes changes to its URL (and any of its descendants' URLs), Umbraco makes a note of the old URLs. Whenever an incoming request is served and the default content finders cannot find a matching published document, Umbraco checks whether the URL matches one of these saved URLs. If a match is found, Umbraco returns a "301 Redirect" response pointing to the new URL of the document.

The URL Redirect Management functionality does not support rewriting "rules" (e.g. regular expressions), nor complex scenarios (e.g. changing the culture and hostnames configuration). There are already powerful solutions to deal with these types of situations, such as Microsoft's own [Url Rewrite](https://www.iis.net/downloads/microsoft/url-rewrite) module for IIS. Since netcore is decoupled from the webserver hosting it, your approach for URL rewriting, outside what Umbraco provide out of the box, will depend on what you use to host your solutions, but for more info on the IIS Url Rewrite module have a look at the [official documentation](https://docs.microsoft.com/en-us/iis/extensions/url-rewrite-module/url-rewrite-module-configuration-reference).

## Dashboard

It is possible to list the redirect URLs via the *Redirect Url Management* dashboard in the *Content* section. This dashboard lists the original URL, new URL, and culture. It also allows you to delete a URL redirect.

In addition, the dashboard can be used to disable or enable the 301 Redirect Management (via the `appsettings.json` configuration option described below - note that this requires an application restart to take effect).

## Technical Overview

Anytime a document is published and its corresponding *url segment* changes, Umbraco checks its URL (and all its descendants' URLs) for changes. For every URL that has changed, it creates (or updates) a row in the `umbracoRedirectUrl` table. Rows in this table contain: the old url, the create date, and the target content identifier, culture, and a url hash.

Umbraco registers a new content finder, `ContentFinderByRedirectUrl`, which runs as a normal content finder after the other content finders. It looks for the incoming URL in the database table and, if found, computes the URL of the target document and returns a "301 Redirect". These redirects are considered "permanent". It's good to note that we explicitly set `no-cache` headers on these redirects so that when they change, browsers update the URL immediately. They are a "true" 301, however, and search engines will accept them as such.

## Enable / Disable / Configure

The 301 Redirect Management feature is enabled by default.

It is possible to disable the feature entirely (both generating URLs in the database table, and running the content finder) by editing the `appsettings.json` file:

```json
"Umbraco": {
  "CMS": {
    "WebRouting": {
      "DisableRedirectUrlTracking": false
    }
  }
}
```

See [the web routing config reference](../configuration/webroutingsettings.md) for more configuration options
