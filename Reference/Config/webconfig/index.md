#Web.config

_This section defines the appSetting parameters found in the web.config_

##Explicit settings

_These are settings that require a value in the appSettings section of the web.config file_

###umbracoConfigurationStatus

Holds the version number of the currently installed version of Umbraco. This version number changes automatically when running the installer and the upgrade installer. It is not recommended to update this version manually as the upgrade installer might need to perform some actions to upgrade your site properly. The upgrade installer doesn't run when this version is the same as the version number in the Umbraco dll.

###umbracoReservedUrls

A comma separted list of files to be left alone by umbraco.  IIS will service these files, and the umbraco request pipeline will not be triggered.  

    <add key="umbracoReservedUrls" value="~/config/splashes/booting.aspx,~/install/default.aspx,~/config/splashes/noNodes.aspx,~/VSEnterpriseHelper.axd" />

###umbracoReservedPaths

A comma separated list of all the folders in your directory to be left alone by umbraco.  If you have folders with custom files, add them to this setting to make sure umbraco leaves them alone.

    <add key="umbracoReservedPaths" value="~/umbraco,~/install/" />

###umbracoPath

The Url pointing to the umbraco administration folder.  If you rename the umbraco folder, you need to update this setting too.

    <add key="umbracoPath" value="~/umbraco" />

###umbracoHideTopLevelNodeFromPath

If you are runing multiple sites, you don't want the top level node in your Url.  Possible options are _true_ and _false_.

    <add key="umbracoHideTopLevelNodeFromPath" value="true" />

###umbracoUseDirectoryUrls

Strips `.aspx` from URLs on the frontend when set to `true`.  
This setting is only important to older IIS configurations where extension-less URLs weren't supported very well.

###umbracoTimeOutInMinutes

Configures the number of minutes without any requests being made before the Umbraco user will be required to re-login. Any backoffice request will reset the clock. Default setting is 20 minutes

    <add key="umbracoTimeOutInMinutes" value="20" />

###umbracoDefaultUILanguage

The default language to use in the back office if a user isn't explicitly assigned one. The default is English (en)

###umbracoUseSSL

Makes sure that all of the requests in the backoffice are called over https instead of http when set to `true`.

##Optional settings

_These are settings that have default values but can be overridden by creating the appSetting and setting its value in the web.config_

###umbracoContentXML

The default value is:
*~/App_Data/umbraco.config*

The value must be set to a virtual path with a prefixed tilda (~)

###umbracoContentXMLUseLocalTemp

The default value is:
*'false'*

Generally set to 'false' but when set to 'true' the content xml file (normally stored @ ~/App_Data/umbraco.config) will be stored in the local servers' Temp (CodeGen) folder. This is handy for load balanced environments when the website is running from a central SAN based file system (non-replicated). 

If you are not running a load balanced environment on a central SAN based file system (or similar) ensure that this setting remains set to 'false'.

###umbracoVersionCheckPeriod

The default value is:
*'7'*

When this value is set above 0, the back office will check for new version of Umbraco every 'x' number of days where 'x' is the value defined for this setting. By default Umbraco ships with a value of '7'.
