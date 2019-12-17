---
versionFrom: 7.0.0
---

# Builder Modes

Models Builder can be used in different modes:

* PureLive models
* Dll models
* AppData models
* API models

The mode is indicated by the `Umbraco.ModelsBuilder.ModelsMode` key in the `appSettings` section of the `Web.config` file.

## Pure Live Models

Corresponds to the `PureLive` setting value.

With **PureLive** models, models are generated and compiled on the fly, in memory, at runtime. They are available in views exclusively. This is for people who exclusively use the Umbraco backoffice, and probably do not write custom code such as controllers anyway. Whenever a content type is modified, models are updated without restarting Umbraco (in the same way .cshtml views are recompiled).

If the `~/App_Data/Models` directory contains any non-generated C# files (i.e. `*.cs` but not `*.generated.cs`), Models Builder parses these files for instructions, and includes them in the compilation (see [documentation for configuring and extending models](Control-Generation-v7.md)).

Generation _can_ fail for various reasons, in which case Umbraco will run without models (and front-end views probably fail to render). Umbraco's log file should contain all details about what prevented the generation, but it is probably faster to check the Models Builder dashboard, which should report the last error that was encountered, if any.

Models Builder maintains some files in `~/App_Data/Models`:

* `models.generated.cs` contains the generated models code
* `all.generated.cs` contains the compiled code (models merged with non-generated files)
* `models.hash` contains a hash code of the content types
* `models.err` contains the last generation error information, if any

The `models.hash` file is used when Umbraco restarts, to figure out whether models have changed and need to be re-generated. Otherwise, the local `models.generated.cs` file is reused.

## Dll Models

Corresponds to the `Dll` and `LiveDll` setting values.

With **Dll** models, models are generated in the `~/App_Data/Models` directory, then compiled into a Dll that is copied into `~/bin`, thus restarting the application. Models must be generated explicitly from the dashboard or the content type editor.

If the `~/App_Data/Models` directory contains any non-generated C# files (i.e. `*.cs` but not `*.generated.cs`), Models Builder parses these files for instructions, and includes them in the compilation (see [documentation for configuring and extending models](Control-Generation-v7.md)).

Because models are in a Dll, they become visible to custom code, controllers, etc. and can even be referenced in Visual Studio to benefit from Intellisense.

Generation _can_ fail for various reasons, in which case Umbraco will run without models (and front-end views probably fail to render). Umbraco's log file should contain all details about what prevented the generation, but it is probably faster to check the Models Builder dashboard, which should report the last error that was encountered, if any.

**LiveDll** models work much in the same way, except that generation takes place automatically whenever content types change. This means that Umbraco will restart anytime a content type is modified, which is not very efficient. You probably do _not_ want to use LiveDll models.

## AppData Models

Corresponds to the `AppData` and `LiveAppData` setting values.

With **AppData** models, models are generated in the `~/App_Data/Models` directory, and that is all. It is then up to you to decide how to compile the models (e.g. by including them in a Visual Studio solution).

If the `~/App_Data/Models` directory contains any non-generated C# files (i.e. `*.cs` but not `*.generated.cs`), Models Builder parses these files for instructions (see [documentation for configuring and extending models](Control-Generation-v7.md)).

Generation _can_ fail for various reasons, in which case no models are generated. Umbraco's log file should contain all details about what prevented the generation, but it is probably faster to check the Models Builder dashboard, which should report the last error that was encountered, if any.

**LiveAppData** models work much in the same way, except that generation takes place automatically whenever content types change. Because generation does not cause any compilation, it does not cause Umbraco to restart, either.

## API models

