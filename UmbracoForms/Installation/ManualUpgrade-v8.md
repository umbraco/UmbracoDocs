---
versionFrom: 8.0.0
meta.Title: "Manually Upgrading Umbraco Forms"
meta.Description: "Documentation on how to upgrade Umbraco Forms"
---

# Manually upgrading forms

## Download

In order to upgrade you will want to [download the version of Forms you wish to upgrade to](https://our.umbraco.com/projects/developer-tools/umbraco-forms/). Instead of downloading the actual package, however, you want to download the `Umbraco.Forms.Files.x.y.z.zip` file (where x.y.z) is the version.

Note that this filename ends with `.Files.x.y.z.zip` and contains only the files that get installed when you install Umbraco Forms.

## Copy

The easiest way to proceed is to unzip the file you downloaded and copy and overwrite (almost) everything into your website. Almost, because you might not want to overwrite `~/App_Plugins/UmbracoForms/UmbracoForms.config` because you might have updated it in the past. Make sure to compare your current version to the version in the zip file you downloaded. If there's any new configuration options in there then copy those into your website's `UmbracoForms.config` file.
