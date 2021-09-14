---
versionFrom: 8.0.0
meta.Title: "Default data types in Umbraco"
meta.Description: "Learn about the default data types in Umbraco."
---

# Default Data Types

Here's a list of the default Data Types that come installed with Umbraco. There are plenty more that you can create based on the installed [Property Editors](../../Backoffice/Property-Editors/index.md).

![Umbraco 8 Data Type List](images/default-data-types-8.png)

### Approved Color
Adds a list of approved colors which can be selected by clicking. The approved colors are added as hex values by using the color picker. Optionally you can enable labels to give the colors different names.

### Checkbox list
Displays a list of preset values as a list of checkbox controls. The preset values are modified in the Settings
section under "Data Types" / checkbox list where new items can be added. The value saved is a comma-separated
string of prevalue IDs.

### Content picker
The content picker opens a modal to pick a specific page from the content structure.
The value saved is the selected page's ID.

### Date picker
Displays a calendar UI for selecting dates and time, the value saved is a standard dateTime value,
but with no time information.

### Date picker with time
Displays a calendar UI for selecting dates and time, the value saved is a standard dateTime value.

### Dropdown
Displays a list of preset values as a list where only a single value can be selected. The default Data Type does not contain any prevalues. The value saved is the selected value as a string.

### Dropdown multiple
Displays a list of preset values as a list where multiple values can be selected. The default data type does not contain any prevlaues .The value saved is a comma separated string of prevalue IDs.

### Image Cropper
Allows for the upload and cropping of images by using a focal point. Specific crop definitions can also be added. This data type is used by default on the Image Media Type.

### Label
Is a non-editable control, can only be used to display a present text (string). It can also be used in the
media section to load in values related to the node, such as width, height and file size.

If you want to input something other than a string into a Label, you can use one of the five other Label Data Types: Label (bigint), Label (datetime), Label (decimal), Label (integer) or Label (time). 

If you want to save a long string value for a Label, there is a Value type: Label (Long string) which can be used for that.

### List View - Content
This data type is used by Document Types that are set to display as list views.

### List View - Media
This data type is used by Media Types that are set to display as list views.

### List View - Members
This data type is used by Member Types that are set to display as list views.

### Media Picker
The picker opens a modal to pick a specific media item from the Media tree.
The value saved is the selected media node UDI.

### Member Picker
Displays a dropdown with all available members in. A single member can be selected.
The value saved is the ID of the member.

### Multi URL Picker
This Data Type allows an editor to add an array of links. These can either be internal Umbraco pages external URLs or links to media in the Media section. The Data Type can be configured by limited number of links it is possible to add.

### Multiple Media Picker
The picker opens a modal to pick multiple media item from the Media tree.
The value saved is a comma separated string of media node UDIs.

### Numeric
A textbox to input a numeric value.

### Radiobox
This Data type enables editors to choose from a list of radiobuttons.

### Richtext Editor
The TinyMCE based WYSIWYG editor. This is the standard editor used to edit larger amount of text. The editor has a lot of settings, which can be changed on Richtext editor Data Type in the Settings section. The editor also supports TinyMCE plugins which can be controlled in the configuration file located at `/config/tinyMce.config`.

In the default settings some tags such as bullet list can be used. If you want to use other tags like `h1` or `h2`, you need to add stylesheets.

Create child stylesheets for each tag(`h1` or `h2`) under a base one.
Go to "*Backoffice -> Settings -> Data Types -> Richtext editor*" and associate the Richtext editor with your stylesheet.
Also turn on "Style select" in the toolbar section.

An example of the stylesheet tree is as follows.

<pre>
Stylesheets
-IE7
-IE8
-Style
-RichEdit
--h1
--h2
</pre>

### Tags
A textbox that allows you to use multiple tags on a Document Type. You can specify a Tag Group for this data type, in case you need to use Tags on different sections of your site (i.e  News, Article, Events).

### Textarea
A textarea

### Textstring
A normal HTML input text field

### True/False
A checkbox which saves either 0 or 1, depending on the checkbox being checked or not. A common use is to create a property with the special alias 'umbracoNaviHide' and the Data Type True/False to enable editors to hide nodes from appearing in a navigation menu.

### Upload
Adds an upload field, which allows documents or images to be uploaded to Umbraco. This does not add them to the media library, they are added to the document data.
