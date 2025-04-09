---
meta.Title: Umbraco Maximum upload size settings
description: Information on how to change the default cap of upload size
---

# Maximum Upload Size Settings

Umbraco does not touch the default maximum allowed content size of the different services, but you can configure this yourself.

## Using IIS

To configure the default 28.6MB upload limit using IIS, we have to create a web.config file at the root of the project. It should contain this:

```xml
<?xml version="1.0"?>
<configuration>
  <system.webServer>
    <security>
      <requestFiltering>
        <!-- ~ Below is the number of bytes allowed, 4GB is the maximum -->
        <requestLimits maxAllowedContentLength="2000000" />
      </requestFiltering>
    </security>
  </system.webServer>
</configuration>
```

`maxAllowedContentLength` is specified in bytes, so this configuration would limit requests, and therefore uploaded files, to 2 megabytes

{% hint style="info" %}
**Are you hosting your site on Umbraco Cloud?**

Umbraco Cloud uses IIS for hosting. This means you need to add the setting in a `web.config` file for this to work on your Umbraco Cloud hosted sites. The upload size limit is 500mb on Umbraco Cloud.
{% endhint %}

## Using Kestrel

Runtime settings allow you to configure the `MaxRequestLength` and `MaxQueryStringLength` for kestrel. If you want to upload files larger than 28.6MB, then you have to configure these settings. If nothing is configured requests and query strings can only be the default size and smaller.

An example of a configuration could look something like this:

```json
"Umbraco": {
  "CMS": {
    "Runtime": {
      "MaxQueryStringLength": 90,
      "MaxRequestLength": 2000
    }
  }
}
```

`MaxRequestLength` is specified in kilobytes. This configuration will limit requests, and therefore uploaded files, to 2 megabytes, and a maximum query string length of 90 characters.

## [Using Nginx (external)](https://nginx.org/en/docs/http/ngx_http_core_module.html#client_max_body_size)

## [Using apache (external)](https://httpd.apache.org/docs/2.2/mod/core.html#limitrequestbody)
