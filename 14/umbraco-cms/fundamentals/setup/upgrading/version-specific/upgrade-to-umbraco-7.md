---
description: >-
  This document should be used as a reference, not a step by step guide.
  Upgrading will largely depend on what version of Umbraco you are currently
  running, what packages you have installed and the many
---

# Upgrade to Umbraco 7

The [standard upgrade instructions](../) still apply to this process as well.

## Backup

It is critical that you back up your website and database before upgrading. There are database changes made during installation and you cannot revert an Umbraco 7 database to an Umbraco 6 database.

## .Net 4.5

Umbraco 7 is built on .Net 4.5 and your development environment will require this version installed in order to operate. Visual Studio users may require 2012 or higher.

## HTML 5 browser support

Umbraco 7 requires browsers with proper HTML 5 support, these include Chrome, Firefox, IE10+

## Breaking changes

Before you upgrade be sure to read the list of breaking changes. This is especially recommended if you have removed or modified code in the core or if one of these breaking changes directly affects your installation.

[See the list of breaking changes](https://our.umbraco.com/contribute/releases/700) for more details.

## Examine

It is recommended to rebuild all Examine indexes after completing the upgrade.

## Xml Cache rebuild

You should re-generate the XML cache. This can be done by following the prompts when visiting the following URL:

`your-domain.com/umbraco/dialogs/republish.aspx?xml=true`

## Configuration changes

It is recommended that you use a Diff tool to compare the configuration file changes with your own current configuration files.

* `/web.config` updates
  * Details are listed here: [https://issues.umbraco.org/issue/U4-2900](https://issues.umbraco.org/issue/U4-2900)
  * You will need to compare the new Umbraco 7 `web.config` with your current `web.config`. Here is a quick reference of what needs to change:
    * Remove the `section name="BaseRestExtensions"` section
    * Remove the `section name="FileSystemProviders"` section
    * Remove the `sectionGroup name="system.web.webPages.razor"` section
    * Remove the `<FileSystemProviders>` element
    * Remove the `BaseRestExtensions` element
    * Remove the `add key="umbracoUseMediumTrust"` element
    * Remove the `system.web.extensions` element
    * Removes the `xhtmlConformance` element
    * Remove the `system.codedom` element
    * Remove the `compilation` assemblies, `/compilation`
    * Remove the `system.web.webPages.razor` element
    * New: `sectionGroup name="umbracoConfiguration"` section
    * New: `umbracoConfiguration` element
    * Ensure that the `targetFramework="4.5"` is added to the `httpRuntime` element
    * Add `add key="ValidationSettings:UnobtrusiveValidationMode" value="None"` to the `appSettings` element
* `/config/clientdependency.config` changes
  * remove `add name="CanvasProvider"` element
* `/views/web.config` updates
* New `macroscripts/web.config`
* `config/umbracoSettings.config`
  * Umbraco is now shipped with minimal settings but the [full settings](https://our.umbraco.com/documentation/Using-Umbraco/Config-files/umbracoSettings/) are still available
  * `umbracoSettings` is now a true ASP.NET configuration section [https://issues.umbraco.org/issue/U4-58](https://issues.umbraco.org/issue/U4-58)
  * Remove the `EnableCanvasEditing` element
  * Remove the `webservices` element
* Removed `xsltExtensions.config`
  * [https://issues.umbraco.org/issue/U4-2742](https://issues.umbraco.org/issue/U4-2742)
* `/config/applications.config` and `/config/trees.config` have some icon paths and names updated. You need to merge the new changes into your existing config files.
* `/config/tinyMceConfig.config`
  * The `inlinepopups` is compatible and supported in Umbraco 7. You need to remove these elements: `plugin loadOnFrontend="true"`, `inlinepopups/plugin`;
  *   The plugins element that is shipped with Umbraco 7 looks like this:

      ```xml
      <plugins>
          <plugin loadOnFrontend="true">code</plugin>
          <plugin loadOnFrontend="true">paste</plugin>
          <plugin loadOnFrontend="true">umbracolink</plugin>
          <plugin loadOnFrontend="true">anchor</plugin>
          <plugin loadOnFrontend="true">charmap</plugin>
          <plugin loadOnFrontend="true">table</plugin>
          <plugin loadOnFrontend="true">lists</plugin>
      </plugins>
      ```

      * You need to merge the changes from the new `tinyMceConfig` file into yours. The `command` elements that have changed are: `JustifyCenter`, `JustifyLeft`, `JustifyRight`, `JustifyFull`, `umbracomacro`, `umbracoembed`, `mceImage`, `subscript`, `superscript`, `styleselect`
      * Remove the command: `mceSpellCheck`
* `/config/dashboard.config`
  * You need to merge the changes from the new `dashboard.config` into yours. Some of the original dashboard entries that were shipped with Umbraco 6 have been replaced or removed.

## Medium Trust

Umbraco 7+ will no longer support medium trust environments. There are now some assemblies used in the core that do not support medium trust but are used extensively. Plugin scanning now also allows for scanning Umbraco's internal types which requires full trust.

## Events

### Tree events

Content, Media, Members, and Data Type trees will no longer raise the legacy tree events (based on BaseTree). It is recommended to change all tree event handlers to use the new tree events that fire for every tree in Umbraco including legacy trees. The new tree events are static events and are found in the class `Umbraco.Web.Trees.TreeControllerBase`:

* `MenuRendering`
* `RootNodeRendering`
* `TreeNodesRendering`

### Legacy business logic events

The Content, Media, Member, and Data Type editors have been re-created and are solely using the new Umbraco Services data layer. This means that operations performed in the backoffice will no longer raise the legacy business logic events (for example, events based on `umbraco.cms.businesslogic.web.Document`). It is recommended to change your event handlers to subscribe to the new Services data layer events. These are static events and are found in the services. For example: `Umbraco.Core.Services.ContentService.Saved`.

## Property Editors

Legacy property editors (pre-Umbraco 7) will not work with Umbraco 7. During the upgrade installation process, Umbraco will generate a report showing you which legacy property editors are installed. These will all be converted to a `readonly` Label property editor. No data loss will occur but you'll need to re-assign your existing data types to use a new compatible Umbraco 7 property editor.

Most Umbraco core property editors shipped will be mapped to their equivalent Umbraco 7 editors. The Image cropper editor has not been completed for v7.0.

### The Related Links property editor and XSLT

Since the Related Links property is an advanced property editor, the data format has changed from XML to JSON. This should not have any effect when retrieving the data from razor. If you are outputting Related Links data with XSLT you will need to update your XSLT snippet. Making use of the new library method `umbraco.library:JsonToXml` and taking into account that the xml structure has also slightly changed.

### GUID -> Alias mapping

One of the database changes made in Umbraco 7 is the change of referencing a property editor from a GUID to a string alias. In order to map a legacy property editor to a new Umbraco 7 version you can add your custom "GUID -> Alias" map during application startup. To do this you would add your map using this method: `Umbraco.Core.PropertyEditors.LegacyPropertyEditorIdToAliasConverter.CreateMap`

## Parameter Editors

Legacy parameter editors (pre-Umbraco 7) will not work with Umbraco 7. If Umbraco detects legacy parameter editor aliases that do not map to a Umbraco 7 parameter editor it will render a textbox in its place. You will need to update your macros to use a compatible Umbraco 7 parameter editor as those that aren't supported.

Previously, parameter editors were registered in an Umbraco database table: `cmsMacroPropertyType` which no longer exists. Parameter editors in Umbraco 7 are plugins like property editors. During the Umbraco 7 upgrade installation process it will update the new `cmsMacroProperty.editorAlias` column with the previous parameter editor alias. During this process it will look into the `Umbraco.Core.PropertyEditors.LegacyParameterEditorAliasConverter` for a map between a legacy alias to a new Umbraco 7 alias.

Custom legacy parameters can be mapped to new Umbraco 7 parameter editor aliases during installation. This can be done by modifying the mapping during application startup using this method: `Umbraco.Core.PropertyEditors.LegacyParameterEditorAliasConverter.CreateMap`.

## Database changes

All database changes will be taken care of during the upgrade installation process.

For database change details see (including all child tasks):

* [Issue U4-2886](https://issues.umbraco.org/issue/U4-2886)
* [Issue U4-3015](https://issues.umbraco.org/issue/U4-3015)

## Tags

See above for the database updates made for better tag support.

* Tags can now be assigned to a nodes property and not only a node
* Multiple tag controls can exist on one page with different data
  * The legacy API does **not** support this, the legacy API will effectively, add/update/remove tags for the first property found for the document that is assigned a tag property editor.
* There is a new ITagService that can be used to query tags
  * Querying for tags in a view (front-end) can be done via the new TagQuery class which is exposed from the UmbracoHelper. For example: `@Umbraco.TagQuery.GetTagsForProperty`

## Packages

You should check with the package creator for all installed packages to ensure they are compatible with Umbraco 7.

## For package developers

We see common errors that we cannot fix for you, but we do have recommendations you can follow to fix them:

### TypeFinder

```none
Could not load type umbraco.BusinessLogic.Utils.TypeFinder from assembly businesslogic, Version=1.0.5031.21336, Culture=neutral, PublicKeyToken=null.
```

The TypeFinder has been deprecated since 4.10 and is now found under `Umbraco.Core.TypeFinder`.

### JavaScript in menu actions

While you need to have JavaScript inside menu actions to trigger a response, it is highly recommended that you use the recommended `UmbClientMgr` methods. You should not try to override `parent.right.document` and similar tricks to get to the right-hand frame.

### Use the recommended Umbraco uicontrols

If you have a webforms page, it is recommended to use the built-in ASP.NET controls to render panels, properties and so on. If you use the raw HTML or try to style it to match the backoffice, you will get out of sync. Follow the guidelines set by Umbraco's internal editors and use the ASP.NET custom controls for UI.
