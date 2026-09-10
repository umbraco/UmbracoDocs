---
description: Instructions on installing Umbraco on various platforms using various tools.
---

# Installation

{% hint style="warning" %}
**Before you begin**

Ensure your environment meets the [System Requirements](requirements.md). You must have the latest [.NET SDK](https://dotnet.microsoft.com/download) installed and a compatible database ready.
{% endhint %}

## Install the Template

1. Open your command line.
2. Install the Umbraco templates:

```bash
dotnet new install Umbraco.Templates
```

3. Create a new project:

```bash
dotnet new umbraco --name MyProject
```

{% hint style="info" %}
New projects created with this template use [Central Package Management (CPM)](https://learn.microsoft.com/en-us/nuget/consume-packages/central-package-management) by default. NuGet package versions are managed centrally in a `Directory.Packages.props` file created at the project root, rather than in the individual `.csproj` file. If you later add additional projects, you can move the `Directory.Packages.props` file to the solution root and version all dependencies in one place.
{% endhint %}

4. _\[Optional]_ Create a solution file:

```bash
dotnet new sln
dotnet sln add MyProject
```

5. Navigate to the newly created project folder. It will be the folder containing the `.csproj` file:

```bash
cd MyProject
```

6. Build and run the newly created Umbraco site:

```bash
dotnet run
```

7. The console will output a message similar to: `[10:57:39 INF] Now listening on: https://localhost:44388`

{% hint style="info" %}
It is recommended to set up a developer certificate and run the website under HTTPS. If that has not yet been configured, run the following command:

```console
dotnet dev-certs https --trust
```
{% endhint %}

8. Open your browser and navigate to that URL.
9. Follow the instructions to finish up the installation of Umbraco. If you chose to use MS SQL Server or Azure, you will need to add your connection string during this setup process to get access to the Umbraco backoffice.

{% hint style="info" %}
Members of the Umbraco Community have created a website that makes the installation of Umbraco a lot easier for you. You can find the website at [https://psw.codeshare.co.uk](https://psw.codeshare.co.uk). On the website, you can configure your options to generate the required script to run. Click on the Install Script tab to get the commands you need to paste into the terminal. This tab also includes the commands for adding a starter kit or unattended install which creates the database for you.
{% endhint %}

## Additional Options and Troubleshooting

<details>

<summary>Troubleshooting: Templates fail to install</summary>

In some cases, the templates may silently fail to install (usually this is an issue with NuGet sources). If this occurs, specify the NuGet source directly:

```bash
dotnet new install Umbraco.Templates --nuget-source "https://api.nuget.org/v3/index.json"
```

</details>

<details>

<summary>Verify the templates were installed</summary>

Run `dotnet new list` to confirm that Umbraco was added to the list of available project types:

```cli
Templates                    Short Name               Language          Tags
------------------------------------------------------------------------------------------------------
Umbraco Project              umbraco                  [C#]              Web/CMS/Umbraco
Umbraco Extension            umbraco-extension        [C#]              Web/CMS/Umbraco/Extension/Plugin/Razor Class Library
Umbraco Docker Compose       umbraco-compose                            Web/CMS/Umbraco
```

</details>

<details>

<summary>Full list of template options</summary>

Run `dotnet new umbraco -h` to see all available options:

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
   -pm, --package-management <choice>         Choose how to manage NuGet package versions
                                             Type: choice
                                               Central     Use Directory.Packages.props (recommended for new projects)
                                               PerProject  Use versions in .csproj (recommended when adding to existing projects)
                                             Default: Central
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
  --telemetry-level <telemetry-level>        Used to specify the level of telemetry the installation will report (Minimal, Basic or Detailed).
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

</details>

<details>

<summary>About the port and local cookies</summary>

The project runs on the [Kestrel server](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/servers/?view=aspnetcore-5.0\&tabs=windows#kestrel) and is assigned a free available port. Check the terminal output after `dotnet run` for the exact URL.

{% hint style="info" %}
Cookies are shared between sites on `localhost`, no matter which port each site runs on. To sign in to more than one local backoffice at a time, give each site unique cookie names. See [Site name](../../develop-with-umbraco/configuration/securitysettings.md#site-name) in the security settings article.
{% endhint %}

</details>



## Alternative Installation Methods

Choose the path that best fits your development environment and workflow.

| Method                                                     | Best For                     | Description                                                                                        |
| ---------------------------------------------------------- | ---------------------------- | -------------------------------------------------------------------------------------------------- |
| [**Visual Studio**](visual-studio.md)                      | Windows / Full IDE           | The standard wizard-based setup for developers who prefer a full IDE experience on Windows.        |
| [**Visual Studio Code**](install-umbraco-with-vs-code.md)  | Lightweight / Cross-platform | A streamlined setup for developers using Visual Studio Code on macOS, Linux, or Windows.           |
| [**Docker Compose**](running-umbraco-on-docker-locally.md) | Containerization             | Spin up Umbraco and its database dependencies quickly in a consistent, isolated environment.       |
| [**IIS & Local Hosting**](iis.md)                          | Windows Server               | Guidance for hosting and running your local installation on Internet Information Services.         |
| [**Linux / macOS**](running-umbraco-on-linux-macos.md)     | Unix-based Native            | Specific environment configurations and steps for running Umbraco natively on non-Windows systems. |
| [**Unattended Install**](unattended-install.md)            | Automation & CI/CD           | An automation-friendly setup—ideal for Azure Web Apps, build pipelines, and rapid deployments.     |
| [**Nightly Builds**](installing-nightly-builds.md)         | Early Adopters               | Get early access to the latest "bleeding edge" features and fixes before the official release.     |
