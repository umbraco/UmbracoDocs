# Upgrade your project

_This is the guide for upgrading existing installations in general._

In this article, you will find everything you need to upgrade your Umbraco CMS project.

You will find instructions on how to upgrade to a new minor or major version as well as how to run upgrades unattended.

* [Before you upgrade](./#before-you-upgrade)
* [Upgrade to a new Major](./#upgrade-to-a-new-major)
* [Upgrade to a new Minor](./#upgrade-to-a-new-minor)
* [Run an unattended upgrade](./#run-an-unattended-upgrade)

## Before you upgrade

The following lists a few things to be aware of before initiating an upgrade of your Umbraco CMS project.

* Sometimes there are exceptions to general upgrade guidelines. These are listed in the [**version-specific guide**](version-specific/). Be sure to read this article before moving on.
* Check if your setup meets the [requirements](../requirements.md) for the new versions you will be upgrading your project to.
* Things may go wrong for different reasons. Be sure to **ALWAYS** keep a backup of both your site's files and the database. This way you can always return to a version that you know works.
* Before upgrading to a new major version, check if the packages you're using are compatible with the version you're upgrading to. On the package's download page, in the **Project compatibility** area, click **View details** to check version-specific compatibility.

{% hint style="info" %}
It is necessary to run the upgrade installer on each environment of your Umbraco site. This means that you need to repeat the steps below on each of your environments in order to complete the upgrade.
{% endhint %}

## Legacy Umbraco

The steps outlined in this article apply to modern Umbraco from version 10 and later versions.

Are you upgrading to a minor for Umbraco 6, 7, or 8? You can find the appropriate guide below:

{% content-ref url="version-specific/minor-upgrades-for-umbraco-8.md" %}
[minor-upgrades-for-umbraco-8.md](version-specific/minor-upgrades-for-umbraco-8.md)
{% endcontent-ref %}

{% content-ref url="version-specific/minor-upgrades-for-umbraco-7.md" %}
[minor-upgrades-for-umbraco-7.md](version-specific/minor-upgrades-for-umbraco-7.md)
{% endcontent-ref %}

## Upgrade to a new Major

You can upgrade to a new major of Umbraco CMS directly by using NuGet.

{% hint style="warning" %}
Switching to a new major of Umbraco CMS also means switching to a new .NET version. You need to make sure that any packages used on your site are compatible with this version before upgrading.

The package compatibility can be checked on the package's download page. Locate the **Project compatibility** area and select **View details** to check version-specific compatibility.
{% endhint %}

### Choose the correct .NET version

Use the table below to determine which .NET version to upgrade to when going through the steps below.

| CMS version | .NET version |
| ----------- | ------------ |
| 12          | 7.0          |
| 11          | 7.0          |
| 10          | 6.0.5        |

### Upgrade your project using Visual Studio

It's recommended that you upgrade the site offline and test the upgrade fully before deploying it to the production environment.

1. Stop your site in IIS to prevent any changes from being made while you are upgrading.
2. Open your Umbraco project in Visual Studio.
3. Right-click on the project name in the Solution Explorer and select **Properties**.
4. Select the **.NET** version from the **Target Framework** drop-down.
5. Go to **Tools** > **NuGet Package Manager** > **Manage NuGet Packages for Solution...**
6. Go to the **Installed** tab in the NuGet Package manager.
7.  Upgrade **Umbraco.Cms**.

    a. Select the correct version from the **Version** drop-down.

    b. Click **Install** to upgrade your project.

{% hint style="info" %}
If you have other packages installed such as Umbraco Forms, then before upgrading **Umbraco.CMS** you will need to upgrade the packages first. Consult the [version specific upgrade notes for Umbraco Forms](https://docs.umbraco.com/umbraco-forms/upgrading/version-specific) if relevant.
{% endhint %}

8. Make sure that your connection string has `TrustServerCertificate=True` in order to complete successfully the upgrade:

```csharp
"ConnectionStrings": {
    "umbracoDbDSN": "Server=YourLocalSQLServerHere;Database=NameOfYourDatabaseHere;User Id=NameOfYourUserHere;Password=YourPasswordHere;TrustServerCertificate=True"
}
```

9. Restart your site in IIS, build, and run your project to finish the installation.

{% hint style="warning" %}
If your database experiences timeout issues after an upgrade, it might be due to [ASP.NET Core Module's](https://learn.microsoft.com/en-us/aspnet/core/test/troubleshoot-azure-iis?#default-startup-limits) 'startupTimeLimit' configuration.

To fix the issue, try increasing the [`startupTimeLimit`](https://learn.microsoft.com/en-us/aspnet/core/host-and-deploy/iis/web-config?) in the `web.config` file. Additionally, you can set the [`Connection Timeout`](https://learn.microsoft.com/en-us/dotnet/api/system.data.sqlclient.sqlconnection.connectiontimeout?) value in the [`ConnectionString`](https://learn.microsoft.com/en-us/dotnet/api/microsoft.data.sqlclient.sqlconnection.connectionstring?) in the `appsettings.json` file.
{% endhint %}

## Upgrade to a new Minor

NuGet installs the latest version of the package when you use the `dotnet add package` command unless you specify a package version:

`dotnet add package Umbraco.Cms --version <VERSION>`

Add a package reference to your project by executing the `dotnet add package Umbraco.Cms` command in the directory that contains your project file.

Run `dotnet restore` to install the package.

{% hint style="warning" %}
For v9: If you are using SQL CE in your project you will need to run `dotnet add package Umbraco.Cms.SqlCe --version <VERSION>` before running the `dotnet restore` command. From v10, SQL CE has been replaced with SQLite so a `dotnet restore` should be sufficient. If this is not working then you will need to run `dotnet add package Umbraco.Cms.Persistence.Sqlite --version <VERSION>` and then `dotnet restore`.
{% endhint %}

When the command completes, open the **.csproj** file to make sure the package reference was updated:

```xml
<ItemGroup>
  <PackageReference Include="Umbraco.Cms" Version="x.x.x" />
</ItemGroup>
```

## Run an unattended upgrade

When upgrading your Umbraco project, it is possible to enable the upgrade to run unattended. This means that you will not need to run through the installation wizard when upgrading.

Below you will find the steps you need to take in order to upgrade your project unattended.

{% hint style="info" %}
Are you running a load balanced setup with multiple servers and environments?

Check out the section about [Unattended upgrades in a load balanced setup](./#unattended-upgrades-in-a-load-balanced-setup).
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

The Runtime level will use `Run` instead of `Upgrade` to allow the website to continue to boot up directly after the migration is run. This happens instead of initiating the otherwise required restart.

{% hint style="info" %}
The upgrade is run after Composers but before Components and the `UmbracoApplicationStartingNotification`. This is because the migration requires services that are registered in Composers and Components require that Umbraco and the database are ready.
{% endhint %}

### Unattended upgrades in a load balanced setup

Follow the steps outlined below to use unattended upgrades in a load balanced setup.

1. Upgrade Umbraco via NuGet ([see instructions above](./#upgrade-to-a-new-major))
2. Deploy to all environments.
3. Set the `Umbraco:CMS:Unattended:UpgradeUnattended` configuration key to `true` for **the Main server only**.
4. Boot the Main server and the upgrade will run automatically.
5. Wait for the upgrade to complete.
6. Boot the Read-Only servers and make sure they do not show the “upgrade required” screen.
