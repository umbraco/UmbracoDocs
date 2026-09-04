---
description: >-
  A list of the built-in Umbraco property editors and their corresponding index
  value types in Umbraco Search
hidden: true
---

# Indexed values of built-in property editors

The following list shows how the [built-in Umbraco property editors](https://docs.umbraco.com/umbraco-cms/fundamentals/backoffice/property-editors/built-in-umbraco-property-editors) are indexed for Umbraco Search.

Some property editors are excluded because they generate more noise than value in the index. For example, color and media pickers have been omitted.

| Property editor               | Indexed as       | Notes                                                                                                                                                                                         |
| ----------------------------- | ---------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Umbraco.BlockGrid`           | (see below)      |                                                                                                                                                                                               |
| `Umbraco.BlockList`           | (see below)      |                                                                                                                                                                                               |
| `Umbraco.CheckBoxList`        | `Keyword`        |                                                                                                                                                                                               |
| `Umbraco.ContentPicker`       | `Keyword`        | Indexes the ID (key) of the picked content.                                                                                                                                                   |
| `Umbraco.DateTime`            | `DateTimeOffset` |                                                                                                                                                                                               |
| `Umbraco.Decimal`             | `Decimal`        |                                                                                                                                                                                               |
| `Umbraco.DropDown.Flexible`   | `Keyword`        |                                                                                                                                                                                               |
| `Umbraco.Integer`             | `Integer`        |                                                                                                                                                                                               |
| `Umbraco.Label`               | (see below)      |                                                                                                                                                                                               |
| `Umbraco.MarkdownEditor`      | `Text`           | Same as `Umbraco.RichText`                                                                                                                                                                    |
| `Umbraco.MultiNodeTreePicker` | `Keyword`        | Indexes the IDs (keys) of the picked content. Does not index values when configured to pick media or members.                                                                                 |
| `Umbraco.MultipleTextstring`  | `Text`           |                                                                                                                                                                                               |
| `Umbraco.MultiUrlPicker`      | `Text`           | Indexes the names (titles) of the picked links.                                                                                                                                               |
| `Umbraco.Plain.String`        | `Text`           |                                                                                                                                                                                               |
| `Umbraco.Plain.Decimal`       | `Decimal`        |                                                                                                                                                                                               |
| `Umbraco.Plain.Integer`       | `Integer`        |                                                                                                                                                                                               |
| `Umbraco.Plain.DateTime`      | `DateTimeOffset` |                                                                                                                                                                                               |
| `Umbraco.RadioButtonList`     | `Keyword`        |                                                                                                                                                                                               |
| `Umbraco.RichText`            | `Text`           | Headings (H1, H2, H3) are indexed with individual relevance, all other tags as lowest relevance text. If the property contains blocks, they are indexed in the same way as the block editors. |
| `Umbraco.Slider`              | `Decimal`        | For range slides, both the lower and upper bounds are indexed.                                                                                                                                |
| `Umbraco.Tags`                | `Keyword`        | In addition, all tags for all properties are accumulated into a dedicated system field (see [system fields](system-fields.md)).                                                               |
| `Umbraco.TextArea`            | `Text`           | Indexed as lowest relevance text.                                                                                                                                                             |
| `Umbraco.TextBox`             | `Text`           | Indexed as lowest relevance text.                                                                                                                                                             |
| `Umbraco.TrueFalse`           | `Integer`        | Indexed as 1 for `true`, 0 for `false`.                                                                                                                                                       |

### Special case: `Umbraco.BlockGrid` and `Umbraco.BlockList`

Block editors contain other property editors. These will iterate their contained properties and aggregate their index values. As such, a single block editor property value can potentially index as all value types.

### Special case: `Umbraco.Label`

The label editor indexes as either `Integer`, `Decimal`, `DateTimeOffset` or `Text`, depending on the Data Type configuration (the property editor value type).
