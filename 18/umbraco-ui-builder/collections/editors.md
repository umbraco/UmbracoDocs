---
description: Configuring the editor of a collection in Umbraco UI Builder.
---

# Editors

An editor is the user interface used to edit an entity. It consists of tabs and property editors.

![A collection editor](<../.gitbook/assets/people-editor (1).png>)

## Configuring an Editor

The editor configuration is a sub-configuration of a [`Collection`](the-basics.md) config builder instance and is accessed via the `Editor` method.

### Using the `Editor()` Method

Accesses the editor configuration for the specified collection.

#### Method Syntax

```cs
Editor(Lambda editorConfig = null) : EditorConfig<TEntityType>
```

#### Example

```csharp
collectionConfig.Editor(editorConfig => {
    ...
});
```

## Adding a Tab to an Editor

### Using the `AddTab()` Method

Adds a tab to the editor.

#### Method Syntax

```cs
AddTab(string name, Lambda tabConfig = null) : EditorTabConfigBuilder<TEntityType>
```

#### Example

```csharp
editorConfig.AddTab("General", tabConfig => {
    ...
});
```

## Configuring a Sidebar to a Tab

A sidebar is a smaller section displayed on the right side of the main editor. It can contain fieldsets and fields, similar to tabs, but with limited space. The sidebar is ideal for displaying entity metadata.

### Using the `Sidebar()` Method

Configures the sidebar for the tab.

#### Method Syntax

```cs
Sidebar(Lambda sidebarConfig = null) : EditorTabSidebarConfigBuilder<TEntityType>
```

#### Example

```csharp
tabConfig.Sidebar(sidebarConfig => {
    ...
});
```

## Setting the Visibility of a Tab

### Using the `SetVisibility()` Method for Tabs

Determines the visibility of the tab at runtime.

#### Method Syntax

```cs
SetVisibility(Predicate<EditorTabVisibilityContext> visibilityExpression) : EditorTabConfigBuilder<TEntityType>
```

#### Example

```csharp
tabConfig.SetVisibility(ctx => ctx.EditorMode == EditorMode.Create);
```

## Adding a Fieldset to a Tab

### Using the `AddFieldset()` Method

Adds a fieldset to a tab.

#### Method Syntax

```cs
AddFieldset(string name, Lambda fieldsetConfig = null) : EditorFieldsetConfigBuilder<TEntityType>
```

#### Example

```csharp
tabConfig.AddFieldset("Contact", fieldsetConfig => {
    ...
});
```

## Setting the Visibility of a Fieldset

### Using the `SetVisibility()` Method for Fieldsets

Determines the visibility of a fieldset at runtime.

#### Method Syntax

```cs
SetVisibility(Predicate<EditorFieldsetVisibilityContext> visibilityExpression) : EditorFieldsetConfigBuilder<TEntityType>
```

#### Example

```csharp
fieldsetConfig.SetVisibility(ctx => ctx.EditorMode == EditorMode.Create);
```

## Adding a Field to a Fieldset

### Using the `AddField()` Method

Adds a property field to the editor.

#### Method Syntax

```cs
AddField(Lambda propertyExpression, Lambda propertyConfig = null) : EditorFieldConfigBuilder<TEntityType, TValueType>
```

#### Example

```csharp
fieldsetConfig.AddField(p => p.FirstName, fieldConfig => {
    ...
});
```

## Changing the Label of a Field

By default, Umbraco UI Builder converts property names into readable labels by splitting camel case names. You can override this behavior by setting an explicit label.

### Using the `SetLabel()` Method

Sets a custom label for a field.

#### Method Syntax

```cs
SetLabel(string label) : EditorFieldConfigBuilder<TEntityType, TValueType>
```

#### Example

```csharp
fieldConfig.SetLabel("First Name");
```

## Hiding the Label of a Field

Sometimes, a field works better without a label, especially in full-width layouts.

### Using the `HideLabel()` Method

Hides the field label.

#### Method Syntax

```cs
HideLabel() : EditorFieldConfigBuilder<TEntityType, TValueType>
```

#### Example

```csharp
fieldConfig.HideLabel();
```

## Adding a Description to a Field

### Using the `SetDescription()` Method

Adds a description to the field.

#### Method Syntax

```cs
SetDescription(string description) : EditorFieldConfigBuilder<TEntityType, TValueType>
```

#### Example

```csharp
fieldConfig.SetDescription("Enter your age in years");
```

## Changing the Data Type of a Field

By default, Umbraco UI Builder assigns a suitable Data Type for basic field types. However, you can specify a custom Data Type.

### Using the `SetDataType()` Method

Assigns an Umbraco Data Type by name or ID.

#### Method Syntax (by name)

```cs
SetDataType(string dataTypeName) : EditorFieldConfigBuilder<TEntityType, TValueType>
```

#### Example

```csharp
fieldConfig.SetDataType("Richtext Editor");
```

#### Method Syntax (by ID)

```cs
SetDataType(int dataTypeId) : EditorFieldConfigBuilder<TEntityType, TValueType>
```

