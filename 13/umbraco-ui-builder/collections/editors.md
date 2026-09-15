---
description: >-
  Configuring the editor of a collection in Umbraco UI Builder, the backoffice
  UI builder for Umbraco.
---

# Editors

An editor is the user interface used to edit an entity and is made up of tabs and property editors.

![A collection editor](../.gitbook/assets/people_editor.png)

## Configuring an editor

The editor configuration is a sub-configuration of a [`Collection`](the-basics.md) config builder instance and is accessed via its `Editor` method.

### **Editor(Lambda editorConfig = null) : EditorConfig\<TEntityType>**

Accesses the editor config of the given collection.

```csharp
// Example
collectionConfig.Editor(editorConfig => {
    ...
});
```

## Adding a tab to an editor

### **AddTab(string name, Lambda tabConfig = null) : EditorTabConfigBuilder\<TEntityType>**

Adds a tab to the editor.

```csharp
// Example
editorConfig.AddTab("General", tabConfig => {
    ...
});
```

## Configuring a sidebar to a tab

A slidebar is a smaller area that is displayed to the right of the main editor. The sidebar can also contain fieldsets and fields in the same way tabs can. However, it is a much more limited display area so you'll need to choose your field types carefully. The sidebar is a great location to display entity metadata.

### **Sidebar(Lambda sidebarConfig = null) : EditorTabSidebarConfigBuilder\<TEntityType>**

Configures the sidebar for the tab.

```csharp
// Example
tabConfig.Sidebar(sidebarConfig => {
    ...
});
```

## Setting the visibility of a tab

### **SetVisibility(Predicate\<EditorTabVisibilityContext> visibilityExpression) : EditorTabConfigBuilder\<TEntityType>**

Sets the runtime visibility of the tab.

```csharp
// Example
tabConfig.SetVisibility(ctx => ctx.EditorMode == EditorMode.Create);
```

## Adding a fieldset to a tab

### **AddFieldset(string name, Lambda fieldsetConfig = null) : EditorFieldsetConfigBuilder\<TEntityType>**

Adds the given fieldset to the tab.

```csharp
// Example
tabConfig.AddFieldset("Contact", fieldsetConfig => {
    ...
});
```

## Setting the visibility of a fieldset

### **SetVisibility(Predicate\<EditorFieldsetVisibilityContext> visibilityExpression) : EditorFieldsetConfigBuilder\<TEntityType>**

Sets the runtime visibility of the fieldset.

```csharp
// Example
fieldsetConfig.SetVisibility(ctx => ctx.EditorMode == EditorMode.Create);
```

## Adding a field to a fieldset

### **AddField(Lambda propertyExpression, Lambda propertyConfig = null) : EditorFieldConfigBuilder\<TEntityType, TValueType>**

Adds the given property to the editor.

```csharp
// Example
fieldsetConfig.AddField(p => p.FirstName, fieldConfig => {
    ...
});
```

## Changing the label of a field

By default, Umbraco UI Builder will build the label from the property name, including splitting camel case names into sentence cases. However, you can set an explicit label if preferred.

### **SetLabel(string label) : EditorFieldConfigBuilder\<TEntityType, TValueType>**

Sets the label for the editor field.

```csharp
// Example
fieldConfig.SetLabel("First Name");
```

## Hiding the label of a field

Sometimes you may have a field editor that would work better in full width. You can achieve this by explicitly hiding the field label.

### **HideLabel() : EditorFieldConfigBuilder\<TEntityType, TValueType>**

Hides the label for the editor field.

```csharp
// Example
fieldConfig.HideLabel();
```

## Adding a description to a field

### **SetDescription(string description) : EditorFieldConfigBuilder\<TEntityType, TValueType>**

Sets the description for the editor field.

```csharp
// Example
fieldConfig.SetDescription("Enter your age in years");
```

## Changing the Data Type of a field

By default, Umbraco UI Builder will automatically choose a relevant Data Type for basic field types. However, if you wish to use an alternative Data Type then you can override this.

### **SetDataType(string dataTypeName) : EditorFieldConfigBuilder\<TEntityType, TValueType>**

