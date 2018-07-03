# trees.config

The 'trees.config' file contains the configuration for [trees](../../../Extending/Section-Trees/trees.md) that are loaded within each [section](../../../Extending/Section-Trees/sections.md) of the Umbraco Backoffice.

[NB: Trees can also be configured in code](../../../Extending/Section-Trees/trees-v7#creating-trees) and will generate an entry in this file.

(**Troubleshooting Tip**: if you have problems loading a particular tree check that the trees.config or applications.config do not contain duplicate tree/section entries)

## Tree Configuration

Each Tree element defined in trees.config requires the following attributes:

* **alias** - The alias of the tree. to refer to the tree programmatically and the key to use in Language Translation files.
* **title** - The title of the tree.
* **iconClosed** - The icon to display when the tree element is closed.
* **iconOpen** - The icon to display when the tree element has been expanded.
* **application** - The alias of the section/application to load the tree in.
* **sortOrder** - An integer used to determine the position of the tree in a section when multiple trees are defined. 
* **initialize** - Whether the tree should be initialized by default, eg when accessing the section in the backoffice
* **type** - The type of the implementation of the tree in the format: *FullClassName, AssemblyName*


## Example trees.config file

The following trees are configured by default in Umbraco:

    <trees>
      <!--Content-->
      <add initialize="true" sortOrder="0" alias="content" application="content" title="Content" iconClosed="icon-folder" iconOpen="icon-folder" type="Umbraco.Web.Trees.ContentTreeController, umbraco" />
      <add initialize="false" sortOrder="0" alias="contentRecycleBin" application="content" title="Recycle Bin" iconClosed="icon-folder" iconOpen="icon-folder" type="umbraco.cms.presentation.Trees.ContentRecycleBin, umbraco" />
      <!--Media-->
      <add initialize="true" sortOrder="0" alias="media" application="media" title="Media" iconClosed="icon-folder" iconOpen="icon-folder" type="Umbraco.Web.Trees.MediaTreeController, umbraco" />
      <add initialize="false" sortOrder="0" alias="mediaRecycleBin" application="media" title="Recycle Bin" iconClosed="icon-folder" iconOpen="icon-folder" type="umbraco.cms.presentation.Trees.MediaRecycleBin, umbraco" />
      <!--Settings-->
      <add initialize="true" sortOrder="0" alias="documentTypes" application="settings" title="Document Types" iconClosed="icon-folder" iconOpen="icon-folder-open" type="Umbraco.Web.Trees.ContentTypeTreeController, umbraco" />
      <add application="settings" alias="templates" title="Templates" iconClosed="icon-folder" iconOpen="icon-folder-open" type="Umbraco.Web.Trees.TemplatesTreeController, umbraco" initialize="true" sortOrder="1" />
      <add application="settings" alias="partialViews" title="Partial Views" silent="false" initialize="true" iconClosed="icon-folder" iconOpen="icon-folder" type="Umbraco.Web.Trees.PartialViewsTreeController, umbraco" sortOrder="2" />
      <add application="settings" alias="stylesheets" title="Stylesheets" type="umbraco.loadStylesheets, umbraco" iconClosed="icon-folder" iconOpen="icon-folder" sortOrder="3" />
      <add application="settings" alias="stylesheetProperty" title="Stylesheet Property" type="umbraco.loadStylesheetProperty, umbraco" iconClosed="" iconOpen="" initialize="false" sortOrder="0" />
      <add application="settings" alias="scripts" title="Scripts" type="Umbraco.Web.Trees.ScriptTreeController, umbraco" iconClosed="icon-folder" iconOpen="icon-folder" sortOrder="4" />
      <add application="settings" alias="languages" title="Languages" iconClosed="icon-folder" iconOpen="icon-folder-open" type="Umbraco.Web.Trees.LanguageTreeController, umbraco" sortOrder="5" />
      <add application="settings" alias="dictionary" title="Dictionary" type="umbraco.loadDictionary, umbraco" iconClosed="icon-folder" iconOpen="icon-folder" sortOrder="6" />
      <add initialize="true" sortOrder="7" alias="mediaTypes" application="settings" title="Media Types" iconClosed="icon-folder" iconOpen="icon-folder-open" type="Umbraco.Web.Trees.MediaTypeTreeController, umbraco" />
      <!--Developer-->
      <add initialize="true" sortOrder="0" alias="packager" application="developer" iconClosed="icon-folder" iconOpen="icon-folder-open" type="Umbraco.Web.Trees.PackagesTreeController, umbraco" />
      <add initialize="true" sortOrder="1" alias="dataTypes" application="developer" title="Data Types" iconClosed="icon-folder" iconOpen="icon-folder" type="Umbraco.Web.Trees.DataTypeTreeController, umbraco" />
      <add initialize="true" sortOrder="2" alias="macros" application="developer" iconClosed="icon-folder" iconOpen="icon-folder-open" type="Umbraco.Web.Trees.MacroTreeController, umbraco" />
      <add application="developer" alias="relationTypes" title="Relation Types" type="umbraco.loadRelationTypes, umbraco" iconClosed="icon-folder" iconOpen="icon-folder" sortOrder="4" />
      <add initialize="true" sortOrder="5" alias="xslt" application="developer" iconClosed="icon-folder" iconOpen="icon-folder-open" type="Umbraco.Web.Trees.XsltTreeController, umbraco" />
      <add application="developer" alias="partialViewMacros" type="Umbraco.Web.Trees.PartialViewMacrosTreeController, umbraco" silent="false" initialize="true" sortOrder="6" title="Partial View Macro Files" iconClosed="icon-folder" iconOpen="icon-folder" />
      <!--Users-->
      <add initialize="true" sortOrder="0" alias="users" application="users" iconClosed="icon-folder" iconOpen="icon-folder-open" type="Umbraco.Web.Trees.UserTreeController, umbraco" />
      <!--Members-->
      <add initialize="true" sortOrder="0" alias="member" application="member" title="Members" iconClosed="icon-folder" iconOpen="icon-folder-open" type="Umbraco.Web.Trees.MemberTreeController, umbraco" />
      <add initialize="true" sortOrder="1" alias="memberTypes" application="member" title="Member Types" iconClosed="icon-folder" iconOpen="icon-folder-open" type="Umbraco.Web.Trees.MemberTypeTreeController, umbraco" />
      <add application="member" sortOrder="2" alias="memberGroups" title="Member Groups" type="umbraco.loadMemberGroups, umbraco" iconClosed="icon-folder" iconOpen="icon-folder" />
      <!--Translation-->
      <add silent="false" initialize="true" sortOrder="1" alias="openTasks" application="translation" title="Tasks assigned to you" iconClosed="icon-folder" iconOpen="icon-folder" type="umbraco.loadOpenTasks, umbraco" />
      <add silent="false" initialize="true" sortOrder="2" alias="yourTasks" application="translation" title="Tasks created by you" iconClosed="icon-folder" iconOpen="icon-folder" type="umbraco.loadYourTasks, umbraco" />
      <!-- Custom entries appear here -->
     
    </trees>


