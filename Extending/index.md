---
versionFrom: 7.0.0
product: "CMS"
meta.Title: "Learn about extending the functionality of Umbraco"
meta.Description: "This section shows the different ways you can extend Umbraco. From Content Apps to Backoffice tours, and many more."
---

# Extending Umbraco

## [Dashboards](Dashboards/index.md)

A Dashboard is a component for displaying elements on the right-hand side of the backoffice UI area.

## [Sections & Trees](Section-Trees/index.md)

The Umbraco backoffice consists of sections (sometimes referred to as applications) which contain trees. For example, when you load the backoffice you'll see that the 'Content' section contains one tree: the content tree whereas the 'Settings' section contains a number of trees: Stylesheets, Content Types, Media Types, etc...

Both sections and trees can be created to extend Umbraco.

## [Property Editors](Property-Editors/index.md)

A property editor is the editor used to insert content into Umbraco. [See here for definition.](Property-Editors/index.md)

This section will describe how to work with and create Property Editors.

## [Macro Parameter Editors](Macro-Parameter-Editors/index.md)

A Parameter Editor is the editor used to insert values into a [Macro](../Reference/Templating/Macros/index.md).

This section will describe how to work with and create Parameter Editors.

## [Language Files](Language-Files/index.md)

The Umbraco backoffice can be configured so that the user interface runs in the user's native language. This is made possible with community generated language files, if your language is not currently supported, why not help to add support?

## [Backoffice tours](Backoffice-Tours/index.md)

Backoffice tours is the integrated and interactive help for the backoffice.

## [Backoffice UI API Documentation](Backoffice-UI-API-Documentation/)

A library of API Reference documentation.

## [Backoffice Search](Backoffice-Search/)

Extending the Umbraco Backoffice search, customising the fields searched - replacing the searching mechanism.

## [Content Apps](Content-Apps/index.md)

Content Apps are a new concept in v8. Editors can switch from editing 'Content' to accessing contextual information related to the item they are editing.

Content Apps encapsulate companion read-only information relating to the current content item in the Umbraco backoffice.

## [Database](Database/)

Create a custom Database table.

## [Embedded Media Providers](Embedded-Media-Provider/index.md)

Details on how to create a custom Embedded Media Provider to enable editors to embed third party media content into Umbraco via the embed button in the Rich Text Area.

## [FileSystemProviders (IFileSystem)](Custom-File-Systems.md)

Details on implementing virtual file systems for things like media which will allow you to store your files outside of the physical file system (i.e. Cloud based for example).

## [Health Checks](Health-Check)

Developers can create their own Umbraco Health Checks and Health Check notification methods.

## [Packaging](Packages)

Information on the packaging manifest format and how assets should be packaged as a zip file for distribution
