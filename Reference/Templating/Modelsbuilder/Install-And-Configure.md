# Install and configure Umbraco Models Builder

## Install

In order for Models Builder to be used in a website, the [Umbraco.ModelsBuilder NuGet package](https://www.nuget.org/packages/Umbraco.ModelsBuilder/) needs to be installed. From Umbraco 7.4+, Models Builder is bundled with the main Umbraco distribution.

## Configure

Then, the following application settings (in the `appSettings` section of the `Web.config` file) control what Models Builder actually does:

* `Umbraco.ModelsBuilder.Enable` can be `true` or `false` (default) and acts as a giant kill-switch: When `false`, Models Builder behaves as if it were not installed at all, and all other settings are ignored.

* `Umbraco.ModelsBuilder.ModelsMode` determines how Models Builder generates models. Valid values are:
    * `Nothing` (default): Do not generate models
    * `PureLive`: Generate models in a dynamic in-memory assembly
    * `Dll`: Generate models in a Dll in `~/bin` (causes an application restart) whenever the user clicks the "generate models" button in the Developer section
    * `LiveDll`: Generate models in a Dll in `~/bin` (causes an application restart) anytime a content type changes
    * `AppData`: Generate models in `~/App_Data/Models` (but do not compile them) whenever the user clicks the "generate models" button in the Developer section
    * `LiveAppData`: Generate models in `~/App_Data/Models` (but do not compile them) anytime a content type changes

* `Umbraco.ModelsBuilder.EnableFactory` can be `true` (default) or `false` and determines whether Models Builder registers the built-in `IPublishedContentFactory`. When `false`, models could be generated, but would *not* be used by Umbraco.

* `Umbraco.ModelsBuilder.ModelsNamespace` (string, default is `Umbraco.Web.PublishedContentModels`) specifies the generated models' namespace.

* `Umbraco.ModelsBuilder.LanguageVersion` (string, default is `CSharp5`) indicates the C# language version which is used when compiling the models in [`Live`]`Dll`. Can be set to `CSharp6` or `Experimental` to try the new C# features.

* `Umbraco.ModelsBuilder.FlagOutOfDateModels` can be `true` (default) or `false` and indicates whether out-of-date models (i.e. after a content type or data type has been modified) should be flagged.

* `Umbraco.ModelsBuilder.StaticMixinGetters` can be `true` (default) or `false` and indicates whether static mixin getters should be generated.

* `Umbraco.ModelsBuilder.StaticMixinGetterPattern` (string, default is `Get{0}`) indicates the format of the static mixin getters.

* `Umbraco.ModelsBuilder.ModelsDirectory` (string, default is `~/App_Data/Models`) indicates where to generate models and manage all files. Has to be a virtual directory (starting with `~/`) below the website root (see also: `AcceptUnsafeModelsDirectory`).

* `Umbraco.ModelsBuilder.AcceptUnsafeModelsDirectory` (bool, default is `false`) indicates that the directory indicated in `ModelsDirectory` is allowed to be outside the website root (e.g. `~/../../some/place`). Because that can be a potential security risk, it is not allowed by default.

* `Umbraco.ModelsBuilder.DebugLevel` (int, default is zero) indicates the debug level. For internal / development use. Set to greater than zero to enable detailed logging.

## Models Builder Dashboard

When Models Builder is installed, a new dashboard is added to the *Developers* section of Umbraco's backoffice. The dashboard does three things:

* Details how Models Builder is configured
* Provides a way to generate models (in [Live]Dll and [Live]AppData modes only)
* Reports the last error (if any) that would have prevented models from being properly generated

## Models Builder API

In addition, in order for Models Builder to provide the API needed by the Visual Studio extension (or the console tool), **the [Umbraco.ModelsBuilder.Api NuGet package](https://www.nuget.org/packages/Umbraco.ModelsBuilder.Api/) needs to be installed**, and the following application setting needs to be configured:

* `Umbraco.ModelsBuilder.EnableApi` can be `true` or `false` (default) and controls whether Models Builder provides the API.

**WARNING:** The API is provided when the website runs in debug mode, exclusively. Which means that the `debug` attribute of `Web.config`'s `<compilation>` element must be set to `true`.
	
