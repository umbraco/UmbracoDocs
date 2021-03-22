# Upgrading Umbraco Deploy

Umbraco Deploy can be upgraded by using NuGet.

You can open up the **Package Console** and type:
`Update-Package UmbracoDeploy`

You will be prompted to overwrite files, you should choose **"No to All"** by pressing the **"L"** . If there are any specific configuration changes required for the version you are upgrading to then they will be noted in the **[version-specific guide](version-specific.md)**.

Or you can open the **NuGet Package Manager** and select the **Updates** pane to get a list of available updates. Choose the package called **UmbracoDeploy** and click update. This will run through all the files and make sure you have the latest changes while leaving files you have updated.
