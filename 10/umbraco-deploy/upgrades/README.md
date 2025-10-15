---
meta.Title: Upgrading Umbraco Deploy
description: How to upgrade Umbraco Deploy
---

# Upgrading

As with all of our products, it is always recommended to run the latest version of Umbraco Deploy.

On the Umbraco Deploy page in the [Packages page](https://our.umbraco.com/packages/developer-tools/umbraco-deploy/) you can see what the latest version is, as well as read the changelog.

Umbraco Deploy can be upgraded via NuGet.

Open the **Package Console** in Visual Studio and type:

`Update-Package Umbraco.Deploy.OnPrem`

You will be prompted to overwrite files. You should choose **"No to All"** by pressing **"L"**.

You can open the **NuGet Package Manager** and select the **Updates** pane to get a list of available updates. Choose the package called **Umbraco.Deploy.OnPrem** and click update. This will run through all the files and make sure you have the latest changes while leaving files you have updated.

## [Version Specific Upgrade Details](version-specific.md)

Contains version specific documentation for when upgrading to new major versions of Umbraco Deploy.
