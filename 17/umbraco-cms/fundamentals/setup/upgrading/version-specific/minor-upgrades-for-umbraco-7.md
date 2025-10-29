---
description: >-
  This article provides details on how to upgrade to the next minor version when
  using Umbraco 7.
---

# Minor upgrades for Umbraco 7

Sometimes there are exceptions to these guidelines, which are listed in the [**version-specific guide**](./).

## Note

It is necessary to run the upgrade installer on each environment of your Umbraco site. If you want to update your staging and live site then you need to repeat the steps below and make sure that you click through the install screens to complete the upgrade.

## Contents

In this article you will find instructions for 2 different ways of upgrading:

* [Upgrade using NuGet](minor-upgrades-for-umbraco-7.md#upgrade-using-nuget)
* [Upgrade manually from a Zip file](minor-upgrades-for-umbraco-7.md#upgrade-manually-from-a-zip-file)

## Upgrade using NuGet

1. Open up the **Package Console** and type: `Update-Package UmbracoCms`
2. Choose **"No to All"** by pressing the **"L"** when prompted.
   * If there are any specific configuration changes required for the version you are upgrading to then they will be noted in the [**version-specific guide**](./).

Alternatively, you can use the Visual Studio **NuGet Package Manager** to upgrade:

1. Open the **NuGet Package Manager** and select the **Updates** pane to get a list of available updates.
2. Choose the package called **UmbracoCms** and select update.

The upgrade will run through all the files and make sure you have the latest changes while leaving the files you have updated.

### Upgrades to versions lower than 7.2.0

If you're not upgrading to 7.2.0 or higher then you should follow these extra instructions. If you are upgrading to 7.2.0+ then you can skip this and go to [Merge UI.xml and language](#merge-uixml-and-language).

You will be asked to overwrite your web.config file and the files in /config, make sure to answer **No** to those questions.

For some inexplicable reason, the installation will fail if you click "No to All" (in the GUI) or answer "L" (in the package manager console) to the question: "File 'Web.config' already exists in project 'MySite'. Do you want to overwrite it?" So make sure to only answer "**No**" (in the GUI) or "**N**" (in the package manager console).

![File conflict dialog with a web.config file in conflict](<../../../../../../16/umbraco-cms/fundamentals/setup/upgrading/images/nuget-overwrite-dialog (1) (1) (1).png>) ![File conflict console message with multiple files in conflict](<../../../../../../16/umbraco-cms/fundamentals/setup/upgrading/images/nuget-upgrade-overwrite (1) (1) (1).png>)

We will overwrite the `web.config` file. We'll back it up so don't worry. You can find the backup in `App_Data\NuGetBackup\20140320-165450\`. The `20140320-165450` bit is the date and time when the backup occurred, which varies. You can then merge your config files and make sure they're up to date.

## Upgrade manually from a zip file

Download the .zip file for the new version you are upgrading to from [https://our.umbraco.com/download](https://our.umbraco.com/download)

Copy the following folders from inside the .zip file over the existing folders in your site:

* `/bin`
* `/Umbraco`
* `/Umbraco_Client`

{% hint style="info" %}
There are hosting providers (we know of one: RackSpace Cloud) that require proper casing of file and folder names. Generally, on Windows, this is not a problem. Is your hosting provider forcing proper casing? You'll then need to verify that folders and files are named in the same casing as the version you're upgrading to.
{% endhint %}

## Merge configuration files

You can expect some changes to the following configuration files:

* Any file in the `/Config` folder
* The `/Global.asax` file
* The `web.config` file in the root of your site **(Important: make sure to copy back the version number, and the connection string as they were.)**
* In rare cases, the `web.config` file in the Views folder

Use a tool like [WinMerge](http://winmerge.org/) to check changes between all of the config files. Depending on when you last did this there may have been updates to a few of them.

There's also the possibility that files in the `/Config` folder are new or have been removed(we note this in the release notes). WinMerge (and other diff tools) is able to compare folders as well so you can spot these differences.

Up until version 6.0.0 it was necessary to change the version number in `ClientDependency.config`. This was to clear the cached HTML/CSS/JS files in the backoffice. Change the current version number to one that's higher than that. Make sure not to skip this step as you might get strange behavior in the backoffice otherwise.

## Merge UI.xml and language

Some packages (like Contour and Umbraco Forms) add dialogs to the `UI.xml`. Make sure to merge those changes back in from your backup during the upgrade so that the packages continue to work. This file can be found in: `/Umbraco/Config/Create/UI.xml`.

Packages like Contour, Umbraco Forms, and Courier also make changes to the language files located in: `/Umbraco/Config/Lang/*.xml` (typically `en.xml`).

## Finalize

After copying the files and making the config changes, you can open your site. You should see the installer which will guide you through the upgrade.

The installer will do two things:

* Update the version number in the `web.config`
* Upgrade your database in case there are any changes

We are aware that, currently, the installer is asking you for the database details of a **blank database** while upgrading. In the near future this will be pre-filled with your existing details and the wording will be updated. So no need to be scared. Enter the details of your existing database and Umbraco will upgrade it to the latest version when necessary.

## Post installation

One important recommendation is to always remove the `install` folder immediately after upgrading Umbraco and never to upload it to a live server.

## Potential issues and gotchas

### Browser cache

Google Chrome has notoriously aggressive caching. If something doesn't seem to work well in the backoffice, make sure to clear cache and cookies thoroughly (for other browsers as well). Normally the browser cache problem is automatically handled in an Umbraco upgrade by modifying the config/ClientDependency.config version number. If you wish to re-force this update you can increment this version number. This will ensure that any server-side cache of JavaScript and stylesheets gets cleared as well.

One way to nudge the cache in Chrome is to open the developer tools (F12) and go to the settings (the cog icon). There will be a checkbox that says "Disable cache (while DevTools is open)". Once this checkbox is on you can refresh the page and the cache should be invalidated. To force it even more, the "reload" button next to your address bar now has extra options when you right-click it. It should have "Normal reload", "Hard reload" and "Empty cache and hard reload" now. The last option is the most thorough and you might want to try that.
