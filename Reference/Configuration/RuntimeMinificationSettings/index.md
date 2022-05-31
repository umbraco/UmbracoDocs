---
versionFrom: 9.0.0
meta.Title: "Umbraco Runtime Minification Settings"
meta.Description: "Information on the runtime minification settings section"
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

## Use in memory cache

Specifies if Smidge should use an in memory cache or not.

## Cache buster

Specifies what type of cache buster to use, the options are:

* Version - Caches will be busted every time the version string changes.
* AppDomain - Caches will be busted when the app restarts.
* Timestamp - Caches will be busted based on a timestamp.

## Automatically generated settings

If you use a CacheBuster setting of "Version" you can add an additional configuration option, also called 'Version'  

```json
"Umbraco": {
  "CMS": {
    "RuntimeMinification": {
      "UseInMemoryCache": false,
      "CacheBuster": "Version",
      "Version": "1234"
    }
  }
}
```

to control the version number generated in the HTML link thus: ```<link href='/sc/69a3dbf6.1cf661e7.css.v1234' rel='stylesheet' type='text/css'/>```

:::note
Generally you don't need to add this. However, if you're making some front end changes and not seeing the change, then you can add this option and increase the number by one each time, clearing the cache and rendering the change.
:::

Another configuration option is the `"dataFolder`" setting, this setting specifies what folder Smidge will use for its temporary data, it should not be necessary to change this either.
