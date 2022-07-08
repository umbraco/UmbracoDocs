---
versionFrom: 9.0.0
versionTo: 10.0.0
meta.Title: "Installing Umbraco Nightly Builds"
meta.Description: "Instructions on installing nightly builds of Umbraco."
---

# Installing nightly builds

Here we'll explain how you can get the latest bleeding edge builds of Umbraco V9 and above. There's three steps to this.

1. Adding the nightly feed as a NuGet source
2. Finding the latest nightly version
3. Installing the latest nightly version template

But let's take things one step at a time.

## Adding the nightly feed as a NuGet source

The NuGet feed containing the nightly builds is `https://www.myget.org/F/umbraconightly/api/v3/index.json`, you can either add this feed through the command line or use your IDE of choice, in this guide we'll cover Visual Studio and Rider as well as using the command line.

### Using the command line

To add the nightly feed using the command line, open up your command prompt of choice and run the following command:

```none
dotnet nuget add source "https://www.myget.org/F/umbraconightly/api/v3/index.json" -n "Umbraco Nightly"
```

This will add the nightly feed as a source named `Umbraco Nightly`

### Using Visual Studio

To add the feed through Visual Studio, first open the NuGet settings by selecting the `Tools > NuGet Package Manager > Package Manager Settings` options from the top menu.

![Open NuGet settings](images/VS/open-nuget-setttings.jpg)

Now the options window will open, first select the `Package Sources` option, then click the `+` icon in the top bar, a new source will be added and automatically highlighted. Now enter your desired name for the feed in the `Name` input, and then enter the link `https://www.myget.org/F/umbraconightly/api/v3/index.json` into the source input and click `OK`.

![Register the nightly feed](images/VS/registering-nightly-feed.jpg)

Now the feed is added as a source named `Umbraco Nightly`

### Using Rider

To add the feed through Rider first click on the `NuGet` tab at the bottom, a menu blade will pop up, then choose the `Sources` tab. Now you must choose what NuGet configuration you wish to add the feed to, to add the feed globally add it to the `NuGet.Config` in `AppData\Roaming\NuGet`, by clicking that option. Lastly, open up the `New Feed` dialog by clicking the green `+` button.

![Open the new feed menu](images/Rider/open-add-feed.jpg)

When you click the green `+` icon the new feed dialog will pop up, and the name and URL `https://www.myget.org/F/umbraconightly/api/v3/index.json`, to the fields, and press `OK`. Leave the User and Password empty and the `Enabled` box ticked.

![Adding the feed](images/Rider/add-the-feed.jpg)

Now the feed is added as a source named `Umbraco Nightly`

## Finding the latest nightly version

Now that the feed is added we're ready to install the nightly build, great! However, this begs the question what is the version called we want to install? This is in particular an issue if we want to create a new site using the dotnet template, since the dotnet command does not allow us to use wildcards to install the newest version. Fortunately, our tools can help us out here, we can see a list of available versions in both Visual Studio and Rider, and then use that version to install the template.

Here we're going to assume that you want to create a brand new site with the dotnet template, however, the approach will be the same if you're updating an existing site, you'll just be clicking the update button for the `Umbraco.Cms` package instead of installing the template through the terminal.

### Using Visual Studio

You can use the package manager in Visual Studio to browse the available template versions. First, open the package manager by selecting `Tools > NuGet Package Manager > Manage NuGet Packages For Solution...` from the top menu

![Opening the Nuget Package Manager](images/VS/open-nuget-package-manager.jpg)

Now the `NuGet` window will open, in the top right corner there is a dropdown `Package source`, in order to be able to see our nightly builds, we have to change this to the feed we've just added `Umbraco Nightly` in this case.

![Select the nightly NuGet feed](images/VS/select-nuget-feed.jpg)

Now that the correct feed is selected we're almost ready to search for the package and choose a version, however since these are marked as prerelease, we have to tick the checkbox `Include prerelease` otherwise these will be filtered out. Next search for `Umbraco.Templates`, and choose that package. Now we can click on the `Version` drop down and see the available nightly builds for both V9 and V10. his is the ***template***, not the Umbraco package itself, so it won't work to click install. Instead chose the applicable version and note down the version number

![Find the version](images/VS/find-the-version.jpg)

### Using Rider

You can use the NuGet window in Rider to browse the available template versions. First open the window by clicking on `NuGet` on the bottom bar, next make sure the `Packages` tab is selected. To make things as easy as possible for ourselves click on the sources dropdown (3), and make sure that only our nightly feed is selected.

![Choose the feed](images/Rider/choose-the-feed.jpg)

Now that the correct feed is selected we're almost ready to search for the package and choose a version, however since these are marked as prerelease, we have to tick the checkbox `Prerelase` otherwise these will be filtered out. Next search for `Umbraco.Templates`, and choose that package. Now we can click on the `Version` drop down and see the available nightly builds for both V9 and V10. It's important to note that this is the ***template***, not the Umbraco package itself, so it won't work to click install. Instead chose the applicable version and note down the version number

![Find the version](images/Rider/find-the-version.jpg)

## Installing the nightly build

Now that our feed is added and we know the exact version we're ready to install our template.

Open up your command prompt of choice and execute the `dotnet new -i ` command using the latest, version, at the time of writing the latest preview build is `9.4.0-preview20220228.85007` so to install the newest nightly build I'd have to execute:

```none
dotnet new -i Umbraco.Templates::9.4.0-preview20220228.85007
```

The name and the versions are separated with two colons `::`, it's important that we specify the entire version including the `-preview20220228.85007`, otherwise the dotnet new command cannot find the package.

With that, we've successfully installed the latest nightly build of Umbraco! All we have to do now to create a site with the newest nightly is to run `dotnet new Umbraco -n MyAwesomeNightlySite`

For more information about installing Umbraco see [the installation documentation](./index.md)
