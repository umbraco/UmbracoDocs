---
versionFrom: 9.0.0
---

# Install Umbraco with .NET CLI

We have made custom Umbraco templates that are available for use with `dotnet new`. The steps below will demonstrate the minimum amount of actions required to get you going and set up an Umbraco project from the command line using .NET templates.

## Video Tutorial

<iframe width="800" height="450" src="https://www.youtube.com/embed/boK2cMXiI10" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Install the template

1. Install the latest [.NET SDK](https://dotnet.microsoft.com/download).

2. Run `dotnet new -i Umbraco.Templates` to install the project templates.  
*The solution is packaged up into the NuGet package [Umbraco.Templates](https://www.nuget.org/packages/Umbraco.Templates) and can be installed into the dotnet CLI*.

> Once that is complete, you can see that Umbraco was added to the list of available projects types by running `dotnet new -all`:

```none
Templates                    Short Name               Language          Tags
------------------------------------------------------------------------------------------------------
Umbraco Solution             umbraco                  [C#]              Web/CMS/Umbraco
Umbraco Package              umbracopackage           [C#]              Web/CMS/Umbraco/Package/Plugin
```
:::note
In some cases the templates may silently fail to install (usually this is an issue with NuGet sources). If this occurs you can try specifying the NuGet source in the command by running `dotnet new -i Umbraco.Templates --nuget-source "https://api.nuget.org/v3/index.json"`.
:::

To get **help** on a project template with `dotnet new` run the following command:

`dotnet new umbraco -h`

From that command's output, you will get a better understanding of what are the default template options, as well as those command-line flags specific to Umbraco that you can use (as seen below):

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

## Create an Umbraco project

1. Create a new empty Umbraco solution using MS SQL Azure/Server:  
`dotnet new umbraco -n MyCustomUmbracoProject`

    Or if you prefer to using SQL CE:  

    `dotnet new umbraco --SqlCe -n MyCustomUmbracoProject`

You will now have a new project with the name *MyCustomUmbracoProject*, or the name you chose to use.
The new project can be opened and run using your favorite IDE or you can continue using the CLI commands.

:::note
If you want to create a solution file as well you can run the commands below. 
`dotnet new sln`  
`dotnet sln add MyCustomUmbracoProject `
:::

## Run Umbraco

1. Navigate to the newly created project folder:  
`cd MyCustomUmbracoProject`

1. Build and run the new Umbraco .Net Core project:  
`dotnet build`  
`dotnet run`

The project is now running on the [Kestrel server](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/servers/?view=aspnetcore-5.0&tabs=windows#kestrel) and has assigned a free available port to run it on. Look in the terminal window after the `dotnet run` command to see the URLs.

The next step is to run through the Umbraco CMS installation. If you chose to use MS SQL Server/Azure you will need to add your connection string during this setup process to get access to the Umbraco backoffice.
