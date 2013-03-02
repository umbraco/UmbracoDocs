#Upgrades in general

_This is the general upgrade guide, sometimes there are exceptions to these guidelines, they're listed in the [version-specific guide](version-specific.md)._

##Warning
First of all, things may go wrong for various reasons. Make sure to **ALWAYS** take a backup of both your site's files and the database so that you can return to a version that you know works.

##Copying files

Usually when there's a new version you would want to take the zip file of that version and copy the following folders from the zip file over the existing ones in your site:

- /bin
- /Install (don't forget to remove it after the upgrade is finished)
- /Umbraco 
- /Umbraco_Client

##Merge configuration files
You can also expect there to be some changes to the following configuration files. 

* Any file in the /Config folder
* The web.config file in the root of your site
 * **Warning: Do not remove the version number, nor the existing connection string**
* In rare cases also the Web.config file in the Views folder

Use a tool like [WinMerge](http://winmerge.org/ "WinMerge") to check changes between all of the config files. Depending on when you did this last there have been updates to quite a few of them.

There's also the possibility that some files in the /Config folder are new or some have been removed (we do make a note of this in the release notes). WinMerge (and other diff tools) is able to compare folders as well so you can more easily spot these differences too.

Up until version 6.0.0 it was necessary to change the version number in ClientDependency.config. This was to clear the cached html/css/js files in the backoffice. Just change the current version number to one that's higher than that. Make sure not to skip this step as you might get strange behaviour in the backoffice otherwise.

#Finalize
After copying the files and making the config changes, you can open your site. You should see the installer which will guide you through the upgrade. 

The installer will do two things

* Update the version number in the Web.config 
* Upgrade your database in case there are any changes.

We are aware that, currently, the installer is asking you for the database details of a **blank database** while upgrading. In the near future this will be prefilled with your existing details and the wording will be updated.  
So no need to be scared, enter the details of your existing database and Umbraco will upgrade it to the latest version when necessary. 

Since version 4.0.0 there have been two database upgrades, one to version 4.1.0 and one to version 4.9.0.  
Version 6 introduces a large database upgrade and still handles all the previously necessary database upgrades too.