Set the Data Type of the current field to the Umbraco Data Type with the given name.

```csharp
// Example
fieldConfig.SetDataType("Richtext Editor");
```

### **SetDataType(int dataTypeId) : EditorFieldConfigBuilder\<TEntityType, TValueType>**

Set the Data Type of the current field to the Umbraco Data Type with the given id.

```csharp
// Example
fieldConfig.SetDataType(-88);
```

## Setting the default value of a field

### **SetDefaultValue(TValueType defaultValue) : EditorFieldConfigBuilder\<TEntityType, TValueType>**

Sets the default value to a known constant.

```csharp
// Example
fieldConfig.SetDefaultValue(10);
```

### **SetDefaultValue(Func defaultValueFunc) : EditorFieldConfigBuilder\<TEntityType, TValueType>**

Sets the default value via a function that gets evaluated at time of entity creation.

```csharp
// Example
fieldConfig.SetDefaultValue(() => DateTime.Now);
```

## Making a field required

### **MakeRequired() : EditorFieldConfigBuilder\<TEntityType, TValueType>**

Makes the given field required.

```csharp
// Example
fieldConfig.MakeRequired();
```

## Validating a field

### **SetValidationRegex(string regex) : EditorFieldConfigBuilder\<TEntityType, TValueType>**

Defines the regular expression to use when validating the field.

```csharp
// Example
fieldConfig.SetValidationRegex("[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}");
```

## Making a field read-only

### **MakeReadOnly() : EditorFieldConfigBuilder\<TEntityType, TValueType>**

Makes the current field read-only disabling editing in the UI.

```csharp
// Example
fieldConfig.MakeReadOnly();
```

### **MakeReadOnly(Func\<TValueType, string> format) : EditorFieldConfigBuilder\<TEntityType, TValueType>**

Makes the current field read-only disabling editing in the UI. Provides a custom formatting expression to use when rendering the value as a string.

```csharp
// Example
fieldConfig.MakeReadOnly(distanceProp => $"{distanceProp:## 'km'}");
```

### **MakeReadOnly(object dataTypeNameOrId) : EditorFieldConfigBuilder\<TEntityType, TValueType>**

Makes the current field read-only disabling editing in the UI. Provides the name or id of a datatype to use when in read-only mode.

```csharp
// Example
fieldConfig.MakeReadOnly("myReadOnlyEditor");
```

### **MakeReadOnly(Predicate\<EditorFieldReadOnlyContext> readOnlyExp) : EditorFieldConfigBuilder\<TEntityType, TValueType>**

Makes the current field read-only disabling editing in the UI if the given runtime predicate is true.

```csharp
// Example
fieldConfig.MakeReadOnly(ctx => ctx.EditorMode == EditorMode.Create);
```

### **MakeReadOnly(Predicate\<EditorFieldReadOnlyContext> readOnlyExp, Func\<TValueType, string> format) : EditorFieldConfigBuilder\<TEntityType, TValueType>**

Makes the current field read-only disabling editing in the UI if the given runtime predicate is true. Provides a custom formatting expression to use when rendering the value as a string.

```csharp
// Example
fieldConfig.MakeReadOnly(ctx => ctx.EditorMode == EditorMode.Create, distanceProp => $"{distanceProp:## 'km'}");
```

### **MakeReadOnly(Predicate\<EditorFieldReadOnlyContext> readOnlyExp, object dataTypeNameOrId) : EditorFieldConfigBuilder\<TEntityType, TValueType>**

Makes the current field read-only disabling editing in the UI if the given runtime predicate is true. Provides the name or id of a datatype to use when in read-only mode.

```csharp
// Example
fieldConfig.MakeReadOnly(ctx => ctx.EditorMode == EditorMode.Create, "myReadOnlyEditor");
```

## Setting the visibility of a field

### **SetVisibility(Predicate\<EditorFieldVisibilityContext> visibilityExpression) : EditorFieldConfigBuilder\<TEntityType, TValueType>**

Sets the runtime visibility of the field.

```csharp
// Example
fieldConfig.SetVisibility(ctx => ctx.EditorMode == EditorMode.Create);
```
