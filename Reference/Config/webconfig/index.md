---
versionFrom: 8.0.0
meta.Title: "web.config settings in Umbraco"
meta.Description: "Reference on web.config settings in Umbraco"
---

# Web.config

_This section defines the appSetting parameters found in the web.config_

## Explicit settings

_These are settings that require a value in the appSettings section of the web.config file_

### Umbraco.Core.ConfigurationStatus

Holds the version number of the currently installed version of Umbraco. 

```xml
<add key="Umbraco.Core.ConfigurationStatus" value="8.1.5" />
```

This version number changes automatically when running the installer and the upgrade installer. It is not recommended to update this version manually as the upgrade installer might need to perform some actions to upgrade your site properly. The upgrade installer doesn't run when this version is the same as the version number in the Umbraco DLL.

### Umbraco.Core.ReservedUrls

A comma-separated list of files to be left alone by Umbraco. IIS will serve these files, and the Umbraco request pipeline will not be triggered.

```xml
<add key="Umbraco.Core.ReservedUrls" value="~/config/splashes/booting.aspx,~/install/default.aspx,~/config/splashes/noNodes.aspx,~/VSEnterpriseHelper.axd" />
```

### Umbraco.Core.ReservedPaths

A comma-separated list of all the folders in your directory to be left alone by Umbraco. If you have folders with custom files, add them to this setting to make sure Umbraco leaves them alone.

```xml
<add key="Umbraco.Core.ReservedPaths" value="~/umbraco" />
```

### Umbraco.Core.Path

The URL pointing to the Umbraco administration folder. If you rename the `umbraco` folder, you need to update this setting too.

```xml
<add key="Umbraco.Core.Path" value="~/umbraco" />
```

### Umbraco.Core.HideTopLevelNodeFromPath

If you are running multiple sites, you don't want the top level node in your URL. Possible options are `true` and `false`.

```xml
<add key="Umbraco.Core.HideTopLevelNodeFromPath" value="true" />
```

### Umbraco.Core.TimeOutInMinutes

Configures the number of minutes without any requests being made before the Umbraco user will be required to re-login. Any backoffice request will reset the clock. Default setting is 20 minutes.

```xml
<add key="Umbraco.Core.TimeOutInMinutes" value="20" />
```

### Umbraco.Core.DefaultUILanguage

The default language to use in the backoffice if a user isn't explicitly assigned one. The default is English (en).

```xml
<add key="Umbraco.Core.DefaultUILanguage" value="es" />
```

### Umbraco.Core.UseHttps

Makes sure that all of the requests in the backoffice are called over HTTPS instead of HTTP when set to `true`.

```xml
<add key="Umbraco.Core.UseHttps" value="true" />
```

:::memo
Check out the [security documentation](../../security/use-https.md).
:::

### Umbraco.Examine.LuceneDirectoryFactory

The `SyncTempEnvDirectoryFactory` enables Examine to sync indexes between the remote file system and the local environment temporary storage directory. The indexes will be accessed from the temporary storage directory. 

This setting is required due to the nature of Lucene files and IO latency on Azure Web Apps.

```xml
<add key="Umbraco.Examine.LuceneDirectoryFactory" value="Examine.LuceneEngine.Directories.SyncTempEnvDirectoryFactory, Examine" />
```

:::note
This setting used to be set in the `~/Config/ExamineSettings.config` file in Umbraco 7. `
Read more in the [Azure Web Apps](../../../Getting-Started/Setup/Server-Setup/azure-web-apps.md#examine-v0180) article.
:::

### umbracoCssPath

By adding this to appSettings you can specify a new/different folder for storing your css-files and still be able to edit them within Umbraco. Default folder is ~/css.
For example if you wanted to store css in a folder in the website root folder "/assets/css", you could have this in appsetting:

```xml
<add key="umbracoCssPath" value="~/assets/css" />
```

### umbracoMediaPath

By adding this to appSettings you can specify a new/different folder for storing your media files. Default folder is ~/media.
For example if you wanted to store in a folder in the website root folder called "umbracoMedia", you woul have this in appsetting:

```xml
<add key="umbracoMediaPath" value="~/umbracoMedia" />
```

### umbracoScriptsPath

By adding this to appSettings you can specify a new/different folder for storing your JavaScript files and still be able to edit them within Umbraco. Default folder is ~/scripts.
For example if you wanted to store javascript in a folder in the website root folder "/assets/js", you could have this in appsetting:

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

### Umbraco.Core.ContentXML

The default value is: `~/App_Data/umbraco.config`

The value must be set to a virtual path with a prefixed tilde (~)

### Umbraco.Core.LocalTempStorage

The default value is: `Default`

This setting controls where Umbraco stores the XML cache file, the DistCache and PluginCache TEMP folders. Version 1.9.6+ of [ClientDependency Framework](https://github.com/Shazwazza/ClientDependency) also observe this setting.

The options are:

- `Default` - Umbraco cache file will be stored in `App_Data` and the `DistCache` and `PluginCache` folders will be stored in the `App_Data/TEMP` folder
- `EnvironmentTemp` - All files will be stored in the environment temporary folder
- `AspNetTemp` - All Files will be stored in the ASP.NET temporary folder

### Umbraco.Core.VersionCheckPeriod

The default value is: `7`

When this value is set above 0, the backoffice will check for a new version of Umbraco every 'x' number of days where 'x' is the value defined for this setting. Set this value to `0` to never check for a new version.

```xml
<add key="Umbraco.Core.VersionCheckPeriod" value="0" />
```

### Umbraco.Core.DisableElectionForSingleServer

The default value is: `false`

This is not a setting that commonly needs to be configured.

This value is primarily used on Umbraco Cloud for a small startup performance optimization. When this is true, the website instance will automatically be configured to not support load balancing and the website instance will be configured to be the 'primary' server for scheduling so no [primary election](https://our.umbraco.com/documentation/Getting-Started/Setup/Server-Setup/load-balancing/flexible#scheduling-and-master-election) occurs. This will save 1 database call during startup.
