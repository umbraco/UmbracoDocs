---
description: >-
  Learn about the different Property Editor UI elements that ship with Umbraco out of the box.

---

# Umbraco Property Editor UI Elements

This document provides a comprehensive list of all Property Editor UI elements registered via manifests (`propertyEditorUi`) available in Umbraco CMS. These elements define the user interface components for property editors used throughout the system.

## Overview

Property Editor UI manifests define how property editors appear and behave in the Umbraco backoffice. Each manifest includes properties like alias, label, icon, group, and configuration settings.

## Property Editor UI Categories

### 1. Text Input Editors

#### Text Box
- **Alias:** `Umb.PropertyEditorUi.TextBox`
- **Icon:** `icon-autofill`
- **Group:** `common`
- **Schema:** `Umbraco.TextBox`
- **Read-only Support:** ✅
- **Location:** `/packages/property-editors/text-box/manifests.ts`
- **Settings:**
  - `inputType` - Configure input type (text, email, url, etc.)

#### Email
- **Alias:** `Umb.PropertyEditorUi.EmailAddress`
- **Icon:** `icon-message`
- **Group:** `common`
- **Schema:** `Umbraco.EmailAddress`
- **Read-only Support:** ✅
- **Location:** `/packages/property-editors/text-box/manifests.ts`
- **Settings:**
  - `inputType` - Input type configuration

#### Text Area
- **Alias:** `Umb.PropertyEditorUi.TextArea`
- **Icon:** `icon-edit`
- **Group:** `common`
- **Schema:** `Umbraco.TextArea`
- **Read-only Support:** ✅
- **Location:** `/packages/property-editors/textarea/manifests.ts`
- **Settings:**
  - `rows` - Number of rows to display

### 2. Boolean/Toggle Editors

#### Toggle
- **Alias:** `Umb.PropertyEditorUi.Toggle`
- **Icon:** `icon-checkbox`
- **Group:** `common`
- **Schema:** `Umbraco.TrueFalse`
- **Read-only Support:** ✅
- **Location:** `/packages/property-editors/toggle/manifests.ts`
- **Settings:**
  - `default` - Preset value
  - `showLabels` - Show on/off labels
  - `labelOn` - Custom "on" label
  - `labelOff` - Custom "off" label
  - `ariaLabel` - Screen reader label

### 3. Number Editors

#### Integer
- **Alias:** `Umb.PropertyEditorUi.Integer`
- **Icon:** `icon-autofill`
- **Group:** `common`
- **Schema:** `Umbraco.Integer`
- **Read-only Support:** ✅
- **Location:** `/packages/property-editors/number/manifests.ts`

#### Decimal
- **Alias:** `Umb.PropertyEditorUi.Decimal`
- **Icon:** `icon-autofill`
- **Group:** `common`
- **Schema:** `Umbraco.Decimal`
- **Read-only Support:** ✅
- **Location:** `/packages/property-editors/number/manifests.ts`
- **Settings:**
  - `placeholder` - Placeholder text

#### Slider
- **Alias:** `Umb.PropertyEditorUi.Slider`
- **Icon:** `icon-navigation-horizontal`
- **Group:** `common`
- **Schema:** `Umbraco.Slider`
- **Read-only Support:** ✅
- **Location:** `/packages/property-editors/slider/manifests.ts`
- **Settings:**
  - `enableRange` - Enable range selection
  - `initVal1` - Initial value
  - `initVal2` - Second initial value (for range)
  - `step` - Step increments

### 4. Date & Time Editors

#### Date Picker
- **Alias:** `Umb.PropertyEditorUi.DatePicker`
- **Icon:** `icon-time`
- **Group:** `pickers`
- **Schema:** `Umbraco.DateTime`
- **Read-only Support:** ✅
- **Location:** `/packages/property-editors/date-picker/manifests.ts`
- **Settings:**
  - `format` - Date format string

### 5. Color Editors

#### Color Picker
- **Alias:** `Umb.PropertyEditorUi.ColorPicker`
- **Icon:** `icon-colorpicker`
- **Group:** `pickers`
- **Schema:** `Umbraco.ColorPicker`
- **Read-only Support:** ✅
- **Location:** `/packages/property-editors/color-picker/manifests.ts`

