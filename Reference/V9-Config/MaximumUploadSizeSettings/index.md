---
versionFrom: 9.0.0
meta.Title: "Umbraco Maximum upload size settingsg"
meta.Description: "Information on how to change the default cap of upload size"
---

Umbraco does not touch the default maximum allowed content size of the different services, but you can configure this yourself.

# Using IIS

To configure the default 28.6mb upload limit using IIS, we have to create a web.config file in the root of the project. It should contain this:
```
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

# Using Kestrel

Runtime settings allows you to configure the `MaxRequestLength` and `MaxQueryStringLength` for kestrel. If you want to upload files larger than 28.6mb, then you have to configure these seetings. If nothing is configured reqests and query string can only be the default size and smaller.

An example of a configuration could look something like: 

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

`MaxRequestLength` is specified in kilobytes, so this configuration would limit requests, and therefore uploaded files, to 2 megabytes, and a maximum query string length of 90 characters.

# Using nginx

Here's the documentation link to nginx: 
https://nginx.org/en/docs/http/ngx_http_core_module.html#client_max_body_size

# Using apache

Here's the documentation link to apache:
https://httpd.apache.org/docs/2.2/mod/core.html#limitrequestbody