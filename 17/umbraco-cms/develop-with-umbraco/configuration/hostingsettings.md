---
description: "Information on the hosting settings section"
---

# Hosting settings

Hosting settings contains settings regarding the hosting of the site, such as application virtual path, local temporary storage location and debug.

A full configuration with default values can be seen here:

```json
"Umbraco": {
  "CMS": {
    "Hosting": {
      "ApplicationVirtualPath": "/",
      "LocalTempStorageLocation": "Default",
      "TemporaryFileUploadLocation"
      "Debug": false,
      "SiteName",
      "MachineIdentifier"
    }
  }
}
```

## Setting overview

### Application virtual path

This setting specified the virtual path of the application, this path must start with a slash.

### Local temp storage location

This setting specifies the location of the local temp storage.

Options:

* Default
* EnvironmentTemp

### Temporary file upload location

This setting specifies the location of the temporarily uploaded files, for instance, when uploading files in the media section. The `umbraco/Data/TEMP/TemporaryFile/` folder is used if not specified.

### Debug

This setting allows you to run Umbraco in debug mode, by setting the value to true.

### Site name

Gets or sets a value specifying the name of the site. The [IWebHostEnvironment.ApplicationName](https://docs.microsoft.com/en-us/dotnet/api/microsoft.extensions.hosting.ihostenvironment.applicationname?view=dotnet-plat-ext-6.0) is used if not specified

### Machine identifier

Set `MachineIdentifier` to a stable value that identifies this server instance. Umbraco uses the value to track cache synchronization state per server. The state determines whether a restart can resume from the last sync or must rebuild caches and indexes.

Set this property in environments where the OS hostname is not stable across restarts, such as Docker or Kubernetes.

{% hint style="info" %}
`MachineIdentifier` is available from Umbraco 17.6.
{% endhint %}
