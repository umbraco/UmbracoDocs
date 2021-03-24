---
versionFrom: 8.0.0
---

# Upgrading Umbraco Deploy

As with all of our products, it is always recommended to run the latest version of Umbraco Deploy.

On the Umbraco Deploy page in the [Packages page](https://our.umbraco.com/packages/developer-tools/umbraco-deploy/) you can see what the latest version is, as well as read the changelog.

Umbraco Deploy can be upgraded via NuGet.

Open the **Package Console** in Visual Studio and type:

`Update-Package UmbracoDeploy`

You will be prompted to overwrite files. You should choose **"No to All"** by pressing **"L"** . If there are any specific configuration changes required for the version you are upgrading to then they will be noted in the **[version-specific guide](../../../Getting-Starter/Setup/Upgrading/version-specific.md)**.

You can open the **NuGet Package Manager** and select the **Updates** pane to get a list of available updates. Choose the package called **UmbracoDeploy** and click update. This will run through all the files and make sure you have the latest changes while leaving files you have updated.
