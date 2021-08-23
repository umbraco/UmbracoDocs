---
versionFrom: 9.0.0
meta.Title: "Umbraco configuration"
meta.Description: "Information on configuring Umbraco"
state: complete
verified-against: beta-3
update-links: true
---

# Configuration Files

In V9, we have moved away from the previous configuration using .config files, to instead using the netcore built-in configuration pattern. This means that there is no longer separate files for different configuration, the configuration is now primarily done from the `appsettings.json` file.

For more in depth information on the configuration pattern see Microsofts [Configuration in ASP.NET Core](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/configuration/?view=aspnetcore-5.0) article.

## Managing configuration

You might not always want to have the configuration stored in the `appsettings.json` file, for instance, you might not want to have the admin password in the file if using the unattended feature. You might also want to use a specific set of configurations when developing your solution, fortunately, the `IConfiguration` pattern.

With the configuration pattern the settings can be read from multiple different source, where some take precedence over other, you can configure you site with: 

1. The `appsettings.json` file
2. An `appsettings.{environment}.json` file
3. UserSecrets (Only when in development)
4. Environment variables
5. Command line arguments

This list is in order of precedence, so the values from `appSettings.json` will only be used if they're not also define in the environment variables, if they are then the environment variable will be used instead.

There is one caveat, to this precedence though, the `appSettings.{environment}.json` file will only be used if the current environment matches the name of the config file, for instance, the `appsettings.Development.json` file will only be used when the environment is set to development.

### Using environment variables for configuration

It is not feasible to have an entire json file as an environment variable, and the `:` doesn't work with environment variables on all platforms, so instead a double underscore is used to create the hierachy.

As an example, if you want to set your unattended username, you would normally write it in the `appsettings.json` like so: 

```json
"Umbraco": {
  "CMS": {
    "Unattended": {
      "UnattendedUserName": "A.N. Other"
    }
  }
}
```

As an environment variable it becomes a variable with the name `Umbraco__CMS__Unattended__UnattendedUserName` and a value of `A.N. Other`.

### Using command line arguments configuration

Like with environment variables, it's not feasable to use an entire json file as a command line argument. However, with the command line the `:` will work without issues, so each section of the hierarchy is seperated with a `:` character. If we use the same example as above, you can achieve the same result by using the following when starting the site via the command line:

`dotnet run Umbraco:CMS:Unattended:UnattendedUserName="A.N Other"`


## IntelliSense

A great thing about the `appsettings.json` is that it allows for intellisense with a schema file. For most ediors this should work out of the box, without having to configure anything, since the schema is specified in the top of the file like so `"$schema": "https://json.schemastore.org/appsettings.json"`.

## Reading configuration in code

You might need to read the configuration from your code. When reading the configuration you need to inject an `IOptions<>` object into the class that needs it, here is an example of how you'd read the the Host value from the SMTP settings contained within the global settings: 

```C#
using Microsoft.Extensions.Options;
using Umbraco.Cms.Core.Configuration.Models;

namespace MySite
{
    public class SomeClass
    {
        private GlobalSettings _globalSettings;

        public SomeClass(IOptions<GlobalSettings> globalSettings)
        {
            _globalSettings = globalSettings.Value;

            var smtpHost = _globalSettings.Smtp.Host;
        }
    }
}
```

First off `using Microsoft.Extensions.Options` is added, to gain access to the `IOptions` type, and `using Umbraco.Cms.Core.Configuration.Models;` is added to get access to the `GlobalSettings` type.

`IOptions<GlobalSettings>` is then injected into the constructor of the class, where we can use the `Value` property to gain access to the actual settings object.

Now we have a typed object containing our settings, so we can get the Host value by calling `_globalSettings.Smtp.Host`.

To see what setting types you can access see the complete list below, each document corresponds to a settings type.

## Configuration options

A complete list of all the configuration sections included in Umbraco by default can be seen here, along with any keys they contain:

* [Global settings](GlobalSettings/index.md)
* [Content settings](ContentSettings/index.md)
* [Imaging settings](ImagingSettings/index.md)
* [Serilog settings](Serilog/index.md)
* [Security settings](SecuritySettings/index.md)
* [Hosting settings](HostingSettings/index.md)
* [Models builder settings](ModelsBuilderSettings/index.md)
* [Unattended settings](UnattendedSettings/index.md)
* [Health checks settings](HealthChecks/index.md)
* [Connection strings settings](ConnectionStringsSettings/index.md)
* [Web routing settings](WebRoutingSettings/index.md)
* [Keep alive settings](KeepAliveSettings/index.md)
* [Request handler settings](RequestHandlerSettings/index.md)
* [Runtime minification settins](RuntimeMinificationSettings/index.md)
* [Tours settings](ToursSettings/index.md)
* [Rich text editor settings](RichTextEditorSettings/index.md)
* [Debug settings](DebugSettings/index.md)
* [Exception filter settings](ExceptionFilterSettings/index.md)
* [Examine settings](ExamineSettings/index.md)
* [NuCache settings](NuCacheSettings/index.md)
* [Runtime settings](RuntimeSettings/index.md)
* [Type finder settings](TypeFinderSettings/index.md)
* [Logging settings](LoggingSettings/index.md)
* [Plugins settings](PluginsSettings/index.md)
