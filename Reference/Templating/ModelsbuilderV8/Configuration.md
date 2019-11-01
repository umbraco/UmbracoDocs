---
versionFrom: 8.0.0
---

# Configuration

The following configuration option can be set int the application settings (in the `appSettings` section of the `Web.config` file):

* `Umbraco.ModelsBuilder.Enable` can be `true` or `false` (default) and acts as a giant kill-switch: When `false`, Models Builder behaves as if it were not installed at all, and all other settings are ignored.

* `Umbraco.ModelsBuilder.ModelsMode` determines how Models Builder generates models. Valid values are:
    * `Nothing` (default): Do not generate models
    * `PureLive`: Generate models in a dynamic in-memory assembly
    * `AppData`: Generate models in `~/App_Data/Models` (but do not compile them) whenever the user clicks the "generate models" button in the Developer section
    * `LiveAppData`: Generate models in `~/App_Data/Models` (but do not compile them) anytime a content type changes

* `Umbraco.ModelsBuilder.EnableFactory` can be `true` (default) or `false` and determines whether Models Builder registers the built-in `IPublishedContentFactory`. When `false`, models could be generated, but would *not* be used by Umbraco.

* `Umbraco.ModelsBuilder.ModelsNamespace` (string, default is `Umbraco.Web.PublishedContentModels`) specifies the generated models' namespace.

* `Umbraco.ModelsBuilder.FlagOutOfDateModels` can be `true` (default) or `false` and indicates whether out-of-date models (i.e. after a content type or data type has been modified) should be flagged.

* `Umbraco.ModelsBuilder.ModelsDirectory` (string, default is `~/App_Data/Models`) indicates where to generate models and manage all files. Has to be a virtual directory (starting with `~/`) below the website root (see also: `AcceptUnsafeModelsDirectory`).

* `Umbraco.ModelsBuilder.AcceptUnsafeModelsDirectory` (bool, default is `false`) indicates that the directory indicated in `ModelsDirectory` is allowed to be outside the website root (e.g. `~/../../some/place`). Because that can be a potential security risk, it is not allowed by default.

* `Umbraco.ModelsBuilder.DebugLevel` (int, default is zero) indicates the debug level. For internal / development use. Set to greater than zero to enable detailed logging.

## Models Builder Dashboard

Models Builder ships with a dashboard in the *Settings* section of Umbraco's backoffice. The dashboard does three things:

* Details how Models Builder is configured
* Provides a way to generate models (in [Live]Dll and [Live]AppData modes only)
* Reports the last error (if any) that would have prevented models from being properly generated
