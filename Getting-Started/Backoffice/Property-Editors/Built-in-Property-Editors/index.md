# Built-in Umbraco v7+ Property Editors

This page contains a list of all the built-in Umbraco  v7+ property editors and a short description of what they do:

## [Checkbox list](CheckBox-List.md)
`Alias: Umbraco.CheckBoxList`

Displays a list of preset values as a list of checkbox controls

## [Color Picker](Color-Picker.md)
`Alias: Umbraco.ColorPickerAlias`

Adds a list of approved colours which can be selected by clicking.

## [Content Picker](Content-Picker2.md)
`Alias: Umbraco.ContentPicker2`

The content picker allows the content editor to pick a specific node from the content structure.

## [(Obsolete) Content Picker](Content-Picker.md)
`Alias: Umbraco.ContentPickerAlias`

Made obsolete with the release of Umbraco v7.6 the content picker allows the content editor to pick a specific node from the content structure.

## [Date](Date.md)
`Alias: Umbraco.Date`

Displays a calendar UI for selecting dates

## [Date/Time](Date-Time.md)
`Alias: Umbraco.DateTime`

Displays a calendar UI for selecting dates and time

## [Dropdown](Dropdown.md)
`Alias: Umbraco.DropDown.Flexible`

Introduced in Umbraco v 7.10. Displays a list of preset values. The content editor can select either a single or multiple values.

## [(Obsolete) Dropdown list](DropDown-List.md)
`Alias: Umbraco.DropDown`

Made obsolete with the release of Umbraco v7.10. Displays a list of preset values. The value saved is a text value.

## [(Obsolete) Dropdown list, publishing keys](DropDown-List-Publishing-Keys.md)
`Alias: Umbraco.DropdownlistPublishingKeys`

Made obsolete with the release of Umbraco v7.10. Displays a list of preset values as a list. The value saved is a prevalue ID

## [(Obsolete) Dropdown list multiple](DropDown-List-Multiple.md)
`Alias: Umbraco.DropDownMultiple`

Made obsolete with the release of Umbraco v7.10. Displays a list of preset values where multiple can be selected. The value saved is a CSV of the text values.

## [(Obsolete) Dropdown list multiple, publish keys](DropDown-List-Multiple-Publish-Keys.md)
`Alias: Umbraco.DropdownlistMultiplePublishKeys`


Made obsolete with the release of Umbraco v7.10. Displays a list of preset values where multiple can be selected. The value saved is a CSV of prevalue ids.

## Email address
`Alias: Umbraco.EmailAddress`

A single line textbox only allowing valid email addresses.

## File upload
`Alias: Umbraco.UploadField`

Adds an upload field, which allows documents or images to be uploaded to Umbraco

## Folder Browser
`Alias: Umbraco.FolderBrowser`

Used mainly with container Media Types, the Folder Browser displays a list of thumbnail images.

## [Grid Layout](Grid-Layout.md)
`Alias: Umbraco.Grid`

New to v7.2, gives editors a grid layout editor which allows them to insert different types of content in a predefined layout.

## [Image Cropper](Image-Cropper.md)
`Alias: Umbraco.ImageCropper`

Used to crop and resize images to predefined sizes. Available from V7.1

## Label
`Alias: Umbraco.NoEdit`

Label is a non-editable control, can only be used to display a pre-set text.

## Legacy Media Picker
`Alias: Umbraco.MediaPicker`

The legacy media picker opens a simple dialogue to pick a specific media item from the media tree. The value saved is the selected media ID.

## List View
`Alias: Umbraco.ListView`

This control gives the same functionality as the standard listview, but allows you to add the listview as a control on a tab while controlling the other tabs and properties.

## Macro container
`Alias: Umbraco.MacroContainer`

