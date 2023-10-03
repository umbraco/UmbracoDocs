---


meta.Title: "Umbraco Keep Alive Settings"
description: "Information on the keep alive settings section"
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

If you want to change the URL you need to call to keep the site alive, update this property. The URL should not contain a trailing slash.
