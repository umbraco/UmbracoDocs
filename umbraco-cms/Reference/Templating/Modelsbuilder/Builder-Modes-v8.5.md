---
versionFrom: 8.5.0
---

# Builder Modes

Models Builder can be used in different modes:

* PureLive models
* AppData models

The mode is indicated by the `Umbraco.ModelsBuilder.ModelsMode` key in the `appSettings` section of the `Web.config` file.

## Pure Live Models

Corresponds to the `PureLive` setting value.

With **PureLive** models, models are generated and compiled on the fly, in memory, at runtime. They are available in views exclusively. 

This is for a setup that exclusively uses the Umbraco backoffice, and do not use custom code such as controllers. Whenever a content type is modified, models are updated without restarting Umbraco (in the same way .cshtml views are recompiled).

If the `~/App_Data/Models` directory contains any non-generated C# files (i.e. `*.cs` but not `*.generated.cs`), Models Builder parses these files for instructions, and includes them in the compilation (see [documentation for configuring and extending models](Control-Generation.md)).

Generation *can* fail for various reasons, in which case Umbraco will run without models (and front-end views fail to render). Umbraco's log file should contain all details about what prevented the generation, but it is probably faster to check the Models Builder dashboard, which should report the last error that was encountered, if any.

Models Builder maintains some files in `~/App_Data/Models`:

* `models.generated.cs` contains the generated models code
* `all.generated.cs` contains the compiled code (models merged with non-generated files)
* `models.hash` contains a hash code of the content types
* `models.err` contains the last generation error information, if any

The `models.hash` file is used when Umbraco restarts, to figure out whether models have changed and need to be re-generated. Otherwise, the local `models.generated.cs` file is reused.

## AppData Models

Corresponds to the `AppData` and `LiveAppData` setting values.

With **AppData** models, models are generated in the `~/App_Data/Models` directory, and that is all. It is then up to you to decide how to compile the models (e.g. by including them in a Visual Studio solution).

If the `~/App_Data/Models` directory contains any non-generated C# files (i.e. `*.cs` but not `*.generated.cs`), Models Builder parses these files for instructions (see [documentation for configuring and extending models](Control-Generation.md)).

Generation *can* fail for various reasons, in which case no models are generated. Umbraco's log file should contain all details about what prevented the generation, but it is probably faster to check the Models Builder dashboard, which should report the last error that was encountered, if any.

**LiveAppData** models work much in the same way, except that generation takes place automatically whenever content types change. Because generation does not cause any compilation, it does not cause Umbraco to restart, either.

## API models and Dll Models

These modes are not available in the embedded version of Models Builder. See the full version of [ModelsBuilder](https://github.com/zpqrtbnk/Zbu.ModelsBuilder).
