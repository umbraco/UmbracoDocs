---
versionFrom: 8.0.0
meta.Title: "Umbraco Heartcore GraphQL Property Editors"
meta.Description: "Documentation for Umbraco Heartcore GraphQL property editors and their types"
---

# Property Editors

This page contains a list of all the built-in Umbraco Property Editors and their GraphQL types. The type may depend on the configuration of the specific Property Editor.

## [Contentment] Data List

**Editor Alias**: `Umbraco.Community.Contentment.DataList`<br>

**List editor**: `Checkbox List` or `Tags`<br>
**GraphQL Type**: `[String]`<br>
**Can be used for filtering**: `true`

**Other editors configured with `Multiple selection`**: `true`<br>
**GraphQL Type**: `[String]`<br>
**Can be used for filtering**: `true`

**Other editors and configuration**: `true`<br>
**GraphQL Type**: `String`<br>
**Can be used for filtering**: `true`

## Block List

**Editor Alias**: `Umbraco.BlockList`<br>
**GraphQL Type**: [`BlockListItem`](../Schema-Generation/#block-list-item)
**Can be used for filtering**: `false`

## Checkbox

**Editor Alias**: `Umbraco.TrueFalse`<br>
**GraphQL Type**: `Boolean`<br>
**Can be used for filtering**: `true`

## Checkbox list

**Editor Alias**: `Umbraco.CheckBoxList`<br>
**GraphQL Type**: `[String]`<br>
**Can be used for filtering**: `false`

## Color Picker

**Editor Alias**: `Umbraco.ColorPicker`

**Include labels?**: `true`<br>
**GraphQL Type**: [`PickedColor`](../Schema-Generation/#picked-color)

**Include labels?**: `false`<br>
**GraphQL Type**: `String`<br>
**Can be used for filtering**: `true`

## Content Picker

**Editor Alias**: `Umbraco.ContentPicker`<br>
**GraphQL Type**: [`Content`](../Schema-Generation/#content)<br>
**Can be used for filtering**: `true

## Date/Time

**Editor Alias**: `Umbraco.DateTime`<br>
**GraphQL Type**: `DateTime`<br>
**Can be used for filtering**: `true`

## Decimal

**Editor Alias**: `Umbraco.Decimal`<br>
**GraphQL Type**: `Decimal`<br>
**Can be used for filtering**: `true`

## Dropdown

**Editor Alias**: `Umbraco.DropDown.Flexible`<br>
**GraphQL Type**: `[String]`<br>
**Can be used for filtering**: `true`

## Email address

**Editor Alias**: `Umbraco.EmailAddress`<br>
**GraphQL Type**: `String`<br>
**Can be used for filtering**: `true`

## File upload

**Editor Alias**: `Umbraco.UploadField`<br>
**GraphQL Type**: `String`<br>
**Can be used for filtering**: `true`

## Form Picker

**Editor Alias**: `UmbracoForms.FormPicker`<br>
**GraphQL Type**: [`JSON`](../Schema-Generation/#json)<br>
**Can be used for filtering**: `false`

## Google Maps Single Marker

**Editor Alias**: `Our.Umbraco.GMaps`<br>
**GraphQL Type**: [`OurUmbracoGMaps`](../Schema-Generation/#our-umbraco-gmaps)<br>
**Can be used for filtering**: `false`

## Grid layout

**Editor Alias**: `Umbraco.Grid`<br>
**GraphQL Type**: [`JSON`](../Schema-Generation/#json)<br>
**Can be used for filtering**: `false`

## Image Cropper

**Editor Alias**: `Umbraco.ImageCropper`<br>
**GraphQL Type**: [`ImageCropper`](../Schema-Generation/#image-cropper)<br>
**Can be used for filtering**: `false`

## Label

**Editor Alias**: `Umbraco.Label`<br>
**GraphQL Type**: `String`<br>
**Can be used for filtering**: `true`

## List view

**Editor Alias**: `Umbraco.ListView`<br>
:::note
This editor is not supported and will not be present in the generated schema
:::

## Markdown Editor

**Editor Alias**: `Umbraco.MarkdownEditor`<br>
**GraphQL Type**: [`HTML`](../Schema-Generation/#html)<br>
**Can be used for filtering**: `false`

## Media Picker

**Editor Alias**: `Umbraco.MediaPicker3`

**Pick Multiple items**: `true`<br>
**GraphQL Type**: [`[MediaWithCrops]`](../Schema-Generation/#media-with-crops)<br>
**Can be used for filtering**: `false`

**Pick Multiple items**: `false`<br>
**GraphQL Type**: [`MediaWithCrops`](../Schema-Generation/#media-with-crops)<br>
**Can be used for filtering**: `false`

## Media Picker (legacy)

**Editor Alias**: `Umbraco.MediaPicker`

**Pick Multiple items**: `true`<br>
**GraphQL Type**: [`[Media]`](../Schema-Generation/#media)<br>
**Can be used for filtering**: `true`

**Pick Multiple items**: `false`<br>
**GraphQL Type**: [`Media`](../Schema-Generation/#media)<br>
**Can be used for filtering**: `true`

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
**Can be used for filtering**: `false`

**Maximum number of items**: not `1`<br>
**GraphQL Type**: [`[Link]`](../Schema-Generation/#link)
**Can be used for filtering**: `false`

## Multinode Treepicker

**Editor Alias**: `Umbraco.MultiNodeTreePicker`

**Node type**: `Content`<br>
**Maximum number of items**: `1`<br>
**GraphQL Type**: [`Content`](../Schema-Generation/#content)<br>
**Can be used for filtering**: `true`

**Node type**: `Content`<br>
**Maximum number of items**: not `1`<br>
**GraphQL Type**: [`[Content]`](../Schema-Generation/#content)<br>
**Can be used for filtering**: `true`

**Node type**: `Media`<br>
**Maximum number of items**: `1`<br>
**GraphQL Type**: [`Media`](../Schema-Generation/#media)<br>
**Can be used for filtering**: `true`

**Node type**: `Media`<br>
**Maximum number of items**: not `1`<br>
**GraphQL Type**: [`[Media]`](../Schema-Generation/#media)<br>
**Can be used for filtering**: `true`

**Node type**: `Member`<br>
:::note
This editor configuration is not supported and will not be present in the generated schema
:::

## Nested Content

**Editor Alias**: `Umbraco.NestedContent`<br>
**GraphQL Type**: [`[Element]`](../Schema-Generation/#element)<br>
**Can be used for filtering**: `false`

## Numeric

**Editor Alias**: `Umbraco.Integer`<br>
**GraphQL Type**: `Int`
**Can be used for filtering**: `true`

## Radio button List

**Editor Alias**: `Umbraco.RadioButtonList`<br>
**GraphQL Type**: `[String]`
**Can be used for filtering**: `true`

## Repeatable textstrings

**Editor Alias**: `Umbraco.MultipleTextstring`<br>
**GraphQL Type**: `[String]`<br>
**Can be used for filtering**: `true`

## Rich Text Editor

**Editor Alias**: `Umbraco.TinyMCE`<br>
**GraphQL Type**: [`HTML`](../Schema-Generation/#html)<br>
**Can be used for filtering**: `false`

## Slider

**Editor Alias**: `Umbraco.Slider`

**Enable Range**: `true`<br>
**GraphQL Type** [`DecimalRange`](../Schema-Generation/#decimal-range)<br>
**Can be used for filtering**: `false`

**Enable Range**: `false`<br>
**GraphQL Type** `Decimal`<br>
**Can be used for filtering**: `true`

## Tags

**Editor Alias**: `Umbraco.Tags`<br>
**GraphQL Type**: `[String]`<br>
**Can be used for filtering**: `true`

## Textarea

**Editor Alias**: `Umbraco.TextArea`<br>
**GraphQL Type**: `String`<br>
**Can be used for filtering**: `true`

## Textbox

**Editor Alias**: `Umbraco.TextBox`<br>
**GraphQL Type**: `String`<br>
**Can be used for filtering**: `true`

## User Picker

**Editor Alias**: `Umbraco.UserPicker`<br>
:::note
This editor is not supported and will not be present in the generated schema
:::
