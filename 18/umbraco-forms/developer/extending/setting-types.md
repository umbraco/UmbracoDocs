# Setting Types

Umbraco Forms field, prevalue source and workflow types are defined in C# and include one or more setting values.

These settings are completed by the editor when using the type on their form.

Each setting type can have it's own user interface. So a string can use a text box but a more complicated JSON structure can use a more appropriate user interface.

From Forms 14, each interface is defined as an Umbraco [property editor UI](https://docs.umbraco.com/umbraco-cms/customizing/property-editors/composition/property-editor-ui).

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
| Umb.PropertyEditorUi.Tiptap                    | CMS    | Uses a rich text editor for input                         | The "Send email" workflows                    |
| Umb.PropertyEditorUi.Toggle                    | CMS    | Uses a single checkbox for entry                          |                                               |
| Umb.PropertyEditorUi.UploadField               | CMS    | Used for selection of a file                              | The "Text file" prevalue source               |
| Forms.PropertyEditorUi.DataTypePicker          | Forms  | Uses a datatype picker                                    | The "Umbraco prevalues" prevalue source       |
| Forms.PropertyEditorUi.DocumentTypePicker      | Forms  | Uses a Document Type picker                               | The "Umbraco nodes" prevalue source           |
| Forms.PropertyEditorUi.DocumentTypeFieldPicker | Forms  | Uses to select fields from a Document Type                | The "Umbraco nodes" prevalue source           |
| Forms.PropertyEditorUi.DocumentMapper          | Forms  | Used for mapping of fields from a Document Type           | The "Save as Umbraco node" workflow           |
| Forms.PropertyEditorUi.EmailTemplatePicker     | Forms  | Used for selection of an email template                   | The "Send email with Razor template" workflow |
| Forms.PropertyEditorUi.FieldMapper             | Forms  | Used to map fields from a form to required aliases        | The "Send to URL" workflow                    |
| Forms.PropertyEditorUi.Password                | Forms  | Uses password text box for entry                          |                                               |
| Forms.PropertyEditorUi.StandardFieldMapper     | Forms  | Used to map system fields from a form to required aliases | The "Send to URL" workflow                    |
| Forms.PropertyEditorUi.TextWithFieldPicker     | Forms  | Uses a single-line textbox/form field list for entry      |                                               |

Most of the above setting types are used in one or more field, prevalue source and workflow types available with Umbraco Forms. For the less common ones, a usage has been indicated in the table.

## Additional setting types

Some types we don't use within the package, but we make available for developers to use when creating their own types.

For example `Forms.PropertyEditorUi.TextWithFieldPicker`. This offers the option of text field entry or the selection of a field from the form. This can be useful in workflows where you need to reference the value of a specific field.

![Text with field picker](../../.gitbook/assets/text-with-field-picker.png)

## Creating a setting type

It's also possible to define your own setting type using a combination of server and client-side code.

Read how do this in the article on [adding a field type](adding-a-fieldtype.md#field-settings).
