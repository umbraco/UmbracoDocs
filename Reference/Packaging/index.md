# What are package actions?

Package actions are a simple way to perform common tasks while installing packages / nitros. It is XML based and could be compared to for example NAnt tasks. Actions perform small configuration related tasks, which could for example be allowing a document type on another type, moving a document to another location or adding a string to an existing template.
Currently we have 10 actions available. If you need to perform more advanced installation routines, you will have to build a custom installer (.ascx based) or write your own package action using the IPackageAction Interface, which will then automatically be picked up by umbraco.

## Adding actions to a package script

With the build-in packager, it is possible to add the actions you need directly from the UI. Just add <Action> nodes to the textare.
Alternatively the actions can be manually added to the package manifest by adding a <Actions> node containing the package actions xml.

## Standard fields on all actions

- **Undo**, optional, is true by default.
- **Alias**, mandatory, The alias of the package action to be executed
- **Runat**, mandatory, can either be install or uninstall

## Standard elements on all actions

All actions are a <Action> node element (notice the uppercase A)

## Installing. Un-Installing and Undo

In the first version of the package actions, about 10 actions were included, the high number of actions was caused by the fact that every action needed a corresponding uninstall action. So a “**Insert string into template**” action would also need a “**Remove string from template**” action to be un-installable.

This led to a lot of confusion and also opened up the possibility that the actions could be used for evil, (like removing the string `<umbraco:macro` from all templates, would cause quite a bit of havoc.

So in this revised version, an undo attribute has been put on all actions. An action will always contain an undo action which is turned on by default, but can be turned off.

At the same time, all actions which were only actually there to perform uninstall actions have been removed. Depending on community feedback, some of these might be included again.

## Add application

Creates a new application, and adds it to the database.

Alias: addApplication

    <Action runat="install"   
    [undo="false"]   
    alias="addApplication"   
    appName="Application Name"   
    appAlias="myApplication"   
    appIcon="application.gif"/>

## Add application tree

Creates a new application tree, and adds it to the db.

Alias: addApplicationTree

    <Action runat="install"
    [undo="false"]
    alias="addApplicationTree"
    silent="[true/false]"
    initialize="[true/false]"
    sortOrder="1"
    applicationAlias="appAlias"
    treeAlias="myTree"
    treeTitle="My Tree"
    iconOpened="folder_o.gif"
    iconClosed="folder.gif"
    assemblyName="umbraco"
    treeHandlerType="treeClass"
    action="alert('you clicked');"/>

## Add dashboard section

Creates a new dashboard section. Uses the standard dashboard xml as a child node of the action itself.

You will need to locate this file in the `/WebSiteRoot/config/Dashboard.config`

Alias: addDashboardSection

    <Action runat="install" [undo="false"]
    alias="addDashboardSection"
    dashboardAlias="MyDashboardSection">
    <section>
    <areas>
    <area>default</area>
    <area>content</area>
    </areas>
    <tab caption="Last Edits">
    <control>/usercontrols/latestEdits.ascx</control>
    <control>/usercontrols/PostCreate.ascx</control>
    </tab>
    <tab caption="Create blog post">
    <control>/usercontrols/new.ascx</control>
    </tab>
    </section>
    </Action>

## Allow document type

Allows a document type to be created below another document type. Ex: allow TextPage to be allowed under HomePage.

Alias: allowDocumentType

    <Action runat="install"
    alias="allowDocumenttype"
    documentTypeAlias="MyNewDocumentType"
    parentDocumentTypeAlias="HomePage"/>

## Publish root document

Publishes a document located in the root of the website.

Alias: publishRootDocument

    <Action runat="install"
    alias="publishRootDocument"
    documentName="News" />

## Add string to html element

Inserts a string into a specific html element in a specific template. The undo option makes sure that the string can be removed again at uninstall.

Alias: addStringToHtmlElement

*templateAlias: name of the target template.
*htmlElementId: the target html element in the target template
*{nodevalue}: the string to be copied to the target element.
*Position: where to place the string in the element: (can only be end/ beginning)

    <Action runat="install"
    alias="addStringToHtmlElement"
    templateAlias="news"
    htmlElementId="newsSection"
    position="[beginning/end">
    <![CDATA[hello world!]]>
    </Action>

## Community made Package Actions

Richard Soeteman has created the Codeplex project PackageActionsContrib which contains community submitted Package Actions which other developers may find useful.

You can find out more about the package actions contribution project at https://packageactioncontrib.codeplex.com

It is also worth checking the patches section of the project as new package actions have been submitted by other developers that have not yet been integrated into the PackageActionsContrib project that you might find useful.
