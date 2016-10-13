#Manually upgrading forms
We [made it easy to upgrade to the latest version of Umbraco Forms automatically](upgrading.md) but sometimes it's necessary to manually upgrade your install.

#Download
In order to upgrade you will want to [download the version of Forms you wish to upgrade to](https://our.umbraco.org/projects/developer-tools/umbraco-forms/). Instead of downloading the actual package, however, you want to download the `UmbracoForms.x.y.z.Files.zip` file (where x.y.z) is the version.

Note that this filename ends with `.Files.zip` and contains just the files that get installed when you install Umnbraco Forms.

#Copy
The easiest way to proceed next is to unzip the file you just downloaded and copy and overwrite (almost) everything into your website. Almost, because you might not want to overwrite `~/App_Plugins/UmbracoForms/UmbracoForms.config` because you might have updated it in the past. Make sure to compare your current version to the version in the zip file you just downloaded. If there's any new configuration options in there then copy those into your website's `UmbracoForms.config` file. 

#Upgrade marker
Finally, you'll need to tell Umbraco Forms to update itself when you start the website next. In order to do that you need to have a `formsupdate` file (an empty text file without extension) in `~/App_Data/TEMP/`. The easiest way to create this file is by going into the root folder of your website and start a command line there. You can then type the following command: `echo > /App_Data/TEMP/formsupdate`

This command creates the file and you should see it disappear the next time the website recycles (you may want to recycle the website manually after creating this file).  

That's it! You're all set now.