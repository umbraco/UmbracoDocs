---
versionFrom: 9.0.0
meta.Title: "Umbraco Keep Alive Settings"
meta.Description: "Information on the keep alive settings section"
state: complete
verified-against: beta-3
update-links: true
---

# Keep alive settings

Allows you to configure the keep alive service of Umbraco. A keep alive section fully populated with default values can be seen here:

```json
"Umbraco": {
  "CMS": {
    "KeepAlive": {
      "DisableKeepAliveTask": false,
      "KeepAlivePingUrl": "{umbracoApplicationUrl}/api/keepalive/ping"
    }
  }
}
```

### Disable keep alive task

Allows you to disable the keep alive http calls.

### Keep alive pung URL

If you want to change the url you need to call to keep the site alive, update this property.
