---
description: Information on the web routing settings section
---

# Web routing

This section allows you to configure routing for your solution, all of these settings have either default values, or do not need to be configured. However, you might want to tweak these settings in some scenarios, for instance, if you're running in a load-balanced setup.

An example of a web routing config with default values, and a placeholder for the application URL can be seen here:

```json
"Umbraco": {
  "CMS": {
    "WebRouting": {
      "TryMatchingEndpointsForAllPages": false,
      "TrySkipIisCustomErrors": false,
      "InternalRedirectPreservesTemplate": false,
      "DisableAlternativeTemplates": false,
      "ValidateAlternativeTemplates": false,
      "DisableFindContentByIdPath": false,
      "DisableRedirectUrlTracking": false,
      "UrlProviderMode": "Auto",
      "UmbracoApplicationUrl": "http://www.mysite.com/"
    }
  }
}
```

{% hint style="warning" %}
**Are you on Umbraco Cloud?**

It is not possible to change the `UmbracoApplicationUrl setting` because the value is overwritten to the default Umbraco URL: `https://[project-alias].[region].umbraco.io/` on Umbraco Cloud.
{% endhint %}

## Using the webrouting options in code

The following is an example of how you can use code to get the value for the `UmbracoApplicationUrl` configuration key:

```csharp
using Microsoft.Extensions.Options;
using Umbraco.Cms.Core.Configuration.Models;

namespace UmbracoDocs;

public class TestService
{
    private readonly IOptionsMonitor<WebRoutingSettings> _webRoutingSettings;

    public TestService(IOptionsMonitor<WebRoutingSettings> webRoutingSettings)
    {
        _webRoutingSettings = webRoutingSettings;
    }

    public void DocsExample()
    {
        var umbracoApplicationUrl = _webRoutingSettings.CurrentValue.UmbracoApplicationUrl;
    }
}
```

## Try matching endpoints for all pages

When set to `true` Umbraco will check if any routed endpoints match a front-end request. This happens before the Umbraco dynamic router tries to map the request to a Umbraco content item. This setting should not be necessary as long as the Umbraco catch-all route is registered last.

## Try skip IIS custom errors

Defines the value of Response.TrySkipIisCustomErrors when an error (404, 400, 500...) is encountered. In order to prevent IIS from displaying its own 404 or 500 pages, set this to `true` to have your own page displayed.

## Internal redirect preserves template

When true, an internal redirect does not reset the alternative template, if any.

## Disable alternative templates

When true, the entire alternative templates feature of Umbraco is disabled.

**validateAlternativeTemplates** will not load the template from the database. If `false` the template might not exists in the database. Otherwise the template need to exist in the database.

## Validate alternative templates

If set to true alternative templates will be validated

## Disable find content by ID path

When true, content can't be found by their ID meaning that urls such as /1234 do _not_ find content with ID 1234.

## Disable redirect URL tracking

When you move and rename pages in Umbraco, 301 permanent redirects are automatically created, set this to true if you do not want this behavior.

## URL provider mode

Will set the URL provider mode, options are:

* `Default`: Indicates that the URL provider should do what it has been configured to do.
* `Relative`: Indicates that the URL provider should produce relative URLs exclusively.
* `Absolute`: Indicates that the URL provider should produce absolute URLs exclusively.
* `Auto`: Indicates that the URL provider should determine automatically whether to return relative or absolute URLs.

## Umbraco application URL

Defines the Umbraco application URL that the server should reach itself. By default, Umbraco will guess that URL from the first request made to the server. Use this setting if the guess is not correct (because you are behind a load-balancer, for example). Format is: `http://www.mysite.com/`, ensure to contain the scheme (http/https) and complete hostname.

{% hint style="info" %}
Previously before v9, it was required to specify **backofffice** path as this was customizable (`/umbraco` by default). However, from v9+ this is no longer possible, so it's sufficient to use the URL that contains the scheme (http/https) and complete hostname.
{% endhint %}
