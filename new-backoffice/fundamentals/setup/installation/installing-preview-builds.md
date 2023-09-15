---
description: Instructions on installing preview builds of Umbraco.
---

# Installing Preview Builds

Here we'll explain how you can get the latest bleeding-edge builds of Umbraco V9 and above. There are three steps to do this.

1. Adding the nightly feed as a NuGet source
2. Finding the latest nightly version
3. Installing the latest nightly version template

{% hint style="info" %}
If you experience any problems running any of the prerelease/nightly builds, please ensure that you have the required version of .NET. You can always find the latest on the [dot.net website](https://dotnet.microsoft.com/en-us/). For Umbraco 13 and 14 you will need at least .NET 8.
{% endhint %}

But let's take things one step at a time.

## Adding the feed as a NuGet source

There are two NuGet feeds to choose from to try out the latest Umbraco including the Umbraco 14 preview releases containing the new Backoffice.

**Prerelease feed**

This feed contains prebuilt versions of Umbraco released along with the prerelease announcements. [You can read more about our prereleases here](../../../getting-started/getting-started-with-the-new-backoffice/alpha-release.md).

The feed is available through this URL, which you have to use during the rest of the guide:

```
https://www.myget.org/F/umbracoprereleases/api/v3/index.json
```

**Nightly feed**

This feed receives a release once a day. The releases are built from the respective dev branches of Umbraco and are therefore not considered stable.

The feed is available through this URL, which you have to use during the rest of the guide:

```
https://www.myget.org/F/umbraconightly/api/v3/index.json
```

## Using the feed

You can either add the feed through the command line or use your IDE of choice. In this guide, we'll cover the command line.

We will use the prerelease feed during this guide, but the instructions are the same for both feeds.

### Using the command line

To add the feed using the command line, open up your command prompt of choice and run the following command:

```bash
dotnet nuget add source "https://www.myget.org/F/umbracoprereleases/api/v3/index.json" -n "Umbraco Prereleases"
```

This will add the feed as a source named `Umbraco Prereleases`

## Installing the latest build

Now that our feed is added we're ready to install our template.

Open up your command prompt of choice and execute the `dotnet new install` command and provide the version that we want to install. For the latest Umbraco 14 preview release, the command looks like this:

```
dotnet new install Umbraco.Templates::14.0.0--preview002
```

The name and the versions are separated with two colons `::`. It's important that we specify the entire version, including the `--preview001`; otherwise, the `dotnet new` command cannot find the package.

With that, we've successfully installed the latest build of Umbraco! All we have to do now is to create a new site by executing the newly installed template:

```bash
dotnet new umbraco -n MyAwesomeNightlySite
```

This creates a folder named "MyAwesomeNightlySite" on your system. You can open it in your IDE (like Rider) or use the command line to start working with it. If you choose to use the command line first you have to change the directory to `MyAwesomeNightlySite`.

To run the newly created Umbraco site, you can execute the following command:

```bash
dotnet run
```

For more information about installing Umbraco see [the installation documentation](./).
