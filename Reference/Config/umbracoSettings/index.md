---
versionFrom: 7.0.0
needsV8Update: "true"
---

# umbracoSettings

Here you will be able to find documentation on all the options you can modify in the umbracoSettings.config file.

:::warning
In v7+ many of these settings are not explicitly contained in the configuration file that is shipped with Umbraco and most of these settings have default values assigned.
These default values will be expressed below and you can insert these configuration items in the file to override the defaults.
:::

## Backoffice

Below you can see the settings that affect the Umbraco backoffice (v7.8+)

### Tours

The section is used for controlling the backoffice tours functionality.
```xml
<backOffice>
    <tours enable="true"></tours>
</backOffice>
```

There is only one supported attribute on the tours element:

**`enable`**
By default this is set to true. Set it to false to turn off [backoffice tours](../../../Extending/Backoffice-Tours/index.md)

## Content

Below you can see settings that affects content in Umbraco.

### Obsolete data types

This section is used for controlling whether or not the data types marked as obsolete should be visible in the dropdown when creating new data types.
```xml
<showDeprecatedPropertyEditors>false</showDeprecatedPropertyEditors>
```

**`enable`**
By default this is set to false. To make the obsolete data types visible in the dropdown change the value to **true**.

### Imaging

<small>This was introduced in 4.8 but is first used with the new media archive in 4.9</small>

This section is used for managing thumbnail creation, allowed attributes and, which properties of an image that should be automatically updated on upload.

```xml
<imaging>
    <!-- what file extension that should cause Umbraco to create thumbnails -->
    <imageFileTypes>jpeg,jpg,gif,bmp,png,tiff,tif</imageFileTypes>
    <!-- what attributes that are allowed in the editor on an img tag -->
    <allowedAttributes>alt,border,class,style,align,id,name,onclick,usemap</allowedAttributes>
    <!-- automatically updates dimension, file size and extension attributes on upload -->
    <autoFillImageProperties>
        <uploadField alias="umbracoFile">
            <widthFieldAlias>umbracoWidth</widthFieldAlias>
            <heightFieldAlias>umbracoHeight</heightFieldAlias>
            <lengthFieldAlias>umbracoBytes</lengthFieldAlias>
            <extensionFieldAlias>umbracoExtension</extensionFieldAlias>
        </uploadField>
    </autoFillImageProperties>
</imaging>
```

Let's break it down.

**`<imageFileTypes>`**
As the comment above states, this is a comma separated list of accepted image formats, which Umbraco can create a thumbnail of the image from.

**`<allowedAttributes>`**
As the comment above states, this is a comma separated list of those attributes you want to allow on the image tag.

**`<autoFillImageProperties>`**
As the comment above states, you can define what properties should be automatically updated when an image is being uploaded. This means that if you, for some odd reason, decide
to rename the default **umbracoWidth** and **umbracoHeight** properties to **width** and **height** then the values in **`<widthFieldAlias>`** and **`<heightFieldAlias>`** of course need to
be updated with the new property aliases in order to automatically populate the values when the image is being uploaded.

If you need to create a custom media document type to handle images called something like "Custom Image" width an alias of **customImage** then you need to add another
**`<uploadField>`** element where the **alias** is set to **customImage**. Like below. Note that the width and height attributes has also been changed in this example.

```xml
<imaging>
    <!-- what file extension that should cause Umbraco to create thumbnails -->
    <imageFileTypes>jpeg,jpg,gif,bmp,png,tiff,tif</imageFileTypes>
    <!-- what attributes that are allowed in the editor on an img tag -->
    <allowedAttributes>alt,border,class,style,align,id,name,onclick,usemap</allowedAttributes>
    <!-- automatically updates dimension, file size and extension attributes on upload -->
    <autoFillImageProperties>
        <uploadField alias="umbracoFile">
            <widthFieldAlias>umbracoWidth</widthFieldAlias>
            <heightFieldAlias>umbracoHeight</heightFieldAlias>
            <lengthFieldAlias>umbracoBytes</lengthFieldAlias>
            <extensionFieldAlias>umbracoExtension</extensionFieldAlias>
        </uploadField>
        **<uploadField alias="customImage">**
            **<widthFieldAlias>width</widthFieldAlias>**
            **<heightFieldAlias>height</heightFieldAlias>**
            <lengthFieldAlias>umbracoBytes</lengthFieldAlias>
            <extensionFieldAlias>umbracoExtension</extensionFieldAlias>
        </uploadField>
    </autoFillImageProperties>
</imaging>
```

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

### Errors

In case of a 404 error (page not found) Umbraco can return a default page instead. This is set here. Notice you can also set a different error page, based on the current culture so a 404 page can be returned in the correct language.