The Macro container was in the early days the only built-in way to allow repeated content out of the box.  It allows a content editor to add multiple blocks.  Each block is one of the selected Macro's, wrapping an xslt, usercontrols or Macro Partial.
Today there are other options to have repeated content like [Nested Content](Nested-Content.md), [Grid Layout](Grid-Layout.md) and many other controls in different packages.

## Markdown editor
`Alias: Umbraco.MarkdownEditor`

[Markdown](https://daringfireball.net/projects/markdown/) is a lightweight markup language with plain text formatting syntax. It is designed so that it can be converted to HTML.  The built-in editor allow the user to use the markdown formatting options.

The markdown editor will be interpreted by the Models Builder. Behind the scenes, Umbraco uses the [Markdown NuGet package](https://www.nuget.org/packages/Markdown/).

## [Media Picker](Media-Picker2.md)
`Alias: Umbraco.MediaPicker2`

The media picker displays the current selected media and provides the option to open the mediaPicker dialog to select existing or upload new media files. There is a setting to enable multiple media items to be selected.

## [(Obsolete) Media Picker](Media-Picker.md)
`Alias: Umbraco.MultipleMediaPicker`

Made obsolete with the release of Umbraco v7.6 the media picker displays the current selected media and provides the option to open the mediaPicker dialog to select existing or upload new media files. There is a setting to enable multiple media items to be selected.

## Member Group Picker
`Alias: Umbraco.MemberGroupPicker`

## [Member Picker](Member-Picker.md)
`Alias: Umbraco.MemberPicker`

## [Multinode Treepicker](Multinode-Treepicker2.md)
`Alias: Umbraco.MultiNodeTreePicker2`

The multinode treepicker data type allows content editors to choose multiple nodes in the content or media trees.

## [(Obsolete) Multinode Treepicker](Multinode-Treepicker.md)
`Alias: Umbraco.MultipleTextstring`

Made obsolete with the release of Umbraco v7.6 the multinode treepicker data type allows content editors to choose multiple nodes in the content or media trees.

## [Multiple Textbox](Multiple-Textbox.md)
`Alias: Umbraco.TextboxMultiple`

The Multiple Textbox property editor enables a content editor to make a list of text items

## [Nested Content](Nested-Content.md)
`Alias: Umbraco.NestedContent`

New to v7.7, the nested content property editor enables you to use Document Types as a schema for list items.

## Numeric
`Alias: Umbraco.Integer`

A configurable number control allowing only numbers.

## [Radio button list](RadioButton-List.md)
`Alias: Umbraco.RadioButtonList`

Pretty much like the name indicates this property editor enables editors to choose from list of radio buttons.

## [Related Links](Related-Links2.md)
`Alias: Umbraco.RelatedLinks`

Related Links allows an editor to easily add an array of links. These can either be internal Umbraco pages or external URLs.

## [(Obsolete) Related Links](Related-Links.md)
`Alias: Umbraco.RelatedLinks2`

Made obsolete with the release of Umbraco v7.6 the related links editor allows an editor to easily add an array of links. These can either be internal Umbraco pages or external URLs.

## Rich Text Editor
`Alias: Umbraco.TinyMCEv3`

A [tinymce](https://www.tinymce.com/) based rich text editor which is highly configurable.  Probably one of the most used controls in Umbraco projects.

## Slider
`Alias: Umbraco.Slider`

A slider with a number in a certain range.

## [Tags](Tags.md)
`Alias: Umbraco.Tags`

A tag control which can be controlled by a certain group of tags.

## [Textarea](Textarea.md)
`Alias: Umbraco.TextboxMultiple`

A simple textarea control to input text.

## [Textbox](Textbox.md)
`Alias: Umbraco.Textbox`

A normal html input text field.

## [True/False](True-False.md)
`Alias: Umbraco.TrueFalse`

A simple checkbox which saves either 0 or 1, depending on the checkbox being checked or not.

## User picker
`Alias: Umbraco.UserPicker`

The easiest way to pick a person from user backend users.  See Members for front-end users.
