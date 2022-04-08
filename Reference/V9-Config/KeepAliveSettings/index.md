---
versionFrom: 9.0.0
meta.Title: "Umbraco Keep Alive Settings"
meta.Description: "Information on the keep alive settings section"
state: complete
verified-against: 9.5.0
update-links: true
---

# Keep alive settings

Allows you to configure the keep alive service of Umbraco. A keep alive section fully populated with default values can be seen here:

```json
"Umbraco": {
  "CMS": {
    "KeepAlive": {
      "DisableKeepAliveTask": false,
      "KeepAlivePingUrl": "~/api/keepalive/ping"
    }
  }
}
```

### Disable keep alive task

Allows you to disable the keep alive http calls.

### Keep alive ping URL

If you want to change the url you need to call to keep the site alive, update this property, it should not contain a trailing slash.

:::note Due to a bug this setting is ignored [pre v9.5.0](https://github.com/umbraco/Umbraco-CMS/pull/12224) :::
