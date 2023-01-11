---
description: "In this article we show how you can upgrade your Umbraco 10 Cloud project locally to Umbraco 11 and then migrate the project to a new Umbraco 11 project."
---

# Migrate from Umbraco 10 to 11 on Umbraco Cloud

In this guide, we will migrate an Umbraco Cloud project from Umbraco 10 to Umbraco 11.

{% hint style="info" %}
**Are you using any custom packages?**

You will need to ensure the packages you use are available in Umbraco 11.

**Breaking Changes**

Make sure you know the [Breaking changes](../../umbraco-cms/fundamentals/setup/upgrading/version-specific/) in the latest version of Umbraco CMS.
{% endhint %}

## Prerequisites

* Follow the **requirements** for [local development](../../umbraco-cms/fundamentals/setup/requirements.md#local-development).
* A Umbraco Cloud project running **the latest Umbraco 10** - We will refer to this in the guide as the **Migration project**.
* The .NET 7 Software Development Kit (SDK) installed locally.
* A clean Umbraco 11 Cloud project - We will refer to this in the guide as the **Clean Umbraco 11 project**.

## Step 1: Enable .NET 7

1. Go to the Umbraco 10 project in the Umbraco Cloud portal.
2. Navigate to **Settings** -> **Advanced**.
3. Scroll down to the **Runtime Settings** section.
4. **Enable the latest version of .NET** for each environment on your Cloud project.

<figure><img src="../../.gitbook/assets/runtime-settings.png" alt=""><figcaption><p>Runtime settings</p></figcaption></figure>

## Step 2: Clone down your environment

1. Clone down the **Live** environment.
2. Build and run the [project locally](../set-up/working-locally.md#running-the-site-locally).
3. Log in to the backoffice.
4. Restore content from your Cloud environment.

## Step 3: Upgrade the project locally using Visual Studio

1. Open your project in Visual Studio - use the `csproj` file in the `/src/UmbracoProject` folder.
2. Right-click your project solution in **Solution Explorer**.
3. Select **Properties**.

    <figure><img src="images/Solution-Explorer.png" alt=""><figcaption></figcaption></figure>
4. Change the **.Net** **Target Framework** from .NET 6 to .NET 7
5. It can be changed in the **General** section of the **Application** tab  in Visual Studio.

    ![Target Framework](images/Target-Framework.png)
6. Go to **Tools** > **NuGet Package Manager** > **Manage NuGet Packages for Solution...**.
7. Navigate to the **Browse** tab.
8. Install version 7.0.0 of the `Microsoft.Extensions.DependencyInjection.Abstractions` framework.
9. Navigate to the **Installed** tab.
10. Choose **Umbraco.Cms**.
11. Select your project.
12. Choose **the latest stable version of Umbraco 11** from the **Version** drop-down.
13. Click **Install** to upgrade your project.

![Nuget Version Install](images/Nuget-Version-Install.png)

### Upgrading Add-on packages

Update the following packages to the latest stable Umbraco 11 version as well:

* Umbraco.Deploy.Cloud
* Umbraco.Deploy.Contrib
* Umbraco.Forms
* Umbraco.Deploy.Forms
* Umbraco.Cloud.Identity.Cms
* Umbraco.Cloud.StorageProviders.AzureBlob

## Step 4: Finishing the Upgrade

1. Enable [Unattended Upgrades](../../umbraco-cms/reference/configuration/unattendedsettings.md#upgrade-unattended)
2. Run the **project locally**
3. Log in to the Umbraco backoffice to **verify the upgrade** has happened.
4. **Remove** Unattended Upgrades
5. **Build and run** the project to verify everything works as expected.

![Target Framework](images/verify-v10-upgrade-locally.png)

Once the Umbraco project runs locally without any errors, the next step is to deploy our **Migration project** to our **clean Umbraco 11 project**.

## Migrate the Umbraco 10 project to the Umbraco 11 project

{% hint style="warning" %}
Make sure that your local project is Upgraded to Umbraco 11 and works as expected before continuing the process.
{% endhint %}

1. Clone down the **clean Umbraco 11 project**.
2. Replace the `src/UmbracoProject/umbraco-cloud.json` file in the **Migration project** with the one from the **clean Umbraco 11 project**.

{% hint style="info" %}
The `umbraco-cloud.json` file contains details about each environment on the Cloud project.

By replacing this file, content and media transfers will now point to the environments on the **clean Umbraco 11 project**.
{% endhint %}

1. Commit all the local changes on your **Migration project** through git, but do not push it yet.
2.  Use the following git commands to connect your local **Migration project** to the live environment of the **clean Umbraco 11 project** :

    ```
    git remote rm origin

    git remote add origin https://scm.umbraco.io/euwest01/name-of-us-live-site.git

    git fetch

    git branch --set-upstream-to=origin/master
    ```
3.  Push the schema and files from the  **Migration project** to the **clean Umbraco 11 project** using the following git command:

    ```
    git push origin master -f
    ```
4. Verify that the schema and files have been merged into the Live environment on the **clean Umbraco 11 project**.
5. Transfer content and media from the local **Migration project** to the **clean Umbraco 11 project**.
6. Verify that all the content and media have been transfered to the **clean Umbraco 11 project**.

Once you have verified that all schema, files, content, and media have been successfully deployed and transferred, the migration is complete.

It is highly recommended to thoroughly go through everything on the migrated site to ensure that everything works as expected.

## Post migration tasks

By following the steps above you have migrated your Umbraco project from one Cloud environment to another.

The following will need to be reconfigured on the new project after the initial migration:

* All **Team Members** added through the Cloud Portal on the **Migration project** also need to be invited to the **new Umbraco 11 project**.
* **Hostnames**, **certificates** and other related settings need to be re-added and reconfigured on the **new Umbraco 11 project**.

Once everything has been configured and set up you can safely delete the **Migration project** which will also cancel the running subscription on the project.

Do you need help or have any questions regarding this process, please reach out to our support using [contact@umbraco.com](mailto:contact@umbraco.com).

## Related articles

* [Manage hostnames](../set-up/project-settings/manage-hostnames/)
* [Team Members](../set-up/project-settings/team-members/)
* [Certificates](../set-up/project-settings/manage-hostnames/security-certificates.md)


