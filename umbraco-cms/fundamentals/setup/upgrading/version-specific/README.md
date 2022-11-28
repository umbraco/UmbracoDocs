# Version Specific Upgrades

_This document covers specific upgrade steps if a version requires them. Most versions do not require specific upgrade steps. In most cases, you will be able to upgrade directly from your current version to the latest version._

Follow the steps in the [general upgrade guide](../), then these additional instructions for the specific versions.

## Breaking changes

{% content-ref url="umbraco10-breaking-changes.md" %}
[umbraco10-breaking-changes.md](umbraco10-breaking-changes.md)
{% endcontent-ref %}

{% content-ref url="umbraco11-breaking-changes.md" %}
[umbraco11-breaking-changes.md](umbraco11-breaking-changes.md)
{% endcontent-ref %}

## Version 9 to version 10

{% hint style="warning" %}
**Important**: .NET version 6.0.5 is the minimum required version for Umbraco 10 to be able to run. You can check with `dotnet --list-sdks` what your latest installed Software Development Kit (SDK) version is. SDK version 6.0.300 is the one that includes .NET 6.0.5. At the time of writing, .NET 6.0.6 is out with an SDK version of 6.0.301.
{% endhint %}

## Video Tutorial

{% embed url="https://www.youtube.com/watch?ab_channel=UmbracoLearningBase&v=075H_ekJBKI" %}
Upgrading from Umbraco 9 to Umbraco 10
{% endembed %}

The upgrade path between Umbraco 9 and Umbraco 10 can be done directly by updating your project using NuGet. You will need to ensure the packages you are using are available in Umbraco 10.

Are you looking to upgrade an Umbraco Cloud project from 9 to 10? Follow the guide made for [Upgrading your project from Umbraco 9 to 10](../../../../../umbraco-cloud/upgrades/major-upgrades.md) instead, as it requires a few steps specific to Umbraco Cloud.

{% hint style="warning" %}
**Important**: SQL CE is no longer a supported database engine.

There is no official migration path from SQL CE to another database engine.

The following options may suit your needs:

* Follow a community guide to migrate from a SQL CE database to SQL Server, like the [article by Jan Reilink](https://www.saotn.org/convert-sqlce-database-to-sql-server/)
* Setup a new database for v10 and use [uSync](https://jumoo.co.uk/usync/) to transfer document types and content across.
* Setup a new database for v10 and use a premium tool such as [redgate SQL Data Compare](https://www.red-gate.com/products/sql-development/sql-data-compare/) to copy database contents across.
* Setup a new database for v10 and use a premium tool such as [Umbraco Deploy](https://umbraco.com/products/umbraco-deploy) to transfer document types and content across.
{% endhint %}

### Steps to upgrade using Visual Studio

It's recommended that you upgrade the site offline, and test the upgrade fully before deploying it to the production environment.

1. Stop your site in IIS to prevent any changes being made to the database or filesystem while you are upgrading.
2. Open your Umbraco 9 project in Visual Studio.
3. Right-click on the project name in the Solution Explorer and select **Properties**.
4. Select **.NET 6.0** from the **Target Framework** drop-down.
5. Go to **Tools** > **NuGet Package Manager** > **Manage NuGet Packages for Solution...**
6. Go to the **Installed** tab in the NuGet Package manager.
7. Choose **Umbraco.Cms**.
8. Select **10.0.0** from the **Version** drop-down and click **Install** to upgrade your project to version 10.
9.  Update `Program.cs` to the following:

    ```csharp
    public class Program
    {
        public static void Main(string[] args)
            => CreateHostBuilder(args)
                .Build()
                .Run();

        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureUmbracoDefaults()
                .ConfigureWebHostDefaults(webBuilder =>
                {
                    webBuilder.UseStaticWebAssets();
                    webBuilder.UseStartup<Startup>();
                });
    }
    ```

    The calls to `ConfigureUmbracoDefaults` and `webBuilder.UseStaticWebAssets()` are new.
10. Remove the following files and folders:
    * `/wwwroot/umbraco`
    * `/umbraco/PartialViewMacros`
    * `/umbraco/UmbracoBackOffice`
    * `/umbraco/UmbracoInstall`
    * `/umbraco/UmbracoWebsite`
    * `/umbraco/config/lang`
    * `/umbraco/config/appsettings-schema.json`
11. If using Umbraco Forms, update your files and folders according to the [Upgrading - version specific](../../../../../umbraco-forms/installation/version-specific.md) for version 10 article.
12. Restart your site in IIS, build and run your project to finish the installation of Umbraco 10.

To re-enable the appsettings IntelliSense, you must update your schema reference in the `appsettings.json` file and any other `appsettings.{Environment}.json` files from:

```json
"$schema": "./umbraco/config/appsettings-schema.json",
```

To:

```json
"$schema": "./appsettings-schema.json",
```

{% hint style="info" %}
To upgrade to Umbraco 10, your database needs to be at least on Umbraco 8.18.
{% endhint %}

### Upgrade of any publicly hosted environment

When the upgrade is completed and tested, and prior to deploying to any publicly accessible environment, you should consider the following:

1. Ensure you have backups for both the database and the file system.
2. Stop the site so it is not accessible during the upgrade process.
3. Delete the relevant folders from the filesystem prior to deploying:
   * `/wwwroot/umbraco`
   * `/umbraco/PartialViewMacros`
   * `/umbraco/UmbracoBackOffice`
   * `/umbraco/UmbracoInstall`
   * `/umbraco/UmbracoWebsite`
   * `/umbraco/config/lang`
   * `/umbraco/config/appsettings-schema.json`
4. Deploy the site how you normally would to your public facing environment.
5. Start the site. At this point it will launch and upgrade the database, after which the site should become accessible and your upgrade is complete.
6. Check the logs for any errors which may have occurred during the upgrade process.

## [Breaking changes from Umbraco 9 to Umbraco 10](umbraco10-breaking-changes.md)

Breaking changes going from Umbraco 9 to Umbraco 10.
