---
meta.Title: "Manual Upgrade project cloned with UaaS.CMD tool"
meta.Description: "An article explaining how to upgrade your Cloud project if it has been cloned down with the UaaS.cmd tool"
versionFrom: 8.0.0
---

# Manual Upgrade of your cloud project cloned with UaaS.CMD tool

Following the move to a new hosting platform for Umbraco Cloud every Umbraco 8 projects need to be on at least  8.5.1.

In this guide we will show you how you can manually upgrade your project if you are on 8.0.x and need to upgrade your project to 8.5.1  when you have used the UaaS.cmd tool.

:::note
The UaaS.cmd tool will provide you with visual studio solution with both a .web and a .core folder of the project.

This guide will only focus on upgrading the .web part of the project
:::

## Upgrading the project

The first step to upgrade the project is to update the version of the CMS from 8.0.x to Umbraco 8.1.0

this can be done by doing the following:

1. Open the visual studio solution locally
2. Open the NuGet Package Manager
3. Find the Umbraco CMS package
4. Install version 8.1.0 on the .web part
5. When prompted to overwrite the config file make sure to say no

Once the new version is installed if you start up the site you will be meet with a YSOD error.

This is because we need to upgrade the Umbraco Forms package the ModelsBuilder and Umbraco Deploy to the supported versions for it to work properly.

See the [product dependencies](https://our.umbraco.com/documentation/Umbraco-Cloud/Upgrades/Product-Dependencies/) article for more details for which versions 8.1+ is compatible with.

### Update Umbraco Forms

The first package that should be upgraded is the UmbracoForms package.

This should be upgraded to version 8.5.3

To upgrade UmbracoForms:

1. Go to the NuGet Package Manager
2. find the UmbracoForms package
3. Install version 8.5.3 on the project.

Once the forms package have been installed we can go ahead and update the ModelsBuilder.

### Update the Umbraco ModelsBuilder

We need to update the ModelsBuilder to version 8.1.6.

To upgrade the ModelsBuilder you will need to:

1. Go to the NuGet Package Manager
2. find the  ModelsBuilder.UI and  ModelsBuilder  package
3. Install version 8.1.6 on the project.

Upgrading the ModelsBuilder to 8.1.6 will also upgrade the project to Umbraco 8.5.1.

When the ModelsBuilder.UI and ModelsBuilder is done installing, it is time for the next step, which is upgrade the Umbraco Deploy version.

### Update Umbraco Deploy

Since the project is now on Umbraco 8.5.1 it also means that he version of deploy compatible with the project is 3.5.x.

Unlike the two other packages the Deploy package is not available through NuGet, instead you will need to download it from the [Umbraco Nightly page](http://nightly.umbraco.org/?container=umbraco-deploy-release)

Make sure to download the latest version of deploy 3.5.x which in this case is 3.5.3.

Once the version have been downloaded you need to:

1. Unzip the folder
2. Copy the following folders to your projects .web folder
    - App_plugins
    - Bin

3. From the config folder, only copy over the splash folder and the UmbracoDeploy.Settings.Config

:::note
Do not copy the UmbracoDeploy.config over as it will overwrite the IDs for the cloud environments.
:::

Once the files have been copied over to the project, build and run it to verify that everything works on the project.

If everything works as it should, go to the backoffice and login.

This will begin the upgrade of the internal components like the database.

Once the upgrade is done, commit the changes to git and push the changes up to Umbraco Cloud.

You should now be able to see on the project portal that the project is running on Umbraco 8.5.1, Umbraco forms 8.5.3 and Deploy 3.5.3.
