---
meta.Title: "Umbraco .Net Core Updates"
meta.Description: "Updates and information related to the upcoming release of Umbraco .Net Core."
---

# Umbraco .Net Core

:::note
This article is intended for keeping an overview of all the information, official as well as unofficial, currently available on the upcoming release of Umbraco .Net Core.

Are you aware of some information about Umbraco .Net Core that isn't already added to this list?
Please feel free to submit a Pull Request by using the **Edit this page** button at the top of this article.
:::

In this article you will find detailed instructions on [how to try out and test the current alpha version of Umbraco .Net Core](#net-core-alpha). You will also find a list of relevant links to official as well as unofficial resources on the upcoming release.

## News and updates from Umbraco HQ

In this section you will find links to news and updates from the .Net Core team at Umbraco HQ, as well as from the UniCore community team.

### Blog posts

* [.NET Core Alpha release](https://umbraco.com/blog/net-core-alpha-release/)
* [.NET Core in the Unicorner](https://umbraco.com/blog/the-unicorner-returns-net-core-alpha-release/)
* [Automated testing in Umbraco](https://umbraco.com/blog/automated-testing-in-umbraco/)
* [Status of migrating to .NET Core](https://umbraco.com/blog/status-of-migration-to-net-core/)
* [Unicore team visit at Umbraco HQ](https://umbraco.com/blog/unicore-team-visit-at-umbraco-hq/)
* [The Unicore Team](https://umbraco.com/blog/the-unicore-team/)

### Other resources

* [The Umbraco Roadmap](https://umbraco.com/products/roadmap/)
* [Community: The UniCore team](https://our.umbraco.com/get-involved/the-unicore-team/)

## Community resources

In this section you will find a list of Umbraco .Net Core resources provided by the Umbraco Community.

### Community blog posts

* [Rick Butterfield: Umbraco Unicore first impressions](https://rickbutterfield.com/blog/umbraco-unicore-impressions)
* [Greystate: Trying Out the .NET Core Umbraco Alpha Release](https://greystate.dk/log/2020/09/04/umbraco-net-core-alpha/)

### Other

* [Adrian Ochmann: Umbraco (.NET Core) Docker Example](https://github.com/thecogworks/umbraco-core-docker-example)
* [Youtube: umbraCoffee #141 - Unicore Alpha](https://www.youtube.com/watch?v=-ceCJZ9Tus0&ab_channel=umbraCoffee)
* [Youtube: umbraCoffee #110 - Meet the Unicore team](https://www.youtube.com/watch?v=55xAuUxkpUo&ab_channel=umbraCoffee)
* [Umbraco Community: Unicore Team update](https://www.youtube.com/watch?v=0WmP3Xdq9dU)

## .NET Core Alpha

As of September 3rd 2020 it is possible to try out and test the latest alpha release of Umbraco .Net Core.

More details on the alpha can be found in [the alpha release blog post](https://umbraco.com/blog/net-core-alpha-release/).

:::warning
As this is an **alpha release**, bugs and minor issues are to be expected.

You can find a list of known issues in the [release blog post](https://umbraco.com/blog/net-core-alpha-release/) and see [already reported issues on the Issue tracker](https://github.com/umbraco/Umbraco-CMS/issues?q=is%3Aopen+is%3Aissue+label%3Aproject%2Fnet-core+).

Found a bug that isn't already reported? Please report it on the [GitHub tracker](https://github.com/umbraco/Umbraco-CMS/issues/new?labels=project%2Fnet-core&template=3_BugNetCore.md&title=NetCore%3A%20%7BIssue%20Title%7D) with a title prefixed with “NetCore:”.
:::

To get started, follow the steps outlined below.

### Known issues in current Alpha release

 * Restarts during install
    * When the Umbraco solution is installed, a restart is required. Right now we need to use IIS/IIS express to handle the next request and start the process again. Sometimes this fails and you need to start the process again
 * Previews do not work due to the missing website part
 * Members can’t be created, as we’re still using MembershipProviders
 * Case sensitive filesystems (Linux and sometimes Mac) creates folders in the project like “~” and “**”, and lots of paths are not requested in the correct casing, yet
 * Mac/Linux + Examine/Lucene issue as that assembly still is built for .NET Framework.
 * External logins are not supported yet
 * No support for Packages currently
 * Errors in log "Index Population failed for populator ..."

### Prerequisites

* [.Net Core 3.1 SDK](https://dotnet.microsoft.com/download)
* SQL connection string (MS SQL Server/Azure), unless you want to install using SQL CE (Compact Edition)

### Steps to install the Umbraco `dotnet new` template

1. Use a command prompt of your choice to insert this custom NuGet feed:

    ```none
    dotnet nuget add source "https://www.myget.org/F/umbracoprereleases/api/v3/index.json" -n "Umbraco Prereleases"
    ```

1. Install the new Umbraco dotnet template:

    ```none
    dotnet new -i Umbraco.Templates::0.5.0-alpha002
    ```
    
### Steps to update the template from earlier alpha versions
If you have already installed the Umbraco `dotnet new` template, you will need ensure it is up-to-date 

1. Use a command prompt of your choice to update the `dotnet new` templates

    ```none
    dotnet new -i Umbraco.Templates::0.5.0-alpha002
    ```

### Steps to create an Umbraco solution using the `dotnet new` template
1. Create a new empty Umbraco solution using MS SQL Azure/Server (first option) or SQL CE (second edition):

    ```none
    dotnet new umbraco -n MyCustomUmbracoSolution
    ```

    ```none
    dotnet new umbraco --UseSqlCe -n MyCustomUmbracoSolution
    ```

You will now have a new project with the name `MyCustomUmbracoSolution`, or whichever name you chose.

The new project can be opened and run using your favorite IDE or you can continue to use the CLI commands.

### Steps to build and run

The following steps, will continue using CLI based on the steps above.

1. Navigate to the newly created project folder:

    ```none
    cd MyCustomUmbracoSolution
    ```

2. Build and run the new Umbraco .Net Core project:

    ```none
    dotnet build
    dotnet run
    ```

The project is now running on the [Kestrel server](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/servers/?view=aspnetcore-3.1&tabs=windows#kestrel) and is available on the default ports: http://localhost:5000 and https://localhost:5001.

The next step is to run through the Umbraco CMS installation. If you chose to use MS SQL Server/Azure you will need to add your connection string during this setup process.

Once the installation process is complete you might need to **manually restart the application** in order to start the application again and get access to the Umbraco backoffice.
