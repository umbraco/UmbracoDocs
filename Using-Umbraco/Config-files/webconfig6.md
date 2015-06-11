#Web.config

**Applies to: versions < 7.0.0**

_This section defines the appSetting parameters found in the web.config for versions previous to version 7_

##umbracoConfigurationStatus

Coming soon!

##umbracoReservedUrls

Coming soon!

##umbracoReservedPaths

Coming soon!

##umbracoContentXML

Coming soon!

##umbracoStorageDirectory

Coming soon!

##umbracoPath

Coming soon!

##umbracoEnableStat

***This setting has zero effect and will be removed in v7***

##umbracoHideTopLevelNodeFromPath

Coming soon!

##umbracoEditXhtmlMode

***This setting will be removed in v7!***

This setting is used for Netscape 4 compatibility to change the way that the rich text editor output's html breaks, if set to true then it outputs "&lt;br /&gt;" otherwise it outputs "&lt;br/&gt;".

##umbracoUseDirectoryUrls

Coming soon!

##umbracoTimeOutInMinutes

Coming soon!

##umbracoVersionCheckPeriod

When this value is set above 0, the back office will check for new version of Umbraco every 'x' number of days where 'x' is the value defined for this setting. By default Umbraco ships with a value of '7'.

##umbracoDisableXsltExtensions

***This setting will be removed in v7!***

##umbracoDefaultUILanguage

Coming soon!

##umbracoProfileUrl

A legacy setting used for re-routing a member profile login page.

##umbracoUseSSL

Coming soon!

##umbracoContentXMLUseLocalTemp

Generally set to 'false' but when set to 'true' the content xml file (normally stored @ ~/App_Data/umbraco.config) will be stored in the local servers' Temp (CodeGen) folder. This is handy for load balanced environments when the website is running from a central SAN based file system (non-replicated). 

If you are not running a load balanced environment on a central SAN based file system (or similar) ensure that this setting remains set to 'false'.
 