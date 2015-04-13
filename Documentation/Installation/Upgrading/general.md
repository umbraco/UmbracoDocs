#Upgrades in general

_This is the guide for upgrading in general. Sometimes there are exceptions to these guidelines, which are listed in the [version-specific guide](version-specific.md)._

##Warning
First of all, things may go wrong for various reasons. Make sure to **ALWAYS** make a backup of both your site's files and the database so that you can return to a version that you know works. You will need the backed up files for merging later so this step is not optional.

Before upgrading to a new major version (like v4 to v6), check if the packages you're using are compatible with the version you're upgrading to. On the package's download page, in the **Project compatibility** area, click **View details** to check version-specific compatibilities.

##Note
It is necessary to run the upgrade installer on each environment of your Umbraco site. So if you want to update your staging and your live site then you need to repeat the steps below and make sure that you click through the install screens so that your upgrade is complete.

##Copying files

Download the .zip file for the new version you are upgrading to.

Copy the following folders from inside the .zip file over the existing folders in your site:

- /bin
- Only for versions lower than 7.1.0: 
   - /Install (don't forget to remove it after the upgrade is finished)
   - (This folder is no longer present or needed in Umbraco v7.1.0+)
- Only for versions higher than 7.2.0:
	- /Views/Partials/Grid (contains Grid rendering views)
- /Umbraco 
- /Umbraco_Client

**Note:** There are hosting providers (we know of one: RackSpace Cloud) that require proper casing of file and folder names. Normally on Windows this is not a problem but if your hosting provider forces proper casing then you will need to verify that the folder and file names are in the same casing as in the newest version you're upgrading to.

##Are you using NuGet?

You can simply open up the **Package Console** and type:
`Update-Package UmbracoCms`

Or you can open the **NuGet Package Manager** and select the **Updates** pane to get a list of available updates. Choose the package called **UmbracoCms** and click update. This will run through all the files and make sure you have the latest changes while leaving files you have updated.

####Upgrades to versions lower than 7.2.0
If you're not upgrading to 7.2.0 or higher then you should follow these extra instructions, if you are upgrading to 7.2.0+ then you can skip this and go to [Merge UI.xml and language files](#MergeUIxmlandlanguagefiles)

**The following only applies to upgrading to versions lower than 7.2.0**  
You will be asked to overwrite your web.config file and the files in /config, make sure to answer **No** to those questions.

For some inexplicable reason, the installation will fail if you click "No to All" (in the GUI) or answer "L" (in the package manager console) to the question: "File 'Web.config' already exists in project 'MySite'. Do you want to overwrite it?" So make sure to only answer "**No**" (in the GUI) or "**N**" (in the package manager console).

![](images/nuget-overwrite-dialog.png)
![](images/nuget-upgrade-overwrite.png)

Now here comes the tricky bit: We'll be mean and overwrite your web.config file anyway. But we'll back it up so don't worry. (Plus you already had your own backup, right?) You can find the backup in `App_Data\NuGetBackup\20140320-165450\`. (The `20140320-165450` bit is the date and time when the backup occurred, which varies.) You can then merge your config files and make sure they're completely up to date.

##Merge configuration files
You can expect some changes to the following configuration files:

* Any file in the /Config folder
* The /Global.asax file
* The web.config file in the root of your site **(Important: make sure to copy back the version number, and the connection string as they were.)**
* In rare cases, the Web.config file in the Views folder


Use a tool like [WinMerge](http://winmerge.org/ "WinMerge") to check changes between all of the config files. Depending on when you last did this there may have been updates to quite a few of them.

There's also the possibility that some files in the /Config folder are new or some have been removed (we do make a note of this in the release notes). WinMerge (and other diff tools) is able to compare folders as well so you can more easily spot these differences.

Up until version 6.0.0 it was necessary to change the version number in ClientDependency.config. This was to clear the cached html/css/js files in the backoffice. Just change the current version number to one that's higher than that. Make sure not to skip this step as you might get strange behaviour in the backoffice otherwise.

##Merge UI.xml and language files
Some packages (like Contour) add dialogs to the UI.xml. Make sure to merge those changes back in from your backup during the upgrade so that the packages continue to work. This file can be found in: /Umbraco/Config/Create/UI.xml.

Packages like Contour and Courier also make changes to the language files located in: /Umbraco/Config/Lang/*.xml (typically en.xml).

#Finalize
After copying the files and making the config changes, you can open your site. You should see the installer which will guide you through the upgrade. 

The installer will do two things:

* Update the version number in the Web.config 
* Upgrade your database in case there are any changes

We are aware that, currently, the installer is asking you for the database details of a **blank database** while upgrading. In the near future this will be prefilled with your existing details and the wording will be updated. So no need to be scared. Just enter the details of your existing database and Umbraco will upgrade it to the latest version when necessary.

Since version 4.0.0 there have been two database upgrades, one to version 4.1.0 and one to version 4.9.0. Version 6 introduces a large database upgrade and still handles all the previously necessary database upgrades too.

##Post installation
One important recommendation is to always remove the `install` folder immediately after upgrading Umbraco and never to upload it to a live server.

##Potential issues and gotchas

###Browser cache (mostly v7 related)
Google Chrome has notoriously aggressive caching, so if something doesn't seem to work well in the backoffice, make sure to clear cache and cookies thoroughly (for other browsers as well). 

One way to nudge the cache in Chrome is to open the developer tools (F12) and go to the settings (the cog icon). There will be a checkbox that says "Disable cache (while DevTools is open)". Once this checkbox is on you can refresh the page and the cache should be invalidated. To force it even more, the "reload" button next to your address bar now has extra options when you right-click it. It should have "Normal reload", "Hard reload" and "Empty cache and hard reload" now. The last option is the most thorough and you might want to try that.

The important other thing you'll need to do is go into config/ClientDependency.config and update the version number there. If it currently says version="2" then just make it one higher: version="3". This will ensure that any server-side cache of JavaScript and stylesheets gets cleared as well.

**_We're working on making this experience better and seamless, but for now make sure to follow these steps for v7 upgrades._**

###Module Load Order

`UmbracoModule` requires `UrlRewriteModule` to be loaded first. This is determined in the `<system.webServer><modules>` section of your web.config file. 

Typically, your configuration file should look like this

	<system.webServer>
    	<validation validateIntegratedModeConfiguration="false" />
    	<modules runAllManagedModulesForAllRequests="true">
      		<remove name="UrlRewriteModule" />
      		<add name="UrlRewriteModule" type="UrlRewritingNet.Web.UrlRewriteModule, UrlRewritingNet.UrlRewriter" />
      		<remove name="UmbracoModule" />
      		<add name=" UmbracoModule" type="Umbraco.Web.UmbracoModule,umbraco" />
			... Other modules ...
		</modules>
	</system.webServer>

