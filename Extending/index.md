---
versionFrom: 7.0.0
---

# Extending Umbraco

## [Backoffice tours](Backoffice-Tours/index.md)

Backoffice tours is the integrated and interactive help for the backoffice

## [Dashboards](Dashboards/index.md)

A Dashboard is a component for displaying elements on the right-hand side of the backoffice UI area.

## [Sections & Trees](Section-Trees/index.md)

The Umbraco backoffice consists of sections (sometimes referred to as applications) which contain trees. For example, when you load the backoffice you'll see that the 'Content' section contains one tree: the content tree whereas the 'Settings' section contains a number of trees: Stylesheets, Content Types, Media Types, etc...

Both sections and trees can be created to extend Umbraco.

## [Property Editors](Property-Editors/index.md)

A property editor is the editor used to insert content into Umbraco. [See here for definition.](Property-Editors/index.md)

This section will describe how to work with and create Property Editors.

## [Server variables & URLs](version7-assets.md)

Information on extending Umbraco, details such as dealing with server variables, service URLs, JavaScript and CSS assets, etc....

## [Macro Parameter Editors](Macro-Parameter-Editors/index.md)

A Parameter Editor is the editor used to insert values into a [Macro](../reference/templating/macros/index.md).

This section will describe how to work with and create Parameter Editors.

## [Language Files](Language-Files/index.md)

The Umbraco backoffice can be configured so that the user interface runs in the user's native language. This is made possible with community generated language files, if your language is not currently supported, why not help to add support?

## [Health Checks](Health-Check)

Developers can create their own Umbraco Health Checks and Health Check notification methods.

## Packaging

Information on the packaging manifest format and how assets should be packaged as a zip file for easy distribution
**(coming soon)**

## [Custom file systems (IFileSystem)](Custom-File-Systems.md)

Details on implementing virtual file systems for things like media which will allow you to store your files outside of the physical file system (i.e. Cloud based for example)

## [Embedded Media Providers](Embedded-Media-Provider/index.md)

Details on how to create a custom Embedded Media Provider to enable editors to embed third party media content into Umbraco via the embed button in the Rich Text Area.