#### Eye Dropper Color Picker
- **Alias:** `Umb.PropertyEditorUi.EyeDropper`
- **Icon:** `icon-colorpicker`
- **Group:** `pickers`
- **Schema:** `Umbraco.ColorPicker.EyeDropper`
- **Location:** `/packages/property-editors/eye-dropper/manifests.ts`
- **Settings:**
  - `showAlpha` - Show alpha channel
  - `showPalette` - Show color palette

### 6. Selection/List Editors

#### Dropdown
- **Alias:** `Umb.PropertyEditorUi.Dropdown`
- **Icon:** `icon-list`
- **Group:** `lists`
- **Schema:** `Umbraco.DropDown.Flexible`
- **Read-only Support:** ✅
- **Location:** `/packages/property-editors/dropdown/manifests.ts`

#### Select
- **Alias:** `Umb.PropertyEditorUi.Select`
- **Icon:** `icon-list`
- **Group:** `pickers`
- **Location:** `/packages/property-editors/select/manifests.ts`
- **Settings:**
  - `items` - Add selectable options

#### Radio Button List
- **Alias:** `Umb.PropertyEditorUi.RadioButtonList`
- **Icon:** `icon-target`
- **Group:** `lists`
- **Schema:** `Umbraco.RadioButtonList`
- **Read-only Support:** ✅
- **Location:** `/packages/property-editors/radio-button-list/manifests.ts`

#### Checkbox List
- **Alias:** `Umb.PropertyEditorUi.CheckBoxList`
- **Icon:** `icon-bulleted-list`
- **Group:** `lists`
- **Schema:** `Umbraco.CheckBoxList`
- **Read-only Support:** ✅
- **Location:** `/packages/property-editors/checkbox-list/manifests.ts`
- **Settings:**
  - `items` - Add checkbox options

#### Multiple Text String
- **Alias:** `Umb.PropertyEditorUi.MultipleTextString`
- **Icon:** `icon-ordered-list`
- **Group:** `lists`
- **Schema:** `Umbraco.MultipleTextstring`
- **Read-only Support:** ✅
- **Location:** `/packages/property-editors/multiple-text-string/manifests.ts`

### 7. Content & Document Pickers

#### Content Picker
- **Alias:** `Umb.PropertyEditorUi.ContentPicker`
- **Icon:** `icon-page-add`
- **Group:** `pickers`
- **Schema:** `Umbraco.MultiNodeTreePicker`
- **Read-only Support:** ✅
- **Location:** `/packages/property-editors/content-picker/manifests.ts`
- **Settings:**
  - `filter` - Filter by content type

#### Document Picker
- **Alias:** `Umb.PropertyEditorUi.DocumentPicker`
- **Icon:** `icon-document`
- **Group:** `pickers`
- **Schema:** `Umbraco.ContentPicker`
- **Read-only Support:** ✅
- **Location:** `/packages/documents/documents/property-editors/document-picker/manifests.ts`
- **Settings:**
  - `startNodeId` - Set start node

#### Multi URL Picker
- **Alias:** `Umb.PropertyEditorUi.MultiUrlPicker`
- **Icon:** `icon-link`
- **Group:** `pickers`
- **Schema:** `Umbraco.MultiUrlPicker`
- **Read-only Support:** ✅
- **Location:** `/packages/multi-url-picker/property-editor/manifests.ts`
- **Settings:**
  - `overlaySize` - Overlay size
  - `hideAnchor` - Hide anchor/query string input

### 8. Media Editors

#### Media Picker
- **Alias:** `Umb.PropertyEditorUi.MediaPicker`
- **Icon:** `icon-picture`
- **Group:** `media`
- **Schema:** `Umbraco.MediaPicker3`
- **Read-only Support:** ✅
- **Location:** `/packages/media/media/property-editors/media-picker/manifests.ts`

#### Upload Field
- **Alias:** `Umb.PropertyEditorUi.UploadField`
- **Icon:** `icon-download-alt`
- **Group:** `media`
- **Schema:** `Umbraco.UploadField`
- **Location:** `/packages/media/media/property-editors/upload-field/manifests.ts`

#### Image Cropper
- **Alias:** `Umb.PropertyEditorUi.ImageCropper`
- **Icon:** `icon-crop`
- **Group:** `media`
- **Schema:** `Umbraco.ImageCropper`
- **Location:** `/packages/media/media/property-editors/image-cropper/manifests.ts`

### 9. Rich Content Editors

