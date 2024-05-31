---
description: Instructions on installing nightly builds of Umbraco.
---

# Installing Nightly Builds

In this article, we'll explain how you can get the latest builds of Umbraco. You can do this in three steps:

1. [Adding the nightly feed as a NuGet source](installing-nightly-builds.md#adding-the-nightly-feed-as-a-nuget-source)
2. [Finding the latest nightly version](installing-nightly-builds.md#finding-the-latest-nightly-version)
3. [Installing the latest nightly version template](installing-nightly-builds.md#installing-the-latest-nightly-version-template)

## Adding the nightly feed as a NuGet source

The NuGet feed containing the nightly builds is `https://www.myget.org/F/umbraconightly/api/v3/index.json`.

You can either add this feed through the command line or use an IDE of your choice. In this article, we'll provide steps for:

* [Using the command line](installing-nightly-builds.md#option-1-using-the-command-line)
* [Using Visual Studio](installing-nightly-builds.md#option-2-using-visual-studio)
* [Using Rider](installing-nightly-builds.md#option-3-using-rider)

### Option 1: Using the command line

To add the nightly feed using the command line:

1. Open a command prompt of your choice.
2. Run the following command:

```
dotnet nuget add source "https://www.myget.org/F/umbraconightly/api/v3/index.json" -n "Umbraco Nightly"
```

Now the feed is added as a source named `Umbraco Nightly`.

### Option 2: Using Visual Studio

To add the nightly feed using Visual Studio:

1. Open Visual Studio.
2. Go to **Tools** > **NuGet Package Manager** > **Package Manager Settings**.

![Package Manager Settings](<../../../.gitbook/assets/Package-Manager-Settings (1) (2).jpg>)

3. The **Options** window open.
4. Select the **Package Sources** option in the **NuGet Package Manager** section.
5. Click the `+` icon.
6. A new Package source will be added automatically and highlighted.
7. Enter the desired name for the feed in the **Name** field.
8. Enter the link `https://www.myget.org/F/umbraconightly/api/v3/index.json` into the **Source** field.
9. Click **OK**.

![Register the nightly feed](../../../.gitbook/assets/Register\_Nightly\_Feed.jpg)

Now the feed is added as a source named `Umbraco Nightly`.

### Option 3: Using Rider

To add the nightly feed using Rider:

1. Open Rider.
2. Go to **View** > **Tool Windows** > **NuGet**.
3. Go to **Sources** tab.
4. Choose the `C:\Users\Úmbraco\AppData\Roaming\NuGet\NuGet.Config` to add the feed globally.
5. Cick the green `+` button in the **New Feed** field.

![Open the new feed menu](../../../.gitbook/assets/NuGet\_NewFeed.jpg)

6. The New feed dialog opens.
7. Enter the desired name in the **Name** field.
8. Enter `https://www.myget.org/F/umbraconightly/api/v3/index.json` in the URL field.

{% hint style="info" %}
Leave the **User, Password** fields empty, and the **Enabled** checkbox ticked.
{% endhint %}

![Adding the feed](../../../.gitbook/assets/NewFeed\_Details.jpg)

9. Click **OK**.

Now the feed is added as a source named `Umbraco Nightly`.

## Finding the latest nightly version

In the previous steps, we've added the feed and are now ready to install the nightly build.

However, which version should we install? This is, in particular, an issue if we want to create a new site using the dotnet template. The dotnet command does not allow us to use wildcard characters to install the newest version.

Using IDE, we can see a list of available versions in both Visual Studio and Rider. We can then use that version to install the template.

Here we're going to assume that you want to create a brand new site with the dotnet template. The approach is the same if you're updating an existing site. You'll click the **Update** button for the `Umbraco.Cms` package instead of installing the template through the terminal.

Let's look at how we can find the latest version of the nightly build:

* [Using Visual Studio](installing-nightly-builds.md#option-1-using-visual-studio)
* [Using Rider](installing-nightly-builds.md#option-2-using-rider)

### Option 1: Using Visual Studio

You can use the package manager in Visual Studio to browse the available template versions.

1. Open Visual Studio.
2. Go to **Tools** > **NuGet Package Manager** > **Manage NuGet Packages For Solution...**

![Opening the Nuget Package Manager](<../../../.gitbook/assets/Manage\_NuGet\_Pkgs (1).jpg>)

3. Select **Umbraco Nightly** from the **Package source** dropdown in the **NuGet - Solution** window.

![Select the nightly NuGet feed](../../../.gitbook/assets/Manage\_Packages.jpg)

4. Check the **Include prerelease** checkbox.
5. Search for **Umbraco.Templates** in the **Browse** field.
6. Choose that package.
7. Click on the **Version** dropdown and see the available nightly builds.
8. Choose the applicable version and note down the version number.

![Find the version](../../../.gitbook/assets/Latest\_nightly\_build\_version.jpg)

### Option 2: Using Rider

You can use the NuGet window in Rider to browse the available template versions.

1. Open Rider.
2. Go to the **Packages** tab in the **NuGet** window..
3. Select **Umbraco Nightly** from the **All Feeds** dropdown.

![Choose the feed](../../../.gitbook/assets/Rider\_Nightly\_Feed.jpg)

4. Check the **Prerelase** checkbox.
5. Search for **Umbraco.Templates** in the **Search** field.
6. Choose that package.
7. Click on the **Version** drop down and see the available nightly builds.
8. Choose the applicable version and note down the version number

![Find the version](../../../.gitbook/assets/Rider\_Nightly\_Feed\_version.jpg)

## Installing the latest nightly version template

Now that our feed is added and we know the exact version we're ready to install our template.

To install the latest nightly version template:

1. Open your command prompt.
2. Run the following command using the latest version:

```bash
dotnet new install Umbraco.Templates
```

With that, we've successfully installed the latest nightly build of Umbraco.

All we have to do now is to create a site using the `dotnet new umbraco -n MyAwesomeNightlySite` command.

For more information about installing Umbraco, see the [Installation](./) article.
