# Structure

_Belle introduces a new default location for all client files like JS, CSS and related assets._


## /umbraco/Client
The mother folder, containing all sub folders related to the client. If you have any files related to the UI
or a UI component, they should be placed here and afterwards loaded with clientdependency.

### Subfolders
Inside /umbraco/Client, is a number of subfolders, which are described below


## /Lib
Library folder, which contains all 3rd party libraries used by umbraco. such as JQuery and TinyMCE. Each library
has it's own folder, but beyond that it follows the library's own folder structure for easy copy-paste updates.
All files in the this folder must remain *unchanged* as these will get upgraded with new versions and no-one will check
for customizations. 

## /Modules
Contains individual UI components, grouped by a namespace and module name. A module is basicly a group of js, css and image files, used 
by this module, so everything is in one place for that specific component, and thereby easier to load dependencies into the browser.
*The /Modules folder is devided into subfolders:*


#### /Modules/Umbraco.Application
Modules used by the application in generel, such as the tree, search, popovers and so on.

#### /Modules/Umbraco.PropertyEditors
Modules used by individual property editors / data types. Like the Content Picker, Date picker etc. Each module contains the js and css files for
that module, but not any dependencies, these are still located in /Lib

#### /Modules/Umbraco.Editors
Modules / classes used by individual editor pages, so for exemple editTemplates.aspx has all its clientside logic in 
/Modules/Umbraco.Editors/Settings/editTemplate.js

#### /Modules/Umbraco.Utills
Utility classes which are available on all pages

#### /Modules/Umbraco.System
Underlying System classes currently used for the NameSpace Manager and History manager

## /Css
Contains the main stylesheets for the application, currently it contains: 

- *login.css* only used on the login.aspx page
- *application.css* which is only used by the main window
- *page.css* added on all pages
- *dialog.css* only added to pages which uses the dialog masterpage

*Also: * the default stylesheet from twitter bootstrap is available on all pages

For anything else, css should be placed in its relevant module folder *Notice:* this is not the case YET, but what we try to get to.

## /Js
This folder is legacy and will at some point be removed, please use /modules if you need to add some javascript to the application to hook into
the page load event use /modules/umbraco.editors/default.js which is loaded on all pages and /Modules/Umbraco.Application/window to hook into the
general application window.

## /img
For any non-css images