#### Example

```csharp

fieldConfig.SetDataType(-88);
```

## Setting the Default Value of a Field

### Using the `SetDefaultValue()` Method

Sets a static default value.

#### Method Syntax

```cs
SetDefaultValue(TValueType defaultValue) : EditorFieldConfigBuilder<TEntityType, TValueType>
```

#### Example

```csharp
// Example
fieldConfig.SetDefaultValue(10);
```

### Using the `SetDefaultValue()` Method (Function-Based)

Defines a function to compute the default value at the time of entity creation.

#### Method Syntax

```cs
SetDefaultValue(Func defaultValueFunc) : EditorFieldConfigBuilder<TEntityType, TValueType>
```

#### Example

```csharp
fieldConfig.SetDefaultValue(() => DateTime.Now);
```

## Making a Field Required

### Using the `MakeRequired()` Method

Marks a field as required.

#### Method Syntax

```cs
MakeRequired() : EditorFieldConfigBuilder<TEntityType, TValueType>
```

#### Example

```csharp
fieldConfig.MakeRequired();
```

## Validating a Field

### Using the `SetValidationRegex()` Method

Applies a regular expression for field validation.

#### Method Syntax

```cs
SetValidationRegex(string regex) : EditorFieldConfigBuilder<TEntityType, TValueType>
```

#### Example

```csharp
fieldConfig.SetValidationRegex("[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}");
```

## Making a Field Read-only

### Using the `MakeReadOnly()` Method

This method makes the current field read-only, preventing any user modifications in the UI. Once applied, the field's value remains visible but cannot be edited.

#### Method Syntax

```cs
MakeReadOnly() : EditorFieldConfigBuilder<TEntityType, TValueType>
```

#### Example

```csharp
fieldConfig.MakeReadOnly();
```

### Using the `MakeReadOnly(Func<TValueType, string>)` Method

This method makes the current field read-only, preventing user edits in the UI. Additionally, it allows specifying a custom formatting expression, which determines how the field value is displayed as a string.

#### Method Syntax

```cs
MakeReadOnly(Func<TValueType, string> format) : EditorFieldConfigBuilder<TEntityType, TValueType>
```

#### Example

```csharp
fieldConfig.MakeReadOnly(distanceProp => $"{distanceProp:## 'km'}");
```

### Using the `MakeReadOnly(object dataTypeNameOrId)` Method

This method makes the current field read-only, preventing user edits in the UI. Additionally, it allows specifying a Data Type name or ID to determine how the field should be rendered when in read-only mode.

#### Method Syntax

```cs
MakeReadOnly(object dataTypeNameOrId) : EditorFieldConfigBuilder<TEntityType, TValueType>
```

#### Example

```csharp
fieldConfig.MakeReadOnly("myReadOnlyEditor");
```

### Using the `MakeReadOnly(Predicate<>)` Method

This method makes the current field read-only in the UI if the provided runtime predicate evaluates to true, preventing user edits.

#### Method Syntax

```cs
MakeReadOnly(Predicate<EditorFieldReadOnlyContext> readOnlyExp) : EditorFieldConfigBuilder<TEntityType, TValueType>
```

#### Example

```csharp
fieldConfig.MakeReadOnly(ctx => ctx.EditorMode == EditorMode.Create);
```

### Using the `MakeReadOnly(Predicate<>, Func<>)` Method

This method makes the current field read-only in the UI if the provided runtime predicate evaluates to true, preventing user edits. It also allows specifying a custom formatting expression to render the field’s value as a string.

#### Method Syntax

```cs
MakeReadOnly(Predicate<EditorFieldReadOnlyContext> readOnlyExp, Func<TValueType, string> format) : EditorFieldConfigBuilder<TEntityType, TValueType>
```

#### Example

```csharp
fieldConfig.MakeReadOnly(ctx => ctx.EditorMode == EditorMode.Create, distanceProp => $"{distanceProp:## 'km'}");
```

### Using the `MakeReadOnly(Predicate<>, Func<>)` Method

This method makes the current field read-only in the UI if the provided runtime predicate evaluates to true, preventing user edits. It also allows specifying a Data Type name or ID to use when the field is in read-only mode.

#### Method Syntax

```cs
MakeReadOnly(Predicate<EditorFieldReadOnlyContext> readOnlyExp, object dataTypeNameOrId) : EditorFieldConfigBuilder<TEntityType, TValueType>
```

#### Example

```csharp
fieldConfig.MakeReadOnly(ctx => ctx.EditorMode == EditorMode.Create, "myReadOnlyEditor");
```

## Setting the Visibility of a Field

### Using the `SetVisibility()` Method for Fields

Controls field visibility at runtime.

#### Method Syntax

```cs
SetVisibility(Predicate<EditorFieldVisibilityContext> visibilityExpression) : EditorFieldConfigBuilder<TEntityType, TValueType>
```

#### Example

```csharp
fieldConfig.SetVisibility(ctx => ctx.EditorMode == EditorMode.Create);
```
