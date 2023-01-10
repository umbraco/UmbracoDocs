---
description:
  In this article we show how you can upgrade your Umbraco 10 Cloud project locally to Umbraco 11 and then migrate the project to a new Umbraco 11 project.
---

# Migrating a Umbraco 10 project to a Umbraco 11 project

Due to an issue with different SDK's on the underlying framework of Umbraco Cloud, we currently do not recommend to directly upgrade a project on Umbraco Cloud from Umbraco 10 to 11. 

Instead it is possible to upgrade a Umbraco 10 project to Umbraco 11 locally and then migrate the project to a clean Umbraco 11 project using `git`.

{% hint style="info" %}
**Are you using any custom packages or code on your Umbraco Cloud project?**

You will need to ensure the packages you use are available in the latest version of Umbraco and that your custom code is valid with the .NET Framework.

**Breaking Changes**

Make sure you know the [Breaking changes](../../umbraco-cms/fundamentals/setup/upgrading/version-specific/) in the latest version of Umbraco CMS.
{% endhint %}

## Prerequisites

* Follow the **requirements** for [local development](../../umbraco-cms/fundamentals/setup/requirements.md#local-development).
* A Umbraco Cloud project running **the latest Umbraco 10**
* The .NET 7 SDK installed locally.
* A clean Umbraco 11 project.

## Step 1: Enable .NET 7

* Go to the Umbraco 10 project in the Umbraco Cloud portal.
* Navigate to **Settings** -> **Advanced**.
* Scroll down to the **Runtime Settings** section.
* **Enable the latest version of .NET** for each environment on your Cloud project.

<figure><img src="../../.gitbook/assets/runtime-settings.png" alt=""><figcaption><p>Runtime settings</p></figcaption></figure>

## Step 2: Clone down your environment

* Clone down the **Live** environment.
* Build and run the [project locally](../set-up/working-locally.md#running-the-site-locally).
* Log in to the backoffice.
* Restore content from your Cloud environment.

## Step 3: Upgrade the project locally using Visual Studio

* Open your project in Visual Studio - use the `csproj` file in the `/src/UmbracoProject` folder.
* Right-click your project solution in **Solution Explorer**.
* Select **Properties**.

<figure><img src="images/Solution-Explorer.png" alt=""><figcaption></figcaption></figure>

* Select the **.Net 7** **Target Framework** drop-down in the **General** section of the **Application** tab as on your Cloud project.

![Target Framework](images/Target-Framework.png)

* Go to **Tools** > **NuGet Package Manager** > **Manage NuGet Packages for Solution...**.
* Navigate to the **Browse** tab.
* Install version 7.0.0 of the `Microsoft.Extensions.DependencyInjection.Abstractions` framework.
* Navigate to the **Installed** tab.
* Choose **Umbraco.Cms**.
* Select your project.
* Choose **the latest stable version of Umbraco 11** from the **Version** drop-down.
* Click **Install** to upgrade your project.

![Nuget Version Install](images/Nuget-Version-Install.png)

### Upgrading Add-on packages

Update the following packages to the latest stable version as well:

* Umbraco.Deploy.Cloud
* Umbraco.Deploy.Contrib
* Umbraco.Forms
* Umbraco.Deploy.Forms
* Umbraco.Cloud.Identity.Cms
* Umbraco.Cloud.StorageProviders.AzureBlob

{% hint style="info" %}
Choose the package version corresponding to the CMS version that you are currently upgrading to.

For example, if you are upgrading to "Umbraco.Cms 11.0.0" update the forms package to "Umbraco.Forms 11.0.0" as well. \\

Also, if you have more projects in your solution or other packages, make sure that these are also updated to support tUmbraco 11.
{% endhint %}

## Step 4: Finishing the Upgrade

* Enable [Unattended Upgrades](../../umbraco-cms/reference/configuration/unattendedsettings.md#upgrade-unattended)
* Run the **project locally**
* Log in to the Umbraco backoffice to **verify the upgrade** has happened.
* **Remove** Unattended Upgrades
* **Build and run** the project to verify everything works as expected.

![Target Framework](images/verify-v10-upgrade-locally.png)

Once the Umbraco project runs locally without any errors, the next step is to deploy our Umbraco 10 project to our _clean Umbraco 11 project_.

## Migrate Umbraco 10 project to Umbraco 11 project

The following steps will guide you through the process of deploying your locally upgraded Umbraco 10 project to the _clean Umbraco 11 project_.

{% hint style="warning" %}
Make sure that your local project is Upgraded to Umbraco 11 and works as expected before continuing the process.
{% endhint %}


1. Clone down the _clean Umbraco 11 project_.
2. Replace the `src/UmbracoProject/umbraco-cloud.json` file in the old project with the one from the clean Umbraco 11 project.

{% hint style="info" %}
The `umbraco-cloud.json` file contains details about each environment on the Cloud project.

By replacing the one on the _old project_ with the one from the _clean Umbraco 11 project_, content and media transfers will point to the environments on the _clean Umbraco 11 project_ instead of the _old project_.
{% endhint %}

1. Commit all the local changes on your _old project_ through git, but do not push it yet.
2.  Use the following git commands to connect your local _clean Umbraco 11 project_ to the live environment of the _clean Umbraco 11 project_ :

    ```
    git remote rm origin

    git remote add origin https://scm.umbraco.io/euwest01/name-of-us-live-site.git

    git fetch

    git branch --set-upstream-to=origin/master
    ```
3.  Push the schema and files from the  _old project_ to the _clean Umbraco 11 project_ using the following git command:

    ```
    git push origin master -f
    ```
4. Verify that the schema and files have been merged into the live environment on the _clean Umbraco 11 project_.
5. Transfer content and media from the local _clean Umbraco 11 project_ to the _clean Umbraco 11 project_.
6. Verify that all the content and media have been transfered to the _clean Umbraco 11 project_.

Once you have verified that all schema and files as well as content and media has successfully been deployed and transferred to your new _clean Umbraco 11 project_ the migration process is complete.

It is highly recommended to thoroughly go through everything on the migrated site to ensure that everything works as expected.

