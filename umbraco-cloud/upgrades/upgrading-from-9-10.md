# Upgrading Umbraco 9 project to Umbraco 10

This article will provide steps on how to upgrade your Umbraco 9 project to Umbraco 10.

tip **Are you using any custom packages or code on your Umbraco Cloud project?**

You will need to ensure the packages you are using are available in Umbraco 10 and that your custom code is valid with the .NET 6 Framework.

## Content

An overview of what you will find throughout this guide.

* [Prerequisites](upgrading-from-9-10.md#prerequisites)
* [Video Tutorial](upgrading-from-9-10.md#video-tutorial)
* [Step 1: Enable .NET 6](upgrading-from-9-10.md#step-1-enable-net-6)
* [Step 2: Clone down your project](upgrading-from-9-10.md#step-2-clone-down-your-environment)
* [Step 3: Upgrade the project locally using Visual Studio](upgrading-from-9-10.md#step-3-upgrade-the-project-locally-using-visual-studio)
* [Step 4: Deploy and Test on Umbraco Cloud](upgrading-from-9-10.md#step-4-deploy-and-test-on-umbraco-cloud)
* [Step 5: Going live](upgrading-from-9-10.md#step-5-going-live)

## Prerequisites

* An Umbraco 9 Cloud project running **the latest version of Umbraco 9**
* **At least 2 environments** on your Cloud project.
* A backup of your project database.
  * Directly from your environment. See the [Database backups](../databases/backups.md) article,
  * Or clone down and restore the project, and take a backup of the local database.

## Video Tutorial

{% embed url="https://www.youtube.com/embed/AN5OOKLHmPE?rel=0" %}
Video example.
{% endembed %}

## Step 1: Enable .NET 6

1. Go to the project in the Umbraco Cloud portal.
2. Navigate to **Settings** -> **Advanced**.
3. Scroll down to the **Runtime Settings** section.
4.  **Enable .NET 6** for each environment on your Cloud project.

    ![Runtime Settings](images/Runtime-Settings.png)

## Step 2: Clone down your environment

1. Clone down the **Development** environment.
2. Build and run the project locally.
3. Log in to the backoffice.
4. Restore content from your Cloud enviroment.

## Step 3: Upgrade the project locally using Visual Studio

1. Open your project in Visual Studio - use the `csproj` file in the `/src/UmbracoProject` folder.
2. Right-click your project solution in the **Solution Explorer**.
3.  Select **Properties**.

    ![Solution Explorer](images/Solution-Explorer.png)
4.  Select **.Net 6.0** from the **Target Framework** drop-down in the **General** section of the **Application** tab.

    ![Target Framework](images/Target-Framework.png)
5. Go to **Tools** > **NuGet Package Manager** > **Manage NuGet Packages for Solution...**.
6. Navigate to the **Browse** tab.
7. Install the _latest stable_ version of the "Microsoft.Extensions.DependencyInjection.Abstractions".
8. Navigate to the **Installed** tab.
9. Choose **Umbraco.Cms**.
10. Select your project.
11. Choose **10.0.0** from the **Version** drop-down.
12. Click **Install** to upgrade your project to version 10.

    ![Nuget Version Install](images/Nuget-Version-Install.png)

Follow the steps 9-12 to update the following packages as well:

| Package                                  | Version |
| ---------------------------------------- | ------- |
| Umbraco.Deploy.Cloud                     | 10.0.0  |
| Umbraco.Deploy.Contrib                   | 10.0.0  |
| Umbraco.Forms                            | 10.0.0  |
| Umbraco.Deploy.Forms                     | 10.0.0  |
| Umbraco.Cloud.Identity.Cms               | 10.0.2  |
| Umbraco.Cloud.StorageProviders.AzureBlob | 10.0.0  |

{% hint style="info" %}
If you have more projects in your solution or other packages, make sure that these are also updated to support .NET 6 framework.
{% endhint %}

With the packages and projects updated, it is time to make some changes to some of the default files.

1.  Update the `Program` class in the `Program.cs` file to the following:

    ```
    using Umbraco.Cms.Web.Common.Hosting;

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
2.  Re-enable the appsettings IntelliSense by updating your schema reference in the **appsettings.json** file from:

    ```json
    "$schema": "./umbraco/config/appsettings-schema.json",
    ```

    To:

    ```json
    "$schema": "./appsettings-schema.json",
    ```

    Apply this change to the following files as well:

    * **appsettings.Development.json**
    * **appsettings.Production.json**
    * **appsettings.Staging.json**
3. Remove the following files and folders _manually_ from your local project:
   * `/wwwroot/umbraco`
   * `/umbraco/PartialViewMacros`
   * `/umbraco/UmbracoBackOffice`
   * `/umbraco/UmbracoInstall`
   * `/umbraco/UmbracoWebsite`
   * `/umbraco/config/lang`
4. Update the Umbraco Forms related files and folders according to the [Upgrading - version specific](../../umbraco-forms/installation/version-specific.md) for version 10 article.
5. Choose your Database configuration:
   * To re-use the existing LocalDB database, configure the [ConnectionStrings](../../umbraco-deploy/upgrades/version-specific.md#database-initialization) or use the [`PreferLocalDbConnectionString` setting](../../umbraco-deploy/deploy-settings.md#preferlocaldbconnectionstring).
   * To use the default SQLite database, skip this step.
6.  Build and run your project locally to verify the Umbraco 10 upgrade.

    ![Target Framework](images/verify-v10-upgrade-locally.png)
7. Update the `global.json` in the root repository folder to target the runtime Software Development Kit (SDK) for the latest version of [.NET 6](https://dotnet.microsoft.com/en-us/download/dotnet/6.0).

````json
  {
  "sdk": {
      "allowPrerelease": false,
      "version": "6.0.402",
      "rollForward": "minor"
  }
  }
  ```

<div data-gb-custom-block data-tag="hint" data-style='info'></div>
If `global.json` does not exist in the root of your repository, you need to add it manually.

Learn more about the `global.json` in the offical [Microsoft docs](https://learn.microsoft.com/en-us/dotnet/core/tools/global-json).
{% raw %}
{% %}
{% endraw %}

## Step 4: Deploy and Test on Umbraco Cloud

Once the Umbraco 10 project runs locally without any errors, the next step is to deploy and test on the Cloud Development environment.

1. Remove the folders mentioned above on the **Development** environment using [KUDU](../set-up/power-tools/) from the `repository` and `wwwroot` folders.
2. Push the changes to the **Development** environment. See the [Deploying from local to your environments](../deployment/local-to-cloud.md) article.
3. Test **everything** in the **Development** environment.

We highly recommend that you go through everything on your Development environment. This can help you identify any potential errors after the upgrade, and ensure that you are not deploying any issues onto your Live environment.

## Step 5: Going live

Before deploying the upgrade to your Live environment, you will need to remove the folders you also removed from both your local instance and your Development environment.

The files are:

* `/wwwroot/umbraco`
* `/umbraco/PartialViewMacros`
* `/umbraco/UmbracoBackOffice`
* `/umbraco/UmbracoInstall`
* `/umbraco/UmbracoWebsite`
* `/umbraco/config/lang`

They need to be removed through KUDU from both the `repository` and `wwwroot` folders.

## Related Information

* [Breaking changes in Umbraco 10](../../umbraco-cms/fundamentals/setup/upgrading/version-specific/umbraco10-breaking-changes.md)
* [Working locally with Umbraco Cloud](../set-up/working-locally.md)
* [KUDU on Umbraco Cloud](../set-up/power-tools/)
````
