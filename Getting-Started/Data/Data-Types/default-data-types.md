# Default Data Types #

Here's a list of some of the default Data Type's that come installed with Umbraco. There are plenty more that you can create based on the installed [Property Editors](../../Backoffice/Property-Editors/).

![Umbraco v7.9 Data Type List](images/default-data-types.png)

#### Approved Color ####
Adds a list of approved colours which can be selected by clicking. The approved colours need to be added
as hex values (without the #) in the prevalues field. i.e. cccccc

#### Checkbox list ####
Displays a list of preset values as a list of checkbox controls. The preset values are modified in the developer
section under "data types" / checkbox list where new items can be added. The value saved is a comma-separated
string of prevalue IDs.

#### Content picker ####
The content picker opens a simple modal to pick a specific page from the content structure.
The value saved is the selected page's ID. 

#### Date picker ####
Displays a calendar UI for selecting dates and time, the value saved is a standard dateTime value,
but with no time information.

#### Date picker with time ####
Displays a calendar UI for selecting dates and time, the value saved is a standard dateTime value.

#### Dropdown ####
Displays a list of preset values as a list where only a single can be selected. The default data type does not contain any prevlaues. The value saved is the selected value as a string.

#### Dropdown multiple ####
Displays a list of preset values as a list where multiple values can be selected. The default data type does not contain any prevlaues .The value saved is a comma separated string of prevalue IDs.

#### Image Cropper ####
Allows for the upload and cropping of images by using a focal point. Specific crop definitions can also be added. This data type is used by default on the Image Media Type.

#### Label ####
Is a non-editable control, can only be used to display a present text. It can also be used in the
media section to load in values related to the node, such as width, height and file size.

#### List View - Content ####
This data type is used by Document Types that are set to display as list views. 

#### List View - Media ####
This data type is used by Media Types that are set to display as list views.

#### List View - Members ####
This data type is used by Member Types that are set to display as list views. 

#### Media Picker ####
The picker opens a simple modal to pick a specific media item from the media tree.
The value saved is the selected media node UDI.

#### Multiple Media Picker ####
The picker opens a simple modal to pick a multiple media item from the media tree.
The value saved is a comma separated string of media node UDIs.

#### Member Picker ####
Displays a simple dropdown with all available members in. A single member can be selected.
The value saved is the ID of the member

#### Numeric ####
A simple textbox to input a numeric value.

#### Radiobox ####
This Data type enables editors to choose from list of radiobuttons. 

#### Related Links ####
This datatype allows an editor to easily add an array of links. These can either be internal Umbraco pages or external URLs.

#### Richtext Editor ####
The TinyMCE based wysiwyg editor. This is the standard editor used to edit any larger amount of text. The editor has a lot of settings, which can be changed under the developer section in "data types" / Richtext editor. The editor also supports TinyMCE plugins which can be controlled in the configuration file located at /config/tinyMce.config

In the default settings some tags such as bullet list can be used. If you want to use other tags like h1 or h2, you need to add stylesheets.

Create child stylesheets for each tag(h1 or h2) under a base one.
Go to "Back office->Developer->Data Types->Richtext editor" and associate rich text editor with the base.
Also turn on "styleselect" in the toolbar section.
You can find a new button in the toolbar of the content editor.

An example of the style sheet tree is as follows.

<pre>
Stylesheets
-IE7
-IE8
-Style
-RichEdit
--h1
--h2
</pre>

#### Tags ####
A textbox that allows you to use use multiple tags on a docType. You can specify a TAG Group for this datatype, in case you need to use TAGS on different sections of your site (i.e  News, Article, Events).

#### Textarea ####
A simple textarea

#### Textstring ####
A normal html input text field

#### True/False ####
A simple checkbox which saves either 0 or 1, depending on the checkbox being checked or not. A common use for instance is to create a property with the special alias 'umbracoNaviHide' and the Data-Type True/False to enable editors to hide nodes from appearing in a navigation menu.

#### Upload ####
Adds an upload field, which allows documents or images to be uploaded to Umbraco. This does not add them to the media library, they are simply added to the document data.
