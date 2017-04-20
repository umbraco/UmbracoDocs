#Upgrading - version specific
This page covers specific upgrade documentation for specific versions

##Version 4 to Version 6
Upgrading to Version 6 of Umbraco Forms, has a higher minimum dependancy on Umbraco CMS core of `7.6.0` & higher. The reasoning behind this is due to some underlying changes to ensure Forms works with Umbraco Cloud & Deploy.

With Umbraco you have many options to upgrade Umbraco Forms, you can install the Umbraco package via the community package searach from our.umbraco.org or downloading directly from our.umbraco.org, alternatively you can download a regular ZIP containing the updated files which you can unzip & apply over the top of your existing install. Both of these approaches should not cause any upgrade problems.

###Upgrading with Nuget
Using Nuget to perform an Upgrade of Umbraco Forms to the next major version, you will run into a problem where the legacy MacroPartial view file will be removed from the site & thus cause any existing Umbraco Forms rendered on the site to stop functioning.
Before running the site after the Nuget upgrade again; consider this may need to be done on each environmet depending on your deployment process/setup. You will need to from your source control copy/restore the following file `Views/MacroPartials/InsertUmbracoForm.cshtml`

The file needs to be here before the site is restarted - due to the migration/upgrade tasks listed below.

For new & clean installs done with Nuget this will not be a problem for you, as only the new Macro & its associated MacroPartial view file is part of the new nuget version.


###Upgrade tasks
The following outlines for `version 6.0.0` what upgrade/migration tasks that are being performed:

* Rename legacy macro to make it easier to identify in the backoffice
* Adds new form macro to insert a form with a theme
* Moves JSON Form Storage files from `App_Plugins/UmbracoForms/Data` to `App_Data/UmbracoForms/Data` by default unless a custom Forms IFileSystem is configured such as Azure blob storage
* Moves any Form PreValue sources that uses text files that were uploaded to the media section & now stores in the Umbraco Forms IFileSystem

###Recommendation
We highly recommend you make the switch away from the legacy macro and swap over to the newer macro that supports the new 6.0.0 feature of themes. The legacy macro is there to ease the transisition over and to avoid entire sites forms to stop working.