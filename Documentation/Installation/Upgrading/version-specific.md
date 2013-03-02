#Version specific upgrades

*For now, this document will only list fairly recent updates (the past 2 years), but it will be updated to go further back.*

Most of the time you will be able to go straight from the version you're on to the latest version. Follow the steps in the [general upgrade guide](general.md), and then the additional instructions per version.

The additional steps are listed below, remember that new config files are not mentioned because that is already covered in the general upgrade guide:

##Version 4.6.1 to 4.7.1.1
* Delete bin/Iron*.dll (all dll files starting with "Iron")
* Delete bin/RazorEngine*.dll (all dll files starting with "RazorEngine")

##Version 4.7.1.1 to 4.7.2
* Delete the bin/umbraco.MacroEngines.Legacy.dll file

##Version 4.7.2 to 4.8.0
* Delete the bin/App_Browsers.dll file
* Delete the bin/App_global.asax.dll file
* Delete the bin/Fizzler.Systems.HtmlAgilityPack.dll file
* For people using uComponents 3.1.2 or below, 4.8.0 breaks support for it. Either upgrade to a newer version beforehand or follow the workaround [posted here](http://our.umbraco.org/projects/backoffice-extensions/ucomponents/questionssuggestions/33021-Upgrading-to-Umbraco-48-breaks-support-for-uComponents)

##Version 4.8.0 to 4.10.0
* Copy the new files and folders from the zip file into your site's folder
 * /App_Plugins
 * /Views
 * global.asax
* Remove the Config/formHandlers.config file

##Version 4.10.x to 4.11.x 
* If your site was ever a version between 4.10.x and 4.11.x (anything lower then 4.11.4) install the [fixup package](http://our.umbraco.org/projects/developer-tools/path-fixup).

##Version 4.10.x/4.11.x to 6.0.0 
* If your site was ever a version between 4.10.x and 4.11.x (anything lower than 4.11.4) and you have just upgraded to 6.0.0 install the [fixup package](http://our.umbraco.org/projects/developer-tools/path-fixup).
