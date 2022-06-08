---
versionFrom: 9.0.0
versionTo: 10.0.0
---

# Upgrades in general

_This is the guide for upgrading in general._

:::warning
**Important**: If you are upgrading to a new major version, like from Umbraco 8 to Umbraco 9, make sure to check out the **[version-specific documentation.](version-specific.md)**

Things may go wrong for various reasons. Make sure to **ALWAYS** make a backup of both your site's files and the database so that you can return to a version that you know works. You will need the backed up files for merging later so this step is not optional.

Before upgrading to a new major version, check if the packages you're using are compatible with the version you're upgrading to. On the package's download page, in the **Project compatibility** area, click **View details** to check version-specific compatibility.
:::

Sometimes there are exceptions to these guidelines, which are listed in the **[version-specific guide](version-specific.md)**.

## Note

It is necessary to run the upgrade installer on each environment of your Umbraco site. So if you want to update your staging and your live site then you need to repeat the steps below and make sure that you click through the install screens so that your upgrade is complete.

## Contents

In this article you will find instruction on the following ways of upgrading an Umbraco project:

* [Upgrade using NuGet](#upgrade-using-nuget)
* [Run an unattended upgrade](#run-an-unattended-upgrade)

## Upgrade using NuGet

NuGet installs the latest version of the package when you use the `dotnet add package` command unless you specify a package version:

`dotnet add package Umbraco.Cms --version <VERSION>`

After you have added a package reference to your project by executing the `dotnet add package Umbraco.Cms` command in the directory that contains your project file, run `dotnet restore` to install the package.

:::warning
If you're using SQL CE in your project you will need to run `dotnet add package Umbraco.Cms.SqlCe --version <VERSION>` too before running the `dotnet restore` command.
:::

When the command completes, open the **.csproj** file to make sure the package reference was updated:

```xml
<ItemGroup>
  <PackageReference Include="Umbraco.Cms" Version="9.0.1" />
</ItemGroup>
```

## Run an unattended upgrade

When upgrading your Umbraco project it is possible to enable the upgrade to run unattended. This means that you will not need to run through the installation wizard when upgrading.

Below you will find the steps you need to take in order to upgrade your project unattended.

:::tip
Are you running a load balanced setup with multiple servers and environments?

Check out the section about [Unattended upgrades in a load balanced setup](#unattended-upgrades-in-a-load-balanced-setup).
:::

### Enable the unattended upgrade feature

1. Add the `Umbraco:Cms:Unattended:UpgradeUnattended` configuration key.
2. Set the value of the key to `true`.

#### Example from an appsettings json configuration file
```json
{
    "Umbraco": {
        "CMS": {
            "Unattended": {
                "UpgradeUnattended": true
            }
        }
    }
}
```

### Run the upgrade

With the correct configuration applied, the project will be upgraded on the next boot.

#### Boot order

The Runtime level will use `Run` instead of `Upgrade` in order to allow the website to continue to boot up directly after the migration is run, instead of initiating the otherwise required restart.

:::note
The upgrade is run after Composers but before Components and the `UmbracoApplicationStartingNotification`. This is because the migration requires services that are registered in Composers and Components requires that Umbraco and the database is ready.
:::

### Unattended upgrades in a load balanced setup

Follow the steps outlined below to use run unattended upgrades in a load balanced setup.

1. Upgrade Umbraco via NuGet.
2. Deploy to all environments.
3. Set the `Umbraco:CMS:Unattended:UpgradeUnattended` configuration key to `true` for **the Main server only**.
4. Boot the Main server and the upgrade will run automatically.
5. Wait for the upgrade to complete.
6. Boot the Read-Only servers and make sure they do not show the “upgrade required” screen.
