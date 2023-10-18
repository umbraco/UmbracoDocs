---


meta.Title: "Umbraco Runtime Minification Settings"
description: "Information on the runtime minification settings section"
---

# Runtime minification settings

This section allows you to configure the runtime minifications (defaults shown), used by ['Smidge - A lightweight runtime CSS/Javascript minification,combination, compression & management library for ASP.NET'](https://github.com/shazwazza/smidge)

```json
"Umbraco": {
  "CMS": {
    "RuntimeMinification": {
      "UseInMemoryCache": false,
      "CacheBuster": "Version"
    }
  }
}
```
## Use 'in memory' cache

This setting determines whether Smidge should save it's cached output in memory, or in a file on disk. If set to false, then the folder will be created at the wwwroot of your Umbraco site in a folder called 'Smidge'/

{% hint style="info" %}
It is not possible to disable in memory caching when `Timestamp` is chosen as `CacheBuster` method.
{% endhint %}

## Cache buster

Specifies mechanism for cache invalidation.

The options are:

* Version - Caches will be busted when your assembly version changes, when the upstream Umbraco version changes and when the version string specified in Configuration changes.
* AppDomain - Caches will be busted when the app restarts.
* Timestamp - Caches will be busted based on a timestamp of the bundled files.

## Manually changing the Cache buster version

If you use a CacheBuster setting of "Version" you can add an additional configuration option, also called 'Version' , which allows you to set a value that you can incremement manually, or via a build server to make sure the version number changes for Smidge and busts the cache.

```json
"Umbraco": {
  "CMS": {
    "RuntimeMinification": {
      "UseInMemoryCache": true,
      "CacheBuster": "Version",
      "Version": "1234"
    }
  }
}
```
The actual 'Version' number will not be visible in the url of the assets, this is because it is combined, along with the Umbraco Version from configuration and the your project assembly dll, and then once combined a 'hash' is generated to obscure these details.

in the HTML link thus: ```<link href='/sb/umbraco-backoffice-init-css.css.v7a71f91360259c5f7c3337f152b0df01eeee36f0' rel='stylesheet' type='text/css'/>``` (when [`Umbraco:CMS:Hosting:Debug:false`](hostingsettings.md))

So if you increased the Version in the configuration by 1 to 1235, all you would see is a different hash!

{% hint style="info" %}
For production environments, it's recommended to set Cache Buster to 'Version' (you don't actually need to supply a version number, but if you do, you can control when the cache breaks, eg if a package has installed new assets) or to 'AppDomain'.
{% endhint %}

Another configuration option (of Smidge) is the `"dataFolder`" setting, this setting specifies what folder Smidge will use for its temporary data, it should not be necessary to change this either, it will only be used if UseInMemoryCache is set to false.