#### Rich Text Editor (Tiptap)
- **Alias:** `Umb.PropertyEditorUi.Tiptap`
- **Icon:** `icon-browser-window`
- **Group:** `richContent`
- **Schema:** `Umbraco.RichText`
- **Location:** `/packages/tiptap/property-editors/tiptap/manifests.ts`
- **Settings:**
  - `extensions` - Extensions configuration
  - `toolbar` - Toolbar configuration
  - `stylesheets` - Stylesheet selection
  - `dimensions` - Editor dimensions
  - `maxImageSize` - Maximum image size
  - `overlaySize` - Overlay size

#### Markdown Editor
- **Alias:** `Umb.PropertyEditorUi.MarkdownEditor`
- **Icon:** `icon-code`
- **Group:** `richContent`
- **Schema:** `Umbraco.MarkdownEditor`
- **Read-only Support:** ✅
- **Location:** `/packages/markdown-editor/property-editors/markdown-editor/manifests.ts`
- **Settings:**
  - `preview` - Enable preview
  - `defaultValue` - Default value
  - `overlaySize` - Overlay size

#### Code Editor
- **Alias:** `Umb.PropertyEditorUi.CodeEditor`
- **Icon:** `icon-brackets`
- **Group:** `richContent`
- **Schema:** `Umbraco.Plain.String`
- **Location:** `/packages/code-editor/property-editor/manifests.ts`
- **Settings:**
  - `language` - Programming language
  - `height` - Editor height
  - `lineNumbers` - Show line numbers
  - `minimap` - Show minimap
  - `wordWrap` - Enable word wrap

### 10. Block Editors

#### Block List
- **Alias:** `Umb.PropertyEditorUi.BlockList`
- **Icon:** `icon-thumbnail-list`
- **Group:** `lists`
- **Schema:** `Umbraco.BlockList`
- **Read-only Support:** ✅
- **Location:** `/packages/block/block-list/property-editors/block-list-editor/manifests.ts`
- **Settings:**
  - `useSingleBlockMode` - Single block mode
  - `useLiveEditing` - Live editing mode
  - `useInlineEditingAsDefault` - Inline editing as default
  - `maxPropertyWidth` - Maximum property width

#### Block Grid
- **Alias:** `Umb.PropertyEditorUi.BlockGrid`
- **Icon:** `icon-layout`
- **Group:** `richContent`
- **Schema:** `Umbraco.BlockGrid`
- **Read-only Support:** ✅
- **Location:** `/packages/block/block-grid/property-editors/block-grid-editor/manifests.ts`
- **Settings:**
  - `blockGroups` - Block groups configuration
  - `useLiveEditing` - Live editing mode
  - `maxPropertyWidth` - Editor width
  - `createLabel` - Create button label
  - `gridColumns` - Number of grid columns
  - `layoutStylesheet` - Layout stylesheet

### 11. People Pickers

#### User Picker
- **Alias:** `Umb.PropertyEditorUi.UserPicker`
- **Icon:** `icon-user`
- **Group:** `people`
- **Schema:** `Umbraco.UserPicker`
- **Location:** `/packages/user/user/property-editor/user-picker/manifests.ts`

#### Member Picker
- **Alias:** `Umb.PropertyEditorUi.MemberPicker`
- **Icon:** `icon-user`
- **Group:** `people`
- **Schema:** `Umbraco.MemberPicker`
- **Read-only Support:** ✅
- **Location:** `/packages/members/member/property-editor/member-picker/manifests.ts`

#### Member Group Picker
- **Alias:** `Umb.PropertyEditorUi.MemberGroupPicker`
- **Icon:** `icon-users-alt`
- **Group:** `people`
- **Schema:** `Umbraco.MemberGroupPicker`
- **Read-only Support:** ✅
- **Location:** `/packages/members/member-group/property-editor/member-group-picker/manifests.ts`

### 12. Other Editors

#### Tags
- **Alias:** `Umb.PropertyEditorUi.Tags`
- **Icon:** `icon-tags`
- **Group:** `common`
- **Schema:** `Umbraco.Tags`
- **Read-only Support:** ✅
- **Location:** `/packages/tags/property-editors/tags/manifests.ts`

#### Label
- **Alias:** `Umb.PropertyEditorUi.Label`
- **Icon:** `icon-readonly`
- **Group:** `common`
- **Schema:** `Umbraco.Label`
- **Read-only Support:** ✅
- **Location:** `/packages/property-editors/label/manifests.ts`

