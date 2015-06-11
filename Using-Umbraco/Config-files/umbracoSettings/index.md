#umbracoSettings

Here you will be able to find documentation on all the options you can modify in the umbracoSettings.config file.

##Content

Below you can see settings that affects content in Umbraco.

**Imaging**

<small>This was introduced in 4.8 but is first used with the new media archive in 4.9</small>

This section is used for managing thumbnail creation, allowed attributes and, which properties of an image that should be automatically updated on upload.

        <imaging>
            <!-- what file extension that should cause umbraco to create thumbnails -->
            <imageFileTypes>jpeg,jpg,gif,bmp,png,tiff,tif</imageFileTypes>
            <!-- what attributes that are allowed in the editor on an img tag -->
            <allowedAttributes>alt,border,class,style,align,id,name,onclick,usemap</allowedAttributes>
            <!-- automatically updates dimension, filesize and extension attributes on upload -->
            <autoFillImageProperties>
                <uploadField alias="umbracoFile">
                    <widthFieldAlias>umbracoWidth</widthFieldAlias>
                    <heightFieldAlias>umbracoHeight</heightFieldAlias>
                    <lengthFieldAlias>umbracoBytes</lengthFieldAlias>
                    <extensionFieldAlias>umbracoExtension</extensionFieldAlias>
                </uploadField>
            </autoFillImageProperties>
        </imaging>

Let's break it down.

**`<imageFileTypes>`**
As the comment above states, this is a comma seperated list of accepted image formats, which Umbraco can create a thumbnail of the image from.

**`<allowedAttributes>`**
As the comment above states, this is a comma seperated list of those attributes you want to allow on the image tag.

