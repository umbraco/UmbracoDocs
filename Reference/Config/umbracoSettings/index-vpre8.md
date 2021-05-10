---
versionFrom: 7.0.0
versionRemoved: 8.0.0
meta.Title: "umbracoSettings.config options in Umbraco"
meta.Description: "Reference on umbracoSettings.config options in Umbraco"
---

# umbracoSettings

The sections below are only valid in umbraco versions until v8.

:::warning
In v7+ many of these settings are not explicitly contained in the configuration file that is shipped with Umbraco and most of these settings have default values assigned.
These default values will be expressed below and you can insert these configuration items in the file to override the defaults.
:::

### Script editor

This section is used for managing the options to create and edit script files in the Umbraco backoffice.

:::note
Please note that best practice is to handle your script files externally and not through Umbraco!
:::

```xml
<scripteditor>
    <!-- Path to script folder - no ending "/" -->
    <scriptFolderPath>/scripts</scriptFolderPath>
    <!-- what files can be opened/created in the script editor -->
    <scriptFileTypes>js,xml</scriptFileTypes>
    <!-- disable the codepress editor and use a simple textarea instead -->
    <!-- note! codemirror editor always disabled in IE due to automatic hyperlinking "feature" in contenteditable areas -->
    <scriptDisableEditor>false</scriptDisableEditor>
</scripteditor>
```

Let's break it down.

**`<scriptFolderpath>`**
As the comment above says, this is where you can define the directory on the disk where script files should be read from. If you keep you scripts in
another folder structure like /frontend/scripts then change the value to **`<scriptFolderPath>/frontend/scripts</scriptFolderPath>`**

**`<scriptFileTypes>`**
As the comment above says, this is where you can define what files can be opened/created in the script editor in a comma-separated list.

**`<scriptDisableEditor>`**
As the comments above say, this is where you can decide whether you want to edit the code in a textarea or you want to have a more advanced editor available.
If you change the value to "true" then you will see the code in a textarea instead.

**`<UploadAllowDirectories>`**

This setting let's you control if an upload control can create new folders for files uploaded, or if the file should be stored in the /media folder root with a unique ID prefixed to the filename.

```xml
<!--
should Umbraco store the uploaded files like /media/xxx/filename.ext or like /media/xxx-filename.ext
should be set to false if the application pool's user account hasn't got read rights of the drive root up to the /media directory
-->
<UploadAllowDirectories>True</UploadAllowDirectories>
```

**`<EnsureUniqueNaming>`**

Umbraco comes with a built-in action handler that ensures that 2 pages does not get identical urls. In case of identical names, the handler will attach a counter to the duplicate name.

```xml
<!-- if true Umbraco will ensure that no page under the same parent has an identical name -->
<ensureUniqueNaming>True</ensureUniqueNaming>
```

**`<TidyEditorContent>`**

By setting the value to "true" tidy will be Used to clean Richtext Editor content.
**NOTE: This has been changed from "True" to "False" as default with the release of 4.9**.

The benefit of disabling tidy is that HTML5 elements and IFRAMEs can be inserted into the rich text editor without being removed.

```xml
<!-- clean editor content with use of tidy -->
<TidyEditorContent>False</TidyEditorContent>
```

**`<TidyCharEncoding>`**

Character encoding for Tidy.

```xml
<!-- the encoding type for tidy. Default is UTF8, options are ASCII, Raw, Latin1, UTF8, ISO2022, MacroMan-->
<TidyCharEncoding>UTF8</TidyCharEncoding>
```

**`<ForceSafeAliases>`**