With **API** models, Models Builder does _not_ generate models into the Umbraco website, but exposes an API that allows external tools to retrieve models. The Models Builder source code contains a sample console tool that connects to the website and retrieves models. In addition, a [Visual Studio extension](https://marketplace.visualstudio.com/items?itemName=ZpqrtBnk.UmbracoModelsBuilderExtension) is available, which enables models generation straight from Visual Studio.

In both cases **an additional NuGet package must be installed** into the site [Umbraco.ModelsBuilder.Api](https://www.nuget.org/packages/Umbraco.ModelsBuilder.Api/), and the API must be enabled, see [Install And Configure](configuration-v7.md).

Although it is possible to enable the API while still generating models into the Umbraco website, this probably does not make much sense. Therefore, you will want to set the `Umbraco.ModelsBuilder.ModelsMode` to `Nothing` (or remove it entirely). Do _not_ disable Models Builder entirely, though, as that would also disable the models factory (i.e., models would be ignored).

When the Visual Studio extension is installed:

- **Enable API mode**
  The `<appSettings>` part of your root `Web.config` file should contain the following lines:

  ```xml
  <add key="Umbraco.ModelsBuilder.Enable" value="true"/>
  <add key="Umbraco.ModelsBuilder.ModelsMode" value="Nothing"/>
  <add key="Umbraco.ModelsBuilder.EnableApi" value="true"/>
  ```

  This will ensure that Models Builder will run in the **Nothing** mode as explained above, and the API will be activated for the Visual Studio extension to call.

- **Enable debug mode**
  The API will only work when your Umbraco installation is running in debug mode. This is done by going to the root `Web.config`, and finding the `<compilation />` element. The `debug` attribute is `false` by default, so change it to `true`:

  ```xml
  <compilation defaultLanguage="c#" debug="true" batch="true" targetFramework="4.7.2" numRecompilesBeforeAppRestart="50" />
  ```

  Your live environment shouldn't be running in debug mode, so it's recommended building the models locally.

- **Configure the Visual Studio extension**
  In order for the Models Builder extension to access the API, you must enter a few options about your Umbraco installation. You can find the options in Visual Studio by going to **Tools** | **Options** | **Umbraco** | **ModelsBuilder Options**, and then fill out the following options:

    * **Site Url**
    The base url of the Umbraco website, eg `http://example.com`.

    * **User Name**
    The name of the user to connect to Umbraco (must be dev).

    * **User Password**
        The password of the user.

- **Create a container**
  Models Builder needs a container under which it will add the generated models. In a folder of your choice, create a file with the `.mb` file extension - eg. `UmbracoModels.mb`. The contents of the file is not important, so you can leave it empty.

- **Build the models**
  With everything above in place, you can right click on your `UmbracoModels.mb` file, and click the **Build models** action. Models Builder will now pull the needed information from the API, and create your models under the container file.

  You'll be able to see the result in the **Output** tab in Visual Studio. If the models were build successfully, the **Output** tab should show something like:

  ```
  UmbracoModelsBuilder: Starting v8.1.5 15/09/2019 12:50:18.
  UmbracoModelsBuilder: Done.
  ```

  However should generating the models fail, there's usually some clues in the **Output** tab about what when wrong.

The files you'll now find under the `UmbracoModels.mb` container file are the generated models. They are automatically added to the Visual Studio project and will be compiled alongside the rest of your project. Anytime you need to refresh the models you can run the **Build models** action again.

If there are some non-generated C# files (i.e. `*.cs` but not `*.generated.cs`) in the folder, Models Builder will parse them for instructions (see [documentation for configuring and extending models](Control-Generation-v7.md)) and Visual Studio will compile them too.

In order for Visual Studio to compile the project successfully, it needs to reference the Models Builder Dll, so you probably want to install the [Models Builder NuGet package](https://www.nuget.org/packages/Umbraco.ModelsBuilder/) in the project.

**Note**: The settings/options (URL, username and password) are saved _for each solution_ in a file named after the solution, i.e. for solution `<solution>.sln` the file would be `<solution>.UmbracoModelsBuilder.user` in the same directory. It is therefore possible to switch between solutions without re-entering the settings. Because the file contains a password and is relevant to one developer only, it _should not_ be source-controlled.
