---
description: This is the guide for upgrading existing installations in general.
---

# Upgrade your project

In this article, you will find everything you need to upgrade your Umbraco CMS project.

You will find instructions on how to upgrade to a new minor or major version as well as how to run upgrades unattended.

* [What is involved in an upgrade](./#what-is-involved-in-an-upgrade)
* [Before you upgrade](./#before-you-upgrade)
* [Upgrade to a new Major](./#upgrade-to-a-new-major)
* [Upgrade to a new Minor](./#upgrade-to-a-new-minor)
* [Run an unattended upgrade](./#run-an-unattended-upgrade)

## What is involved in an upgrade

When upgrading to a new version of Umbraco, there are four key aspects of the migration to be aware of.

### Database schema and content

Firstly there's the update of your Umbraco database's schema and how the content is stored.  On occasion changes are necessary to support a new feature. This might be adding new tables or columns, or updating the stored data. This is something Umbraco takes care of for you. When Umbraco starts up and is running a newer version, the necessary changes will be detected and applied.

As a developer responsible for the Umbraco website, there's nothing specific you need to do here.  We will communicate key migrations that will happen on major version upgrades. As if you have a large site and significant amounts of data need to be updated, the migration could take some time to complete.

Minor or patch versions may contain schema and content updates too, but they won't be extensive.

### Supported features

Secondly you should review your use of property editors to ensure that they are available on the new version.  It's rare for these to be removed, but it can happen when better alternatives are available.  These are only removed in major versions and with plenty of notice. They will have been indicated as legacy on earlier versions.

### Project customizations

The third aspect is determining and verifying that your own code customizations are compatible with the new version. This includes C# server-side functionality, Razor templates and JavaScript backoffice extensions.

Extensive efforts are made to avoid breaking changes that would cause issues for these types of customization other than in a major version update.

### Third-party packages

Finally you should consider the packages you are using on your project. You will need to verify that the package will work with the new version of Umbraco. Or that a compatible upgrade of the package is available or planned.

As above, breaking changes that would prevent packages from working other than in a major version update are avoided.

### Considerations for major version upgrades

For the reasons described, projects always need to be considered case by case when upgrading to new versions.

Umbraco communicates about the breaking changes in release blog posts and on the documented [version specific upgrade details](./version-specific/README.md). There will be extended release candidate periods to ensure upgrades can be tested and to help package developers support new major versions.

Breaking changes are minimized but there will be cases when such updates are needed. How straightforward the upgrade will be depends on the breaking changes included in the major and whether your project(s) are impacted by them.

## Before you upgrade

The following lists a few things to be aware of before initiating an upgrade of your Umbraco CMS project.

* Sometimes, there are exceptions to general upgrade guidelines. These are listed in the [**version-specific guide**](version-specific/). Be sure to read this article before moving on.
* Ensure your setup meets the [requirements](../requirements.md) for the new versions you will be upgrading your project to.
* Things may go wrong for different reasons. Be sure to **always** keep a backup of both your site's files and the database. This way, you can always return to a version that you know works.
* Before upgrading to a new major version, check if the packages you're using are compatible with the version you're upgrading to. On the package's page on the [Umbraco Marketplace](https://marketplace.umbraco.com/), check the "Umbraco versions" field.

{% hint style="info" %}
It is necessary to run the upgrade installer on each environment of your Umbraco site. This means that you need to repeat the steps below on each of your environments in order to complete the upgrade.
{% endhint %}

## Legacy Umbraco

The steps outlined in this article apply to Umbraco version 10 and later versions.

Are you upgrading to a minor version for Umbraco 6, 7, or 8? You can find the appropriate guide below:

{% content-ref url="version-specific/minor-upgrades-for-umbraco-8.md" %}
[minor-upgrades-for-umbraco-8.md](version-specific/minor-upgrades-for-umbraco-8.md)
{% endcontent-ref %}

{% content-ref url="version-specific/minor-upgrades-for-umbraco-7.md" %}
[minor-upgrades-for-umbraco-7.md](version-specific/minor-upgrades-for-umbraco-7.md)
{% endcontent-ref %}

## Upgrade to a new Major

You can upgrade to a new major version of Umbraco CMS directly by using NuGet.

You must upgrade to the closest [Long-term Support (LTS) major](https://umbraco.com/products/knowledge-center/long-term-support-and-end-of-life/) version before upgrading to the latest version. For Umbraco 10, the closest long-term support version is Umbraco 13. Once the project is on Umbraco 13, you can move on to Umbraco 14.

{% hint style="warning" %}
Switching to a new major version of Umbraco CMS also means switching to a new .NET version. Ensure that any packages used on your site are compatible with this version before upgrading.

The package compatibility can be checked on the package's download page. Locate the **Project compatibility** area and select **View details** to check version-specific compatibility.
{% endhint %}

### Choose the correct .NET version

Use the table below to determine which .NET version to upgrade to when going through the steps below.

| CMS version | .NET version |
| ----------- | ------------ |
| 16          | 9.0          |
| 15          | 9.0          |
| 14          | 8.0          |
| 13          | 8.0          |
| 12          | 7.0          |
| 11          | 7.0          |
| 10          | 6.0.5        |

### Upgrade your project using Visual Studio

{% hint style="info" %}
If you are upgrading a Cloud project locally from version 14 to 15, remove the `Umbraco.Cloud.Cms.PublicAccess` and `Umbraco.Cloud.Identity.Cms` packages. For more details, see [Step 3: Upgrade the project locally using Visual Studio](https://docs.umbraco.com/umbraco-cloud/product-upgrades/major-upgrades#step-3-upgrade-the-project-locally-using-visual-studio) in the Umbraco Cloud Documentation.
{% endhint %}

It's recommended that you upgrade the site offline and test the upgrade fully before deploying it to the production environment.

1. Stop your site in IIS to prevent any changes from being made while you are upgrading.
2. Open your Umbraco project in Visual Studio.
3. Right-click on the project name in the Solution Explorer and select **Properties**.
4. Select the **.NET** version from the **Target Framework** drop-down.
5. Go to **Tools** > **NuGet Package Manager** > **Manage NuGet Packages for Solution...**
6. Go to the **Installed** tab in the NuGet Package Manager.
7.  Upgrade **Umbraco.Cms**.

    a. Select the correct version from the **Version** drop-down.

    b. Click **Install** to upgrade your project.

{% hint style="info" %}
If you have other packages like Umbraco Forms installed, upgrade them before upgrading **Umbraco.CMS**. Consult the [version-specific upgrade notes for Umbraco Forms](https://docs.umbraco.com/umbraco-forms/upgrading/version-specific) if relevant.
{% endhint %}

8. Make sure that your connection string has `TrustServerCertificate=True` to complete the upgrade successfully:

{% code title="appsettings.json" %}
```csharp
"ConnectionStrings": {
    "umbracoDbDSN": "Server=YourLocalSQLServerHere;Database=NameOfYourDatabaseHere;User Id=NameOfYourUserHere;Password=YourPasswordHere;TrustServerCertificate=True"
}
```
{% endcode %}

9. Restart your site in IIS, then build and run your project to finish the installation.

{% hint style="info" %}
Umbraco 13 and later versions use the [Minimal Hosting Model](https://github.com/umbraco/Umbraco-CMS/pull/14656).

If you have added custom code to the `startup.cs` file, it is recommended to move that code into a Composer after upgrading.
{% endhint %}

{% hint style="warning" %}
If your database experiences timeout issues after an upgrade, it might be due to the [ASP.NET Core Module's](https://learn.microsoft.com/en-us/aspnet/core/test/troubleshoot-azure-iis?#default-startup-limits) `startupTimeLimit` configuration.

To fix the issue, try increasing the [`startupTimeLimit`](https://learn.microsoft.com/en-us/aspnet/core/host-and-deploy/iis/web-config?) in the `web.config` file. Additionally, you can set the [`Connection Timeout`](https://learn.microsoft.com/en-us/dotnet/api/system.data.sqlclient.sqlconnection.connectiontimeout?) value in the [`ConnectionString`](https://learn.microsoft.com/en-us/dotnet/api/microsoft.data.sqlclient.sqlconnection.connectionstring?) in the `appsettings.json` file.
{% endhint %}

### Potential issues and gotchas

If you receive an error that **a deploy license is missing** even though you have a valid license, follow the guide below.&#x20;

Google Chrome has aggressive caching, so when experiencing startup issues, clear the cache and cookies thoroughly. Ideally, this should be done for other browsers as well.

Nudge the cache in Chrome following these steps:

1. Open the developer tools (F12).
2. Go to the settings (Cog icon).
3. Ensure that "Disable cache (while DevTools is open)" is checked.
4. Refresh the page, and the cache will be invalidated.
5. Right-click the "reload" button next to your address bar and choose "Empty cache and hard reload".

All caches and cookies have now been cleared from your Google Chrome browser. Generally, it is a good thing to do occasionally.

## Upgrade to a new Minor

NuGet installs the latest version of the package when you use the `dotnet add package` command unless you specify a package version:

`dotnet add package Umbraco.Cms --version <VERSION>`

Add a package reference to your project by executing the `dotnet add package Umbraco.Cms` command in the directory that contains your project file.

Run `dotnet restore` to install the package.

{% hint style="warning" %}
**For Umbraco 9**\
If you are using SQL CE in your project, you need to run `dotnet add package Umbraco.Cms.SqlCe --version <VERSION>` before the `dotnet restore` command. From Umbraco 10, SQL CE has been replaced with SQLite, so a `dotnet restore` should be sufficient. If this is not working, then you need to run `dotnet add package Umbraco.Cms.Persistence.Sqlite --version <VERSION>` , and then `dotnet restore`.
{% endhint %}

When the command completes, open the `.csproj` file to make sure the package reference was updated:

{% code title="YourProjectName.csproj" %}
```xml
<ItemGroup>
  <PackageReference Include="Umbraco.Cms" Version="x.x.x" />
</ItemGroup>
```
{% endcode %}

## Run an unattended upgrade

When upgrading your Umbraco project, it is possible to enable the upgrade to run unattended. This means that you will not need to run through the installation wizard when upgrading.

Below you will find the steps you need to take in order to upgrade your project unattended.

{% hint style="info" %}
Are you running a load-balanced setup with multiple servers and environments?

Check out the section about [Unattended upgrades in a load-balanced setup](./#unattended-upgrades-in-a-load-balanced-setup).
{% endhint %}

### Enable the unattended upgrade feature

1. Add the `Umbraco:Cms:Unattended:UpgradeUnattended` configuration key.
2. Set the value of the key to `true`.

{% code title="appsettings.json" %}
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
{% endcode %}

### Run the upgrade

With the correct configuration applied, the project will be upgraded on the next boot.

#### Boot order

The Runtime level uses `Run` instead of `Upgrade` to allow the website to continue to boot up directly after the migration is run. This happens instead of initiating the otherwise required restart.

{% hint style="info" %}
The upgrade is run after Composers but before Components, and the `UmbracoApplicationStartingNotification`. This is because the migration requires services that are registered in Composers, and Components require that Umbraco and the database are ready.
{% endhint %}

### Unattended upgrades in a load-balanced setup

Follow the steps outlined below to use unattended upgrades in a load-balanced setup.

1. [Upgrade Umbraco via NuGet](./#upgrade-to-a-new-major).
2. Deploy to all environments.
3. Set the `Umbraco:CMS:Unattended:UpgradeUnattended` configuration key to `true` for **the Main server only**.
4. Boot the Main server, and the upgrade will run automatically.
5. Wait for the upgrade to complete.
6. Boot the Read-Only servers and ensure they do not show the “upgrade required” screen.
