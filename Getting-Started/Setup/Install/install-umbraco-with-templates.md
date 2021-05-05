---
versionFrom: 9.0.0
verified-against: alpha-4
state: partial
updated-links: false
---

# Install Umbraco with .NET CLI

We have made custom Umbraco templates that are available for use with `dotnet new`. The steps below will demonstrate the minimum amount of actions required to get you going and set up an Umbraco project from the command line using .NET Core templates.

## Install the template

1. Install the latest [.NET SDK](https://dotnet.microsoft.com/download).

:::note
Umbraco 9 is currently in a beta release, so to get it running right now you will need to add the beta nuget source:
`dotnet nuget add source "https://www.myget.org/F/umbracoprereleases/api/v3/index.json" -n "Umbraco Prereleases"`

And then step 2 below instead becomes:
Run `dotnet new -i Umbraco.Templates::beta-001`
:::

2. Run `dotnet new -i Umbraco.Templates::*` to install the project templates.  
*The solution is packaged up into the NuGet package [Umbraco.Templates](https://www.nuget.org/packages/Umbraco.Templates) and can be installed into the dotnet CLI*.

> Once that is complete, you can see that Umbraco was added to the list of available projects types by running `dotnet new -all`:

```none
Templates                    Short Name               Language          Tags
------------------------------------------------------------------------------------------------------
Umbraco Solution             umbraco                  [C#]              Web/CMS/Umbraco
Umbraco Package              umbracopackage           [C#]              Web/CMS/Umbraco/Package/Plugin
```

To get **help** on a project template with `dotnet new` run the following command:

`dotnet new umbraco -h`

From that command's output, you will get a better understanding of what are the default template options, as well as those command-line flags specific to Umbraco that you can use (as seen below):

```none
Usage: new [options]

Options:
  -h, --help                 Displays help for this command.
  -l, --list                 Lists templates containing the specified template name. If no name is specified, lists all templates.
  -n, --name                 The name for the output being created. If no name is specified, the name of the output directory is used.
  -o, --output               Location to place the generated output.
  -i, --install              Installs a source or a template pack.
  -u, --uninstall            Uninstalls a source or a template pack.
  --interactive              Allows the internal dotnet restore command to stop and wait for user input or action (for example to complete authentication).
  --nuget-source             Specifies a NuGet source to use during install.
  --type                     Filters templates based on available types. Predefined values are "project" and "item".
  --dry-run                  Displays a summary of what would happen if the given command line were run if it would result in a template creation.
  --force                    Forces content to be generated even if it would change existing files.
  -lang, --language          Filters templates based on language and specifies the language of the template to create.
  --update-check             Check the currently installed template packs for updates.
  --update-apply             Check the currently installed template packs for update, and install the updates.
  --search                   Searches for the templates on NuGet.org.
  --author <AUTHOR>          Filters the templates based on the author. Applies to --search and --list.
  --package <PACKAGE>        Filters the templates based on NuGet package ID. Applies to --search.
  --columns <COLUMNS_LIST>   Comma separated list of columns to display in --list and --search output.
                             The supported columns are: language, tags, author, type.
  --columns-all              Display all columns in --list and --search output.
  --tag <TAG>                Filters the templates based on the tag. Applies to --search and --list.


Umbraco Project (C#)
Author: Umbraco HQ
Description: An empty Umbraco Project ready to get started
Options:

  -v|--version              The version of Umbraco to load using NuGet

                            string - Optional

                            Default: 9.0.0-beta002


  -p|--PackageTestSiteName  The name of the package this should be a test site for (Default: '')

                            text - Optional


  -ce|--SqlCe               Adds the required dependencies to use SqlCE (Windows only) (Default: false)

                            bool - Optional

                            Default: false / (*) true


  -F|--Framework            The target framework for the project

                                net5.0    - Target net5.0

                                net6.0    - Target net6.0

                            Default: net5.0


  --no-restore              If specified, skips the automatic restore of the project on create

                            bool - Optional

                            Default: false / (*) true


  --friendly-name           The friendly name of the user for Umbraco login when using Unattended install (Without installer wizard UI)
                            text - Optional


  --email                   Email to use for Umbraco login when using Unattended install (Without installer wizard UI)

                            text - Optional


  --password                Password to use for Umbraco login when using Unattended install (Without installer wizard UI)
                            text - Optional


  --connection-string       Database connection string when using Unattended install (Without installer wizard UI)

                            text - Optional


* Indicates the value used if the switch is provided without a value.
```

## Create an Umbraco solution

1. Create a new empty Umbraco solution using MS SQL Azure/Server:  
`dotnet new umbraco -n MyCustomUmbracoSolution`

    Or if you prefer to using SQL CE:  

    `dotnet new umbraco -n MyCustomUmbracoSolution -ce`

You will now have a new project with the name *MyCustomUmbracoSolution*, or the name you chose to use.
The new project can be opened and run using your favorite IDE or you can continue using the CLI commands.

## Run Umbraco

1. Navigate to the newly created project folder:  
`cd MyCustomUmbracoSolution`

1. Build and run the new Umbraco .Net Core project:  
`dotnet build`  
`dotnet run`

The project is now running on the [Kestrel server](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/servers/?view=aspnetcore-5.0&tabs=windows#kestrel) and has assigned a free available port to run it on. Look in the terminal window after the `dotnet run` command to see the URLs.

The next step is to run through the Umbraco CMS installation. If you chose to use MS SQL Server/Azure you will need to add your connection string during this setup process to get access to the Umbraco backoffice.