#### Icon Picker
- **Alias:** `Umb.PropertyEditorUi.IconPicker`
- **Icon:** `icon-autofill`
- **Group:** `common`
- **Location:** `/packages/property-editors/icon-picker/manifests.ts`

#### Collection (List View)
- **Alias:** `Umb.PropertyEditorUi.Collection`
- **Icon:** `icon-layers`
- **Group:** `lists`
- **Schema:** `Umbraco.ListView`
- **Location:** `/packages/property-editors/collection/manifests.ts`
- **Settings:**
  - `layouts` - Layout configuration
  - `orderBy` - Order by field
  - `orderDirection` - Order direction
  - `pageSize` - Page size
  - `icon` - Workspace view icon
  - `tabName` - Workspace view name
  - `showContentFirst` - Show content workspace view first

### 13. Configuration Property Editors

These property editors are used for configuring other property editors and don't typically have schema aliases:

#### Stylesheet Picker
- **Alias:** `Umb.PropertyEditorUi.StylesheetPicker`
- **Location:** `/packages/templating/stylesheets/property-editors/stylesheet-picker/manifests.ts`

#### Static File Picker
- **Alias:** `Umb.PropertyEditorUi.StaticFilePicker`
- **Location:** `/packages/static-file/property-editors/static-file-picker/manifests.ts`

#### Media Type Picker
- **Alias:** `Umb.PropertyEditorUi.MediaTypePicker`
- **Location:** `/packages/media/media-types/property-editors/media-type-picker/manifests.ts`

#### Document Type Picker
- **Alias:** `Umb.PropertyEditorUi.DocumentTypePicker`
- **Location:** `/packages/documents/document-types/property-editors/document-type-picker/manifests.ts`

#### Value Type Configuration
- **Alias:** `Umb.PropertyEditorUi.ValueType`
- **Location:** `/packages/property-editors/value-type/manifests.ts`

#### Overlay Size Configuration
- **Alias:** `Umb.PropertyEditorUi.OverlaySize`
- **Location:** `/packages/property-editors/overlay-size/manifests.ts`

#### Order Direction Configuration
- **Alias:** `Umb.PropertyEditorUi.OrderDirection`
- **Location:** `/packages/property-editors/order-direction/manifests.ts`

#### Number Range Configuration
- **Alias:** `Umb.PropertyEditorUi.NumberRange`
- **Location:** `/packages/property-editors/number-range/manifests.ts`

#### Color Swatches Editor Configuration
- **Alias:** `Umb.PropertyEditorUi.ColorSwatchesEditor`
- **Location:** `/packages/property-editors/color-swatches-editor/manifests.ts`

## Property Groups

Property editors are organized into the following groups:

- `common` - Basic, frequently-used editors
- `lists` - Editors for managing lists and collections
- `pickers` - Editors for selecting/picking items
- `media` - Media-related editors
- **richContent** - Rich text and content editors
- **people** - User and member pickers

## Manifest Structure

Each property editor UI manifest follows this structure:

```typescript
{
  type: 'propertyEditorUi',
  alias: string,          // Unique identifier
  name: string,           // Internal name
  element: () => import(), // Lazy-loaded component
  meta: {
    label: string,        // Display label
    icon: string,         // Icon identifier
    group: string,        // Category group
    propertyEditorSchemaAlias?: string, // Schema reference
    supportsReadOnly?: boolean,         // Read-only support
    settings?: {          // Configuration settings
      properties: Array<{
        alias: string,
        label: string,
        propertyEditorUiAlias: string,
        // ... other settings
      }>
    }
  }
}
```

## Usage in Data Types

Property Editor UIs are referenced when creating data types through their alias. For example:
- Use `Umb.PropertyEditorUi.TextBox` for a text input field
- Use `Umb.PropertyEditorUi.MediaPicker` for media selection
- Use `Umb.PropertyEditorUi.BlockGrid` for complex grid layouts

## Notes

- **Read-only Support:** Property editors marked with ✅ support read-only mode
- **Location:** File paths are relative to `/src/Umbraco.Web.UI.Client/src/`
- **Settings:** Most property editors can be configured through their settings properties
- **Schema Alias:** Links the UI to the underlying data schema/value converter