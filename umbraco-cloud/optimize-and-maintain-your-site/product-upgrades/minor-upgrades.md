---
description: This article explains how Minor upgrades work in Umbraco Cloud.
---

# Minor Upgrades

When a new minor version is released, there are two ways to upgrade your project:

* [Automatic Minor Upgrades](minor-upgrades.md#automatic-minor-upgrades)
* [Manual Minor Upgrades](minor-upgrades.md#manual-minor-upgrades)

## Automatic Minor Upgrades

To enable automatic minor upgrades, follow these steps:

1. Go to your Umbraco Cloud project.
2.  Navigate to **Configuration** -> **Automatic Upgrades**.

    <figure><img src="../../.gitbook/assets/image (47).png" alt="Settings Umbraco Cloud"><figcaption><p>Settings Umbraco Cloud</p></figcaption></figure>
3.  Enable **Automatic Minor Upgrades**.

    <figure><img src="../../.gitbook/assets/image (10) (1).png" alt=""><figcaption><p>Enable Minor Upgrades</p></figcaption></figure>

With automatic upgrades enabled, all products on Umbraco Cloud will automatically be upgraded. This includes Umbraco CMS, Umbraco Forms, and Umbraco Deploy. Your project does not need to be running the latest minor version for automatic upgrades to work. The project will be upgraded to the latest minor version when it is released.

If you create a new project on Umbraco Cloud automatic upgrades are enabled by default.

{% hint style="info" %}
For projects where automatic minor upgrades are enabled, having a secondary mainline environment is not required. However, it is highly recommended to facilitate a smoother and more controlled upgrade experience. In cases where manual upgrades are necessary, an additional environment becomes essential.
{% endhint %}

A secondary mainline environment is included in all Umbraco Cloud plans, except Starter. Find pricing details for Umbraco Cloud Starter plans on our [website](https://umbraco.com/products/umbraco-cloud/pricing).

## Manual Minor Upgrades

A manual upgrade involves a more hands-on approach, where the upgrade process is initiated and controlled by the user or development team. This allows for greater flexibility and oversight, enabling teams to test and adapt the upgrade to their specific needs and configurations. A manual upgrade provides an opportunity to thoroughly test the new version in a controlled environment before applying it to live production environments. This ensures compatibility and minimizes disruptions.

For more information about manual minor upgrades, see the [Manual upgrade of Umbraco CMS](manual-upgrades/manual-cms-upgrade.md) article.

## Troubleshooting Automated Minor Upgrades

Umbraco Cloud supports performing minor upgrades to your projects automatically. The feature is available when a new minor version of Umbraco is released (for example 10.5.0 or 10.6.0).

The upgrade will resolve most issues it encounters, but some Umbraco configurations may need manual intervention. This is usually related to custom code that depends on APIs that have changed or been removed in the new minor version.

If anything fails during this process, you can reach out for support using the in-app chat in the bottom right corner. We will assist you through the upgrade process if any issues arise.

## Database Upgrade Failing

Symptoms and feedback are given from the upgrade process: **Unable to run the Umbraco installer**

The first step in the process, after having updated all the files, is to call the Umbraco install engine. This is done in order to get its database updated to support the new version. As this step is the first time the site gets requested after the updated files are run, it may fail. The reason is often code that is incompatible with the upgraded files.

It can be code that references APIs that have been deprecated, or code that has some strong references to specific versions. If the error is clear, it will be shown on the screen. It will be a typical ASP.NET error message also called a Yellow Screen of Death (YSOD). You should request the site, and check the error it shows. If the error isn't descriptive, then it is time to clone the repository to your local machine and fix the issue. The usual suspects would be:

* The code you have running is referencing an API that has been changed, is being modified, is obsolete, or removed.
* The `web.config` had assembly bindings for a specific DLL version that doesn't exist anymore. During the upgrade process, we do update the references we are shipping, but there might be something missing.

Once you have the site running locally, you should push your changes to the repository. This will update the site, and it should now be in a running state.

The upgrade process left off when it needed three more steps. These three steps now need to be done manually.

1. Complete the installer
   * To complete the installer, you should visit the site: `https://dev-YOURSITEALIAS.euwest01.umbraco.io`. This will show you the installer screen, where you should insert your backoffice credentials and follow the process. It will run through a few steps, and later Umbraco will be updated to the latest version.
2. Export the metadata files.
   * The second thing you need to do is to regenerate the metadata files used for transferring items like document types, data types, and media types. This is done by accessing the Power tools (Kudu) on the project, opening the cmd prompt, and browsing to the wwwroot/data folder. Once there, you need to enter `echo > deploy-export`. This will generate the required files for the upgraded site to work with Umbraco Deploy.
3. The last thing to do is to go to the `/site/locks` folder (still through Kudu) and rename the file called `upgrading` to `upgraded-minor` - rename the file by typing `ren upgrading upgraded-minor`. This will indicate to Umbraco Cloud, that the left-most environment is now ready to deploy all its changes to the next environment.

Before deploying the upgrade to the next environment, you should verify that everything looks as expected on the left-most environment.
