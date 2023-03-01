---
description: This article provides details on how to upgrade to the next minor version when using Umbraco 8.
---

# Minor upgrades for Umbraco 8

Sometimes there are exceptions to these guidelines, which are listed in the **[version-specific guide](README.md)**.

## Note

It is necessary to run the upgrade installer on each environment of your Umbraco site. If you want to update your staging and live site you need to repeat the steps below. Make sure you click through the install screens so that your upgrade is complete.

## Contents

In this article you will find instructions for 3 different ways of upgrading:

* [Upgrade using NuGet](#upgrade-using-nuget)
* [Upgrade manually from a Zip file](#upgrade-manually-from-a-zip-file)
* [Run an unattended upgrade (v8.12+)](#run-an-unattended-upgrade)

## Upgrade using NuGet

1. Open up the **Package Console** and type: `Update-Package UmbracoCms`
2. Choose **"No to All"** by pressing the **"L"** when prompted.
    * If there are any specific configuration changes required for the version you are upgrading to then they will be noted in the **[version-specific guide](version-specific.md)**.

Alternatively, you can use the Visual Studio **NuGet Package Manager** to upgrade:

1. Open the **NuGet Package Manager** and select the **Updates** pane to get a list of available updates.
2. Choose the package called **UmbracoCms** and select update.

The upgrade will run through all the files and make sure you have the latest changes while leaving files you have updated.

## Upgrade manually from a zip file

Download the `.zip` file for the new version you are upgrading to from [https://our.umbraco.com/download](https://our.umbraco.com/download)

Copy the following folders from inside the `.zip` file over the existing folders in your site:

* `/bin`
* `/Umbraco`

{% hint style="info" %}
There are hosting providers (we know of one: RackSpace Cloud) that require proper casing of file and folder names. Normally on Windows this is not a problem. If your hosting provider however forces proper casing, you will need to verify that the folder and file names are in the same casing as in the newest version you're upgrading to.
{% endhint %}

### Merge configuration files

You can expect some changes to the following configuration files:

* Any file in the `/Config` folder
* The `/Global.asax` file
* The `web.config` file in the root of your site **(Important: make sure to copy back the version number, and the connection string as they were.)**
* In rare cases, the `web.config` file in the `/Views` folder

Use a tool like [WinMerge](http://winmerge.org/ "WinMerge") to check changes between all of the config files. Depending on when you last did this there may have been updates to few of them.

There's also the possibility that some files in the `/Config` folder are new or some have been removed (we do make a note of this in the release notes). WinMerge (and other diff tools) can compare folders as well so you can spot these differences.

### Merge UI.xml and language files

Some packages like Umbraco Forms add dialogs to the `UI.xml`. Make sure to merge those changes back in from your backup during the upgrade so that the packages continue to work. This file can be found in: `/Umbraco/Config/Create/UI.xml`.

Packages like Umbraco Forms and Courier also make changes to the language files located in: `/Umbraco/Config/Lang/*.xml` (typically `en.xml`).

### Finalize

After copying the files and making the config changes, you can open your site. You should see the installer which will guide you through the upgrade.

The installer will do two things:

* Update the version number in the `web.config`
* Upgrade your database in case there are any changes

We are aware that, currently, the installer is asking you for the database details of a **blank database** while upgrading. In the near future this will be pre-filled with your existing details and the wording will be updated. So no need to be scared. Enter the details of your existing database and Umbraco will upgrade it to the latest version when necessary.

## Run an unattended upgrade

When upgrading your Umbraco project to Umbraco v8.12+ it is possible to enable the upgrade to run unattended. This means that you will not need to run through the installation wizard when upgrading.

Below you will find the steps you need to take in order to upgrade your project unattended.

{% hint style="info" %}
Are you running a load balanced setup with multiple servers and environments?

Check out the section about [Unattended upgrades in a load balanced setup](#unattended-upgrades-in-a-load-balanced-setup).
{% endhint %}

### Enable the feature

1. Add the `Umbraco.Core.RuntimeState.UpgradeUnattended` key to `appSettings` in your web.config file.
2. Set the value of the key to `true`.

```xml
    <add key="Umbraco.Core.RuntimeState.UpgradeUnattended" value="true" />
```

### Check the `ConfigurationStatus`

In order to trigger the actual upgrade, the correct version number needs to be set.

It is important to use the version number of the version that you are upgrading to. If this is not set, the upgrade will not run even if the `UpgradeUnattended` key has been set to `true`.

1. Locate the `ConfigurationStatus` key in the `appSettings` section in your web.config file.
2. Update the value to match the Umbraco version that you are upgrading to.

```xml
<add key="Umbraco.Core.ConfigurationStatus" value="x.x.x"/>
```

### Run the upgrade

With the correct configuration applied, the project will be upgraded on the next boot.

{% hint style="info" %}
While the upgrade processes are running, any requests made to the site will be "put on hold", meaning that no content will be returned before the upgrade is complete.
{% endhint %}

#### Boot order

The Runtime level will use `Run` instead of `Upgrade` in order to allow the website to continue to boot up directly after the migration is run, instead of initiating the otherwise required restart.

{% hint style="info" %}
The upgrade is run after Composers but before Components. This is because the migration requires services that are registered in Composers and Components requires that Umbraco and the database is ready.
{% endhint %}

### Unattended upgrades in a load balanced setup

Follow the steps outlined below to use run unattended upgrades in a load balanced setup.

1. Upgrade Umbraco via NuGet in Visual Studio. Make sure the `Umbraco.Core.ConfigurationStatus` key in `appSetting` in the `web.config` file is updated to match the **target version**.
2. Deploy to all environments, including the updated `appSetting` for `Umbraco.Core.ConfigurationStatus`.
3. Set the `Umbraco.Core.RuntimeState.UpgradeUnattended` key in `appSetting` in the `web.config` to `true` for **the Main server only**.
4. Request a page on the Main server and the upgrade will run automatically.
5. Wait for the upgrade to complete.
6. Browse the Read-Only servers and make sure they do not show the “upgrade required” screen.

## Post installation

One important recommendation is to always remove the `install` folder immediately after upgrading Umbraco and never to upload it to a live server.

## Potential issues and gotchas

### Browser cache

Google Chrome has notoriously aggressive caching, so if something doesn't seem to work well in the backoffice, make sure to clear cache and cookies thoroughly (for other browsers as well). Normally the browser cache problem is automatically handled in an Umbraco upgrade by modifying the config/ClientDependency.config version number. If you however wish to re-force this update you can increment this version number which will ensure that any server-side cache of JavaScript and stylesheets gets cleared as well.

One way to nudge the cache in Chrome is to open the developer tools (F12) and go to the settings (the cog icon). There will be a checkbox that says "Disable cache (while DevTools is open)". Once this checkbox is on you can refresh the page and the cache should be invalidated. To force it even more, the "reload" button next to your address bar now has extra options when you right-click it. It should have "Normal reload", "Hard reload" and "Empty cache and hard reload" now. The last option is the most thorough and you might want to try that.
