---
versionRemoved: 8.0.0
---

# Web.config

### umbracoUseSSL

This setting is replaced by `Umbraco.Core.UseHttps` in v8.

Makes sure that all of the requests in the backoffice are called over HTTPS instead of HTTP when set to `true`.

```xml
<add key="umbracoUseSSL" value="true" />
```