```xml
<errors>
    <!-- The id of the page that should be shown if the page is not found -->
    <!--
    <error404>
        <errorPage culture="default">1</errorPage>
        <errorPage culture="en-US">200</errorPage>
    </error404>
    -->
    <error404>1</error404>
</errors>
```

The above example shows what you need to do if you only have a single site that needs to show a custom 404 page. You specify which node that should be shown when a request for a non-existing page is being made. You can specify the node in three ways:

1. Enter the node's **id** (e.g. `<error404>1066</error404>`)
2. Enter the node's **GUID** (e.g. `<error404>4f96ffdd-b969-46a8-949e-7935c41fabc0</error404>`)
3. Enter an XPath to find the node (`<error404>/root/Home//TextPage[@urlName = 'error404']</error404>`)

:::note
- Ids are usually local to the specific solution (so won't point to the same node in two different environments if you're using Umbraco Cloud).
- GUIDs are universal and will point to the same node on different environments, provided the content was created in one environment and deployed to the other(s).
- When using XPath, there is no "context" (i.e. you can't find the node based on "currentPage") so needs to be a global absolute path.
:::

:::warning
Remember to recycle the app pool to make sure changes to this section take effect.
:::

If you have multiple sites, with different cultures, setup in your tree then you will need to setup the errors section like below:

```xml
<errors>
    <!-- The id of the page that should be shown if the page is not found -->
    <error404>
        <errorPage culture="default">1</errorPage>
        <errorPage culture="en-US">200</errorPage>
    </error404>
</errors>
```

If you have more than two sites and for some reason forget to update the above section with a 404 page and a culture then the **default** page will act as a fallback. Same
happens if you for some reason forget to define a hostname on a site.

#### Errors and IIS7+

You may find that your custom error page doesn't show, and instead IIS handles the error. To resolve this add the following key to your web.config right before the closing tag of the system.webServer section.

```xml
<httpErrors existingResponse="PassThrough" />
```

Now IIS will ignore httpErrors and allow Umbraco to handle them.

#### Handling multiple sites with the same culture

If you have multiple sites with the same culture then you can't use the above error settings. Then you will need to have a look at the [uComponents Multi-Site Not Found handler](http://ucomponents.codeplex.com/wikipage?title=MultiSitePageNotFoundHandler).
The benefit of using this handler is that you can choose the error page to be shown within the Umbraco backoffice.

### Notifications

Umbraco can send out email notifications, set the sender email address for the notifications emails here. To set the SMTP server used to send the emails, edit the standard `<mailSettings/>` section in the web.config file.

```xml
<notifications>
    <!-- the email that should be used as from mail when Umbraco sends a notification -->
    <email>your@email.here</email>
</notifications>
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
should not turn this off. Please also note that this option is most likely removed in a future Umbraco release - see http://issues.umbraco.org/issue/U4-867

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

***This option has become obsolete in v7+. It will always be displayed as text***

The setting controls what kind of context help is displayed next to editor fields in the content section.  It can either be display as a small icon with text on mouse hover: (set it to `icon`) Set to displaying the help text directly under the field name (set it to `text`), or not be displayed at all (set to `none`).

```xml
<PropertyContextHelpOption>text</PropertyContextHelpOption>
```

**`<PreviewBadge>`**

This allows you to customize the preview badge being shown when you're previewing a node.

```xml
<PreviewBadge><![CDATA[<a id="umbracoPreviewBadge" style="position: absolute; top: 0; right: 0; border: 0; width: 149px; height: 149px; background: url('{1}/preview/previewModeBadge.png') no-repeat;" href="{0}/endPreview.aspx?redir={2}"><span style="display:none;">In Preview Mode - click to end</span></a>]]></PreviewBadge>
```

**`<UmbracoLibraryCacheDuration>`**

As stated in the comment below this setting caches media and member data. This prevents the need for database queries when getting media and member data.

```xml
<!-- Cache cycle of Media and Member data fetched from the umbraco.library methods -->
<!-- In seconds. 0 will disable cache -->
<UmbracoLibraryCacheDuration>1800</UmbracoLibraryCacheDuration>
```

**`<ResolveUrlsFromTextString>`**

This setting is used when you're running Umbraco in virtual directories.

```xml
<!-- Url Resolving ensures that all links works if you run Umbraco in virtual directories -->
<!-- Setting this to true can increase render time for pages with a large number of links -->
<!-- If running Umbraco in virtual directory this *must* be set to true! -->
<ResolveUrlsFromTextString>false</ResolveUrlsFromTextString>
```

**`<DisallowedUploadFiles>`**

This setting consists of a list of file extensions that editors shouldn't be allowed to upload via the backoffice.

```xml
<!-- These file types will not be allowed to be uploaded via the upload control for media and content -->
<disallowedUploadFiles>ashx,aspx,ascx,config,cshtml,vbhtml,asmx,air,axd,swf,xml,xhtml,html,htm,svg,php,htaccess</disallowedUploadFiles>
```

**`<AllowedUploadFiles>`**

If greater control is required than available from the above, this setting can be used to store a list of file extensions.  If provided, only files with these extensions can be uploaded via the backoffice.

```xml
<!-- If completed, only the file extensions listed below will be allowed to be uploaded.  If empty, disallowedUploadFiles will apply to prevent upload of specific file extensions. -->
<allowedUploadFiles></allowedUploadFiles>
```

**`<loginBackgroundImage>`**

You can specify your own background image for the login screen here. The image will automatically get an overlay to match backoffice colors. This path is relative to the ~/umbraco path. The default location is: /umbraco/assets/img/installer.jpg

```xml
<loginBackgroundImage>../App_Plugins/Backgrounds/login.png</loginBackgroundImage>
```

**`<EnablePropertyValueConverters>`**

Enables [value converters](../../../Extending/Property-Editors/value-converters.md) for all built in property editors so that they return strongly typed object, recommended for use with [Models Builder](../../Templating/Modelsbuilder/index.md)

On new installs this set to true. When you are upgrading from a lower version than 7.6.0 it is recommended to set this setting to false. More information can be found in the explanation of the [breaking changes in 7.6.0](../../../Getting-Started/Setup/Upgrading/760-breaking-changes#property-value-converters-u4-7318)

```xml
<EnablePropertyValueConverters>true</EnablePropertyValueConverters>
```

## Security

In the security section you have the following options: **`<keepUserLoggedIn>`**, **`<usernameIsEmail>`**,  **`<hideDisabledUsersInBackoffice>`**,  **`<allowPasswordReset>`**,  **`<authCookieName>`** and  **`<authCookieDomain>`**. These settings deal with backoffice users and settings for the backoffice authentication cookies.

```xml
<security>
    <!-- set to true to auto update login interval
    (and there by disabling the lock screen) -->
    <keepUserLoggedIn>true</keepUserLoggedIn>

    <!-- by default this is true and if not specified in config will be true.
    Set to false to always show a separate username field in the backoffice user editor -->
    <usernameIsEmail>true</usernameIsEmail>

    <!-- change in 4.8: Disabled users are now showed dimmed and last in the tree.
    If you prefer not to display them set this to true -->
    <hideDisabledUsersInBackoffice>false</hideDisabledUsersInBackoffice>

    <!-- set to true to enable the UI and API to allow backoffice users to reset their passwords -->
    <allowPasswordReset>true</allowPasswordReset>

    <!-- set to a different value if you require the authentication cookie for backoffice users to be renamed -->
    <authCookieName>UMB_UCONTEXT</authCookieName>

    <!-- set to a different value if you require the authentication cookie
    for backoffice users to be set against a different domain -->
    <authCookieDomain></authCookieDomain>

</security>
```

**`<keepUserLoggedIn>`**
Keep this setting to "true" to avoid the lock screen introduced in earlier version of Umbraco. If you like the lock screen feel free to set this
option to "false" and thereby enabling it.

**`<usernameIsEmail>`**
This setting specifies whether the username and email address are separate fields in the backoffice editor. When set to "false", you can specify an email address and username, only the username can be used to log on. When set the "true" (the default value) the username is hidden and always the same as the email address.

**`<hideDisabledUsersInBackoffice>`**
As stated in the comment above, this setting was introduced in v4.8. If it's set to "true" it's not possible to see disabled users, which means it's
not possible to re-enable their access to the backoffice again. It also means you can't create an identical username if the user was disabled by a mistake.

**`<allowPasswordReset>`**
The feature to allow users to reset their passwords if they have forgotten them was introduced in 7.5. The feature is based on [a method provided by ASP.NET Identity](https://www.asp.net/identity/overview/features-api/account-confirmation-and-password-recovery-with-aspnet-identity). By default, this is enabled but if you'd prefer to not allow users to do this it can be disabled at both the UI and API level by setting this value to "false".

**`<authCookieName>`**
The authentication cookie which is set in the browser when a backoffice user logs in, and defaults to `UMB_UCONTEXT`. This setting is excluded from the configuration file but can be added in if a different cookie name needs to be set.

**`<authCookieDomain>`**
The authentication cookie which is set in the browser when a backoffice user logs in is automatically set to the current domain.  This setting is excluded from the configuration file but can be added in if a different domain is required.

## RequestHandler

The options in the request handler let us do some quite useful things, like setting domain prefixes, deciding whether or not to use trailing slashes and setting URL replacement for special characters.
Let's have a further look at each option below.

```xml
<requestHandler>
    <!-- this will ensure that urls are unique when running with multiple root nodes -->
    <useDomainPrefixes>false</useDomainPrefixes>
    <!-- this will add a trailing slash (/) to urls when in directory url mode -->
    <addTrailingSlash>true</addTrailingSlash>
    <urlReplacing removeDoubleDashes="false" toAscii="false">
        <char org=" ">-</char>
        <char org="&quot;"></char>
        <char org="'"></char>
        <char org="%"></char>
        <char org="."></char>
        <char org=";"></char>
        <char org="/"></char>
        <char org="\"></char>
        <char org=":"></char>
        <char org="#"></char>
        <char org="+">plus</char>
        <char org="*">star</char>
        <char org="&amp;"></char>
        <char org="?"></char>
        <char org="æ">ae</char>
        <char org="ø">oe</char>
        <char org="å">aa</char>
        <char org="ä">ae</char>
        <char org="ö">oe</char>
        <char org="ü">ue</char>
        <char org="ß">ss</char>
        <char org="Ä">ae</char>
        <char org="Ö">oe</char>
        <char org="|">-</char>
        <char org="&lt;"></char>
        <char org="&gt;"></char>
    </urlReplacing>
</requestHandler>
```

**`<useDomainPrefixes>`**
As mentioned in the comment above, this should be set to true when running with multiple root notes. This makes sure that you're not able to access content from
site-1.com on the domain of site-b.com, which can lead to duplicate content issues.

In order for this to work it requires you to setup some unique hostnames by right clicking the root nodes and choosing **manage hostnames** where you
then setup the domain and culture for the sites.

**`<addTrailingSlash>`**
As mentioned in the comment above, this will add a trailing slash to the url when **`<umbracoUseDirectoryUrls>`** in the **web.config** file is set to "true".
If you don't want to have a trailing slash when directory urls are in use, set the value to **false**.

**`<urlReplacing>`**
The **removeDoubleDashes** attribute makes sure the double dashes will not appear in the url. Set it to **false** if you want to have double dashes. NOTE that this attribute has no effect anymore starting with Umbraco 6.1 / 7.0 where double dashes are systematically removed.

The **toAscii** attributes tells Umbraco to convert all urls to ASCII using the built-in transliteration library. It is disabled by default, ie by default urls remain UTF8. Set it to **true** if you want to have ASCII urls.
Introduced in Umbraco 7.6.4 the toAscii attribute can be set to **try**. This will make the engine try to convert the name to an ASCII implementation. If it fails, it will fallback to the name. Reason is that some languages don't have ASCII implementations, therefore the urls would end up being empty.

Within the **`<urlReplacing>`** section there are a lot of **`<char>`** elements with an **org** attribute. The attribute holds the character that should
be replaced and within the **`<char>`** tags the value it should be replaced with is entered.

So, if **`<char org="ñ">n</char>`** is added above the **ñ** will be shown as a **n** in the url.

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

**baseUrl**: **(v6.2.5 & v7.1.9+)** This is optional and should only be used if the base URL cannot be detected. This might occur if your hosting setup has some special proxies setup. See this issue for more details: http://issues.umbraco.org/issue/U4-5391

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

*Prior to version 7.3*, when the Umbraco instances are setup and files are synced between the instances, the instances need to know when to refresh their cache. This happens in the `<servers>` setting.

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

## Repositories

This is a legacy setting that is no longer in use.

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

## Web.Routing

This section configures...

**trySkipIisCustomErrors**: defines the value of Response.TrySkipIisCustomErrors when an error (404, 400, 500...) is encountered. You probably want it to be true in order to prevent IIS from displaying its own 404 or 500 pages, and instead have your own page displayed.

**internalRedirectPreservesTemplate**: when true, an internal redirect does not reset the alternative template, if any.

**disableAlternativeTemplates**: when true, the entire alternative templates feature of Umbraco is disabled.

**disableFindContentByIdPath**: when true, urls such as /1234 do *not* find content with ID 1234.

**disableRedirectUrlTracking**: when you move and rename pages in Umbraco, 301 permanent redirects are automatically created, set this to true if you do not want this behavior.

**Note:** The URL tracking feature (and thus, this setting) is only available on Umbraco 7.5.0 and higher.

**umbracoApplicationUrl**: defines the Umbraco application url, i.e. how the server should reach itself. By default, Umbraco will guess that url from the first request made to the server. Use that setting if the guess is not correct (because you are behind a load-balancer, for example). Format is: "http://www.mysite.com/umbraco" i.e. it needs to contain the scheme (http/https), complete hostname, and Umbraco path.

```xml
<web.routing
    trySkipIisCustomErrors="false"
    internalRedirectPreservesTemplate="false"
    disableAlternativeTemplates="false"
    disableFindContentByIdPath="false"
    disableRedirectUrlTracking="false"
    umbracoApplicationUrl=""
/>
```
