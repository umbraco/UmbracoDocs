---
versionFrom: 7.0.0
versionTo: 8.0.0
---

# Manual upgrade of the Umbraco Cloud engine

This article will give you an overview of how you should upgrade Umbraco Deploy.

## Upgrading Umbraco Deploy

**NOTE**: All new projects on Umbraco Cloud use Umbraco Deploy. The same goes for projects running Umbraco CMS version 7.6 and higher.

Here are the steps you need to follow carefully to manually upgrade Deploy on your Umbraco Cloud project:

1. Download the latest version of Umbraco Deploy here: http://nightly.umbraco.org/?container=umbraco-deploy-release
    * Check [Product Dependencies](../Product-Dependencies) to be sure you download the correct version of Deploy
2. Unzip the file on your computer
3. Copy/Paste the files from the unzipped folder to your local project folder
    * You should **not** overwrite the following files:
    * `Config/UmbracoDeploy.config`
    * `Config/UmbracoDeploy.Settings.config`
4. Run the project locally - make sure it runs without any errors
5. Commit and deploy the changes to the Cloud environment
6. Again, make sure everything runs without errors before deploying to the next Cloud environment
