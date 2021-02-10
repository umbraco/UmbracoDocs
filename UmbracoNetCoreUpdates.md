---
meta.Title: "Umbraco .Net Core Updates"
meta.Description: "Updates and information related to the upcoming release of Umbraco .Net Core."
---

# Umbraco .NET Core

:::note
This article is intended for keeping an overview of all the information, official as well as unofficial, currently available on the upcoming release of Umbraco .Net Core.

We have created a separate repository for [articles and tutorials for Umbraco on .NET Core](https://github.com/umbraco/UmbracoCMSDocs). Please keep in mind, that this is still a work in progress.

Are you aware of some information about Umbraco .Net Core that isn't already added to this list?
Please feel free to submit a Pull Request by using the **Edit this page** button at the top of this article.
:::

In this article you will find detailed instructions on [how to try out and test the current alpha version of Umbraco .Net Core](#umbraco-net-core-alpha). You will also find a list of relevant links to official as well as unofficial resources on the upcoming release.

## News and updates from Umbraco HQ

In this section you will find links to news and updates from the .Net Core team at Umbraco HQ, as well as from the UniCore community team.

### Blog posts

* [Alpha 3 release of Umbraco on .NET Core](https://umbraco.com/blog/alpha-3-release-of-umbraco-on-net-core/)
* [Status of migration to .NET Core, December 2020](https://umbraco.com/blog/status-of-migration-to-net-core-december-2020/)
* [.NET Core Alpha release](https://umbraco.com/blog/net-core-alpha-release/)
* [.NET Core in the Unicorner](https://umbraco.com/blog/the-unicorner-returns-net-core-alpha-release/)
* [Automated testing in Umbraco](https://umbraco.com/blog/automated-testing-in-umbraco/)
* [Status of migrating to .NET Core](https://umbraco.com/blog/status-of-migration-to-net-core/)
* [Unicore team visit at Umbraco HQ](https://umbraco.com/blog/unicore-team-visit-at-umbraco-hq/)
* [The Unicore Team](https://umbraco.com/blog/the-unicore-team/)

### Other resources

* [The Umbraco Roadmap](https://umbraco.com/products/roadmap/)
* [Community: The UniCore team](https://our.umbraco.com/get-involved/the-unicore-team/)
* [Overview of Project Unicore/Migrating Umbraco CMS to .NET Core](https://umbraco.com/products/umbraco-cms/migrating-umbraco-to-net-core/)

## Community resources

In this section you will find a list of Umbraco .Net Core resources provided by the Umbraco Community.

### Community blog posts

* [Running Umbraco on a Raspberry Pi or How I Stopped Worrying and Learned to Love Linux](https://skrift.io/issues/running-umbraco-on-a-raspberry-pi-or-how-i-stopped-worrying-and-learned-to-love-linux/)
* [Demystifying config in Umbraco .NET Core](https://24days.in/umbraco-cms/2020/umbraco-dotnet-core-config/)
* [Rick Butterfield: Umbraco Unicore first impressions](https://rickbutterfield.com/blog/umbraco-unicore-impressions)
* [Greystate: Trying Out the .NET Core Umbraco Alpha Release](https://greystate.dk/log/2020/09/04/umbraco-net-core-alpha/)

### Other

* [Adrian Ochmann: Umbraco (.NET Core) Docker Example](https://github.com/thecogworks/umbraco-core-docker-example)
* [Youtube: umbraCoffee #141 - Unicore Alpha](https://www.youtube.com/watch?v=-ceCJZ9Tus0&ab_channel=umbraCoffee)
* [Youtube: umbraCoffee #110 - Meet the Unicore team](https://www.youtube.com/watch?v=55xAuUxkpUo&ab_channel=umbraCoffee)
* [Umbraco Community: Unicore Team update](https://www.youtube.com/watch?v=0WmP3Xdq9dU)

## Umbraco .NET Core Alpha

As of September 3rd 2020 it is possible to try out and test the latest alpha release of Umbraco .Net Core.

Since February 9th 2021, the third alpha release has been available.

More details on the alpha can be found in [the alpha release blog post](https://umbraco.com/blog/net-core-alpha-release/).

:::warning
As this is an **alpha release**, bugs and minor issues are to be expected.

You can find a list of known issues in the [release blog post](https://umbraco.com/blog/net-core-alpha-release/) and see [already reported issues on the Issue tracker](https://github.com/umbraco/Umbraco-CMS/issues?q=is%3Aopen+is%3Aissue+label%3Aproject%2Fnet-core+).

Found a bug that isn't already reported? Please report it on the [GitHub tracker](https://github.com/umbraco/Umbraco-CMS/issues/new?labels=project%2Fnet-core&template=3_BugNetCore.md&title=NetCore%3A%20%7BIssue%20Title%7D) with a title prefixed with “NetCore:”.
:::

To get started, follow the steps outlined below.

### Known issues in current Alpha release
* Often when using the backoffice, a “Not the Ambian scope” exception is shown. Often you can retry the operation with success.
* Restarts during install
  * When the Umbraco solution is installed, a restart is required. Right now we need to use IIS/IIS express to handle the next request and start the process again. Sometimes this fails and you need to start the process again
* Members are still an area with lots of missing functionality
* Mac/Linux + Examine/Lucene issue as that assembly still is built for .NET Framework.

### Prerequisites

* [.Net 5 SDK](https://dotnet.microsoft.com/download)
* SQL connection string (MS SQL Server/Azure), unless you want to install using SQL CE (Compact Edition)

### Steps to install the Umbraco `dotnet new` template

1. Use a command prompt of your choice to insert this custom NuGet feed:

    ```none
    dotnet nuget add source "https://www.myget.org/F/umbracoprereleases/api/v3/index.json" -n "Umbraco Prereleases"
    ```

1. Install the new Umbraco dotnet template:

    ```none
    dotnet new -i Umbraco.Templates::0.5.0-alpha003
    ```

### Steps to update the template from earlier alpha versions

If you have already installed the Umbraco `dotnet new` template, you will need ensure it is up-to-date 

1. Use a command prompt of your choice to update the `dotnet new` templates

    ```none
    dotnet new -i Umbraco.Templates::0.5.0-alpha003
    ```

### Steps to create an Umbraco solution using the `dotnet new` template

1. Create a new empty Umbraco solution using MS SQL Azure/Server:

    ```none
    dotnet new umbraco -n MyCustomUmbracoSolution
    ```

    Or if you prefer to using SQL CE:

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

## .NET Core Nightly Builds

To get the latest nightly builds - the latest version of the Umbraco dotnet template, you will need to add another NuGet source. 

1. Use a command prompt of your choice to insert this custom NuGet feed:

```none
dotnet nuget add source "https://www.myget.org/F/umbraconightly/api/v3/index.json" -n "Umbraco Nightly"
```  

2. Install the new Umbraco dotnet template
    ```none
    dotnet new -i Umbraco.Templates::0.5.0-*
    ```

In order to get the latest template from the new source, you will need to use a wildcard symbol like shown above.

Now you can continue in the same way as if you were using the [Alpha version](#steps-to-create-an-umbraco-solution-using-the-dotnet-new-template)
