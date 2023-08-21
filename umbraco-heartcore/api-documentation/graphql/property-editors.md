---
description: "Documentation for Umbraco Heartcore GraphQL property editors and their types"
---

# Property Editors

This page contains a list of all the built-in Umbraco Property Editors and their GraphQL types. The type may depend on the configuration of the specific Property Editor.

## \[Contentment] Data List

**Editor Alias**: `Umbraco.Community.Contentment.DataList`


**List editor**: `Checkbox List` or `Tags`\
**GraphQL Type**: `[String]`\
**Can be used for filtering**: `true`

**Other editors configured with `Multiple selection`**: `true`\
**GraphQL Type**: `[String]`\
**Can be used for filtering**: `true`

**Other editors and configuration**: `true`\
**GraphQL Type**: `String`\
**Can be used for filtering**: `true`

## Block List

**Editor Alias**: `Umbraco.BlockList`\
**GraphQL Type**: [`BlockListItem`](schema-generation.md#block-list-item) **Can be used for filtering**: `false`

## Checkbox

**Editor Alias**: `Umbraco.TrueFalse`\
**GraphQL Type**: `Boolean`\
**Can be used for filtering**: `true`

## Checkbox list

**Editor Alias**: `Umbraco.CheckBoxList`\
**GraphQL Type**: `[String]`\
**Can be used for filtering**: `false`

## Color Picker

**Editor Alias**: `Umbraco.ColorPicker`

**Include labels?**: `true`\
**GraphQL Type**: [`PickedColor`](schema-generation.md#picked-color)

**Include labels?**: `false`\
**GraphQL Type**: `String`\
**Can be used for filtering**: `true`

## Content Picker

**Editor Alias**: `Umbraco.ContentPicker`\
**GraphQL Type**: [`Content`](schema-generation.md#content)\
**Can be used for filtering**: \`true

## Date/Time

**Editor Alias**: `Umbraco.DateTime`\
**GraphQL Type**: `DateTime`\
**Can be used for filtering**: `true`

## Decimal

**Editor Alias**: `Umbraco.Decimal`\
**GraphQL Type**: `Decimal`\
**Can be used for filtering**: `true`

## Dropdown

**Editor Alias**: `Umbraco.DropDown.Flexible`\
**GraphQL Type**: `[String]`\
**Can be used for filtering**: `true`

## Email address

**Editor Alias**: `Umbraco.EmailAddress`\
**GraphQL Type**: `String`\
**Can be used for filtering**: `true`

## File upload

**Editor Alias**: `Umbraco.UploadField`\
**GraphQL Type**: `String`\
**Can be used for filtering**: `true`

## Form Picker

**Editor Alias**: `UmbracoForms.FormPicker`\
**GraphQL Type**: [`JSON`](schema-generation.md#json)\
**Can be used for filtering**: `false`

## Google Maps Single Marker

**Editor Alias**: `Our.Umbraco.GMaps`\
**GraphQL Type**: [`OurUmbracoGMaps`](schema-generation.md#our-umbraco-gmaps)\
**Can be used for filtering**: `false`

## Grid layout

**Editor Alias**: `Umbraco.Grid`\
**GraphQL Type**: [`JSON`](schema-generation.md#json)\
**Can be used for filtering**: `false`

## Image Cropper

**Editor Alias**: `Umbraco.ImageCropper`\
**GraphQL Type**: [`ImageCropper`](schema-generation.md#image-cropper)\
**Can be used for filtering**: `false`

## Label

**Editor Alias**: `Umbraco.Label`\
**GraphQL Type**: `String`\
**Can be used for filtering**: `true`

## List view

**Editor Alias**: `Umbraco.ListView`
{% hint style="info" %} This editor is not supported and will not be present in the generated schema {% endhint %}

## Markdown Editor

**Editor Alias**: `Umbraco.MarkdownEditor`\
**GraphQL Type**: [`HTML`](schema-generation.md#html)\
**Can be used for filtering**: `false`

## Media Picker

**Editor Alias**: `Umbraco.MediaPicker3`

**Pick Multiple items**: `true`\
**GraphQL Type**: [`[MediaWithCrops]`](schema-generation.md#media-with-crops)\
**Can be used for filtering**: `false`

**Pick Multiple items**: `false`\
**GraphQL Type**: [`MediaWithCrops`](schema-generation.md#media-with-crops)\
**Can be used for filtering**: `false`

## Media Picker (legacy)

**Editor Alias**: `Umbraco.MediaPicker`

**Pick Multiple items**: `true`\
**GraphQL Type**: [`[Media]`](schema-generation.md#media)\
**Can be used for filtering**: `true`

**Pick Multiple items**: `false`\
**GraphQL Type**: [`Media`](schema-generation.md#media)\
**Can be used for filtering**: `true`

## Member Picker

**Editor Alias**: `Umbraco.MemberPicker`
{% hint style="info" %} This editor is not supported and will not be present in the generated schema {% endhint %}

## Member Group Picker

**Editor Alias**: `Umbraco.MemberGroupPicker`
{% hint style="info" %} This editor is not supported and will not be present in the generated schema {% endhint %}

## Multi Url Picker

**Editor Alias**: `Umbraco.MultiUrlPicker`


**Maximum number of items**: `1`\
**GraphQL Type**: [`Link`](schema-generation.md#link) **Can be used for filtering**: `false`

**Maximum number of items**: not `1`\
**GraphQL Type**: [`[Link]`](schema-generation.md#link) **Can be used for filtering**: `false`

## Multinode Treepicker

**Editor Alias**: `Umbraco.MultiNodeTreePicker`

**Node type**: `Content`\
**Maximum number of items**: `1`\
**GraphQL Type**: [`Content`](schema-generation.md#content)\
**Can be used for filtering**: `true`

**Node type**: `Content`\
**Maximum number of items**: not `1`\
**GraphQL Type**: [`[Content]`](schema-generation.md#content)\
**Can be used for filtering**: `true`

**Node type**: `Media`\
**Maximum number of items**: `1`\
**GraphQL Type**: [`Media`](schema-generation.md#media)\
**Can be used for filtering**: `true`

**Node type**: `Media`\
**Maximum number of items**: not `1`\
**GraphQL Type**: [`[Media]`](schema-generation.md#media)\
**Can be used for filtering**: `true`

## Nested Content

**Editor Alias**: `Umbraco.NestedContent`\
**GraphQL Type**: [`[Element]`](schema-generation.md#element)\
**Can be used for filtering**: `false`

## Numeric

**Editor Alias**: `Umbraco.Integer`\
**GraphQL Type**: `Int` **Can be used for filtering**: `true`

## Radio button List

**Editor Alias**: `Umbraco.RadioButtonList`\
**GraphQL Type**: `[String]` **Can be used for filtering**: `true`

## Repeatable textstrings

**Editor Alias**: `Umbraco.MultipleTextstring`\
**GraphQL Type**: `[String]`\
**Can be used for filtering**: `true`

## Rich Text Editor

**Editor Alias**: `Umbraco.TinyMCE`\
**GraphQL Type**: [`HTML`](schema-generation.md#html)\
**Can be used for filtering**: `false`

## Slider

**Editor Alias**: `Umbraco.Slider`

**Enable Range**: `true`\
**GraphQL Type** [`DecimalRange`](schema-generation.md#decimal-range)\
**Can be used for filtering**: `false`

**Enable Range**: `false`\
**GraphQL Type** `Decimal`\
**Can be used for filtering**: `true`

## Tags

**Editor Alias**: `Umbraco.Tags`\
**GraphQL Type**: `[String]`\
**Can be used for filtering**: `true`

## Textarea

**Editor Alias**: `Umbraco.TextArea`\
**GraphQL Type**: `String`\
**Can be used for filtering**: `true`

## Textbox

**Editor Alias**: `Umbraco.TextBox`\
**GraphQL Type**: `String`\
**Can be used for filtering**: `true`

## User Picker

**Editor Alias**: `Umbraco.UserPicker`
{% hint style="info" %} This editor is not supported and will not be present in the generated schema {% endhint %}
