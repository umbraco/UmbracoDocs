---
versionFrom: 8.0.0
meta.Title: "Umbraco Heartcore GraphQL Property Editors"
meta.Description: "Documentation for Umbraco Heartcore GraphQL property editors and their types"
---

# Property Editors

This page contains a list of all the built-in Umbraco Property Editors and their GraphQL types. The type may depend on the configuration of the specific Property Editor.

## Checkbox

**Editor Alias**: `Umbraco.TrueFalse`<br>
**GraphQL Type**: `Boolean`

## Checkbox list

**Editor Alias**: `Umbraco.ChecxBoxList`<br>
**GraphQL Type**: `[String]`

## Color Picker

**Editor Alias**: `Umbraco.ColorPicker`

**Include labels?**: `true`<br>
**GraphQL Type**: [`PickedColor`](../Schema-Generation/#picked-color)

**Include labels?**: `false`<br>
**GraphQL Type**: `String`

## Content Picker

**Editor Alias**: `Umbraco.ContentPicker`<br>
**GraphQL Type**: [`Content`](../Schema-Generation/#content)

## Date/Time

**Editor Alias**: `Umbrace.DateTime`<br>
**GraphQL Type**: `DateTime`

## Decimal

**Editor Alias**: `Umbrace.Decimal`<br>
**GraphQL Type**: `Decimal`

## Dropdown

**Editor Alias**: `Umbraco.DropDown.Flexible`<br>
**GraphQL Type**: `[String]`

## Email address

**Editor Alias**: `Umbraco.EmailAddress`<br>
**GraphQL Type**: `String`

## File upload

**Editor Alias**: `Umbraco.UploadField`<br>
**GraphQL Type**: `String`

## Form Picker

**Editor Alias**: `UmbracoForms.FormPicker`<br>
**GraphQL Type**: [`JSON`](../Schema-Generation/#json)

## Grid layout

**Editor Alias**: `Umbraco.Grid`<br>
**GraphQL Type**: [`JSON`](../Schema-Generation/#json)

## Image Cropper

**Editor Alias**: `Umbraco.ImageCropper`<br>
**GraphQL Type**: [`ImageCropper`](../Schema-Generation/#image-cropper)

## Label

**Editor Alias**: `Umbraco.Label`<br>
**GraphQL Type**: `String`

## List view

**Editor Alias**: `Umbraco.ListView`<br>
:::note
This editor is not supported and will not be present in the generated schema
:::

## Markdown Editor

**Editor Alias**: `Umbraco.MarkdownEditor`<br>
**GraphQL Type**: [`HTML`](../Schema-Generation/#html)

## Media Picker

**Editor Alias**: `Umbraco.MediaPicker`

**Pick Multiple items**: `true`<br>
**GraphQL Type**: [`[Media]`](../Schema-Generation/#media)

**Pick Multiple items**: `false`<br>
**GraphQL Type**: [`Media`](../Schema-Generation/#media)

## Member Picker

**Editor Alias**: `Umbraco.MemberPicker`<br>
:::note
This editor is not supported and will not be present in the generated schema
:::

## Member Group Picker

**Editor Alias**: `Umbraco.MemberGroupPicker`<br>
:::note
This editor is not supported and will not be present in the generated schema
:::

## Multi Url Picker

**Editor Alias**: `Umbraco.MultiUrlPicker`<br>

**Maximum number of items**: `1`<br>
**GraphQL Type**: [`Link`](../Schema-Generation/#link)

**Maximum number of items**: not `1`<br>
**GraphQL Type**: [`[Link]`](../Schema-Generation/#link)

## Multinode Treepicker

**Editor Alias**: `Umbraco.MultiNodeTreePicker`

**Node type**: `Content`<br>
**Maximum number of items**: `1`<br>
**GraphQL Type**: [`Content`](../Schema-Generation/#content)

**Node type**: `Content`<br>
**Maximum number of items**: not `1`<br>
**GraphQL Type**: [`[Content]`](../Schema-Generation/#content)

**Node type**: `Media`<br>
**Maximum number of items**: `1`<br>
**GraphQL Type**: [`Media`](../Schema-Generation/#media)

**Node type**: `Media`<br>
**Maximum number of items**: not `1`<br>
**GraphQL Type**: [`[Media]`](../Schema-Generation/#media)

**Node type**: `Member`<br>
:::note
This editor configuration is not supported and will not be present in the generated schema
:::

## Nested Content

**Editor Alias**: `Umbraco.NestedContent`<br>
**GraphQL Type**: [`[Element]`](../Schema-Generation/#element)

## Numeric

**Editor Alias**: `Umbraco.Numeric`<br>
**GraphQL Type**: `Int`

## Radio button List

**Editor Alias**: `Umbraco.RadioButtonList`<br>
**GraphQL Type**: `[String]`

## Repeatable textstrings

**Editor Alias**: `Umbraco.MultipleTextstring`<br>
**GraphQL Type**: `[String]`

## Rich Text Editor

**Editor Alias**: `Umbraco.TinyMCE`<br>
**GraphQL Type**: [`HTML`](../Schema-Generation/#html)

## Slider

**Editor Alias**: `Umbraco.Slider`

**Enable Range**: `true`<br>
**GraphQL Type** [`DecimalRange`](../Schema-Generation/#decimal-range)

**Enable Range**: `false`<br>
**GraphQL Type** `Decimal`

## Tags

**Editor Alias**: `Umbraco.Tags`<br>
**GraphQL Type**: `[String]`

## Textarea

**Editor Alias**: `Umbraco.TextArea`<br>
**GraphQL Type**: `String`

## Textbox

**Editor Alias**: `Umbraco.TextBox`<br>
**GraphQL Type**: `String`

## User Picker

**Editor Alias**: `Umbraco.UserPicker`<br>
:::note
This editor is not supported and will not be present in the generated schema
:::
