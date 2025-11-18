---
description: "Information on the global settings section"
---

# Global Settings

Global settings contains at set of global settings for the CMS such as default UI language, reserved urls, and much more. All settings except Simple Mail Transfer Protocol (SMTP) use default values. Configuration is optional unless you want to send emails from your site.

The following snippet contains all the available options, with default values, and some example values for the required keys `From`, `Host`, and `Port` keys of the SMTP settings:

```json
"Umbraco": {
  "CMS": {
    "Global": {
      "ReservedUrls": "~/.well-known,",
      "ReservedPaths": "~/app_plugins/,~/install/,~/mini-profiler-resources/,~/umbraco/,",
      "TimeOut": "00:20:00",
      "DefaultUILanguage": "en-US",
      "HideTopLevelNodeFromPath": true,
      "UseHttps": true,
      "VersionCheckPeriod": 7,
      "IconsPath": "~/umbraco/assets/icons",
      "UmbracoCssPath": "~/css",
      "UmbracoScriptsPath": "~/scripts",
      "UmbracoMediaPath": "~/media",
      "UmbracoMediaPhysicalRootPath": "X:/Shared/Media",
      "InstallMissingDatabase": false,
      "DisableElectionForSingleServer": false,
      "DatabaseFactoryServerVersion": "SqlServer.V2019",
      "MainDomLock": "FileSystemMainDomLock",
      "MainDomKeyDiscriminator": "",
      "Id": "184a8175-bc0b-43dd-8267-d99871eaec3d",
      "NoNodesViewPath": "~/umbraco/UmbracoWebsite/NoNodes.cshtml",
      "Smtp": {
        "From": "person@umbraco.dk",
        "Host": "localhost",
        "Port": 25,
        "SecureSocketOptions": "Auto",
        "DeliveryMethod": "Network",
        "PickupDirectoryLocation": "",
        "Username": "person@umbraco.dk",
        "Password": "SuperSecretPassword",
        "EmailExpiration": null,
      },
      "DatabaseServerRegistrar": {
        "WaitTimeBetweenCalls": "00:01:00",
        "StaleServerTimeout": "00:02:00"
      },
      "DatabaseServerMessenger": {
        "MaxProcessingInstructionCount": 1000,
        "TimeToRetainInstructions": "2.00:00:00",
        "TimeBetweenSyncOperations": "00:00:05",
        "TimeBetweenPruneOperations": "00:01:00"
      },
      "DistributedLockingMechanism": "",
      "DistributedLockingReadLockDefaultTimeout": "00:01:00",
      "DistributedLockingWriteLockDefaultTimeout": "00:00:05",
    }
  }
}
```

## Root level settings

In the root level section, that is those without a separate sub section like SMTP, you can configure.

### Reserved urls

Key: `ReservedUrls`
Type: `string` (default: `~/.well-known,`)

A comma-separated list of files to be left alone by Umbraco, these files will be served, and the Umbraco request pipeline will not be triggered.

### Reserved paths

Key: `ReservedPaths`
Type: `string` (default: `~/app_plugins/,~/install/,~/mini-profiler-resources/,~/umbraco/,`)

A comma-separated list of all the folders in your directory to be left alone by Umbraco. If you have folders with custom files, add them to this setting to make sure Umbraco leaves them alone.

{% hint style="warning" %}
Adding additional values to the Reserves URLs and Reserved Paths will overwrite default/current values. This causes performance issues as well.
{% endhint %}

### Timeout

Key: `TimeOut`
Type: `string` (default: `00:20:00`)

Configure the session timeout to determine how much time without a request being made can pass before the user is required to log in again. The session timeout format needs to be set as `HH:MM:SS`. Any activity within the backoffice will reset the timer.

{% hint style="info" %}
Long session timeouts raise data exposure and unauthorized access risks. Thus, it's vital to establish a reasonable timeout to mitigate security risks.
{% endhint %}

### Default UI language

Key: `DefaultUILanguage`
Type: `string` (default: `en-US`)

The default language to use in the backoffice if a user isn't explicitly assigned one.

### Hide top level nodes from path

Key: `HideTopLevelNodeFromPath`
Type: `bool` (default: `true`)

If you are running multiple sites, you don't want the top level node in your URL and can disable it with this setting.

### Use https

Key: `UseHttps`
Type: `bool` (default: `true`)

Makes sure that all of the requests in the backoffice are called over HTTPS instead of HTTP when set to true.

### Version check period

Key: `VersionCheckPeriod`
Type: `int` (default: `7`)

When this value is set above 0, the backoffice will check for a new version of Umbraco every 'x' number of days where 'x' is the value defined for this setting. Set this value to 0 to never check for a new version.

### Icons path

Key: `IconsPath`
Type: `string` (default: `umbraco/assets/icons`)

