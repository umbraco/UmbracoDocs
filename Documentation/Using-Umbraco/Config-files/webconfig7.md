#Web.config

**Applies to: versions 7.0.0 +**

_This section defines the appSetting parameters found in the web.config for versions 7+_

##Explicit settings

_These are settings that require a value in the appSettings section of the web.config file_

###umbracoConfigurationStatus

Holds the version number of the currently installed version of Umbraco. This version number changes automatically when running the installer and the upgrade installer. It is not recommended to update this version manually as the upgrade installer might need to perform some actions to upgrade your site properly. The upgrade installer doesn't run when this version is the same as the version number in the Umbraco dll.

###umbracoReservedUrls

Coming soon!

###umbracoReservedPaths

Coming soon!

###umbracoPath

Coming soon!

###umbracoHideTopLevelNodeFromPath

Coming soon!

###umbracoUseDirectoryUrls

Strips `.aspx` from URLs on the frontend when set to `true`.  
This setting is only important to older IIS configurations where extionless URLs weren't supported very well.

###umbracoTimeOutInMinutes

Configures the number of minutes without any requests being made before the Umbraco user will be required to re-login. Any backoffice request will reset the clock. Default setting is 20 minutes

    <add key="umbracoTimeOutInMinutes" value="20" />

###umbracoDefaultUILanguage

Coming soon!

###umbracoUseSSL

Makes sure that all of the requests in the backoffice are called over https instead of http when set to `true`.

##Optional settings

_These are settings that have default values but can be overridden by creating the appSetting and setting its value in the web.config_

###umbracoContentXML

The default value is:
*~/App_Data/umbraco.config*

The value must be set to a virtual path with a prefixed tilda (~)

###umbracoStorageDirectory

The default value is:
*~/App_Data*

The value must be set to a virtual path with a prefixed tilda (~)

It is recommended to not change this path.

###umbracoContentXMLUseLocalTemp

The default value is:
*'false'*

Generally set to 'false' but when set to 'true' the content xml file (normally stored @ ~/App_Data/umbraco.config) will be stored in the local servers' Temp (CodeGen) folder. This is handy for load balanced environments when the website is running from a central SAN based file system (non-replicated). 

If you are not running a load balanced environment on a central SAN based file system (or similar) ensure that this setting remains set to 'false'.

###umbracoProfileUrl

The default value is:
*'profiler'*

A legacy setting used for re-routing a member profile login page.

###umbracoVersionCheckPeriod

The default value is:
*'7'*

When this value is set above 0, the back office will check for new version of Umbraco every 'x' number of days where 'x' is the value defined for this setting. By default Umbraco ships with a value of '7'.
