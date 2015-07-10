#Upgrading to version 7

*This document should be used as a reference, not a step by step guide. Upgrading will largely depend on what version of Umbraco you are currently running, what packages you have installed and the many aspects of your own Umbraco installation.*

The [standard upgrade instructions](http://our.umbraco.org/documentation/Installation/Upgrading/general) still apply to this process as well.

##Backup

Just like with any upgrade, it is critical that you back up your website and database before upgrading. There are several database changes made during install and you cannot revert an v7 database to a v6 databse.

##.Net 4.5

Umbraco 7 is built on .Net 4.5, your environment will require this .Net version installed in order to operate.
(Visual Studio users may require 2012 or higher)

##HTML 5 browser support

Umbraco 7 requires browsers with proper html 5 support, these include Chrome, Firefox, IE10+

##Breaking changes

Before you upgrade you should read the list of breaking changes, in some cases you may need to change some of your codebase if code has been removed from the core or if one of these breaking changes direclty affects your install.

See: [List of breaking changes](http://our.umbraco.org/contribute/releases/700) 

##Examine

You should rebuild all Examine indexes after the upgrade

##Xml Cache rebuild

You should re-generate the xml cache, you can do this by visiting this url:

/Umbraco/dialogs/republish.aspx?xml=true

and follow the prompts

##Configuration changes

It is recommended that you use a Diff tool to compare the configuration file changes with your own current configuration files.

* /web.config updates 
	* Details are listed here: [http://issues.umbraco.org/issue/U4-2900](http://issues.umbraco.org/issue/U4-2900)
	* You'll need to compare the new v7 web.config with your current web.config, here's a quick reference of what needs to change:		
		* remove &lt;section name="BaseRestExtensions"&gt; section
		* remove &lt;section name="FileSystemProviders"&gt; section
		* remove &lt;sectionGroup name="system.web.webPages.razor"&gt; section
		* remove &lt;<FileSystemProviders &gt; element
		* remove &lt;BaseRestExtensions &gt; element
		* remove &lt;add key="umbracoUseMediumTrust" &gt; element
		* remove &lt;system.web.extensions&gt; element
		* removes &lt;xhtmlConformance &gt; element
		* remove &lt;system.codedom&gt; element
		* remove &lt;compilation&gt; <strong>&lt;assemblies *&gt;</strong> &lt;/compilation&gt;
		* remove &lt;system.web.webPages.razor &gt; element 
		* new &lt;sectionGroup name="umbracoConfiguration"&gt; section
		* new &lt;umbracoConfiguration&gt; element  
		* ensure that the **targetFramework="4.5"** is added to the &lt;httpRuntime&gt; element
		* add &lt;add key="ValidationSettings:UnobtrusiveValidationMode" value="None" /&gt; to the appSettings element
* /config/clientdependency.config changes
	* remove &lt;add name="CanvasProvider" /&gt; element 
* /views/web.config updates
* new /macroscripts/web.config
* /config/umbracoSettings.config 
	* Umbraco is now shipped with minimal settings but the [full settings](http://our.umbraco.org/documentation/Using-Umbraco/Config-files/umbracoSettings/) are still available
	* umbracoSettings is now a true ASP.Net configuration section [http://issues.umbraco.org/issue/U4-58](http://issues.umbraco.org/issue/U4-58)
	* remove the &lt;EnableCanvasEditing&gt; element
	* remove the &lt;webservices&gt; element
* Removed xsltExtensions.config
	* [http://issues.umbraco.org/issue/U4-2742](http://issues.umbraco.org/issue/U4-2742)
* /config/applications.config and /config/trees.config have some icon paths and names updated, you will need to merge the new changes into your existing config files.
* /config/tinyMceConfig.config
	* The inlinepopups is compatible supported in v7, you will need to remove this element: &lt;plugin loadOnFrontend="true"&gt;inlinepopups&lt;/plugin&gt; 
	* The plugins element that is shipped with v7 looks like:

		    <plugins>
		        <plugin loadOnFrontend="true">code</plugin>  
		        <plugin loadOnFrontend="true">paste</plugin>
		        <plugin loadOnFrontend="true">umbracolink</plugin>
		        <plugin loadOnFrontend="true">anchor</plugin>
		        <plugin loadOnFrontend="true">charmap</plugin>
		        <plugin loadOnFrontend="true">table</plugin>
		        <plugin loadOnFrontend="true">lists</plugin>
		    </plugins>
	* You will need to merge the changes from the new tinyMceConfig file into yours, the 'command' elements that have changed are: JustifyCenter, JustifyLeft, JustifyRight, JustifyFull, umbracomacro, umbracoembed, mceImage, subscript, superscript, styleselect
	* Remove the command: mceSpellCheck
* /config/dashboard.config
	* You will need to merge the changes from the new dashboard.config into yours. Some of the original dashboard entries that were shipped with v6 have been replaced or removed. 

##Medium Trust

Umbraco 7+ will no longer support medium trust environments. There are now some assemblies used in the core that do not support medium trust but are used extensively. Plugin scanning now also allows for scanning Umbraco's internal types which requires full trust.

##Events

###Tree events

Content, media, members and data type trees will no longer raise the legacy tree events (based on BaseTree). It is recommended to change all tree event handlers to use the new tree events which fire for every tree in Umbraco including legacy trees. The new tree events are static events and are found on the class `Umbraco.Web.Trees.TreeControllerBase`:

* MenuRendering
* RootNodeRendering
* TreeNodesRendering
 
###Legacy business logic events

The content, media, member and data type editors have been re-created and are solely using the new Umbraco Services data layer. This means that operations performed in the back office will no longer raise the legacy business logic events (for example, events based on `umbraco.cms.businesslogic.web.Document`). It is recommended to change your event handlers to subsribe to the new Services data layer events. These are static events and are found in the various services, for example:  `Umbraco.Core.Services.ContentService.Saved`

##Property Editors

Legacy property editors (pre v7) will not work with Umbraco v7. During the upgrade installation process Umbraco will generate a report showing you which legacy property editors are installed, these will all be converted to a readonly Label property editor. No data loss will occur but you'll need to re-assign your existing data types to use a new compatible v7 property editor.

All Umbraco core property editors shipped will be mapped to their equivalent v7 editors except the following editors 
which have not been completed for v7.0:

* Image cropper

###Related links property editor and xslt
Since this is an advanced prop editor the data format has changed from xml to json this shouldn't have any effect when retrieving the data from razor but if you are outputting related links data with xslt you'll need to update your xslt snippet. Making use of the new library method umbraco.library:JsonToXml and taking into account that the xml structure has also slightly changed.

###Guid -> Alias mapping

There are several database changes made in v7, one of which is the change of referencing a property editor from a GUID to a string alias. If you have a legacy property editor that you'd like to map to a new v7 property editor you can add your custom GUID -> Alias map during application startup. Do do this you'd add your map with this method: `Umbraco.Core.PropertyEditors.LegacyPropertyEditorIdToAliasConverter.CreateMap`

##Parameter Editors

Legacy parameter editors (pre v7) will not work with Umbraco v7. If Umbraco detects a legacy parameter editor alias that does not map to a real v7 parameter editor it will simply render a textbox in its place. You will need to update your macros to use a compatible v7 parameter editor for those that aren't supported.

Previously parameter editors were registered in an Umbraco database table: `cmsMacroPropertyType` which no longer exists. Parameter editors in v7 are plugins just like property editors. During the v7 upgrade installation process it will update the new `cmsMacroProperty.editorAlias` column with the previous parameter editor alias. During this process it will look into the `Umbraco.Core.PropertyEditors.LegacyParameterEditorAliasConverter` for a map between a legacy alias to a new v7 alias.

If you have custom legacy parameter editors and want to map them during install to new v7 parmater editor aliases you can modify this mapping during application startup using this method: `Umbraco.Core.PropertyEditors.LegacyParameterEditorAliasConverter.CreateMap`

##Database changes

All database changes will be taken care of during the upgrade installation process.

For database change details see (including all child tasks):

* [http://issues.umbraco.org/issue/U4-2886](http://issues.umbraco.org/issue/U4-2886)
* [http://issues.umbraco.org/issue/U4-3015](http://issues.umbraco.org/issue/U4-3015)

##Tags

*(see above for the database updates made for better tag support)*

* Tags can now be assigned to a node’s property not just a node
* Multiple tag controls can exist on one page with different data
	* The legacy API does **not** support this, the legacy API will effectively just add/update/remove tags for the first property found for the document that is assigned a tag property editor.
* There is a new ITagService which can be used to query tags
	* Querying for tags in a view (front-end) can be done via the new TagQuery class which is exposed from the UmbracoHelper. For example: `@Umbraco.TagQuery.GetTagsForProperty`
	
##Packages

You should check with the package creator for all installed packages to ensure they are compatible with v7.

##For package developers

We see common errors that we cannot fix for you, but have recommendations you can follow to fix: 

###TypeFinder

Could not load type 'umbraco.BusinessLogic.Utils.TypeFinder' from assembly 'businesslogic, Version=1.0.5031.21336, Culture=neutral, PublicKeyToken=null'.

The TypeFinder has been deprecated since 4.10 and is now found under Umbraco.Core.TypeFinder

### Javascript in menu actions

While you need to have JavaScript  inside menu actions to trigger a response, it is highly recommended that you use the recommended UmbClientMgr methods, and not try to override parent.right.document and similar tricks to get to the right-hand frame.

###Use the recommended Umbraco uicontrols

If you have a webforms page in the backoffice, it is recommended that you use the built-in asp.net controls to render panels, panes, tabviews, properties and so on. If you use the raw html, or try to style it to match the backoffice, you will get out of sync, therefore, follow the guidelines set by Umbraco's internal editors and use the asp.net custom controls for UI.
 
	
 
 