**`<autoFillImageProperties>`**
As the comment above states, you can define what properties should be automatically updated when an image is being uploaded. This means that if you, for some odd reason, decide
to rename the default **umbracoWidth** and **umbracoHeight** properties to **width** and **height** then the values in **`<widthFieldAlias>`** and **``<heightFieldAlias>`** of course need to
be updated with the new property aliases in order to automatically populate the values when the image is being uploaded.

If you need to create a custom media documenttype to handle images called something like "Custom Image" width an alias of **customImage** then you need to add another
**`<uploadField>`** element where the **alias** is set to **customImage**. Like below. Note that the width and height attributes has also been changed in this example.

        <imaging>
            <!-- what file extension that should cause umbraco to create thumbnails -->
            <imageFileTypes>jpeg,jpg,gif,bmp,png,tiff,tif</imageFileTypes>
            <!-- what attributes that are allowed in the editor on an img tag -->
            <allowedAttributes>alt,border,class,style,align,id,name,onclick,usemap</allowedAttributes>
            <!-- automatically updates dimension, filesize and extension attributes on upload -->
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

**Scripteditor**

This section is used for managing the options to create and edit script files in the Umbraco backoffice. 
<small>Please note that best practice is to handle your script files externally and not through Umbraco!</small>

        <scripteditor>
            <!-- Path to script folder - no ending "/" -->
            <scriptFolderPath>/scripts</scriptFolderPath>
            <!-- what files can be opened/created in the script editor -->
            <scriptFileTypes>js,xml</scriptFileTypes>
            <!-- disable the codepress editor and use a simple textarea instead -->
            <!-- note! codemirror editor always disabled in IE due to automatic hyperlinking "feature" in contenteditable areas -->
            <scriptDisableEditor>false</scriptDisableEditor>
        </scripteditor>

Let's break it down.

**`<scriptFolderpath>`**
As the comment above says, this is where you can define the directory on the disk where script files should be read from. If you keep you scripts in
another folder structure like /frontend/scripts then simply change the value to **`<scriptFolderPath>/frontend/scripts</scriptFolderPath>`**

**`<scriptFileTypes>`**
As the comment above says, this is where you can define what files can be opened/created in the script editor in a comma-separated list.

**`<scriptDisableEditor>`**
As the comments above say, this is where you can decide wether you want to just edit the code in a simple textarea or you want to have a more advanced editor available.
If you change the value to "true" then you will see the code in a simple textarea instead.

**UploadAllowDirectories**

This setting let's you control if an upload control can create new folders for files uploaded, or if the file should be stored in the /media folder root with a unique ID prefixed to the filename.

         <!-- should umbraco store the uploaded files like /media/xxx/filename.ext or like /media/xxx-filename.ext
              should be set to false if the application pool's user account hasn't got readrights of the driveroot up to the /media directory -->
        <UploadAllowDirectories>True</UploadAllowDirectories>

**Errors**

In case of a 404 error (page not found) umbraco can return a default page instead. this is set here. Notice you can also set a different error page, based on the current culture so a 404 page can be returned in the correct language

        <errors>
            <!-- the id of the page that should be shown if the page is not found -->
            <!-- 
            <error404>
                <errorPage culture="default">1</errorPage>
                <errorPage culture="en-US">200</errorPage>
            </error404>
            -->
            <error404>1</error404>
        </errors>

The above example shows what you need to do if you only have a single site, that needs to show a custom 404 page. Simply just enter the id of the node that should be
shown a request for non-existing page is being made. **Remember to recycle the app pool to make sure changes to this section take effect**.

If you have multiple sites, with different cultures, setup in your tree then you will need to setup the errors section like below:

        <errors>
            <!-- the id of the page that should be shown if the page is not found -->
            <error404>
                <errorPage culture="default">1</errorPage>
                <errorPage culture="en-US">200</errorPage>
            </error404>
        </errors>

If you have more than two sites and for some reason forget to update the above section with a 404 page and a culture then the **default** page will act as a fallback. Same
happens if you for some reason forget to define a hostname on a site.

**Handling multiple sites with the same culture**

If you have multiple sites with the same culture then you can't use the above error settings. Then you will need to have a look at the [uComponents Multi-Site Not Found handler](http://ucomponents.codeplex.com/wikipage?title=MultiSitePageNotFoundHandler).
The benefit of using this handler is that you can choose the error page to be shown within the Umbraco backoffice.

**Notifications**

Umbraco can send out email notifications, set the sender email address for the notifications emails here. To set the SMTP server used to send the emails, edit the standard <mailSettings/> section in the web.config file.

        <notifications>
            <!-- the email that should be used as from mail when umbraco sends a notification -->
            <email>your@email.here</email>
        </notifications>

**EnsureUniqueNaming**

Umbraco comes with a build-in action handler that ensures that 2 pages does not get identical urls. Incase of identical names, the handler will attach a counter to the dublicate name.

        <!-- if true umbraco will ensure that no page under the same parent has an identical name -->
        <ensureUniqueNaming>True</ensureUniqueNaming>

**TidyEditorContent**

By setting the value to "true" tidy will be Used to clean Richtext Editor content.
**NOTE: This has been changed from "True" to "False" as default with the release of 4.9**.

The benefit of disabling tidy is that HTML5 elements and iframes can be inserted into the rich text editor without being removed.

        <!-- clean editor content with use of tidy -->
        <TidyEditorContent>False</TidyEditorContent>

**TidyCharEncoding**

Character encoding for Tidy.

        <!-- the encoding type for tidy. Default is UTF8, options are ASCII, Raw, Latin1, UTF8, ISO2022, MacroMan-->
        <TidyCharEncoding>UTF8</TidyCharEncoding>

**UseLegacyXmlSchema**

By default Umbraco uses the new XML schema, which was introduced with the release of Umbraco 4.5. If you need to be able to use the old schema, due to an upgrade from an older version
of Umbraco, then change the setting to "true". This way you will not need to update the existing XSLT files to use the new format.

        <!-- to enable new content schema, this needs to be false -->
        <UseLegacyXmlSchema>false</UseLegacyXmlSchema>

**ForceSafeAliases**

This setting allows you to disable the safe aliases, when you're creating properties on your document types. As the comment below states you really
should not turn this of. Pleae also note that this option is most likely removed in a future Umbraco release - see http://issues.umbraco.org/issue/U4-867

        <!-- Whether to force safe aliases (no spaces, no special characters) at businesslogic level on contenttypes and propertytypes -->
        <!-- HIGHLY recommend to keep this to true to ensure valid and beautiful XML Schemas -->
        <ForceSafeAliases>true</ForceSafeAliases>

**XmlCacheEnabled**

Turn Xml caching of content on/off. Umbraco Makes heavy use of caching content in memory to avoid database calls. This makes umbraco faster and more efficient. You should not in any way turn this off, unless you have a very good reason to do so. It will make your website very slow.

        <!-- Enable / disable xml content cache -->
        <XmlCacheEnabled>True</XmlCacheEnabled>

**ContinouslyUpdateXmlDiskCache**

Updates the XmlCache whenever content is published. If it's set to false, then writes to the disk cache will be queued and performed asynchronously.

        <!-- Update disk cache every time content has changed -->
        <ContinouslyUpdateXmlDiskCache>True</ContinouslyUpdateXmlDiskCache>

**XmlContentCheckForDiskChanges**

Checks if the disk cache file has been updated and if so, clears the in-memory cache to force the file to be read. Added to trigger updates of the in-memory cache when the disk cache file is updated.

        <!-- Update in-memory cache if xml file is changed -->
        <XmlContentCheckForDiskChanges>False</XmlContentCheckForDiskChanges>

**EnableSplashWhileLoading**

In case umbraco is taking a bit of time to prepare content to display you can display a "loading, please wait..." splash screen to your users. Simply change the value to "True".

        <!-- Show the /config/splashes/booting.aspx page while initializing content -->
        <EnableSplashWhileLoading>False</EnableSplashWhileLoading>

**PropertyContextHelpOption**

What kind of context help should be displayed next to editor fields in the content section, it can either be display as a small icon with text on mouse hover: (set it to "icon") Set to displaying the help text directly under the field name (set it to "text"), or not be displayed at all (set to "none").

<PropertyContextHelpOption>text</PropertyContextHelpOption>

**PreviewBadge**

This allows you to customize the preview badge being shown when you're previewing a node.

<PreviewBadge><![CDATA[<a id="umbracoPreviewBadge" style="position: absolute; top: 0; right: 0; border: 0; width: 149px; height: 149px; background: url('{1}/preview/previewModeBadge.png') no-repeat;" href="{0}/endPreview.aspx?redir={2}"><span style="display:none;">In Preview Mode - click to end</span></a>]]></PreviewBadge>

**UmbracoLibraryCacheDuration**

As stated in the comment below this setting caches media and member data. This prevents the need for database queries when getting media and member data.

        <!-- Cache cycle of Media and Member data fetched from the umbraco.library methods -->
        <!-- In seconds. 0 will disable cache -->
        <UmbracoLibraryCacheDuration>1800</UmbracoLibraryCacheDuration>

**ResolveUrlsFromTextString**

This setting is used when you're running Umbraco in virtual directories.

        <!-- Url Resolving ensures that all links works if you run Umbraco in virtual directories -->
        <!-- Setting this to true can increase render time for pages with a large number of links -->
        <!-- If running Umbraco in virtual directory this *must* be set to true! -->
        <ResolveUrlsFromTextString>false</ResolveUrlsFromTextString>

##Security

In the security section you have two options. **`<keepUserLoggedIn>`** and **`<hideDisabledUsersInBackoffice>`**. Both settings are dealing
width backoffice users.

    <security>
        <!-- set to true to auto update login interval (and there by disabling the lock screen -->
        <keepUserLoggedIn>true</keepUserLoggedIn>

        <!-- change in 4.8: Disabled users are now showed dimmed and last in the tree. If you prefer not to display them set this to true -->
        <hideDisabledUsersInBackoffice>false</hideDisabledUsersInBackoffice>
    </security>

**`<keepUserLoggedIn>`**
Keep this setting to "true" to avoid the lock screen introduced in earlier version of Umbraco. If you like the lock screen feel free to set this
option to "false" and thereby enabling it.

**`<hideDisabledUsersInBackoffice>`**
As stated in the comment above, this setting was introduced in v4.8. If it's set to true it's not possible to see disabled users, which means it's
not possible to re-enable their access to the backoffice again. It also means you can't create an identical username if the user was disabled by a mistake.

##RequestHandler

The options in the request handler let's us do some quite usefull things, like setting domain prefixes, deciding wether or not to use traling slashes and setting url replacement for special characters.
Let's have a further look at each option below.

    <requestHandler>
        <!-- this will ensure that urls are unique when running with multiple root nodes -->
        <useDomainPrefixes>false</useDomainPrefixes>
        <!-- this will add a trailing slash (/) to urls when in directory url mode -->
        <addTrailingSlash>true</addTrailingSlash>
        <urlReplacing removeDoubleDashes="false">
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

**`<useDomainPrefixes>`**
As mentioned in the comment above, this should be set to true when running with multiple root notes. This makes sure that you're not able to access content from
site-1.com on the domain of site-b.com, which can lead to duplicate content issues.

In order for this to work it requires that you setup some unique hostnames by right clicking the root nodes and choosing **manage hostnames** where you
then setup the domain and culture for the sites.

**`<addTrailingSlash>`**
As mentioned in the comment above, this will add a trailing slash to the url when **`<umbracoUseDirectoryUrls>`** in the **web.config** file is set to "true".
If you don't want to have a trailing slash when directory urls are in use simply just set the value to **false**.

**`<urlReplacing>`**
The **removeDoubleDashes** attribute makes sure the double dashes will not appear in the url. Set it to **false** if you want to have double dashes.

Within the **`<urlReplacing>`** section there are a lot of **`<char>`** elements with an **org** attribute. The attribute holds the character that should
be replaced and withing the **`<char>`** tags the value it should be replaced width is entered.

So if **`<char org="ñ">n</char>`** is added above the **ñ** will be shown as a **n** in the url.

##Templates

Enabled by default, You can turn off masterpages and go back and use the old templating engine (From v3 of Umbraco). But it is in no way recommended to do so.

    <templates>
        <useAspNetMasterPages>true</useAspNetMasterPages>
    </templates>

##Developer

The comment says it all :)

    <!-- this is used by Umbraco to determine if there's valid classes in the /App_Code folder to be used for Rest/XSLT extensions -->
    <developer>
        <appCodeFileExtensions>
            <ext>cs</ext>
            <ext>vb</ext>
        </appCodeFileExtensions>
    </developer>

##Scripting

    <scripting>
        <razor>
            <!-- razor DynamicNode typecasting detects XML and returns DynamicXml - Root elements that won't convert to DynamicXml -->
            <notDynamicXmlDocumentElements>
                <element>p</element>
                <element>div</element>
                <element>ul</element>
                <element>span</element>
            </notDynamicXmlDocumentElements>
            <dataTypeModelStaticMappings>
                <!--
            <mapping dataTypeGuid="00000000-0000-0000-0000-000000000000">Fully.Qualified.Type.Name.For.ModelBinder,Assembly.Name.Excluding.Dot.Dll</mapping>
            <mapping documentTypeAlias="textPage" nodeTypeAlias="propertyAlias">Fully.Qualified.Type.Name.For.ModelBinder,Assembly.Name.Excluding.Dot.Dll</mapping>
            <mapping dataTypeGuid="00000000-0000-0000-0000-000000000000" documentTypeAlias="textPage" nodeTypeAlias="propertyAlias">Fully.Qualified.Type.Name.For.ModelBinder,Assembly.Name.Excluding.Dot.Dll</mapping>
            <mapping dataTypeGuid="00000000-0000-0000-0000-000000000000" documentTypeAlias="textPage">Fully.Qualified.Type.Name.For.ModelBinder,Assembly.Name.Excluding.Dot.Dll</mapping>
            <mapping dataTypeGuid="00000000-0000-0000-0000-000000000000" nodeTypeAlias="propertyAlias">Fully.Qualified.Type.Name.For.ModelBinder,Assembly.Name.Excluding.Dot.Dll</mapping>
            <mapping nodeTypeAlias="propertyAlias">Fully.Qualified.Type.Name.For.ModelBinder,Assembly.Name.Excluding.Dot.Dll</mapping>
            -->
            </dataTypeModelStaticMappings>
        </razor>
    </scripting>

##viewstateMoverModule

The viewstate mover module is included by default. It enables you to move all asp.nets viewstate information to the end of the page, thereby making it easier for search engines to index your content instead of going through viewstate javascript code.Please note that this does not work will all asp.net controls.

    <!-- This moves the asp.net viewstate data to the end of the html document instead of having it in the beginning-->
    <viewstateMoverModule enable="false" />

##Logging

**enableLogging:** turn logging on and off

**enableAsyncLogging:** add log entries using a background thread so it does not slow down page rendering or other more important processes.

**disabledLogTypes:** Enable or disable certain types of log entries. This can be usefull to ensure that debug log entries are not filling the umbracoLog table after the site has entered production.

Standard logTypeAlias Entries are as follows and correspond to the entries found in the logHeader column of the umbracoLog table.

**new** = when a new node is created in the database
**system** = application events such as restart
**debug** = debug information such as node name changes, xml save times
**login** = information regarding Admin user login
**error** = .net error logging of errors in the backoffice as well as website
**save** = node is saved to the database
**delete** = node is deleted from the database
**publish** = node is published
**notfound** = node not found
**open** = recorded when a node is opened

    <logging>
        <enableLogging>true</enableLogging>
        <enableAsyncLogging>true</enableAsyncLogging>
        <disabledLogTypes>
            <!-- <logTypeAlias>[alias-of-log-type-in-lowercase]</logTypeAlias> -->
        </disabledLogTypes>
        <!-- You can add your own logging tool by implementing the umbraco.BusinessLogic.Interfaces.ILog interface and add the reference here -->
        <!-- The external logger can also act as the audit trail storage by setting the logAuditTrail attribute to true -->
        <!--<externalLogger assembly="~/bin/assemblyFileName.dll" type="fully.qualified.namespace.and.type" logAuditTrail="false" /> -->
    </logging>

##ScheduledTasks

In this section you can add multiple scheduled tasks that should run a certain intervals.

    <scheduledTasks>
        <!-- add tasks that should be called with an interval (seconds) -->
        <!--    <task log="true" alias="test60" interval="60" url="http://localhost/umbraco/test.aspx"/>-->
    </scheduledTasks>

For each task you want to run you should simply just add a **`<task>`** element.

The task elements consist of the following attributes:
**log:** Set this to true if you want to write to the umbracoLog table and see if everything is working as expected. If set to false nothing will be written to the log.
**alias:** The alias is being used in the log so you can distinguise between the different tasks and other log-entries.
**interval:** The interval is set in seconds and determines how often the task should be run.
**url:** Here the url for the page that should be called to run the task must be entered. Please note this can also point to an extensionless url or a service etc.

**Please note:** that the scheduler is not in anyway a windows process so it is depending on the application pool umbraco is located in. This means that if the application pool resets, so will the scheduler, so this is not a highly reliable way of scheduling tasks.

##DistributedCalls / Loadbalancing

Umbraco comes with abbility to distrubute it's cached content to multiple servers. Also know as loadbalancing. Umbraco has to be installed on all servers, but all servers sharing the same database.

When the umbraco instances are setup and files are synced between the instances, the instances need to know when to refresh their cache. This happens in the <servers> setting.

Eveytime some content is published in umbraco. You can ask umbraco to ping other hosts and tell them to update their cache. Make sure that these instances can be reached internally on port 80.

Also, remember to include the actual instance performing the publish if you it to refresh it's own cache as well. Cache will only be refreshed on servers in the list.

    <!-- distributed calls make umbraco use webservices to handle cache refreshing -->
    <distributedCall enable="false">
        <!-- the id of the user who's making the calls -->
        <!-- needed for security, umbraco will automatically look up correct login and passwords -->
        <user>0</user>
        <servers>
            <!-- add ip number or hostname, make sure that it can be reached from all servers -->
            <!-- you can also add optional attributes to force a protocol or port number (see #2) -->
            <!-- <server>127.0.0.1</server>-->
            <!-- <server forceProtocol="http|https" forcePortnumber="80|443">127.0.0.1</server>-->
        </servers>
    </distributedCall>

As all instances share the same database the only authentication we need between the servers are the ID of users making the call, which is set in the <users> element. This is strictly for logging.

Though the above example shows the server's as IP addresses, these can also be DNS names of servers. This is useful if you're server is running multiple websites on IIS.

##Webservices

umbraco includes a simple set of webservices to control content, members, media files etc etc from external applications. They can be turned completely off on the <webservices> element or enabled one by one by enabling users access.

documentServiceUsers: access to creating and publishing content
url: /umbraco/webservices/api/documentservice.asmx

fileServiceUsers: Access to change files
fileServiceFolders: folders the fileServiceUsers have access to
url: /umbraco/webservices/api/fileservice.asmx

stylesheetServiceUsers: making changes to stylesheets
url: /umbraco/webservices/api/StylesheetService.asmx

memberServiceUsers: adding and editing members
url: /umbraco/webservices/api/memberservice.asmx

templateServiceUsers: editing template files
url: /umbraco/webservices/api/templateservice.asmx

    <!-- configuration for webservices -->
    <!-- webservices are disabled by default. Set enable="True" to enable them -->
    <webservices enabled="False">
        <!-- You must set user-rights for each service. Enter the usernames seperated with comma (,) -->
        <documentServiceUsers>your-username</documentServiceUsers>
        <fileServiceUsers>your-username</fileServiceUsers>
        <stylesheetServiceUsers>your-username</stylesheetServiceUsers>
        <memberServiceUsers>your-username</memberServiceUsers>
        <templateServiceUsers>your-username</templateServiceUsers>
        <!-- type of files (extensions) that are allowed for the file service -->
        <fileServiceFolders>css,xslt</fileServiceFolders>
    </webservices>

##Repositories

From the Developer section you can access packages. From here you have access to the umbraco package repository from where you can download packages. It is however also possible to add other repositories to this list. If you or your company have a private repository, it can be added to this list.

    <!-- Configuration for repositories -->
    <!-- Add or remove repositories here. You will need the repository's unique key to be able to connect to it.-->
    <repositories>
        <repository name="Umbraco package Repository" guid="65194810-1f85-11dd-bd0b-0800200c9a66" />
    </repositories>

If you wish to add your own repository, contact [Umbraco corp](http://umbraco.com/contact.aspx) to get a **unique key**.

Also note that you can remove the official repository from the **<repositories>** list in case you do not want this functionality

##Providers

The providers section configures the different providers in use in umbraco. Currently only the backend membership provider is set here.

**DefaultBackofficeProvider:** the name of the membership provider you wish to use to authenticate users in the backend. To use, add a new provider to the web.config file and set it's alias here

    <providers>
        <users>
            <!-- if you wish to use your own membershipprovider for authenticating to the umbraco back office -->
            <!-- specify it here (remember to add it to the web.config as well) -->
            <DefaultBackofficeProvider>UsersMembershipProvider</DefaultBackofficeProvider>
        </users>
    </providers>

##Help

In this section you can change the destination you arrive at when clicking the "Help" button inside the Umbraco backoffice.

As a default the link points to a wiki entry on our Umbraco. If you want to point the url to something that makes more sense to your clients
you can easily change the **defaultUrl** to anything you would like.

If you want to make some help pages targeted at different user levels you can benefit from the different parameters shown in the samples below.

    <!-- Maps language, usertype, application and application_url to help pages -->
    <help defaultUrl="http://our.umbraco.org/wiki/umbraco-help/{0}/{1}">
        <!-- Add links that should open custom help pages -->
        <!--<link application="content" applicationUrl="dashboard.aspx"  language="en" userType="Administrators" helpUrl="http://www.xyz.no?{0}/{1}/{2}/{3}" /> -->
    </help>

Each of the parameters added to the **helpUrl** attribute of the **`<link>`** correspond to the content of the other attributes set on **`<link>`**.
{0} = application
{1} = applicationUrl
{2} = language
{3} = userType

This means that the **helpUrl** ends up looking like this http://www.xyz.no/?content/dashboard.aspx/en/administrators

You can rearrange the order of the parameters so if in the **helpUrl** is written like this helpUrl="http://www.xyz.no?{0}/{1}/{3}/{2}"

This will make the final url look like this: http://www.xyz.no/?content/dashboard.aspx/administrators/en

You can also omit the parameters you don't need.

The smart thing about the help section is that it is context aware. Therefore the Help link will change according to it's current context. If nothing has been specified
in the **`<link>`** elements then the help button will default to the **defaultUrl** specified on the **`<help>`** element. Let's have a look at the different attribues i more detail.

**content:** This can be either "content", "media", "settings", "developer", "users", "members" or "translation"
**applicationUrl:** This can be either "dashboard.aspx", "editContent.aspx" or "editMedia.aspx". (There are more options if you stand in other sections but these are the most comon scenarios).
**language:** This one should be defined with a language code like "en" for english, "da" for danish etc.
**userType:** This can be set to "Administrators", "Editor", "Writer", "Translator" or any custom defined usertype.
**helpUrl:** This is the url, that links to the help page which can define a path based on the other attributes as explained above.

This means that you can create some usefull help pages targeting different languages and different user types. Since it's context aware you will be able
to setup help pages that will provide the editor the right kind of help at the right time.

Consider this setup:

    <help defaultUrl="http://our.umbraco.org/wiki/umbraco-help/">
        <link application="content" applicationUrl="dashboard.aspx"  language="en" userType="Administrators" helpUrl="http://www.site.com/{0}/{1}/{2}/{3}" />
        <!-- Result url: http://www.site.com/contant/dashboard.aspx/en/Administrators -->

        <link application="content" applicationUrl="editContent.aspx"  language="en" userType="Administrators" helpUrl="http://www.site.com/{0}/{1}/{2}/{3}" />
        <!-- Result url: http://www.site.com/contant/editContent.aspx/en/Administrators -->

        <link application="content" applicationUrl="dashboard.aspx"  language="en" userType="Editor" helpUrl="http://www.site.com/{0}/{1}/{2}/{3}" />
        <!-- Result url: http://www.site.com/contant/dashboard.aspx/en/Editor -->

        <link application="content" applicationUrl="editContent.aspx"  language="en" userType="Editor" helpUrl="http://www.site.com/{0}/{1}/{2}/{3}" />
        <!-- Result url: http://www.site.com/contant/editContent.aspx/en/Editor -->

        <link application="media" applicationUrl="dashboard.aspx"  language="en" userType="Administrators" helpUrl="http://www.site.com/{0}/{1}/{2}/{3}" />
        <!-- Result url: http://www.site.com/media/dashboard.aspx/en/Administrators -->

        <link application="media" applicationUrl="editMedia.aspx"  language="en" userType="Administrators" helpUrl="http://www.site.com/{0}/{1}/{2}/{3}" />
        <!-- Result url: http://www.site.com/media/editMedia.aspx/en/Administrators -->

        <link application="media" applicationUrl="dashboard.aspx"  language="en" userType="Editor" helpUrl="http://www.site.com/{0}/{1}/{2}/{3}" />
        <!-- Result url: http://www.site.com/media/dashboard.aspx/en/Editor -->

        <link application="media" applicationUrl="editMedia.aspx"  language="en" userType="Editor" helpUrl="http://www.site.com/{0}/{1}/{2}/{3}" />
        <!-- Result url: http://www.site.com/media/editMedia.aspx/en/Editor -->
    </help>

    Here we have 8 different help page link targeting two different users dependant on wether they're standing on "content -> dashboard.aspx", "content -> editContent.aspx", "media -> dashboard.aspx", or "media -> editMedia.aspx".

    The key to make content aware help pages is to understand that application and applicationUrl content is crucial to setup correctly. Otherwise the default url will be used instead.