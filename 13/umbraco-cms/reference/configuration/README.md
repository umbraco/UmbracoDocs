---
description: Information on configuring Umbraco
---

# Configuration

In Umbraco 9+, we have moved away from the previous configuration using `.config` files, to instead using the .NET built-in configuration pattern. This means that there is no longer separate files for different configuration, the configuration is now primarily done using `IConfiguration` with different sources. E.g. The `appsettings.json` file.

For more in depth information on the configuration pattern see Microsofts [Configuration in ASP.NET Core](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/configuration/?view=aspnetcore-6.0) article.

## Managing Configuration

You might not always want to have the configuration stored in the `appsettings.json` file, for instance, you might not want to have the admin password in the file if using the unattended feature. You might also want to use a specific set of configurations when developing your solution. To achieve this, the `IConfiguration` pattern can be used for this.

With the configuration pattern the settings can be read from multiple different source, where some take precedence over other, you can configure you site with:

1. The `appsettings.json` file
2. An `appsettings.{environment}.json` file
3. UserSecrets (Only when in development)
4. Environment variables
5. Command line arguments

This list is in order of precedence, so the values from `appsettings.json` will only be used if they're not also defined in the environment variables. If they are, then the environment variable will be used instead.

There is one caveat, to this precedence though, the `appsettings.{environment}.json` file will only be used if the current environment matches the name of the config file, for instance, the `appsettings.Development.json` file will only be used when the environment is set to development.

### Using Environment Variables for Configuration

It is not feasible to have an entire json file as an environment variable, and the `:` doesn't work with environment variables on all platforms, so instead a double underscore is used to create the hierarchy.

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

### Using Command Line Arguments Configuration

Like with environment variables, it's not feasible to use an entire JSON file as a command line argument. However, with the command line the `:` will work without issues, so each section of the hierarchy is separated with a `:` character. If we use the same example as above, you can achieve the same result by using the following when starting the site via the command line:

`dotnet run Umbraco:CMS:Unattended:UnattendedUserName="A.N Other"`

### Using UserSecrets for Configuration

In the development environment it is possible to use UserSecrets for configuration, which is ideal for connection strings and similar settings that shouldn't be committed to source control. To use UserSecrets you need to first enable them for the project - this is done with the following command, issued within the directory that contains the `.csproj` file:

`dotnet user-secrets init`

Now it's possible to store the connection string with this command:

`dotnet user-secrets set "ConnectionStrings:umbracoDbDSN" "CONNECTION_STRING_IN_HERE"`

The name of the key is created in the same way as in the [Command Line](./#using-command-line-arguments-configuration) example above, and thus corresponds to this JSON chunk:

```json
"ConnectionStrings": {
    "umbracoDbDSN": "CONNECTION_STRING_IN_HERE"
}
```

## IntelliSense

A great thing about `appsettings.json` is that it allows for intellisense with a schema file. For most editors this should work out of the box, without having to configure anything, since the schema is specified in the top of the file like so: `"$schema": "https://json.schemastore.org/appsettings.json"`.

## Reading Configuration in Code

You might need to read the configuration from your code.

When reading the configuration you need to inject an [`IOptions<>`](https://docs.microsoft.com/en-us/dotnet/api/microsoft.extensions.options.ioptions-1?view=dotnet-plat-ext-6.0) or [`IOptionsMonitor<>`](https://docs.microsoft.com/en-us/dotnet/api/microsoft.extensions.options.ioptionsmonitor-1?view=dotnet-plat-ext-6.0) object into the class that needs it. Here is an example of how you would read the `Host` value from the SMTP settings contained within the global settings:

```csharp
using Microsoft.Extensions.Options;
using Umbraco.Cms.Core.Configuration.Models;

namespace MySite;

public class SomeClass
{
    private GlobalSettings _globalSettings;

    public SomeClass(IOptions<GlobalSettings> globalSettings)
    {
        _globalSettings = globalSettings.Value;

        var smtpHost = _globalSettings.Smtp.Host;
    }
}
```

First off `using Microsoft.Extensions.Options` is added, to gain access to the `IOptions` type, and `using Umbraco.Cms.Core.Configuration.Models;` is added to get access to the `GlobalSettings` type.

`IOptions<GlobalSettings>` is then injected into the constructor of the class, where we can use the `Value` property to gain access to the actual settings object.

Now we have a typed object containing our settings, so we can get the Host value by calling `_globalSettings.Smtp.Host`.

To see what setting types you can access see the complete list below, each document corresponds to a settings type.

## Configuration Options

A complete list of all the configuration sections included in Umbraco, by default, can be seen here along with any keys they contain:

* [Basic authentication settings](basicauthsettings.md)
* [Connection strings settings](connectionstringssettings.md)
* [Content settings](contentsettings.md)
* [Debug settings](debugsettings.md)
* [Examine settings](examinesettings.md)
* [Exception filter settings](exceptionfiltersettings.md)
* [Global settings](globalsettings.md)
* [Health checks settings](healthchecks.md)
* [Hosting settings](hostingsettings.md)
* [Imaging settings](imagingsettings.md)
* [Indexing settings](indexingsettings.md)
* [Install default data setting](installdefaultdatasettings.md)
* [Keep alive settings](keepalivesettings.md)
* [Logging settings](loggingsettings.md)
* [Maximum upload size settings](maximumuploadsizesettings.md)
* [Models builder settings](modelsbuildersettings.md)
* [NuCache settings](nucachesettings.md)
* [Package migration settings](packagemigrationsettings.md)
* [Plugins settings](pluginssettings.md)
* [Request handler settings](requesthandlersettings.md)
* [Rich text editor settings](richtexteditorsettings.md)
* [Runtime minification settings](runtimeminificationsettings.md)
* [Runtime settings](runtimesettings.md)
* [Security settings](securitysettings.md)
* [Serilog settings](serilog.md)
* [Tours settings](tourssettings.md)
* [Type finder settings](typefindersettings.md)
* [Unattended settings](unattendedsettings.md)
* [Web routing settings](webroutingsettings.md)

## Configured by code

* [FileSystemProviders](filesystemproviders.md)
