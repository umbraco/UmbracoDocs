---
versionFrom: 8.6.0
---

# KeepAlive

With the `keepAlive` element, you can configure two attributes:
- **disableKeepAliveTask**: Disables the periodic KeepAliveTask when set to `"true"`.   
      Use this setting to disable the KeepAliveTask in case you already have an alternative.   
      For example, Azure App Service has keep alive functionality built-in.
- **keepAlivePingUrl**: The url of the KeepAlivePing action. By default, the url will use the umbracoApplicationUrl setting as the basis.   
      Change this setting to specify an alternative url to reach the KeepAlivePing action. eg http://localhost/umbraco/api/keepalive/ping   
      Defaults to `"{umbracoApplicationUrl}/api/keepalive/ping"`.
      
Here's the default configuration of the `keepAlive` node:
```xml
<keepAlive disableKeepAliveTask="false" keepAlivePingUrl="{umbracoApplicationUrl}/api/keepalive/ping" />
```