By adding this value you can specify a new/different folder for storing your icon resources. It's important to be aware of .NET Core's limitations regarding serving static file content. By default, static content will only be served from the `wwwroot` folder.

### Umbraco CSS path

Key: `UmbracoCssPath`
Type: `string` (default: `~/css`)

By adding this, you can store CSS files in a different folder and still edit them in Umbraco. .NET Core only serves static files from the `wwwroot` folder by default.  For more info see [Extending filesystem](../../extending/filesystemproviders/).

### Umbraco scripts path

Key: `UmbracoScriptsPath`
Type: `string` (default: `~/scripts`)

By adding this, you can store script/JavaScript files in a different folder and still edit them in Umbraco. .NET Core only serves static files from the `wwwroot` folder by default. For more info see [Extending filesystem](../../extending/filesystemproviders/).

### Umbraco media path

Key: `UmbracoMediaPath`
Type: `string` (default: `~/media`)

By adding this, you can store media files in a different folder and still edit them in Umbraco. .NET Core only serves static files from the `wwwroot` folder by default. For more info see [Extending filesystem](../../extending/filesystemproviders/).

### Umbraco media physical root path

Key: `UmbracoMediaPhysicalRootPath`
Type: `string` (default: `~/media`)

By adding this you can specify a new/different folder for storing your media files elsewhere on the server. Unlike `UmbracoMediaPath`, this does not change the relative path that media is served from (e.g. /media) but allows for files to be stored **outside** of the wwwroot folder. Both relative paths (../../Shared/Media) and absolute server paths (X:/Shared/Media) are supported. For more info see [Extending filesystem](../../extending/filesystemproviders/).

### Install missing database

Key: `InstallMissingDatabase`
Type: `bool` (default: `false`)

This is not a setting that commonly needs to be configured.

If enabled Umbraco will try to automatically install the database when it's missing. This is primarily used in conjunction with unattended installs.

### Disable election for single server

Key: `DisableElectionForSingleServer`
Type: `bool` (default: `false`)

This is not a setting that commonly needs to be configured.

This value is primarily used on Umbraco Cloud for a small startup performance optimization. When this is true, the website instance will automatically be configured to not support load balancing and the website instance will be configured to be the 'primary' server for scheduling so no [primary election](../../fundamentals/setup/server-setup/load-balancing/file-system-replication.md) occurs. This will save 1 database call during startup.

### Database factory version

Key: `DatabaseFactoryServerVersion`
Type: `bool` (default: `false`)

This is not a setting that commonly needs to be configured.

This setting is used to specify which sql server version that the database is running, this setting is only required if you use SqlServer 2008, if this is the case set the setting to `"SqlServer.V2008"`.

### Main dom lock

Key: `MainDomLock`
Type: `string`

Specifies the implementation of IMainDomLock to be used.

`IMainDomLock` is used to synchronize access to resources like the Lucene indexes.

Available options:

* `"FileSystemMainDomLock"`- Available cross-platform, uses lock files written to LocalTempPath to control acquisition of MainDom status.
* `"MainDomSemaphoreLock"` - Windows only, uses a named system Semaphore with a `maximumCount` of 1 to control acquisition of MainDom status.
* `"SqlMainDomLock"` - Available cross-platform, uses the database to control acquisition of MainDom status.

The default implementation unless configured otherwise is `FileSystemMainDomLock`.

### Main dom key discriminator

Key: `MainDomKeyDiscriminator`
Type: `string`

For advanced use cases e.g. deployment slot swapping on Azure app services.

When using SqlMainDomLock a MainDomKey is used to identify an instance of a running application.

The MainDomKey is by default comprised of the server's machine name & the application id.

This is generally all that is required to control MainDom status as starting a new process for the same application on the same server will result in a matching MainDomKey. This will then require that an existing instance yields MainDom status to the new process.

