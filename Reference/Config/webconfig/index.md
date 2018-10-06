# Web.config

_This section defines the appSetting parameters found in the web.config_

## Explicit settings

_These are settings that require a value in the appSettings section of the web.config file_

### umbracoConfigurationStatus

Holds the version number of the currently installed version of Umbraco. This version number changes automatically when running the installer and the upgrade installer. It is not recommended to update this version manually as the upgrade installer might need to perform some actions to upgrade your site properly. The upgrade installer doesn't run when this version is the same as the version number in the Umbraco DLL.

### umbracoReservedUrls

A comma-separated list of files to be left alone by Umbraco. IIS will serve these files, and the Umbraco request pipeline will not be triggered.  

    <add key="umbracoReservedUrls" value="~/config/splashes/booting.aspx,~/install/default.aspx,~/config/splashes/noNodes.aspx,~/VSEnterpriseHelper.axd" />

### umbracoReservedPaths

A comma-separated list of all the folders in your directory to be left alone by Umbraco. If you have folders with custom files, add them to this setting to make sure Umbraco leaves them alone.

    <add key="umbracoReservedPaths" value="~/umbraco,~/install/" />

### umbracoPath

The URL pointing to the Umbraco administration folder. If you rename the `umbraco` folder, you need to update this setting too.

    <add key="umbracoPath" value="~/umbraco" />

### umbracoHideTopLevelNodeFromPath

If you are running multiple sites, you don't want the top level node in your URL. Possible options are `true` and `false`.

    <add key="umbracoHideTopLevelNodeFromPath" value="true" />

### umbracoUseDirectoryUrls

Strips `.aspx` from URLs on the frontend when set to `true`.  
This setting is only important to older IIS configurations where extension-less URLs weren't supported very well.

### umbracoTimeOutInMinutes

Configures the number of minutes without any requests being made before the Umbraco user will be required to re-login. Any backoffice request will reset the clock. Default setting is 20 minutes.

    <add key="umbracoTimeOutInMinutes" value="20" />

### umbracoDefaultUILanguage

The default language to use in the backoffice if a user isn't explicitly assigned one. The default is English (en).

### umbracoUseSSL

Makes sure that all of the requests in the backoffice are called over HTTPS instead of HTTP when set to `true`.

### umbracoCssDirectory 

By adding this to appSettings you can specify a new/different folder for storing your css-files and still be able to edit them within Umbraco. Default folder is ~/css.

### umbracoMediaPath

By adding this to appSettings you can specify a new/different folder for storing your media files. Default folder is ~/media.

### umbracoScriptsPath 

By adding this to appSettings you can specify a new/different folder for storing your JavaScript files and still be able to edit them within Umbraco. Default folder is ~/scripts.

### SMTP Settings

By adding this settings to the web.config you will be able to send out emails from your Umbraco installation. This could be notifications emails if you are using content workflow, or you are using Umbraco Forms you also need to specify SMTP settings to be able use the email workflows. The forgot password function from the backoffice also needs a SMTP server to send the email with the reset link.

```
  <system.net>
        <mailSettings>
        <smtp from="noreply@example.com">
            <network host="127.0.0.1" userName="username" password="password" />
        </smtp>
        </mailSettings>
    </system.net>
 ```


## Optional settings

_These are settings that have default values but can be overridden by creating the appSetting and setting its value in the web.config_

### umbracoContentXML

The default value is: `~/App_Data/umbraco.config`

The value must be set to a virtual path with a prefixed tilde (~)

### umbracoContentXMLUseLocalTemp

The default value is: `false`

Generally set to `false` but when set to `true` the content XML file (normally stored in `~/App_Data/umbraco.config`) will be stored in the local servers' Temp (CodeGen) folder. This is handy for load balanced environments when the website is running from a central SAN based file system (non-replicated). 

If you are not running a load balanced environment on a central SAN based file system (or similar) ensure that this setting remains set to `false`.

### umbracoContentXMLStorage (Umbraco v7.6+)

The default value is: `Default`

This setting replaced the `umbracoContentXMLUseLocalTemp` setting.

This setting controls where Umbraco stores the XML cache file.

The options are:

- `Default` - Umbraco cache file will be stored in `App_Data` and the `DistCache` and `PluginCache` folders will be stored in the `App_Data/TEMP` folder
- `EnvironmentTemp` - All files will be stored in the environment temporary folder
- `AspNetTemp` - All Files will be stored in the ASP.NET temporary folder

### umbracoLocalTempStorage (Umbraco v7.7.3+)

The default value is: `Default`

This setting replaced the `umbracoContentXMLStorage` setting.

This setting controls where Umbraco stores the XML cache file, the DistCache and PluginCache TEMP folders. Version 1.9.6+ of [ClientDependency Framework](https://github.com/Shazwazza/ClientDependency) also observe this setting.

The options are:

- `Default` - Umbraco cache file will be stored in `App_Data` and the `DistCache` and `PluginCache` folders will be stored in the `App_Data/TEMP` folder
- `EnvironmentTemp` - All files will be stored in the environment temporary folder
- `AspNetTemp` - All Files will be stored in the ASP.NET temporary folder

### umbracoVersionCheckPeriod

The default value is: `7`

When this value is set above 0, the backoffice will check for a new version of Umbraco every 'x' number of days where 'x' is the value defined for this setting. Set this value to `0` to never check for a new version.

### umbracoDisableElectionForSingleServer (Umbraco v7.6+)

The default value is: `false`

This is not a setting that commonly needs to be configured.

This value is primarily used on Umbraco Cloud for a small startup performance optimization. When this is true, the website instance will automatically be configured to not support load balancing and the website instance will be configured to be the 'master' server for scheduling so no [master election](https://our.umbraco.com/documentation/Getting-Started/Setup/Server-Setup/load-balancing/flexible#scheduling-and-master-election) occurs. This will save 1 database call during startup. 
