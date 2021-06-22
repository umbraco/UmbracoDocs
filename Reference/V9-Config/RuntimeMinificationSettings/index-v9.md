---
versionFrom: 9.0.0
meta.Title: "Umbraco Runtime Minification Settings"
meta.Description: "Information on the runtime minification settings section"
state: complete
verified-against: beta-3
update-links: true
---

# Runtime minification settings

This section allows you to configure the runtime minifications.

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

You might see a setting `"version"` with a long number after it, this setting is generated if you use the `Version` type cache buster, generally you don't need to change this. However. if you're making some front end changes, and not seeing the change, then you can increase this number by one, clearing the cache and now you should see the change.

Another setting you might see be populated is the `"dataFolder`" setting, this setting specifies what folder Smidge will use for its temporary data, it should not be nececary to change this.