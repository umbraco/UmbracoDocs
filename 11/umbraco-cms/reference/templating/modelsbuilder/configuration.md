---
description: Explanation of how to configure models builder
---

# Configuration

The following configuration option can be set in the application settings (in the `appsettings.json` file):

* `Umbraco.CMS.ModelsBuilder.ModelsMode` determines how Models Builder generates models. Valid values are:
  * `Nothing`: Do not generate models.
  * `InMemoryAuto`(default): Generate models in a dynamic in-memory assembly.
  * `SourceCodeManual`: Generate models in `~/umbraco/models` (but do not compile them) whenever the user clicks the "Generate models" button on the Models Builder dashboard in the Settings section.
  * `SourceCodeAuto`: Generate models in `~/umbraco/models` (but do not compile them) anytime a content type changes.
* `Umbraco.CMS.ModelsBuilder.ModelsNamespace` (string, default is `Umbraco.Cms.Web.Common.PublishedModels`) specifies the generated models' namespace.
* `Umbraco.CMS.ModelsBuilder.FlagOutOfDateModels` (bool, default is `true`) indicates whether out-of-date models (for example after a content type or Data Type has been modified) should be flagged.
* `Umbraco.CMS.ModelsBuilder.ModelsDirectory` (string, default is `~/umbraco/models`) indicates where to generate models and manage all files. Has to be a virtual directory (starting with `~/`) below the website root (see also: `AcceptUnsafeModelsDirectory` below).
* `Umbraco.CMS.ModelsBuilder.AcceptUnsafeModelsDirectory` (bool, default is `false`) indicates that the directory indicated in `ModelsDirectory` is allowed to be outside the website root (e.g. `~/../../some/place`). Due to this being a potential security risk, it is not allowed by default.
* `Umbraco.CMS.ModelsBuilder.DebugLevel` (int, default is zero) indicates the debug level. Set to greater than zero to enable detailed logging. For internal / development use.

## Example Configuration

The example below shows an example configuration using the SourceCodeManual mode.

```json
{
  "$schema": "https://json.schemastore.org/appsettings.json",
  "Umbraco": {
    "CMS": {
      "ModelsBuilder": {
        "ModelsMode": "SourceCodeManual"
      }
    }
  }
}
```

{% hint style="info" %}
It is recommended to generate models in your development environment only and change the ModelsMode to `Nothing` for your staging and production environments.
{% endhint %}

## Models Builder Dashboard

Models Builder ships with a dashboard in the _Settings_ section of Umbraco's backoffice. The dashboard does three things:

* Details on how Models Builder is configured
* Provides a way to generate models (in SourceCodeManual mode only)
* Reports the last error (if any) that would have prevented models from being properly generated

![Models Builder Dashboard](images/ModelsBuilderDashboard-v9.png)
