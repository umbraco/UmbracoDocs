---
versionFrom: 7.0.0
needsV8Update: "true"
---

# Web.config
_This section defines the appSetting parameters found in the web.config_

## Explicit settings
_These are settings that require a value in the appSettings section of the web.config file_

### Configuration Status
Holds the version number of the currently installed version of Umbraco. This version number changes automatically when running the installer and the upgrade installer. It is not recommended to update this version manually as the upgrade installer might need to perform some actions to upgrade your site properly. The upgrade installer doesn't run when this version is the same as the version number in the Umbraco DLL.

#### v8 - Umbraco.Core.ConfigurationStatus
```xml
<add key="Umbraco.Core.ConfigurationStatus" value="8.0.2" />
```
#### v7 - umbracoConfigurationStatus
```xml
<add key="umbracoConfigurationStatus" value="7.14.0" />
```

### Reserved URLs
A comma-separated list of files to be left alone by Umbraco. IIS will serve these files, and the Umbraco request pipeline will not be triggered.  

#### v8 - Umbraco.Core.ReservedUrls
```xml
<add key="Umbraco.Core.ReservedUrls" value="~/config/splashes/booting.aspx,~/install/default.aspx,~/config/splashes/noNodes.aspx,~/VSEnterpriseHelper.axd" />
```
#### v7 - umbracoConfigurationStatus
```xml
<add key="umbracoReservedUrls" value="~/config/splashes/booting.aspx,~/install/default.aspx,~/config/splashes/noNodes.aspx,~/VSEnterpriseHelper.axd" />
```

### Reserved Paths
A comma-separated list of all the folders in your directory to be left alone by Umbraco. If you have folders with custom files, add them to this setting to make sure Umbraco leaves them alone.

#### v8 - Umbraco.Core.ReservedPaths
```xml
<add key="Umbraco.Core.ReservedPaths" value="~/umbraco,~/install/" />
```
#### v7 - umbracoReservedPaths
```xml
<add key="umbracoReservedPaths" value="~/umbraco,~/install/" />
```

### Path
The URL pointing to the Umbraco administration folder. If you rename the `umbraco` folder, you need to update this setting too.

#### v8 - Umbraco.Core.Path
```xml
<add key="Umbraco.Core.Path" value="~/umbraco" />
```
#### v7 - umbracoPath
```xml
<add key="umbracoPath" value="~/umbraco" />
```

### Hide Top-Level Node from Path
If you are running multiple sites, you don't want the top-level node in your URL. Possible options are `true` and `false`.

#### v8 - Umbraco.Core.HideTopLevelNodeFromPath
```xml
<add key="Umbraco.Core.HideTopLevelNodeFromPath" value="true" />
```
#### v7 - umbracoHideTopLevelNodeFromPath
```xml
<add key="umbracoHideTopLevelNodeFromPath" value="true" />
```

### Use Directory URLs
Strips `.aspx` from URLs on the frontend when set to `true`.  
This setting is only important to older IIS configurations where extension-less URLs weren't supported very well.

#### v7 - umbracoUseDirectoryUrls
```xml
<add key="umbracoUseDirectoryUrls" value="true" />
```

### Time Out in Minutes
Configures the number of minutes without any requests being made before the Umbraco user will be required to re-login. Any backoffice request will reset the clock. Default setting is 20 minutes.

#### v8 - Umbraco.Core.TimeOutInMinutes
```xml
<add key="Umbraco.Core.TimeOutInMinutes" value="20" />
```
#### v7 - umbracoTimeOutInMinutes
```xml
<add key="umbracoTimeOutInMinutes" value="20" />
```

### Default UI Language
The default language to use in the backoffice if a user isn't explicitly assigned one. The default is English.

#### v8 - Umbraco.Core.DefaultUILanguage
```xml
<add key="Umbraco.Core.DefaultUILanguage" value="en-US" />
```
#### v7 - umbracoDefaultUILanguage
```xml
<add key="umbracoDefaultUILanguage" value="en" />
```

### HTTPS / SSL
Makes sure that all of the requests in the backoffice are called over HTTPS instead of HTTP when set to `true`.

#### v8 - Umbraco.Core.UseHttps
```xml
<add key="Umbraco.Core.UseHttps" value="true" />
```
#### v7 - umbracoUseSSL
```xml
<add key="umbracoUseSSL" value="true" />
```

### CSS Directory 
By adding this to appSettings you can specify a new/different folder for storing your css-files and still be able to edit them within Umbraco. Default folder is ~/css.
For example if you wanted to store css in a folder in the website root folder "/assets/css", you could have this in appsetting:

#### v7 - umbracoCssDirectory
```xml
<add key="umbracoCssDirectory" value="~/assets/css" />
```

### Media Path
By adding this to appSettings you can specify a new/different folder for storing your media files. Default folder is ~/media.
For example if you wanted to store in a folder in the website root folder called "umbracoMedia", you woul have this in appsetting:

#### v7 - umbracoMediaPath
```xml
<add key="umbracoMediaPath" value="~/umbracoMedia" />
```

### Scripts Path
By adding this to appSettings you can specify a new/different folder for storing your JavaScript files and still be able to edit them within Umbraco. Default folder is ~/scripts.
For example if you wanted to store javascript in a folder in the website root folder "/assets/js", you could have this in appsetting:

#### v7 - umbracoScriptsPath
```xml
<add key="umbracoScriptsPath" value="~/assets/js" />
```

### SMTP Settings
By adding this settings to the web.config you will be able to send out emails from your Umbraco installation. This could be notifications emails if you are using content workflow, or you are using Umbraco Forms you also need to specify SMTP settings to be able use the email workflows. The forgot password function from the backoffice also needs a SMTP server to send the email with the reset link.

```xml
<system.net>
    <mailSettings>
        <smtp from="noreply@example.com">
            <network host="127.0.0.1" userName="username" password="password" />
        </smtp>
    </mailSettings>
</system.net>
```

:::note
Since version 7.13, if you keep the `from` attribute set to noreply@example.com, Umbraco won't be able to send user invitations, or password recovery emails.
:::

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

### Version Check Period
The default value is: `7`

When this value is set above 0, the backoffice will check for a new version of Umbraco every 'x' number of days where 'x' is the value defined for this setting. Set this value to `0` to never check for a new version.

#### Version 7 - umbracoVersionCheckPeriod
```xml
<add key="umbracoVersionCheckPeriod" value="0" />
```

### umbracoDisableElectionForSingleServer (Umbraco v7.6+)
The default value is: `false`

This is not a setting that commonly needs to be configured.

This value is primarily used on Umbraco Cloud for a small startup performance optimization. When this is true, the website instance will automatically be configured to not support load balancing and the website instance will be configured to be the 'master' server for scheduling so no [master election](https://our.umbraco.com/documentation/Getting-Started/Setup/Server-Setup/load-balancing/flexible#scheduling-and-master-election) occurs. This will save 1 database call during startup. 
