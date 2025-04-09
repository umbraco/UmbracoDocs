---
description: >-
  Details an integration available for Cookiebot, built and maintained by
  Umbraco HQ.
---

# CookieBot

This integration provides an implementation model for the [Cookiebot](https://www.cookiebot.com/) banner and declaration.

## Package Links

* [NuGet install](https://www.nuget.org/packages/Umbraco.Cms.Integrations.Analytics.Cookiebot)
* [Source code](https://github.com/umbraco/Umbraco.Cms.Integrations/tree/main/src/Umbraco.Cms.Integrations.Analytics.Cookiebot)
* [Umbraco marketplace listing](https://marketplace.umbraco.com/package/umbraco.cms.integrations.analytics.cookiebot)

## Minimum version requirements

To ensure compatibility, check the **Dependencies** tab on NuGet for the required Umbraco CMS version. For example, see [Umbraco.Cms.Integrations.Analytics.Cookiebot](https://www.nuget.org/packages/Umbraco.Cms.Integrations.Analytics.Cookiebot#dependencies-body-tab).

## Configuration

The following configuration is required for the Cookiebot scripts to be loaded correctly:

{% code title="appsettings.json" %}
```json
"Umbraco": {
  "Cookiebot": {
    "Settings": {
      // CBID = Cookiebot Identifier
      "Id": "[YOUR_CBID]"
    }
  }
}
```
{% endcode %}

## Templating

The package is a reusable [Razor class library](https://learn.microsoft.com/en-us/aspnet/core/razor-pages/?view=aspnetcore-6.0\&tabs=visual-studio) that will allow editors to load the Cookiebot Banner and Declaration scripts.

The banner script needs to be inserted as the **first script** of the website, by placing it within the `<head></head>` tag using this syntax:

```csharp
@await Html.PartialAsync("~/Views/Partials/UmbracoCms.Integrations/Analytics/Cookiebot/Banner.cshtml")
```

The Declaration script can be added to whatever page you want, using this syntax:

```csharp
@await Html.PartialAsync("~/Views/Partials/UmbracoCms.Integrations/Analytics/Cookiebot/Declaration.cshtml")
```

Both scripts "pick up" `CBID` from the website's configuration file and update the details accordingly.

## Custom Implementations

This integration demonstrates how an Umbraco package can be used as an integration with a script-based provider, using partial views and the `IConfiguration` interface.

You can use this package as a reference for creating integrations with other providers using scripts:

1. Create a new Razor class library for your integration.
2. Add partial views where you insert your custom script code.
3. Inject the `IConfiguration` interface into your view: `@inject Microsoft.Extensions.Configuration.IConfiguration Configuration`.
4. Use `Configuration[YOUR_SETTINGS_PATH:KEY]` to retrieve the required configuration values.
5. Add `umbraco-marketplace.json` file with Marketplace details of the package.

Once your integration is ready, all that remains to do is to [deploy the package to NuGet](https://learn.microsoft.com/en-us/nuget/what-is-nuget).
