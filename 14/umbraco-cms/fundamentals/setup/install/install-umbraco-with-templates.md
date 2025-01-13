# Install using .NET CLI

We have made custom Umbraco templates that are available for use with `dotnet new`. The steps below will demonstrate the minimum amount of actions required to get you going and set up an Umbraco project from the command line using .NET templates.

## Video Tutorial

{% embed url="https://www.youtube-nocookie.com/embed/ZByL3qILNnI" %}
Video Tutorial
{% endembed %}

## Install the template

1. Install the latest [.NET SDK](https://dotnet.microsoft.com/download).
2. Run `dotnet new install Umbraco.Templates` to install the project templates.\
   &#xNAN;_&#x54;he solution is packaged up into the NuGet package_ [_Umbraco.Templates_](https://www.nuget.org/packages/Umbraco.Templates) _and can be installed into the dotnet CLI_.

> Once that is complete, you can see that Umbraco was added to the list of available projects types by running `dotnet new --list`:

```
Templates                    Short Name               Language          Tags
------------------------------------------------------------------------------------------------------
Umbraco Project              umbraco                  [C#]              Web/CMS/Umbraco
Umbraco Package              umbracopackage           [C#]              Web/CMS/Umbraco/Package/Plugin
```

{% hint style="info" %}
In some cases the templates may silently fail to install (usually this is an issue with NuGet sources). If this occurs you can try specifying the NuGet source in the command by running `dotnet new install Umbraco.Templates --nuget-source "https://api.nuget.org/v3/index.json"`.
{% endhint %}

To get **help** on a project template with `dotnet new` run the following command:

`dotnet new umbraco -h`

From that command's output, you will get a better understanding of what are the default template options, as well as those command-line flags specific to Umbraco that you can use (as seen below):

```
Umbraco Project (C#)
Author: Umbraco HQ
Description: An empty Umbraco project ready to get started.

Usage:
  dotnet new umbraco [options] [template options]

Options:
  -n, --name <name>       The name for the output being created. If no name is specified, the name of the output directory is used.
  -o, --output <output>   Location to place the generated output.
  --dry-run               Displays a summary of what would happen if the given command line were run if it would result in a template
                          creation.
  --force                 Forces content to be generated even if it would change existing files.
  --no-update-check       Disables checking for the template package updates when instantiating a template.
  --project <project>     The project that should be used for context evaluation.
  -lang, --language <C#>  Specifies the template language to instantiate.
  --type <project>        Specifies the template type to instantiate.

Template options:
  -r, --release <Latest|LTS>                 The Umbraco release to use, either latest or latest long term supported
                                             Type: choice
                                               Latest  The latest umbraco release
                                               LTS     The most recent long term supported version
                                             Default: Latest
  --use-https-redirect                       Adds code to Startup.cs to redirect HTTP to HTTPS and enables the UseHttps setting.
                                             Type: bool
                                             Default: false
  -da, --use-delivery-api                    Enables the Delivery API
                                             Type: bool
                                             Default: false
  --add-docker                               Adds a docker file to the project.
                                             Type: bool
                                             Default: false
  --no-restore                               If specified, skips the automatic restore of the project on create.
                                             Type: bool
                                             Default: false
  --exclude-gitignore                        Whether to exclude .gitignore from the generated template.
                                             Type: bool
                                             Default: false
  --minimal-gitignore                        Whether to only include minimal (Umbraco specific) rules in the .gitignore.
                                             Type: bool
                                             Default: false
  --connection-string <connection-string>    Database connection string used by Umbraco.
                                             Type: string
  --connection-string-provider-name          Database connection string provider name used by Umbraco.
  <connection-string-provider-name>          Type: string
                                             Default: Microsoft.Data.SqlClient
  --development-database-type <choice>       Database type used by Umbraco for development.
                                             Type: choice
                                               None     Do not configure a database for development.
                                               SQLite   Use embedded SQLite database.
                                               LocalDB  Use embedded LocalDB database (requires SQL Server Express with Advanced
                                             Services).
                                             Default: None
  --friendly-name <friendly-name>            Used to specify the name of the default admin user when using unattended install on
                                             development (stored as plain text).
                                             Type: string
  --email <email>                            Used to specify the email of the default admin user when using unattended install on
                                             development (stored as plain text).
                                             Type: string
  --password <password>                      Used to specify the password of the default admin user when using unattended install on
                                             development (stored as plain text).
                                             Type: string
  --no-nodes-view-path <no-nodes-view-path>  Path to a custom view presented with the Umbraco installation contains no published
                                             content.
                                             Type: string
  -dm, --development-mode <choice>           Choose the development mode to use for the project.
                                             Type: choice
                                               BackofficeDevelopment  Enables backoffice development, allowing you to develop from
                                             within the backoffice, this is the default behaviour.
                                               IDEDevelopment         Configures appsettings.Development.json to Development runtime
                                             mode and SourceCodeAuto models builder mode, and configures appsettings.json to
                                             Production runtime mode, Nothing models builder mode, and enables UseHttps
                                             Default: BackofficeDevelopment
  -mm, --models-mode <choice>                Choose the models builder mode to use for the project. When development mode is set to
                                             IDEDevelopment this only changes the models builder mode appsetttings.development.json
                                             Type: choice
                                               Default           Let DevelopmentMode determine the models builder mode.
                                               InMemoryAuto      Generate models in memory, automatically updating when a content
                                             type change, this means no need for app rebuild, however models are only available in
                                             views.
                                               SourceCodeManual  Generate models as source code, only updating when requested
                                             manually, this means a interaction and rebuild is required when content type(s) change,
                                             however models are available in code.
                                               SourceCodeAuto    Generate models as source code, automatically updating when a
                                             content type change, this means a rebuild is required when content type(s) change,
                                             however models are available in code.
                                               Nothing           No models are generated, this is recommended for production assuming
                                             generated models are used for development.
                                             Default: Default
  -sk, --starter-kit <choice>                Choose a starter kit to install.
                                             Type: choice
                                               None                   No starter kit.
                                               Umbraco.TheStarterKit  The Umbraco starter kit.
                                             Default: None
```

## Create an Umbraco project

1. Create a new empty Umbraco solution:\
   `dotnet new umbraco -n MyCustomUmbracoProject`

You will now have a new project with the name _MyCustomUmbracoProject_, or the name you chose to use. The new project can be opened and run using your favorite IDE or you can continue using the CLI commands.

{% hint style="info" %}
If you want to create a solution file as well you can run the commands below.\
`dotnet new sln`\
`dotnet sln add MyCustomUmbracoProject`
{% endhint %}

## Run Umbraco

1. Navigate to the newly created project folder:\
   `cd MyCustomUmbracoProject`
2. Build and run the new Umbraco .Net Core project:\
   `dotnet build`\
   `dotnet run`

The project is now running on the [Kestrel server](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/servers/?view=aspnetcore-5.0\&tabs=windows#kestrel) and has assigned a free available port to run it on. Look in the terminal window after the `dotnet run` command to see the URLs.

The next step is to run through the Umbraco CMS installation. If you chose to use MS SQL Server/Azure you will need to add your connection string during this setup process to get access to the Umbraco backoffice.
