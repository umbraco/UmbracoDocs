---
description: "Information on the models builder settings section"
---

# Models builder settings

This section allows you to configure the Umbraco models builder, a complete section with default values can be seen here:

```json
"Umbraco": {
  "CMS": {
    "ModelsBuilder": {
      "ModelsMode": "InMemoryAuto",
      "ModelsNamespace": "Umbraco.Cms.Web.Common.PublishedModels",
      "FlagOutOfDateModels": false,
      "ModelsDirectory": "~/umbraco/models",
      "AcceptUnsafeModelsDirectory": false,
      "DebugLevel": 0,
      "IncludeVersionNumberInGeneratedModels": true,
      "GenerateVirtualProperties": true
    }
  }
}
```

Let's go through them one by one.

## Models mode

Specifies how the models builder will generate models and when to generate them. The options are:

* `Nothing` - The modelsbuilder will not generate any models, this means that all views will use IPublishedContent, instead of strongly typed models.
* `InMemoryAuto` - Models will automatically be generated each time a content type change occurs, and will then be compiled, and loaded into memory dynamically. This means that the models are only available in views, however they will be available instantly.
* `SourceCodeManual` - Models will be generated as `.cs` files whenever a user clicks the "Generate models" button on the models builder dashboard - however, the models will not be compiled and loaded into memory dynamically. This means that models are available to edit within the project. The project needs to be recompiled and restarted for the new models, or model changes, to take effect.
* `SourceCodeAuto` - This mode behaves the same as `SourceCodeManual` with one difference, the generation of models happens automatically every time a content type change occurs.

{% hint style="info" %}
When using Models Builder it is best practice to use the "Nothing" setting for all `appsettings.json` files. If needed, the models mode can then be set to "SourceCodeManual" or "SourceCodeAuto" In the `appsettings.json` file used on the local environment.
{% endhint %}

## Models namespace

This setting allows you to customize the namespace of the generated models, for instance you might want to change this to something that aligns better with your project structure, such as `MySite.ContentModels`.

## Flag out of date models

This setting allows you to specify if a model should be flagged as out of date if its content type, or a datatype the content type depends on, are changed. When a model is flagged as out of date you will be able to see that you need to regenerated models in modelsbuilder dashboard.

This setting is only really relevant if you use the `SourceCodeManual` models mode, since otherwise the models will be automatically regenerated, and will therefore never be out of date.

If you set this setting to true while using an `Auto` mode, it will automatically be interpreted as false.

## Models directory

Allows you to specify a custom directory for your generated models. By default this settings has to be a virtual directory, that is, it must start with `~/`, if needed `AcceptUnsafeModelsDirectory` can be set to true, to allow the path to be outside the website root, be aware though that this is a potential security risk.

{% hint style="info" %}
If you want to generate models outside the web project you can change the ModelsDirectory path. Suppose you have a data project called My.Website.Data the ModelsDirectory path should be:

`~/../My.Website.Data/Models/`
{% endhint %}

## Accept unsafe models directory

By setting this to true, you specify that the models directory is allowed to be outside the websites root. This is not allowed by default since it can be a potential security risk.

## Debug level

This setting specifies the logging level for the models builder. By default this is set to 0, which means minimal logging. Anything higher that 0 means increased logging. Be aware that this setting should only be set to something higher than 0 for development use, not on live sites.

## Include version number in generated models

When source code options are used, the Umbraco version number written to the generated code for each property of the model. This can be useful for debugging purposes but isn't essential. It causes the generated code to change every time Umbraco is upgraded and models are regenerated. In turn, this leads unnecessary code file changes that need to be checked into source control.

If you prefer to exclude this version number from being written to the generated code, set this value to `false`.

## Generate virtual properties

By default, the models will be generated with all properties marked as `virtual` for extensibility purposes. You can disable `virtual` properties by setting this to `false`.

{% hint style="info" %}
[Hot Reload](https://learn.microsoft.com/en-us/aspnet/core/test/hot-reload) does not support changing or adding `virtual` properties while the application is running.

If you plan to use Hot Reload while developing your Umbraco site, set this setting to `false`.
{% endhint %}
