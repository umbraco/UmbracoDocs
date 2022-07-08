---
versionFrom: 8.0.0
versionTo: 9.0.0
---

# Built-in Umbraco Property Editors

This page contains a list of all the built-in Umbraco property editors and a short description of what they do:

## [Block List Editor](Block-List-Editor)

`Alias: Umbraco.BlockList`

Use Element Types to create a set of Blocks that your editors can use to create content.

## [Toggle (True/False)](True-False)

`Alias: Umbraco.TrueFalse`

A checkbox which saves either 0 or 1, depending on the checkbox being checked or not.

## [Checkbox list](CheckBox-List/index.md)

`Alias: Umbraco.CheckBoxList`

Displays a list of preset values as a list of checkbox controls

## [Color Picker](Color-Picker/index.md)

`Alias: Umbraco.ColorPicker`

Adds a list of approved colours which can be selected by clicking.

## [Content Picker](Content-Picker/index.md)

`Alias: Umbraco.ContentPicker`

The content picker allows the content editor to pick a specific node from the content structure.

## [Date/Time](Date-Time/index.md)

`Alias: Umbraco.DateTime`

Displays a calendar UI for selecting dates and time.

## [Decimal](Decimal/index.md)

`Alias: Umbraco.Decimal`

A configurable number control allowing only numbers including decimals.

## [Dropdown](DropDown/index.md)

`Alias: Umbraco.DropDown.Flexible`

Displays a list of preset values. The content editor can select either a single or multiple values.

## [Email Address](Email-Address)

`Alias: Umbraco.EmailAddress`

A single line textbox only allowing valid email addresses.

## [Eye Dropper Color Picker](Eye-Dropper-Color-Picker/index.md)

`Alias: Umbraco.ColorPicker.EyeDropper`

A full HEX/RGBA color picker, which support alpha transparency.

## [File Upload](File-Upload/index.md)

`Alias: Umbraco.UploadField`

Adds an upload field, which allows documents or images to be uploaded to Umbraco

## [Grid Layout](Grid-Layout/index.md)

`Alias: Umbraco.Grid`

Gives editors a grid layout editor which allows them to insert different types of content in a predefined layout.

## [Image Cropper](Image-Cropper.md)

`Alias: Umbraco.ImageCropper`

Used to crop and resize images to predefined sizes.

## [Label](Label.md)

`Alias: Umbraco.Label`

Label is a non-editable control and can only be used to display a pre-set value.

## [List View](Listview/index.md)

`Alias: Umbraco.ListView`

This control gives the same functionality as the standard listview, but allows you to add the listview as a control on a tab while controlling the other tabs and properties.

## [Markdown Editor](Markdown-Editor/index.md)

`Alias: Umbraco.MarkdownEditor`

[Markdown](https://daringfireball.net/projects/markdown/) is a lightweight markup language with plain text formatting syntax. It is designed so that it can be converted to HTML. The built-in editor allow the user to use the markdown formatting options.

The markdown editor will be interpreted by the Models Builder. Behind the scenes, Umbraco uses the [Markdown NuGet package](https://www.nuget.org/packages/Markdown/).

## [Media Picker](Media-Picker-3/index.md)

`Alias: Umbraco.MediaPicker3`

Media Picker  enables you to select one or more media items from the Media Section. This Property Editor can be configured to only pick certain Media Types and it's possible to define Local Image Crops.

## [Media Picker (Legacy)](Media-Picker/index.md)

`Alias: Umbraco.MediaPicker`

:::note
As of Umbraco 8.14, this Media Picker is legacy. Use the [Media Picker](Media-Picker-3) instead.
:::

The media picker displays the current selected media and provides the option to open the mediaPicker dialog to select existing or upload new media files. There is a setting to enable multiple media items to be selected.

## [Member Group Picker](Member-Group-Picker/index.md)

`Alias: Umbraco.MemberGroupPicker`

## [Member Picker](Member-Picker/index.md)

`Alias: Umbraco.MemberPicker`

## [Multi Url Picker](Multi-Url-Picker/index.md)

`Alias: Umbraco.MultiUrlPicker`

New in Umbraco 8, used to be a package called RJP Multi Url Picker. Replaced Related Links.

## [Multinode Treepicker](Multinode-Treepicker/index.md)

`Alias: Umbraco.MultiNodeTreePicker`

The multinode treepicker data type allows content editors to choose multiple nodes in the content or media trees.

## [Nested Content](Nested-Content/index.md)

`Alias: Umbraco.NestedContent`

The nested content property editor enables you to use Document Types as a schema for list items.

## [Numeric](Numeric/index.md)

`Alias: Umbraco.Integer`

A configurable number control allowing only numbers.

## [Radiobutton List](RadioButton-List/index.md)

`Alias: Umbraco.RadioButtonList`

Pretty much like the name indicates this property editor enables editors to choose from list of radio buttons.

## [Repeatable Textstrings](Multiple-Textbox)

`Alias: Umbraco.MultipleTextstring`

The Repeatable textstrings property editor enables a content editor to make a list of text items

## [Rich Text Editor](Rich-Text-Editor)

`Alias: Umbraco.TinyMCE`

A [tinymce](https://www.tinymce.com/) based rich text editor which is highly configurable. Probably one of the most used controls in Umbraco projects.

## [Slider](Slider/index.md)

`Alias: Umbraco.Slider`

A slider with a number in a certain range.

## [Tags](Tags/index.md)

`Alias: Umbraco.Tags`

A tag control which can be controlled by a certain group of tags.

## [Textarea](Textarea/index.md)

`Alias: Umbraco.TextArea`

A textarea control to input text.

## [Textbox](Textbox/index.md)

`Alias: Umbraco.TextBox`

A normal html input text field.

## [User Picker](User-Picker/index.md)

`Alias: Umbraco.UserPicker`

The easiest way to pick a person from user backend users. See Members for front-end users.