Deployment slots for a given Azure App Service share the same machine name. Without additional configuration, they will share a MainDomKey and therefore compete for MainDom status. This can be undesirable if attempting to deploy to a deployment slot followed by a swap with the production slot as once traffic has switched to the new instance the old production instance reboots and can re-acquire MainDom status. See [What happens during a swap](https://docs.microsoft.com/en-us/azure/app-service/deploy-staging-slots#what-happens-during-a-swap).

To prevent this from occurring you can specify a MainDomKeyDiscriminator which should be set as a slot-specific configuration to prevent the slots from competing for MainDom status.

It's worth noting that during the swap operation there is a period where both instances will share the same configuration and at this point, the old instance will yield MainDom status to the new instance.

### Main dom release signal polling interval

Key: `MainDomReleaseSignalPollingInterval`
Type: `string`

Gets or sets the duration (in milliseconds) for which the MainDomLock release signal polling task should sleep. The default value is 2000ms.

### Id

Key: `Id`
Type: `string`

This setting doesn't need to be configured.

This setting contains a unique ID used to identify your project, and is populated the first time your site runs, you shouldn't change this setting.

### No nodes view path

Key: `NoNodesViewPath`
Type: `string` (default: `~/umbraco/UmbracoWebsite/NoNodes.cshtml`)

This setting specifies what view to render when there is no content on the site.

## SMTP settings

By adding this settings to the appsettings.json you will be able to send out emails from your Umbraco installation. This could be notifications emails if you are using content workflow, or you are using Umbraco Forms you also need to specify SMTP settings to be able use the email workflows. The forgot password function from the backoffice also needs a SMTP server to send the email with the reset link.

### From

Specifies the default email address used when sending emails. This can be overridden in some cases, like when inviting a user. The address follows the Request for Comments (RFC) 822 format, allowing a friendly name like: `"Friendly Name <your@emailaddress.com>"`.

### Host

Address of the SMTP host used to send the email from.

### Port

The port of the SMTP host, port 25 is a common port for SMTP.

### Username

The username used to authenticate with the specified SMTP server, when sending an email.

### Password

The password used to authenticate with the specified SMTP server, when sending an email.

### Secure socket options

Allows you to specify what security should be used for the connection sending the email.

The options are:

* None - No SSL or TLS encryption should be used.
* Auto - Allow the IMailService to decide which SSL or TLS options to use (default). If the server does not support SSL or TLS, then the connection will continue without any encryption.
* SslOnConnect - The connection should use SSL or TLS encryption immediately.
* StartTls - Elevates the connection to use TLS encryption immediately after reading the greeting and capabilities of the server. If the server does not support the STARTTLS extension, then the connection will fail and a NotSupportedException will be thrown.
* StartTlsWhenAvailable - Elevates the connection to use TLS encryption immediately after reading the greeting and capabilities of the server, but only if the server supports the STARTTLS extension.

### Delivery method

Specifies what delivery method should be used for emails, most of the time you'd want to use the default `"Network"` option to send emails over the network. It might be useful during development to use `"SpecifiedPickupDirectory"` to place the email messages in a folder on disk, instead of trying to send them over the network.

### Pickup directory location

If you're using the `"SpecifiedPickupDirectory"` option on as the delivery method, this setting allows you to specify what folder the emails should be saved to.

### Email expiration

If set to a TimeSpan format, this value will be used to add an `Expires` heading to emails sent from Umbraco. The configured expiry will be used unless a specific value is provided (for example, password reset and user invites have specific settings and defaults).

## Database server registrar settings

It's unlikely that you will have to change these settings unless you're using a load balanced setup.

### Wait time between calls

Key: `DatabaseServerRegistrar.WaitTimeBetweenCalls`
Type: `string` (default: `00:01:00`)

Sets a value for the amount of time to wait between calls to the database on the background thread.

### Stale server timeout

Key: `DatabaseServerRegistrar.StaleServerTimeout`
Type: `string` (default: `00:02:00`)

Sets a value for the time span to wait before considering a server stale, after it has last been accessed.

## Database server messenger

It's unlikely that you will have change these settings, unless you're using a load balanced setup. These settings are all about how load balancing instructions from the database are processed and pruned.

### Max processing instruction

Key: `DatabaseServerMessenger.MaxProcessingInstructionCount`
Type: `string` (default: `1000`)

Sets a value for the maximum number of instructions that can be processed at startup; otherwise the server cold-boots (rebuilds its caches).

### Time to retain instructions

Key: `DatabaseServerMessenger.TimeToRetainInstructions`
Type: `string` (default: `2.00:00:00`)

Sets a value for the time to keep instructions in the database; records older than this number will be pruned.

### Time between sync operations

Key: `DatabaseServerMessenger.TimeBetweenSyncOperations`
Type: `string` (default: `00:00:05`)

Sets a value for the time to wait between each sync operation.

### Time between prune operations

Key: `DatabaseServerMessenger.TimeBetweenPruneOperations`
Type: `string` (default: `00:01:00`)

Sets a value for the time to wait between each prune operation.

### Distributed Locking Mechanism

Key: `DistributedLockingMechanism`
Type: `string`

This is not a setting that commonly needs to be configured.

Gets or sets a value representing the DistributedLockingMechanism to use.

Valid values:

* `"SqlServerDistributedLockingMechanism"`
* `"SqliteDistributedLockingMechanism"`

### Distributed Read Lock DefaultTimeout

Key: `DistributedLockingReadLockDefaultTimeout`
Type: `string` (default: `00:01:00`)

Gets or sets a value representing the maximum time to wait whilst attempting to obtain a distributed read lock.

The default value is 60 seconds.

### Distributed Write Lock DefaultTimeout

Key: `DistributedLockingWriteLockDefaultTimeout`
Type: `string` (default: `00:00:05`)

Gets or sets a value representing the maximum time to wait whilst attempting to obtain a distributed write lock.

The default value is 5 seconds.
