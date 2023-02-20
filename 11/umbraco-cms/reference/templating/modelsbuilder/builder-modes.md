---
description: "Modelsbuilder modes"
---

# Builder Modes

Models Builder can be used in different modes:

* InMemory models
* SourceCode models

The mode is indicated by the `Umbraco:CMS:ModelsBuilder:ModelsMode` key in the configuration (`appsettings.json` files).

## In memory

Corresponds to the `InMemoryAuto` setting value.

With **InMemory** models, models are generated and compiled on the fly, in memory, at runtime. They are available in views exclusively.

This is for a setup that exclusively uses the Umbraco backoffice, and do not use custom code such as controllers. Whenever a content type is modified, models are updated without restarting Umbraco (in the same way .cshtml views are recompiled).

Generation *can* fail for various reasons, in which case Umbraco will run without models (and front-end views fail to render). Umbraco's log file should contain all details about what prevented the generation, but it is probably faster to check the Models Builder dashboard, which should report the last error that was encountered, if any.

Models Builder maintains some files in `~/umbraco/Data/TEMP/InMemoryAuto`:

* `models.generated.cs` contains the generated models code
* `all.generated.cs` contains the compiled code (models merged with non-generated files)
* `models.hash` contains a hash code of the content types
* `all.dll.path` contains the path to the compiled DLL file containing all the models
* `Compiled/generated.cs{GUID}.dll` the dll containing all the generated models
* `models.err` contains the last generation error information, if any

The `models.hash` file is used when Umbraco restarts, to figure out whether models have changed and need to be re-generated. Otherwise, the local `models.generated.cs` file is reused.

## SourceCode Models

Corresponds to the `SourceCodeManual` and `SourceCodeAuto` setting values.

With **SourceCode** models, models are generated in the `~/umbraco/models` directory, and that is all. It is then up to you to decide how to compile the models (e.g. by including them in a Visual Studio solution).

Generation *can* fail for various reasons, in which case no models are generated. Umbraco's log file should contain all details about what prevented the generation, but it is probably faster to check the Models Builder dashboard, which should report the last error that was encountered, if any.

The modelsbuilder works much in the same way whether using `SourceCodeManual` or `SourceCodeAuto`. The only real difference between the two are that with `SourceCodeManual` you must manually trigger the generation of the models from the models builder dashboard, whereas with `SourceCodeAuto` the models are automatically generated whenever content types change.

## API models and Dll Models

These modes are not available in the embedded version of Models Builder. See the full version of [ModelsBuilder](https://github.com/zpqrtbnk/Zbu.ModelsBuilder).
