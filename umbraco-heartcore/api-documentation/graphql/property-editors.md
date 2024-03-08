---
description: Documentation for Umbraco Heartcore GraphQL property editors and their types
---

# Property Editors

## Supported Property Editors

Below is a list of all the supported built-in Umbraco Property Editors and their GraphQL types. The type may depend on the configuration of the specific Property Editor.

<details>

<summary>[Contentment] Data List</summary>

Editor Alias: `Umbraco.Community.Contentment.DataList`

List editor: `Checkbox List` or `Tags`\
GraphQL Type: `[String]`\
Can be used for filtering: `true`

Other editors configured with `Multiple selection`: `true`\
GraphQL Type: `[String]`\
Can be used for filtering: `true`

Other editors and configuration: `true`\
GraphQL Type: `String`\
Can be used for filtering: `true`

</details>

<details>

<summary>Block Grid</summary>

Editor Alias: `Umbraco.BlockGrid`\
GraphQL Type: [`BlockGrid`](schema-generation.md#block-grid)&#x20;

Can be used for filtering: `false`

</details>

<details>

<summary>Block List</summary>

Editor Alias: `Umbraco.BlockList`\
GraphQL Type: [`BlockListItem`](schema-generation.md#block-list-item)&#x20;

Can be used for filtering: `false`

</details>

<details>

<summary>Checkbox</summary>

Editor Alias: `Umbraco.TrueFalse`\
GraphQL Type: `Boolean`\
Can be used for filtering: `true`

</details>

<details>

<summary>Checkbox list</summary>

Editor Alias: `Umbraco.CheckBoxList`\
GraphQL Type: `[String]`\
Can be used for filtering: `false`

</details>

<details>

<summary>Color Picker</summary>

Editor Alias: `Umbraco.ColorPicker`

Include labels?: `true`\
GraphQL Type: [`PickedColor`](schema-generation.md#picked-color)

Include labels?: `false`\
GraphQL Type: `String`\
Can be used for filtering: `true`

</details>

<details>

<summary>Content Picker</summary>

Editor Alias: `Umbraco.ContentPicker`\
GraphQL Type: [`Content`](schema-generation.md#content)\
Can be used for filtering: `true`

</details>

<details>

<summary>Date/Time</summary>

Editor Alias: `Umbraco.DateTime`\
GraphQL Type: `DateTime`\
Can be used for filtering: `true`

</details>

<details>

<summary>Decimal</summary>

Editor Alias: `Umbraco.Decimal`\
GraphQL Type: `Decimal`\
Can be used for filtering: `true`

</details>

<details>

<summary>Dropdown</summary>

Editor Alias: `Umbraco.DropDown.Flexible`\
GraphQL Type: `[String]`\
Can be used for filtering: `true`

</details>

<details>

<summary>Email address</summary>

Editor Alias: `Umbraco.EmailAddress`\
GraphQL Type: `String`\
Can be used for filtering: `true`

</details>

<details>

<summary>File upload</summary>

Editor Alias: `Umbraco.UploadField`\
GraphQL Type: `String`\
Can be used for filtering: `true`

</details>

<details>

<summary>Form Picker</summary>

Editor Alias: `UmbracoForms.FormPicker`\
GraphQL Type: [`JSON`](schema-generation.md#json)\
Can be used for filtering: `false`

</details>

<details>

<summary>Google Maps Single Marker</summary>

Editor Alias: `Our.Umbraco.GMaps`\
GraphQL Type: [`OurUmbracoGMaps`](schema-generation.md#our-umbraco-gmaps)\
Can be used for filtering: `false`

</details>

<details>

<summary>Grid layout</summary>

The grid editor Data Type in Heartcore is deprecated and will be retired in June 2025 or thereafter. For more information see [this blog post](https://umbraco.com/blog/umbraco-heartcore-update-october-2023#editors).

Editor Alias: `Umbraco.Grid`\
GraphQL Type: [`JSON`](schema-generation.md#json)\
Can be used for filtering: `false`

</details>

<details>

<summary>Image Cropper</summary>

Editor Alias: `Umbraco.ImageCropper`\
GraphQL Type: [`ImageCropper`](schema-generation.md#image-cropper)\
Can be used for filtering: `false`

</details>

<details>

<summary>Label</summary>

Editor Alias: `Umbraco.Label`\
GraphQL Type: `String`\
Can be used for filtering: `true`

</details>

<details>

<summary>Markdown Editor</summary>

Editor Alias: `Umbraco.MarkdownEditor`\
GraphQL Type: [`HTML`](schema-generation.md#html)\
Can be used for filtering: `false`

</details>

<details>

<summary>Media Picker</summary>

Editor Alias: `Umbraco.MediaPicker3`

Pick Multiple items: `true`\
GraphQL Type: [`[MediaWithCrops]`](schema-generation.md#media-with-crops)\
Can be used for filtering: `false`

Pick Multiple items: `false`\
GraphQL Type: [`MediaWithCrops`](schema-generation.md#media-with-crops)\
Can be used for filtering: `false`

</details>

<details>

<summary>Media Picker (legacy)</summary>

Editor Alias: `Umbraco.MediaPicker`

Pick Multiple items: `true`\
GraphQL Type: [`[Media]`](schema-generation.md#media)\
Can be used for filtering: `true`

Pick Multiple items: `false`\
GraphQL Type: [`Media`](schema-generation.md#media)\
Can be used for filtering: `true`

</details>

<details>

<summary>Multi Url Picker</summary>

Editor Alias: `Umbraco.MultiUrlPicker`

Maximum number of items: `1`\
GraphQL Type: [`Link`](schema-generation.md#link) Can be used for filtering: `false`

Maximum number of items: not `1`\
GraphQL Type: [`[Link]`](schema-generation.md#link) Can be used for filtering: `false`

</details>

<details>

<summary>Multinode Treepicker</summary>

Editor Alias: `Umbraco.MultiNodeTreePicker`

Node type: `Content`\
Maximum number of items: `1`\
GraphQL Type: [`Content`](schema-generation.md#content)\
Can be used for filtering: `true`

Node type: `Content`\
Maximum number of items: not `1`\
GraphQL Type: [`[Content]`](schema-generation.md#content)\
Can be used for filtering: `true`

Node type: `Media`\
Maximum number of items: `1`\
GraphQL Type: [`Media`](schema-generation.md#media)\
Can be used for filtering: `true`

Node type: `Media`\
Maximum number of items: not `1`\
GraphQL Type: [`[Media]`](schema-generation.md#media)\
Can be used for filtering: `true`

Node type: `Member`

**Note:** The Member editor configuration is not supported in the Multinode Treeepicker and will not be present in the generated schema.

</details>

<details>

<summary>Nested Content</summary>

Editor Alias: `Umbraco.NestedContent`\
GraphQL Type: [`[Element]`](schema-generation.md#element)\
Can be used for filtering: `false`

</details>

<details>

<summary>Numeric</summary>

Editor Alias: `Umbraco.Integer`\
GraphQL Type: `Int` Can be used for filtering: `true`

</details>

<details>

<summary>Radio button List</summary>

Editor Alias: `Umbraco.RadioButtonList`\
GraphQL Type: `[String]` Can be used for filtering: `true`

</details>

<details>

<summary>Repeatable textstrings</summary>

Editor Alias: `Umbraco.MultipleTextstring`\
GraphQL Type: `[String]`\
Can be used for filtering: `true`

</details>

<details>

<summary>Rich Text Editor</summary>

Editor Alias: `Umbraco.TinyMCE`\
GraphQL Type: [`HTML`](schema-generation.md#html)\
Can be used for filtering: `false`

</details>

<details>

<summary>Slider</summary>

Editor Alias: `Umbraco.Slider`

Enable Range: `true`\
GraphQL Type [`DecimalRange`](schema-generation.md#decimal-range)\
Can be used for filtering: `false`

Enable Range: `false`\
GraphQL Type `Decimal`\
Can be used for filtering: `true`

</details>

<details>

<summary>Tags</summary>

Editor Alias: `Umbraco.Tags`\
GraphQL Type: `[String]`\
Can be used for filtering: `true`

</details>

<details>

<summary>Textarea</summary>

Editor Alias: `Umbraco.TextArea`\
GraphQL Type: `String`\
Can be used for filtering: `true`

</details>

<details>

<summary>Textbox</summary>

Editor Alias: `Umbraco.TextBox`\
GraphQL Type: `String`\
Can be used for filtering: `true`

</details>

## Unsupported Editors

Below is a list of property editors which is not supported in GraphQL and will not be present in the generated schema.

<details>

<summary>List view</summary>

Editor Alias: `Umbraco.ListView`

</details>

<details>

<summary>Member Picker</summary>

Editor Alias: `Umbraco.MemberPicker`

</details>

<details>

<summary>Member Group Picker</summary>

Editor Alias: `Umbraco.MemberGroupPicker`

</details>

<details>

<summary>User Picker</summary>

Editor Alias: `Umbraco.UserPicker`

</details>
