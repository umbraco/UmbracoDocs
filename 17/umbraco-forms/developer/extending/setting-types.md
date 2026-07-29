# Setting Types

Umbraco Forms field, prevalue source and workflow types are defined in C# and include one or more setting values.

These settings are completed by the editor when using the type on their form.

Each setting type can have it's own user interface. So a string can use a text box but a more complicated JSON structure can use a more appropriate user interface.

From Forms 14, each interface is defined as an Umbraco [property editor UI](https://docs.umbraco.com/umbraco-cms/extend-your-project/backoffice-extensions/property-editors/composition/property-editor-ui).

The user interface used for a particular setting is defined by the `View` property:

```csharp
[Umbraco.Forms.Core.Attributes.Setting("Message", View = "Umb.PropertyEditorUi.TextBox")]
public string Message { get; set; }
```

If not specified, the default `Umb.PropertyEditorUi.TextBox` is used.

## How setting values are persisted

Umbraco Forms stores every provider setting as a string. The server model is an `IDictionary<string, string>`. The `View` you choose is rendered using the standard Umbraco CMS property editor UI element:

```html
<umb-property property-editor-ui-alias="Umb.PropertyEditorUi.TextBox"></umb-property>
```

Some editors, such as the text box and text area, already store their value as a plain string. The stored value passes straight to the editor and back, so no conversion is needed.

For editors whose value is not a plain string, such as numeric editors and pickers, a converter is needed. Without one, the raw string passes through unchanged. The value then fails to load into the editor, and can fail server-side validation when saving.

## Setting value converters

A `formsSettingValueConverter` is a client-side component registered against a property editor UI alias. It converts the stored string into the shape the editor expects when loading. It converts the editor value back into a string when saving.

Forms ships converters for the following property editor UI aliases:

| Property editor UI alias                       | Editor                       |
| ---------------------------------------------- | ---------------------------- |
| Umb.PropertyEditorUi.CheckBoxList              | Checkbox list                |
| Umb.PropertyEditorUi.ContentPicker.Source      | Content picker with source   |
| Umb.PropertyEditorUi.Decimal                   | Decimal                      |
| Umb.PropertyEditorUi.Dropdown                  | Dropdown                     |
| Umb.PropertyEditorUi.Integer                   | Numeric (integer)            |
| Umb.PropertyEditorUi.MediaPicker               | Media picker                 |
| Umb.PropertyEditorUi.MultipleTextString        | Multiple text strings        |
| Umb.PropertyEditorUi.RadioButtonList           | Radio button list            |
| Umb.PropertyEditorUi.Slider                    | Slider                       |
| Umb.PropertyEditorUi.TinyMCE                   | Rich text (TinyMCE)          |
| Umb.PropertyEditorUi.Tiptap                    | Rich text (Tiptap)           |
| Umb.PropertyEditorUi.Toggle                    | Toggle                       |
| Umb.PropertyEditorUi.UploadField               | Upload                       |
| Forms.PropertyEditorUi.DocumentTypeFieldPicker | Document Type field picker   |

These editors are tested to round-trip their values correctly when used as a setting `View`. Editors not in the list work only when their value is already a plain string.

To use an editor that is not listed, register your own converter. Read the [Setting Value Converter](adding-a-fieldtype.md#setting-value-converter) section for the steps.

### Rich text settings

For a rich text setting, use the `Forms.PropertyEditorUi.RichText` marker as the `View` rather than a specific editor alias:

```csharp
[Umbraco.Forms.Core.Attributes.Setting("Body text", View = "Forms.PropertyEditorUi.RichText")]
public string BodyText { get; set; }
```

Forms resolves the marker at runtime to the property editor UI of the rich text Data Type configured in `Umbraco:Forms:FieldTypes:RichText:DataTypeId`. It falls back to the default Tiptap editor when the setting is absent. This lets a rich text setting honor a custom editor, such as TinyMCE, instead of being pinned to a single editor.

Forms resolves the marker for field type and workflow type settings only.

### Pickers that store structured values

Pickers that store structured values require a custom setting value converter to work. `Umb.PropertyEditorUi.MultiUrlPicker` is one example. Register a converter that maps the stored string to the picker's value and back.

### Choosing the correct picker alias

Use `Umb.PropertyEditorUi.DocumentPicker` to select a content node. `Umb.PropertyEditorUi.ContentPicker` is not a valid standalone alias and renders nothing.

### Prevalues for numeric editors

`PreValues` is a comma-delimited string. For the Slider, Integer, and Decimal editors, the convention is `min,max,step`:

```csharp
[Umbraco.Forms.Core.Attributes.Setting("Rating", View = "Umb.PropertyEditorUi.Slider", PreValues = "0.0,1.0,0.1,0.5")]
public string Rating { get; set; }
```

The Slider also accepts a fourth value for the default. In the example above the default is `0.5`.

## Built-in setting types

The following setting types are available and are used for the field, prevalue source and workflow types that ship with the package.

Some are defined with the Umbraco CMS and some ship with the Forms package.

| Name                                           | Source | Description                                               | Used in                                       |
| ---------------------------------------------- | ------ | --------------------------------------------------------- | --------------------------------------------- |
| Umb.PropertyEditorUi.CheckBoxList              | CMS    | Uses multiple checkboxes for entry                        |                                               |
| Umb.PropertyEditorUi.CodeEditor                | CMS    | Uses a code editor                                        |                                               |
| Umb.PropertyEditorUi.ContentPicker.Source      | CMS    | Uses a content picker with the option for XPath entry     | The "Save as Umbraco node" workflow           |
| Umb.PropertyEditorUi.DocumentPicker            | CMS    | Uses a content picker                                     |                                               |
| Umb.PropertyEditorUi.Dropdown                  | CMS    | Used for selection from a list of options                 |                                               |
| Umb.PropertyEditorUi.Integer                   | CMS    | Uses numerical text box for entry                         |                                               |
| Umb.PropertyEditorUi.MediaEntityPicker         | CMS    | Uses a media item picker for entry                        | The "Send email with XSLT template" workflow  |
| Umb.PropertyEditorUi.MultipleTextString        | CMS    | Uses multiple text boxes for entry                        |                                               |
| Umb.PropertyEditorUi.RadioButtonList           | CMS    | Uses multiple radio buttons for entry                     |                                               |
| Umb.PropertyEditorUi.Slider                    | CMS    | Uses a slider for range input                             | The "reCAPTCHAv3" field type                  |
| Umb.PropertyEditorUi.TextArea                  | CMS    | Uses a multiline textbox for entry                        |                                               |
| Umb.PropertyEditorUi.TextBox                   | CMS    | Uses a single-line textbox for entry                      |                                               |
| Umb.PropertyEditorUi.Tiptap                    | CMS    | Uses a rich text editor for input                         | The default editor for `Forms.PropertyEditorUi.RichText` |
| Umb.PropertyEditorUi.Toggle                    | CMS    | Uses a single checkbox for entry                          |                                               |
| Umb.PropertyEditorUi.UploadField               | CMS    | Used for selection of a file                              | The "Text file" prevalue source               |
| Forms.PropertyEditorUi.DataTypePicker          | Forms  | Uses a datatype picker                                    | The "Umbraco prevalues" prevalue source       |
| Forms.PropertyEditorUi.DocumentTypePicker      | Forms  | Uses a Document Type picker                               | The "Umbraco nodes" prevalue source           |
| Forms.PropertyEditorUi.DocumentTypeFieldPicker | Forms  | Uses to select fields from a Document Type                | The "Umbraco nodes" prevalue source           |
| Forms.PropertyEditorUi.DocumentMapper          | Forms  | Used for mapping of fields from a Document Type           | The "Save as Umbraco node" workflow           |
| Forms.PropertyEditorUi.EmailTemplatePicker     | Forms  | Used for selection of an email template                   | The "Send email with Razor template" workflow |
| Forms.PropertyEditorUi.FieldMapper             | Forms  | Used to map fields from a form to required aliases        | The "Send to URL" workflow                    |
| Forms.PropertyEditorUi.Password                | Forms  | Uses password text box for entry                          |                                               |
| Forms.PropertyEditorUi.RichText                | Forms  | Uses the rich text editor configured via `Umbraco:Forms:FieldTypes:RichText:DataTypeId` (Tiptap by default) | The "Rich text" field type and the "Send email with Razor template" workflow |
| Forms.PropertyEditorUi.StandardFieldMapper     | Forms  | Used to map system fields from a form to required aliases | The "Send to URL" workflow                    |
| Forms.PropertyEditorUi.TextWithFieldPicker     | Forms  | Uses a single-line textbox/form field list for entry      |                                               |

Most of the above setting types are used in one or more field, prevalue source and workflow types available with Umbraco Forms. For the less common ones, a usage has been indicated in the table.

## Additional setting types

Some types we don't use within the package, but we make available for developers to use when creating their own types.

For example `Forms.PropertyEditorUi.TextWithFieldPicker`. This offers the option of text field entry or the selection of a field from the form. This can be useful in workflows where you need to reference the value of a specific field.

![Text with field picker](../../.gitbook/assets/text-with-field-picker.png)

## Setting properties

Beyond `Name`, `Description`, and `View`, the `Setting` attribute supports other properties.

```csharp
[Setting("My Setting", Description = "Help text for the setting", View = "Umb.PropertyEditorUi.TextBox", SupportsPlaceholders = true, DisplayOrder = 10)]
public virtual string? MySetting { get; set; }
```

- `SupportsPlaceholders` is a flag indicating whether the setting can contain ["magic string" placeholders](../magic-strings.md) and controls whether they are parsed on rendering.

- `HtmlEncodeReplacedPlaceholderValues` takes effect only if `SupportsPlaceholders` is `true`. It controls whether the replaced placeholder values should be HTML encoded (as is necessary for rendering within content from a rich text editor).

- `SupportsHtml` is a flag indicating whether the setting can contain HTML content. When set to `true` it will be treated as HTML content when the value is read from the Forms delivery API.

- `IsMandatory` if set to `true` will provide client-side validation in the backoffice to ensure the value is completed.

- `DisplayOrder` - controls the order settings appear in relative to each other in the backoffice.

## Default values

Default values for settings can be defined in code using one of two approaches.

### Approach 1: Using a property initializer

```csharp
[Setting("Minimum")]
public virtual string? Min { get; set; } = "1";
```

### Approach 2: Using the `DefaultValue` attribute property

```csharp
[Setting("Minimum", DefaultValue = "1")]
public virtual string? Min { get; set; }
```

If both are provided, the `DefaultValue` attribute property takes precedence over the property initializer.

These code-based defaults provide an alternative to [configuring default values via `appsettings.json`](../configuration/README.md#settingscustomization). If a value is configured in `appsettings.json`, it takes precedence over any code-based default.

## Settings when inheriting

When creating a field or other provider type, you might choose to inherit from an existing class. This could be if one of the types provided with Umbraco Forms almost meets your needs but you want to make some changes.

All setting properties for the Forms provider types are marked as `virtual`, so you can override them and change the setting values:

```csharp
[Setting("My Setting", Description = "My custom help text for the setting", View = "Umb.PropertyEditorUi.TextBox", SupportsPlaceholders = true, DisplayOrder = 10)]
public override string? MySetting { get; set; }
```

If you want to hide a setting in your derived class you can use the `IsHidden` property:

```csharp
[Setting("My Setting", IsHidden = true)]
public override string? MySetting { get; set; }
```

## Translations

Setting labels and descriptions can be translated via language files. If no client-side localization is provided, the values provided server-side in the `Setting` attribute's `Name` and `Description` properties will be used.

Each different type of extension for Forms uses a different root value in the localization file:

- Data sources - `formProviderDataSources`
- Export types - `formProviderExportTypes`
- Field types - `formProviderFieldTypes`
- Prevalue sources - `formProviderPrevalueSources`
- Recordset actions - `formRecordSetActions`
- Workflows - `formProviderWorkflows`

For a full worked example, including registering the language file, see the [Language Files](adding-a-fieldtype.md#language-files) section of the field type tutorial.

## Creating a setting type

If none of the [built-in setting types](#built-in-setting-types) fit, you can register your own property editor UI to use as a `View`. This works the same way as for any other Umbraco property editor.

Since Forms stores every setting as a string, you'll need a **setting value converter** if your editor's value isn't a plain string. See [How setting values are persisted](#how-setting-values-are-persisted).

For a complete example, see the [Setting Value Editor](adding-a-fieldtype.md#setting-value-editor) and [Setting Value Converter](adding-a-fieldtype.md#setting-value-converter) sections of the field type tutorial. It builds a custom editor and converter, including manifests, registration, and what each converter method does.