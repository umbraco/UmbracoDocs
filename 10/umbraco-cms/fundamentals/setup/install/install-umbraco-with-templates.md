# Install using .NET CLI

We have made custom Umbraco templates that are available for use with `dotnet new`. The steps below will demonstrate the minimum amount of actions required to get you going and set up an Umbraco project from the command line using .NET templates.

## Video Tutorial

{% embed url="https://www.youtube-nocookie.com/embed/ZByL3qILNnI" %}
Video tutorial
{% endembed %}

## Install the template

1. Install the latest [.NET SDK](https://dotnet.microsoft.com/download).
2. Run `dotnet new install Umbraco.Templates` to install the project templates.\
   &#xNAN;_&#x54;he solution is packaged up into the NuGet package_ [_Umbraco.Templates_](https://www.nuget.org/packages/Umbraco.Templates) _and can be installed into the dotnet CLI_.

> Once that is complete, you can see that Umbraco was added to the list of available projects types by running `dotnet new --list`:

{% tabs %}
{% tab title="Latest version" %}
```none
Templates                    Short Name               Language          Tags
------------------------------------------------------------------------------------------------------
Umbraco Project              umbraco                  [C#]              Web/CMS/Umbraco
Umbraco Package              umbracopackage           [C#]              Web/CMS/Umbraco/Package/Plugin
```
{% endtab %}

{% tab title="Umbraco 9" %}
```none
Templates                    Short Name               Language          Tags
------------------------------------------------------------------------------------------------------
Umbraco Solution             umbraco                  [C#]              Web/CMS/Umbraco
Umbraco Package              umbracopackage           [C#]              Web/CMS/Umbraco/Package/Plugin
```
{% endtab %}
{% endtabs %}

{% hint style="info" %}
In some cases the templates may silently fail to install (usually this is an issue with NuGet sources). If this occurs you can try specifying the NuGet source in the command by running `dotnet new install Umbraco.Templates --nuget-source "https://api.nuget.org/v3/index.json"`.
{% endhint %}

To get **help** on a project template with `dotnet new` run the following command:

`dotnet new umbraco -h`

From that command's output, you will get a better understanding of what are the default template options, as well as those command-line flags specific to Umbraco that you can use (as seen below):

{% tabs %}
{% tab title="Latest version" %}
```none
Umbraco Project (C#)
Author: Umbraco HQ
Description: An empty Umbraco project ready to get started.
Options:
  -v|--version                       The version of Umbraco.Cms to add as PackageReference.
                                     string - Optional
                                     Default: 10.0.0

  --use-https-redirect               Adds code to Startup.cs to redirect HTTP to HTTPS and enables the UseHttps setting.
                                     bool - Optional
                                     Default: false

  --no-restore                       If specified, skips the automatic restore of the project on create.
                                     bool - Optional
                                     Default: false

  --exclude-gitignore                Whether to exclude .gitignore from the generated template.
                                     bool - Optional
                                     Default: false

  --minimal-gitignore                Whether to only include minimal (Umbraco specific) rules in the .gitignore.
                                     bool - Optional
                                     Default: false

  --connection-string                Database connection string used by Umbraco.
                                     string - Optional

  --connection-string-provider-name  Database connection string provider name used by Umbraco.
                                     string - Optional
                                     Default: Microsoft.Data.SqlClient

  --development-database-type        Database type used by Umbraco for development.
                                         None       - Do not configure a database for development.
                                         SQLite     - Use embedded SQLite database.
                                         LocalDB    - Use embedded LocalDB database (requires SQL Server Express with Advanced Services).
                                     Default: None

  --friendly-name                    Used to specify the name of the default admin user when using unattended install on development (stored as plain text).
                                     string - Optional

  --email                            Used to specify the email of the default admin user when using unattended install on development (stored as plain text).
                                     string - Optional

  --password                         Used to specify the password of the default admin user when using unattended install on development (stored as plain text).
                                     string - Optional

  --no-nodes-view-path               Path to a custom view presented with the Umbraco installation contains no published content.
                                     string - Optional

  -p|--PackageTestSiteName           The name of the package project this should be a test site for.
                                     string - Optional
```
{% endtab %}

{% tab title="Umbraco 9" %}
```none
Umbraco Project (C#)
Author: Umbraco HQ
Description: An empty Umbraco Project ready to get started
Options:
  -v|--version              The version of Umbraco to load using NuGet
                            string - Optional
                            Default: 9.0.0

  -p|--PackageTestSiteName  The name of the package this should be a test site for (Default: '')
                            text - Optional

  -ce|--SqlCe               Adds the required dependencies to use SqlCE (Windows only) (Default: false)
                            bool - Optional
                            Default: false

  -F|--Framework            The target framework for the project
                                net5.0    - Target net5.0
                                net6.0    - Target net6.0
                            Default: net5.0

  --no-restore              If specified, skips the automatic restore of the project on create
                            bool - Optional
                            Default: false

  --friendly-name           The friendly name of the user for Umbraco login when using Unattended install (Without installer wizard UI)
                            text - Optional

  --email                   Email to use for Umbraco login when using Unattended install (Without installer wizard UI)
                            text - Optional

  --password                Password to use for Umbraco login when using Unattended install (Without installer wizard UI)
                            text - Optional

  --connection-string       Database connection string when using Unattended install (Without installer wizard UI)
                            text - Optional

  --no-nodes-view-path      Path to a custom view presented with the Umbraco installation contains no published content
                            text - Optional

  --use-https-redirect      Adds code to Startup.cs to redirect HTTP to HTTPS and enables the UseHttps setting (Default: false)
                            bool - Optional
                            Default: false
```
{% endtab %}
{% endtabs %}

## Create an Umbraco project

1. Create a new empty Umbraco solution using MS SQL Azure/Server:\
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
