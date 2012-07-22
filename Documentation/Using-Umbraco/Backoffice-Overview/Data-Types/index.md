#Data-Types#
##Default Data-Types##
###Approved Color###
Adds a list of approved colours which can be selected by clicking. The approved colours need to be added 
as hex values (without the #) in the prevalues field. i.e. cccccc
###Checkbox list###
Displays a list of preset values as a list of checkbox controls. The preset values are modified in the developer 
section under "data types" / checkbox list where new items can be added. The value saved is a commasepareted 
string of prevalue IDs, which is easiliest processed with xslt. (umbraco.library:GetPrevalue())
###Content picker###
The content picker opens a simple modal to pick a specific page from the content structure. 
The value saved is the selected page's ID. This ID can be used in xslt with umbraco.library:GetXmlNodeById(ID) 
to get the page's content
###Date picker with time###
Displays a calendar UI for selecting dates and time, the value saved is a standard dateTime value
###Date picker###
Displays a calendar UI for selecting dates and time, the value saved is a standard dateTime value, 
but with no time information.
###Dropdown multiple###
Displays a list of preset values as a list where multiple values can be selected. The preset values are 
modified in the developer section under "data types" / Dropdown multple where new items can be added. 
The value saved is a commasepareted string of prevalue IDs, which is easiliest processed with xslt. 
(umbraco.library:GetPrevalue())
###Dropdown###
Displays a list of preset values as a list where only a single can be selected. 
The preset values are modified in the developer section under "data types" / Dropdown multple where 
new items can be added. The value saved is the selected value as a string.
###Folder Browser###
###Label###
Is a non-editable control, can only be used to display a present text. It can also be used in the 
media section to load in values related to the node, such as width, height and file size.
###Media Picker###
The content picker opens a simple modal to pick a specific media item from the media tree. 
The value saved is the selected media node ID. This ID can be used in xslt with 
umbraco.library:GetMedia(ID) to get the media items xml data
###Member Picker###
Displays a simple dropdown with all available members in. A single member can be selected. 
The value saved is the ID of the member
###Numeric###
A simple textbox to imput a numeric value.
###Radiobox###
###Related Links###
This datatype allows an editor to easily add an array of links. These can either be internal Umbraco pages or external URLs.
###Richtext Editor###
The TinyMCE based wysiwyg editor. This is the standard editor used to edit any larger amount of text. The editor has a lot of settings, which can be changed under the developer section in "data types" / Richtext editor. The editor also supports TinyMCE plugins which can be controlled in the configuration file located at /config/tinyMce.config
###Simple Editor###
A very scaled down editor which only has bold, italic and link - It does not render the HTML live like the richtext editor, but shows the raw HTML and simply surrounds the selected text with the limited HTML tag buttons at the top.
###Tags###
A textbox that allows you to use use multiple tags on a docType - This is what is used on Blog4Umbraco and is perfect if you need to categorise data.  You can specify a TAG Group when creating new versions of this datatype, in case you need to use TAGS on different sections of your site (i.e  News, Article, Events).
###Textbox multiple###
A simple textarea control to import text
###Textstring###
A normal html input text field
###True/False###
A simple checkbox which saves either 0 or 1, depending on the checkbox being checked or not. A common use for instance is to create a property with the special alias 'umbracoNaviHide' and the Data-Type True/False to enable editors to hide nodes from appearing in a navigation menu.
###Ultimate picker###
###Upload###
Adds an upload field, which allows documents or images to be uploaded to umbraco. This does nto add them to the media library, they are simply added to the document data.
##Custon Data-Types##
If what you're after is not included in the Default Data-Types, you can create a custom Data-Type. Go to the Developer section and right click the Data Types node to create a new custom Data-Type. Reference your custom Data-Type to a [Property Editor](../Property-Editors/index.md). Now you can select your custom Data-Type in the Type dropdown of a Document Type property.


 