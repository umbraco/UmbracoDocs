---
versionFrom: 7.0.0
versionTo: 10.0.0
---

# Version specific upgrades

*This document covers specific upgrade steps if a version requires them, most versions do not require specific upgrade steps and most of the time you will be able to upgrade directly from your current version to the latest version.*

Follow the steps in the [general upgrade guide](general.md), then these additional instructions for the specific versions. (Remember that new config files are not mentioned because they are already covered in the general upgrade guide.)

## Version 9 to version 10

:::warning
**Important**: .net version 6.0.5 is the minimum required version for Umbraco 10 to be able to run. You can check with `dotnet --list-sdks` what your latest installed SDK version is.
SDK version 6.0.300 is the one that includes .net 6.0.5.
At the time of writing, .net 6.0.6 is out with an SDK version of 6.0.301.
:::

## Video Tutorial

<iframe width="800" height="450" src="https://www.youtube.com/embed/075H_ekJBKI" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

The upgrade path between Umbraco 9 and Umbraco 10 can be done directly by updating your project using NuGet. You will need to ensure the packages you are using are available in Umbraco 10.

Are you looking to upgrade an Umbraco Cloud project from 9 to 10? Follow the guide made for [Upgrading your project from Umbraco 9 to 10](../../../Umbraco-Cloud/Upgrades/Migrating-from-9-to-10/) instead, as it requires a few steps specific to Umbraco Cloud.

:::warning
**Important**: SQL CE is no longer a supported database engine.

There is no official migration path from SQL CE to another database engine.

The following options may suit your needs:

+ Follow a community guide to migrate from a SQL CE database to SQL Server e.g. [article by Jan Reilink](https://www.saotn.org/convert-sqlce-database-to-sql-server/)
+ Setup a new database for v10 and use [uSync](https://jumoo.co.uk/usync/) to transfer document types and content across.
+ Setup a new database for v10 and use a premium tool such as [redgate SQL Data Compare](https://www.red-gate.com/products/sql-development/sql-data-compare/) to copy database contents across.
+ Setup a new database for v10 and use a premium tool such as [Umbraco Deploy](https://umbraco.com/products/umbraco-deploy) to transfer document types and content across.
:::

### Steps to upgrade using Visual Studio

1. Open your Umbraco 9 project in Visual Studio.
2. Right-click on the project name in the Solution Explorer and select **Properties**.
3. Select **.NET 6.0** from the **Target Framework** drop-down.
4. Go to **Tools** > **NuGet Package Manager** > **Manage NuGet Packages for Solution...**
5. Go to the **Installed** tab in the NuGet Package manager.
6. Choose **Umbraco.Cms**.
7. Select **10.0.0** from the **Version** drop-down and click **Install** to upgrade your project to version 10.
8. Update `Program.cs` to the following:

    ```csharp
    public class Program
    {
        public static void Main(string[] args)
            => CreateHostBuilder(args)
                .Build()
                .Run();

        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureUmbracoDefaults()
                .ConfigureWebHostDefaults(webBuilder =>
                {
                    webBuilder.UseStaticWebAssets();
                    webBuilder.UseStartup<Startup>();
                });
    }
    ```
    The calls to `ConfigureUmbracoDefaults` and `webBuilder.UseStaticWebAssets()` are new.

9. Remove the following files and folders:
    - `/wwwroot/umbraco`
    - `/umbraco/PartialViewMacros`
    - `/umbraco/UmbracoBackOffice`
    - `/umbraco/UmbracoInstall`
    - `/umbraco/UmbracoWebsite`
    - `/umbraco/config/lang`
    - `/umbraco/config/appsettings-schema.json`
    - `/App_Plugins/UmbracoForms` (if you are using Umbraco Forms on your project)
10. Build and run your project to finish the installation of Umbraco 10.

To re-enable the appsettings IntelliSense, you must update your schema reference in the `appsettings.json` file and any other `appsettings.{Environment}.json` files from:

```json
"$schema": "./umbraco/config/appsettings-schema.json",
```

To:

```json
"$schema": "./appsettings-schema.json",
```

:::note
To upgrade to Umbraco 10, your database needs to be at least on Umbraco 8.18.
:::

:::note
If using Umbraco Forms, the database should be on the latest minor version of Forms 8 (with form definitions stored in the database) or 9. See more details of the Forms upgrade [here](../../../Add-ons/UmbracoForms/Installation/Version-Specific.md).
:::

## [Breaking changes from Umbraco 9 to Umbraco 10](umbraco10-breaking-changes)

Breaking changes going from Umbraco 9 to Umbraco 10.

## Version 8 to version 9

There is no direct upgrade path from Umbraco 8 to Umbraco 9, but it is possible to migrate from Umbraco 8 sites to Umbraco 9 sites.

You can reuse your content if you take a backup of your Umbraco 8 database and restore it into a new database used for a Umbraco 9 site.
You will need to ensure packages you are using is available in Umbraco 9, and you will need to reimplement your custom code and templates.

The reason why it is not possible to upgrade an Umbraco 8 site to Umbraco 9 is is that the codebase has been fundamentally updated in Umbraco 9 and the underlying web framework updated from ASP.NET to ASP.NET Core.
It wouldn’t be possible to take this giant leap while maintaining full compatibility with Umbraco 8.

## Version 8.1.0

There are a few breaking changes from 8.0.x to 8.1.0. Make sure to check the [full list](https://github.com/umbraco/Umbraco-CMS/issues?q=is%3Aissue+label%3Arelease%2F8.1.0+is%3Aclosed+label%3Acategory%2Fbreaking).

### IPublishedContent

Due to the [changes in `IPublishedContent`](https://github.com/umbraco/Umbraco-CMS/issues/5170) there are few steps you will need to take to make sure that your site works. See the [docs on IPublishedContent changes in 8.1.0](v81-ipublishedcontent-changes.md) and what steps you may need to take when you upgrade.

### Models Builder

If you're using ModelsBuilder in dll mode you will need to delete the dlls before upgrading because they're going to be wrong and cause your whole site to YSOD.

If you're using ModelsBuilder in AppData mode and you have your generated models in your solution you will need to update them after upgrading: `PublishedContentType` will need to be replaced with `IPublishedContentType`. If you have an implementation of the `PropertyValueConverter` class, you need to replace all references to `PublishedPropertyType` with `IPublishedPropertyType` within that class. Only after you do that will your solution build again.

### AutoMapper

Umbraco 8.1 replaces AutoMapper with [UmbracoMapper](../../../Reference/Mapping/index.md). This in itself will not break anything on your site, but if you have used AutoMapper in your own code you will have to either include the package yourself or switch your implementation to use UmbracoMapper.

## Version 7 to version 8

There is no direct upgrade path from Umbraco 7 to Umbraco 8, but it is possible to migrate content from Umbraco 7 sites to Umbraco 8 sites. We have [added content migrations](#migrating-content-from-v7-to-v8) in Umbraco 8.1.0 that will enable you to move your content (content/media/members) from an Umbraco 7 site to an Umbraco 8 site.

The reason why it is not possible to upgrade an Umbraco 7 site to Umbraco 8 is is that the codebase has been fundamentally updated in Umbraco 8. A lot of outdated code and technology has been removed and instead new, faster and more secure technology has been implemented throughout Umbraco 8. It wouldn’t be possible to take this giant leap while maintaining full compatibility with Umbraco 7.

In Umbraco 8 we have added improvements and updated dependencies as well as done a thorough clean-up to make it simpler for you to work with and extend your Umbraco project.

### Migrating content from v7 to v8

If you have an Umbraco 7 site you can migrate the content to an Umbraco 8.1+ site. Read how to do it in our [Content migration to v8 guide](migrating-to-v8.md).

## Version 7.7.0

Version 7.7.0 introduces User Groups and a better user management and security facilities. This means that anything to do with "User Types" no longer exist including several APIs that work with User Types. If your code or any package's code that you use makes reference to "User Type" APIs, you may need to make changes to your code. In many cases we've created backward compatibility shims for these scenarios and obsoleted APIs that should no longer be used but in some cases this was not possible.

Also we're now by default using the e-mail address and not the username for the credentials. So when trying to login to the backoffice one will now need to use the e-mail address as opposed to the username, which was used in previous versions. If you do an upgrade from an older version and would like to keep using the username you will need to change the `<usernameIsEmail>true</usernameIsEmail>` setting to **false**.

For a full list of breaking changes see: [the list on the issue tracker](https://issues.umbraco.org/issues/?q=&project=U4&tagValue=&release=7.7.0&issueType=&search=search)

Version 7.7.2 no longer ships with the `CookComputing.XmlRpcV2` assembly. If you reference this assembly or have a package that requires this assembly, you may need to copy it back into your website from the backup you've taken before you began the 7.7.2 upgrade.

This version also ships with far less client files (i.e. js, css, images) that were only relevant for very old versions of Umbraco (i.e. < 7.0.0). There might be some packages that were referencing these old client files so if you seen missing image references you may need to contact the vendor of the package in question to update their references.

## Version 7.6.3

In short:

In Umbraco version 7.6.2 we made a mistake in the Property Value Converts (PVCs) which was corrected 2 days later in version 7.6.3. If you were having problems with querying the following data types in the frontend, then make sure to upgrade to 7.6.3:

* Multi Node Tree Picker
* Related Links
* Member Picker

Depending on if you tried to fix problem with those data types you will might need to fix them again after you upgrade to 7.6.3.

## Property Value Converters

Umbraco stores data for data types in different ways, for a lot of pickers it will store (for example) 1072 or 1083,1283. These numbers refer to the identifier of the item in Umbraco. In the past, when building your templates you would manually have to take that value and find the content item it belongs to and then get the data you wanted from there, for example:

```csharp
@{
    IPublishedContent contactPage;
    var contactPageId = Model.Content.GetPropertyValue<int>("contactPagePicker");
    if (contactPageId > 0)
    {
        contactPage = Umbraco.TypedContent(contactPageId);
    }
}

<p>
  <a href="@contactPage.Url">@contactPage.Name</a>
</p>
```

Wouldn't it be nice if instead of that you could do:

```html
<p>
    <a href="@Model.Content.ContactPagePicker.Url">@Model.ContactPagePicker.Name</a>
</p>
```

This is possible since 7.6.0 using Models Builder and through the inclusion of [core property value converters](https://our.umbraco.com/projects/developer-tools/umbraco-core-property-value-converters/), a brilliant package by Jeavon.

In order to not break everybody's sites (the results of queries are different when PVCs are enabled) we disabled these PVCs by default.

Umbraco 7.6.0 also came with new pickers that store their data as a [UDI (Umbraco Identifier)](https://our.umbraco.com/Documentation/Reference/Querying/Udi). We wanted to simplify the use of these new pickers and by default we wanted PVCs to always be enabled for those pickers.

Unfortunately we noticed that some new pickers also got their PVCs disabled when the configuration setting was set to false (`<EnablePropertyValueConverters>false</EnablePropertyValueConverters>`) - yet the content picker ignored this setting.

In order to make everything consistent, we made sure that the UDI pickers would always use PVCs in 7.6.2... or so we thought! By accident we reversed the behavior. So when PVCs were enabled, the property would NOT be converted and when PVCs were disabled, the property would be converted after all. This is the exact opposite behavior of 7.6.2. Oops!
So we have fixed this now in 7.6.3.

This issue only affects:

* Multi Node Tree Picker
* Related Links
* Member Picker

If you have already upgraded to 7.6.2 and fixed some of your queries for those three data types then you might have to fix them again in 7.6.3.

We promise it's the last time you need to update them. We're sorry for the inconvenience.

## Version 7.6.0

There are a few breaking changes in 7.6.0 be sure to **[read about them here](760-breaking-changes.md)** and [here's the list of these items on the tracker](http://issues.umbraco.org/issues/U4?q=Due+in+version%3A+7.6.0+Backwards+compatible%3F%3A+No+)

The three most important things to note are:

 1. In web.config do NOT change `useLegacyEncoding` to `false` if it is currently set to `true` - changing the password encoding will cause you not being able to log in any more
 2. In umbracoSettings.config leave `EnablePropertyValueConverters` set to `false` - this will help your existing content queries to still work
 3. In tinyMceConfig.config make sure to remove `<plugin loadOnFrontend="true">umbracolink</plugin>` so that the rich text editor works as it should

### Upgrading via NuGet

This is an important one and there was unfortunately not a perfect solution to this. We have removed the UrlRewriting dependency and no longer ship with it, however if you are using it we didn't want to have NuGet delete all of your rewrites. So the good news is that if you are using it, the NuGet upgrade will not delete your rewrite file and everything should continue to work (though you should really be using IIS rewrites!).

However, if you are not using it, **you will get a YSOD after upgrading, here's how to fix it**

Since you aren't using UrlRewriting you will have probably never edited the UrlRewriting file and in which case NuGet will detect that and remove it. However you will need to manually remove these UrlRewriting references from your web.config:

```xml
<section name="urlrewritingnet" restartOnExternalChanges="true" requirePermission="false" type="UrlRewritingNet.Configuration.UrlRewriteSection, UrlRewritingNet.UrlRewriter" />
```

```xml
<urlrewritingnet configSource="config\UrlRewriting.config" />
```

* And remove the following http modules from your web.config:

```xml
<system.web>
<httpModules>
    <add name="UrlRewriteModule" type="UrlRewritingNet.Web.UrlRewriteModule, UrlRewritingNet.UrlRewriter"/>
    ...
</httpModules>
<system.web>
```

and

```xml
<system.webServer>
    <modules>
    <remove name="UrlRewriteModule"/>
    <add name="UrlRewriteModule" type="UrlRewritingNet.Web.UrlRewriteModule, UrlRewritingNet.UrlRewriter"/>
    ...
    </modules>
</system.webServer>
```

#### Forms

Umbraco Forms 6.0.0 has been released to be compatible with Umbraco 7.6, it is a new major version release of Forms primarily due to the strict dependency on 7.6+. If you are using Forms, you will need to update it to version 6.0.0

There is **[important Forms upgrade documentation that you will need to read the here](https://our.umbraco.com/documentation/Add-ons/UmbracoForms/Installation/Version-Specific#version-4-to-version-6)**

#### Courier

Umbraco Courier 3.1.0 has been released to be compatible with Umbraco 7.6. If you are using Courier, you will need to update it to version 3.1.0

## Version 7.4.0

For manual upgrades:

* Copy the new folder `~/App_Plugins/ModelsBuilder` into the site
* Do not forget to merge `~/Config/trees.config` and `~/Config/Dashboard.config` - they contain new and updated entries that are required to be there
  * If you forget `trees.config` you will either not be able to browse the Developer section or you will be logged out immediately when trying to go to the developer section
* You may experience an error saying `Invalid object name 'umbracoUser'` - this can be fixed by [clearing your cookies on localhost](http://issues.umbraco.org/issue/U4-8031)

## Version 7.3.0

Make sure to manually clear your cookies after updating all the files, otherwise you might an error relating to `Umbraco.Core.Security.UmbracoBackOfficeIdentity.AddUserDataClaims()`. The error looks like: `Value cannot be null. Parameter name: value`.

NuGet will do the following for you but if you're upgrading manually:

* Delete `bin/Microsoft.Web.Helpers.dll`
* Delete `bin/Microsoft.Web.Mvc.FixedDisplayModes.dll`
* Delete `bin/System.Net.Http.dll`
* Delete `bin/System.Net.Http.*.dll` (all dll files starting with `System.Net.Http`) **EXCEPT** for `System.Net.Http.Formatting.dll`
* Delete `bin/umbraco.XmlSerializers.dll`
* In your `web.config` file, add this in the `appSetting` section: `<add key="owin:appStartup" value="UmbracoDefaultOwinStartup" />`

Other considerations:

* WebApi has been updated, normally you don’t have to do anything unless you have custom webapi configuration:
  * See this article if you are using `WebApiConfig.Register`: [https://www.asp.net/mvc/overview/releases/how-to-upgrade-an-aspnet-mvc-4-and-web-api-project-to-aspnet-mvc-5-and-web-api-2](https://www.asp.net/mvc/overview/releases/how-to-upgrade-an-aspnet-mvc-4-and-web-api-project-to-aspnet-mvc-5-and-web-api-2)
  * You need to update your `web.config` file to have the correct WebApi version references - this should be done by doing a compare/merge of your `~/web.config` file with the `~/web.config` file in the release
* MVC has been updated to MVC5
  * You need to update your `web.config` file to have the correct MVC version references - this should be done by doing a compare/merge of your `~/web.config` file with the `~/web.config` file in the release
  * The upgrader will take care of updating all other web.config’s (in all other folders, for example, the `Views` and `App_Plugins` folders) to have the correct settings
  * For general ASP.NET MVC 5 upgrade details see: [https://www.asp.net/mvc/overview/releases/how-to-upgrade-an-aspnet-mvc-4-and-web-api-project-to-aspnet-mvc-5-and-web-api-2](https://www.asp.net/mvc/overview/releases/how-to-upgrade-an-aspnet-mvc-4-and-web-api-project-to-aspnet-mvc-5-and-web-api-2)
* It is not required that you merge the changes for the Examine index paths in the ExamineIndex.config file. However, if you do, your indexes will be rebuilt on startup because Examine will detect that they don’t exist at the new location.
* It's highly recommended to clear browser cache - the ClientDependency version is automatically bumped during install which should force browser cache to refresh, however in some edge cases this might not be enough.

## Version 7.2.0

* Copy in the /Views/Partials/Grid (contains Grid rendering views)

## Version 7.1.0

* Remove the /Install folder.

## Version 7.0.1 to 7.0.2

* There was an update to the /umbraco/config/create/ui.xml which needs to be manually updated, the original element had this text:

```xml
<nodeType alias="users">
    <header>User</header>
    <usercontrol>/create/simple.ascx</usercontrol>
    <tasks>
    <create assembly="umbraco" type="userTasks" />
    <delete assembly="umbraco" type="userTasks" />
    </tasks>
</nodeType>
```

* The &lt;usercontrol&gt; value has changed to: **/create/user.ascx**, this is a required change otherwise creating a new user will not work.
* There is a breaking change to be aware of, full details can be found [here](https://umbraco.com/blog/heads-up-breaking-change-coming-in-702-and-62/).

## Version 7.0.0 to 7.0.1

* Remove all uGoLive dlls from /bin
  * These are not compatible with V7
* Move appSettings/connectionStrings back to web.config
  * If you are on 7.0.0 you should migrate these settings into the web.config instead of having them in separate files in /config/
  * The keys in config/AppSettings.config need to be moved back to the web.config `<appSettings>` section and similarly, the config/ConnectionStrings.config holds the Umbraco database connections in v7.0.0 and they should be moved back to the web.config `<connectionStrings>` section.
  * /config/AppSettings.config and /config/ConnectionString.config can be removed after the contents have been moved back to web.config. (Make backups)
* Delete all files in ~/App_Data/TEMP/Razor/*
  * Related to issues with razor macros

## Version 6 to 7.0.0

Read and follow [the full v7 upgrade guide](upgrading-to-v7.md)

## Version 4.10.x/4.11.x to 6.0.0

* If your site was ever a version between 4.10.0 and 4.11.4 and you have upgraded to 6.0.0 install the [fixup package](https://our.umbraco.com/projects/developer-tools/path-fixup) and run it after the upgrade process is finished.
* The DocType Mixins package is **NOT** compatible with v6+ and will cause problems in your document types.

## Version 4.10.x to 4.11.x

* If your site was ever a version between 4.10.0 and 4.11.4 install the [fixup package](https://our.umbraco.com/projects/developer-tools/path-fixup) and run it after the upgrade process is finished.

## Version 4.8.0 to 4.10.0

* Delete the bin/umbraco.linq.core.dll file
* Copy the new files and folders from the zip file into your site's folder
  * /App_Plugins
  * /Views
  * Global.asax
* Remove the Config/formHandlers.config file

## Version 4.7.2 to 4.8.0

* Delete the bin/App_Browsers.dll file
* Delete the bin/App_global.asax.dll file
* Delete the bin/Fizzler.Systems.HtmlAgilityPack.dll file
* For people using uComponents 3.1.2 or below, 4.8.0 breaks support for it. Either upgrade to a newer version beforehand or follow the workaround [posted here](https://our.umbraco.com/projects/backoffice-extensions/ucomponents/questionssuggestions/33021-Upgrading-to-Umbraco-48-breaks-support-for-uComponents)

## Version 4.7.1.1 to 4.7.2

* Delete the bin/umbraco.MacroEngines.Legacy.dll file

## Version 4.6.1 to 4.7.1.1

* Delete bin/Iron*.dll (all dll files starting with "Iron")
* Delete bin/RazorEngine*.dll (all dll files starting with "RazorEngine")
* Delete bin/umbraco.MacroEngines.Legacy.dll
* Delete bin/Microsoft.Scripting.Debugging.dll
* Delete bin/Microsoft.Dynamic.dll