This setting allows you to disable the safe aliases, when you're creating properties on your document types. As the comment below states you really
should not turn this off. Please also note that this option is most likely removed in a future Umbraco release - see [http://issues.umbraco.org/issue/U4-867](http://issues.umbraco.org/issue/U4-867)

```xml
<!-- Whether to force safe aliases (no spaces, no special characters) at businesslogic level on contenttypes and propertytypes -->
<!-- HIGHLY recommend to keep this to true to ensure valid and beautiful XML Schemas -->
<ForceSafeAliases>true</ForceSafeAliases>
```

**`<XmlCacheEnabled>`**

Turn XML caching of content on/off. Umbraco makes heavy use of caching content in memory to avoid database calls. This makes Umbraco faster and more efficient. You should not in any way turn this off unless you have a very good reason to do so. It will make your website very slow.

```xml
<!-- Enable / disable XML content cache -->
<XmlCacheEnabled>True</XmlCacheEnabled>
```

**`<ContinouslyUpdateXmlDiskCache>`**

Updates the XmlCache whenever content is published, default is set to true. If it's set to false then it will never write the xml to disc. This will have an affect on start up times as Umbraco will have to fetch the initial Xml from the database instead of from disc. This is a legacy setting for older load balanced setups. You are advised to leave this set to true on new builds.

```xml
<!-- Update disk cache every time content has changed -->
<ContinouslyUpdateXmlDiskCache>True</ContinouslyUpdateXmlDiskCache>
```

**`<XmlContentCheckForDiskChanges>`**

Checks if the disk cache file has been updated and if so, clears the in-memory cache to force the file to be read. Added to trigger updates of the in-memory cache when the disk cache file is updated.

```xml
<!-- Update in-memory cache if XML file is changed -->
<XmlContentCheckForDiskChanges>False</XmlContentCheckForDiskChanges>
```

**`<EnableSplashWhileLoading>`**

In case Umbraco is taking a bit of time to prepare content to display you can display a "loading, please wait..." splash screen to your users. Change the value to "True".

```xml
<!-- Show the /config/splashes/booting.aspx page while initializing content -->
<EnableSplashWhileLoading>False</EnableSplashWhileLoading>
```

**`<PropertyContextHelpOption>`**

**_This option has become obsolete in v7+. It will always be displayed as text_**

The setting controls what kind of context help is displayed next to editor fields in the content section. It can either be display as a small icon with text on mouse hover: (set it to `icon`) Set to displaying the help text directly under the field name (set it to `text`), or not be displayed at all (set to `none`).

```xml
<PropertyContextHelpOption>text</PropertyContextHelpOption>
```

**`<UmbracoLibraryCacheDuration>`**

As stated in the comment below this setting caches media and member data. This prevents the need for database queries when getting media and member data.

```xml
<!-- Cache cycle of Media and Member data fetched from the umbraco.library methods -->
<!-- In seconds. 0 will disable cache -->
<UmbracoLibraryCacheDuration>1800</UmbracoLibraryCacheDuration>
```

**`<EnablePropertyValueConverters>`**

Enables [value converters](../../../Extending/Property-Editors/value-converters.md) for all built in property editors so that they return strongly typed object, recommended for use with [Models Builder](../../Templating/Modelsbuilder/index.md)

On new installs this set to true. When you are upgrading from a lower version than 7.6.0 it is recommended to set this setting to false. More information can be found in the explanation of the [breaking changes in 7.6.0](../../../Getting-Started/Setup/Upgrading/760-breaking-changes#property-value-converters-u4-7318)

```xml
<EnablePropertyValueConverters>true</EnablePropertyValueConverters>
```

## RequestHandler

Until v7 it was possible to use "domain prefixes".

```xml
<requestHandler>
    <!-- this will ensure that urls are unique when running with multiple root nodes -->
    <useDomainPrefixes>false</useDomainPrefixes>

</requestHandler>
```

### `<useDomainPrefixes>`

As mentioned in the comment above, this should be set to true when running with multiple root notes. This makes sure that you're not able to access content from
site-1.com on the domain of site-b.com, which can lead to duplicate content issues.

In order for this to work it requires you to setup some unique host names by right clicking the root nodes and choosing **manage hostnames** where you
then setup the domain and culture for the sites.

## Templates

```xml
<templates>
    <defaultRenderingEngine>Mvc</defaultRenderingEngine>
    <useAspNetMasterPages>true</useAspNetMasterPages>
    <enableSkinSupport>true</enableSkinSupport>
</templates>
```

**`<defaultRenderingEngine>`**
Tells Umbraco whether to create MVC Views or Webforms Master Pages when creating a template. This does not limit you from using one technology or the other, it is a flag to indicate to Umbraco what type of templates to create in the backoffice.

**`<enableSkinSupport>`**
This setting only affects skinning when using Webforms Masterpages.

## Developer

The comment says it all :)

```xml
<!-- this is used by Umbraco to determine if there's valid classes in the /App_Code folder to be used for Rest/XSLT extensions -->
<developer>
    <appCodeFileExtensions>
        <ext>cs</ext>
        <ext>vb</ext>
    </appCodeFileExtensions>
</developer>
```

## Scripting

The [`<scripting>` section](index-vpre6.0.0.md) is about legacy scripting and is by default not present in new versions.

## viewstateMoverModule

The viewstate mover module is included by default. It enables you to move all ASP.NET viewstate information to the end of the page, thereby making it easier for search engines to index your content instead of going through viewstate JavaScript code. Please note that this does not work will all ASP.NET controls.

```xml
<!-- This moves the ASP.NET viewstate data to the end of the html document instead of having it in the beginning-->
<viewstateMoverModule enable="false" />
```

## Logging

Umbraco v7 used Log4Net for logging.

**enableLogging:** turn logging on and off

**enableAsyncLogging:** add log entries using a background thread so it does not slow down page rendering or other more important processes.

**disabledLogTypes:** Enable or disable certain types of log entries. This can be useful to ensure that debug log entries are not filling the UmbracoLog table after the site has entered production.

Standard logTypeAlias Entries are as follows and correspond to the entries found in the logHeader column of the umbracoLog table.

**new** = when a new node is created in the database
**system** = application events such as restart
**debug** = debug information such as node name changes, XML save times
**login** = information regarding Admin user login
**error** = .net error logging of errors in the backoffice as well as website
**save** = node is saved to the database
**delete** = node is deleted from the database
**publish** = node is published
**notfound** = node not found
**open** = recorded when a node is opened

```xml
<logging>
    <enableLogging>true</enableLogging>
    <enableAsyncLogging>true</enableAsyncLogging>
    <disabledLogTypes>
        <!-- <logTypeAlias>[alias-of-log-type-in-lowercase]</logTypeAlias> -->
    </disabledLogTypes>
    <!-- You can add your own logging tool by implementing the umbraco.BusinessLogic.Interfaces.ILog interface and add the reference here
    The external logger can also act as the audit trail storage by setting the logAuditTrail attribute to true
    <externalLogger assembly="~/bin/assemblyFileName.dll" type="fully.qualified.namespace.and.type" logAuditTrail="false" /> -->
</logging>
```

## ScheduledTasks

In this section you can add multiple scheduled tasks that should run at certain intervals.

```xml
<scheduledTasks baseUrl="OptionalCustomBaseUrl.com/umbraco/">
    <!-- add tasks that should be called with an interval (seconds) -->
    <!--    <task log="true" alias="test60" interval="60" url="http://localhost/umbraco/test.aspx"/>-->
</scheduledTasks>
```

The scheduledTasks element consist of the following attributes:

**baseUrl**: **(v6.2.5 & v7.1.9+)** This is optional and should only be used if the base URL cannot be detected. This might occur if your hosting setup has some special proxies setup. See this issue for more details: [http://issues.umbraco.org/issue/U4-5391](http://issues.umbraco.org/issue/U4-5391).

Note: this setting is **obsolete** as of 7.2.7, use umbracoApplicationUrl instead (see Web.Routing below).

For each task you want to run you should add a **`<task>`** element.

The task elements consist of the following attributes:

**log:** Set this to true if you want to write to the umbracoLog table and see if everything is working as expected. If set to false nothing will be written to the log.

**alias:** The alias is being used in the log so you can distinguish between the different tasks and other log-entries.

**interval:** The interval is set in seconds and determines how often the task should be run.

**url:** Here the url for the page that should be called to run the task must be entered. Please note this can also point to an extensionless url or a service etc.

**Please note:** that the scheduler is not in any way a windows process so it depends on the application pool in which Umbraco is located. This means that if the application pool resets, so will the scheduler, so this is not a highly reliable way of scheduling tasks.

## DistributedCalls / Loadbalancing

**Please note:** this setting applies only to [legacy load balancing](../../../Getting-Started/Setup/Server-Setup/Load-Balancing/traditional.md).

Umbraco comes with ability to distribute its cached content to multiple servers via a method known as load balancing. Umbraco has to be installed on all servers, with all servers sharing the same database.

_Prior to version 7.3_, when the Umbraco instances are setup and files are synced between the instances, the instances need to know when to refresh their cache. This happens in the `<servers>` setting.

Every time some content is published in Umbraco. You can ask Umbraco to ping other hosts and tell them to update their cache. Make sure that these instances can be reached internally on port 80.

Also, remember to include the actual instance performing the publish if you it to refresh its own cache as well. Cache will only be refreshed on servers in the list.

```xml
<!-- distributed calls make Umbraco use webservices to handle cache refreshing -->
<distributedCall enable="false">
    <!-- the id of the user who's making the calls -->
    <!-- needed for security, Umbraco will automatically look up correct login and passwords -->
    <user>0</user>
    <servers>
        <!-- add ip number or hostname, make sure that it can be reached from all servers -->
        <!-- you can also add optional attributes to force a protocol or port number (see #2) -->
        <!-- <server>127.0.0.1</server>-->
        <!-- <server forceProtocol="http|https" forcePortnumber="80|443">127.0.0.1</server>-->
    </servers>
</distributedCall>
```

As all instances share the same database the only authentication we need between the servers are the ID of users making the call, which is set in the `<users>` element. This is strictly for logging.

Though the above example shows the server's as IP addresses, these can also be DNS names of servers. This is useful if you're server is running multiple websites on IIS.

## Providers

The providers section configures the different providers in use in Umbraco. Currently only the backend membership provider is set here.

**DefaultBackofficeProvider:** the name of the membership provider you wish to use to authenticate users in the backend. To use, add a new provider to the web.config file and set its alias here

```xml
<providers>
    <users>
        <!-- if you wish to use your own membershipprovider for authenticating to the Umbraco backoffice
        specify it here (remember to add it to the web.config as well) -->
        <DefaultBackofficeProvider>UsersMembershipProvider</DefaultBackofficeProvider>
    </users>
</providers>
```
