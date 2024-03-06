---
description: Instructions on installing preview builds of Umbraco.
---

{% hint style="warning" %}
This page is a work in progress. It will be updated as the software evolves.
{% endhint %}

# Installing Preview Builds

In this article, we'll explain how you can get the latest builds of Umbraco. You can do this in three steps:

1. [Using the Feed](preview-builds.md#using-the-feed)
2. [Adding the "prereleases" Feed as a NuGet Source](preview-builds.md#adding-the-prereleases-feed-as-a-nuget-source)
3. [Installing the Preview Build Template](preview-builds.md#installing-the-preview-build-template)

{% hint style="info" %}
If you experience any problems running any of the prerelease/nightly builds, ensure that you have the [required version of .NET](../requirements.md#local-development). You can always find the latest on the [Microsoft website](https://dotnet.microsoft.com/en-us/).
{% endhint %}

## Using the Feed

You can choose from two NuGet feeds to try out the latest Umbraco preview releases containing the new Backoffice:

* [Prerelease Feed](preview-builds.md#prerelease-feed)
* [Nightly Feed](preview-builds.md#nightly-feed)

### Prerelease Feed

The prerelease feed contains prebuilt versions of Umbraco released along with the prerelease announcements.

The feed is available through this URL and is used in the rest of the guide:

```
https://www.myget.org/F/umbracoprereleases/api/v3/index.json
```

### Nightly Feed

The nightly feed usually receives a release once a day. The releases are built from the respective dev branches of Umbraco and are therefore not considered stable.

The feed is available through this URL:

```
https://www.myget.org/F/umbraconightly/api/v3/index.json
```

For more information, see the [Installing Nightly Builds](installing-nightly-builds.md) article.

{% hint style="info" %}
Check the [MyGet website](https://www.myget.org/feed/umbraconightly/package/nuget/Umbraco.Templates) to stay up-to-date with the latest nightly versions.
{% endhint %}

## Adding the "prereleases" Feed as a NuGet Source

You can either add the feed through the command line or use an IDE of your choice. In this guide, we'll provide steps for:

* [Using the command line](preview-builds.md#using-the-command-line)
* [Using Visual Studio](preview-builds.md#using-visual-studio)

### Using the command line

To add the feed using the command line:

1. Open a command prompt of your choice.
2. Run the following command:

```bash
dotnet nuget add source "https://www.myget.org/F/umbracoprereleases/api/v3/index.json" -n "Umbraco Prereleases"
```

The feed is added as a source named `Umbraco Prereleases`.

### Using Visual Studio

To add the feed using Visual Studio:

1. Open Visual Studio.
2. Go to **Tools** > **NuGet Package Manager** > **Package Manager Settings**.

![Package Manager Settings](<../../../.gitbook/assets/Package-Manager-Settings (1) (2).jpg>)

3. The **Options** window open.
4. Select the **Package Sources** option in the **NuGet Package Manager** section.
5. Select **Umbraco Prereleases**.
6. Enter the desired name for the feed in the **Name** field.
7. Enter the link `https://www.myget.org/F/umbracoprereleases/api/v3/index.json` into the **Source** field.
8. Click **OK**.

![Register the prereleases feed](<../../../.gitbook/assets/VS-Package-Sources (1).jpg>)

The feed is added as a source named `Umbraco Prereleases`.

## Installing the Preview Build Template

Now that our feed is added we're ready to install the preview build template.

To install the preview build template:

1. Open your command prompt.
2. Run the following command and provide the version that you want to install.

```bash
dotnet new install Umbraco.Templates::14.0.0-beta001
```

The prerelease name and the version are separated with two colons`::`. It is important to specify the entire version, including the `-beta001` otherwise the `dotnet new` command will not find the package.

With that, we've successfully installed the latest build of Umbraco.

## Create an Umbraco project

Create a new project using the following command:

```bash
dotnet new umbraco -n MyAwesomePreviewSite
```

This creates a folder named **MyAwesomePreviewSite**. The new project can be opened and run using your favorite IDE or you can continue using the CLI commands.

### Run Umbraco

1. Navigate to the newly created project folder:

```bash
cd MyAwesomePreviewSite
```

2. Build and run the newly created Umbraco site:

```bash
dotnet run
```

For more information about installing Umbraco, see the [Installation Requirements](../requirements.md).
