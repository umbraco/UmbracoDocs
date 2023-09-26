---

meta.Title: "Umbraco Hosting Settings"
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
      "Debug": false,
      "SiteName"
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

### Debug

This setting allows you to run Umbraco in debug mode, by setting the value to true.

### Site name

Gets or sets a value specifying the name of the site. The [IWebHostEnvironment.ApplicationName](https://docs.microsoft.com/en-us/dotnet/api/microsoft.extensions.hosting.ihostenvironment.applicationname?view=dotnet-plat-ext-6.0) is used if not specified
