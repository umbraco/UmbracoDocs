---
description: Configuring the editor of a collection in Konstrukt, the back office UI builder for Umbraco.
---

# Editors

An editor is the user interface used to edit an entity and is made up of tabs and property editors.

![A collection editor](../images/people_editor.png)

## Configuring an editor

The editor configuration is a sub configuration of a [`Collection`](the-basics.md) config builder instance and is accessing via it's `Editor` method.

#### **Editor(Lambda editorConfig = null) : KonstruktEditorConfig&lt;TEntityType&gt;**

Accesses the editor config of the given collection.

````csharp
// Example
collectionConfig.Editor(editorConfig => {
    ...
});
````

## Adding a tab to an editor

#### **AddTab(string name, Lambda tabConfig = null) : KonstruktEditorTabConfigBuilder&lt;TEntityType&gt;**

Adds a tab to the editor.

````csharp
// Example
editorConfig.AddTab("General", tabConfig => {
    ...
});
````

## Configuring a sidebar to a tab

A slidebar is a smaller area that is displayed to the right of the main editor. The sidebar can also contain fieldsets and fields in the same way tabs can but with a much more limited display area so you'll need to choose your field types carefully. The sidebar is a great location to display entity metadata.

#### **Sidebar(Lambda sidebarConfig = null) : KonstruktEditorTabSidebarConfigBuilder&lt;TEntityType&gt;**

Configures the sidebar for the tab.

````csharp
// Example
tabConfig.Sidebar(sidebarConfig => {
    ...
});
````

## Setting the visibility of a tab

#### **SetVisibility(Predicate&lt;KonstruktEditorTabVisibilityContext&gt; visibilityExpression) : KonstruktEditorTabConfigBuilder&lt;TEntityType&gt;**

Sets the runtime visibility of the tab.

````csharp
// Example
tabConfig.SetVisibility(ctx => ctx.EditorMode == KonstruktEditorMode.Create);
````

## Adding a fieldset to a tab

#### **AddFieldset(string name, Lambda fieldsetConfig = null) : KonstruktEditorFieldsetConfigBuilder&lt;TEntityType&gt;**

Adds the given fieldset to the tab.

````csharp
// Example
tabConfig.AddFieldset("Contact", fieldsetConfig => {
    ...
});
````

## Setting the visibility of a fieldset

#### **SetVisibility(Predicate&lt;KonstruktEditorFieldsetVisibilityContext&gt; visibilityExpression) : KonstruktEditorFieldsetConfigBuilder&lt;TEntityType&gt;**

Sets the runtime visibility of the fieldset.

````csharp
// Example
fieldsetConfig.SetVisibility(ctx => ctx.EditorMode == KonstruktEditorMode.Create);
````

## Adding a field to a fieldset

#### **AddField(Lambda propertyExpression, Lambda propertyConfig = null) : KonstruktEditorFieldConfigBuilder&lt;TEntityType, TValueType&gt;**

Adds the given property to the editor.

````csharp
// Example
fieldsetConfig.AddField(p => p.FirstName, fieldConfig => {
    ...
});
````

## Changing the label of a field

By default Konstrukt will build the label from the property name, including splitting camel case names into sentence case, however you can set an explicit label if you'd prefer.

#### **SetLabel(string label) : KonstruktEditorFieldConfigBuilder&lt;TEntityType, TValueType&gt;**

Sets the label for the editor field.

````csharp
// Example
fieldConfig.SetLabel("First Name");
````

## Hiding the label of a field

Sometimes you may have a field editor that would work better in full width, in which case you can achieve this by explicitly hiding the fields label.

#### **HideLabel() : KonstruktEditorFieldConfigBuilder&lt;TEntityType, TValueType&gt;**

Hides the label for the editor field.

````csharp
// Example
fieldConfig.HideLabel();
````

## Adding a description to a field

#### **SetDescription(string description) : KonstruktEditorFieldConfigBuilder&lt;TEntityType, TValueType&gt;**

Sets the description for the editor field.

````csharp
// Example
fieldConfig.SetDescription("Enter your age in years");
````

## Changing the data type of a field

By default Konstrukt will automatically choose a relevant data type for simple field types, however you can override this should you wish to use an alternative data type.

#### **SetDataType(string dataTypeName) : KonstruktEditorFieldConfigBuilder&lt;TEntityType, TValueType&gt;**

Set the data type of the current field to the Umbraco data type with the given name.

````csharp
// Example
fieldConfig.SetDataType("Richtext Editor");
````

#### **SetDataType(int dataTypeId) : KonstruktEditorFieldConfigBuilder&lt;TEntityType, TValueType&gt;**

Set the data type of the current field to the Umbraco data type with the given id.

````csharp
// Example
fieldConfig.SetDataType(-88);
````

## Setting the default value of a field

#### **SetDefaultValue(TValueType defaultValue) : KonstruktEditorFieldConfigBuilder&lt;TEntityType, TValueType&gt;**

Sets the default value to a known constant.

````csharp
// Example
fieldConfig.SetDefaultValue(10);
````

#### **SetDefaultValue(Func<TValueType> defaultValueFunc) : KonstruktEditorFieldConfigBuilder&lt;TEntityType, TValueType&gt;**

Sets the default value via a function that gets evaluated at time of entity creation.

````csharp
// Example
fieldConfig.SetDefaultValue(() => DateTime.Now);
````

## Making a field required

#### **MakeRequired() : KonstruktEditorFieldConfigBuilder&lt;TEntityType, TValueType&gt;**

Makes the given field required.

````csharp
// Example
fieldConfig.MakeRequired();
````

## Validating a field

#### **SetValidationRegex(string regex) : KonstruktEditorFieldConfigBuilder&lt;TEntityType, TValueType&gt;**

Defines the regular expression to use when validating the field.

````csharp
// Example
fieldConfig.SetValidationRegex("[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}");
````

## Making a field read only

#### **MakeReadOnly() : KonstruktEditorFieldConfigBuilder&lt;TEntityType, TValueType&gt;**

Makes the current field read only disabling editing in the UI.

````csharp
// Example
fieldConfig.MakeReadOnly();
````

#### **MakeReadOnly(Func&lt;TValueType, string&gt; format) : KonstruktEditorFieldConfigBuilder&lt;TEntityType, TValueType&gt;**

Makes the current field read only disabling editing in the UI. Provides a custom formatting expression to use when rendering the value as a string.

````csharp
// Example
fieldConfig.MakeReadOnly(distanceProp => $"{distanceProp:## 'km'}");
````

#### **MakeReadOnly(object dataTypeNameOrId) : KonstruktEditorFieldConfigBuilder&lt;TEntityType, TValueType&gt;**

Makes the current field read only disabling editing in the UI. Provides the name or id of a datatype to use when in readonly mode.

````csharp
// Example
fieldConfig.MakeReadOnly("myReadOnlyEditor");
````

#### **MakeReadOnly(Predicate&lt;KonstruktEditorFieldReadOnlyContext&gt; readOnlyExp) : KonstruktEditorFieldConfigBuilder&lt;TEntityType, TValueType&gt;**

Makes the current field read only disabling editing in the UI if the given runtime predicate is true.

````csharp
// Example
fieldConfig.MakeReadOnly(ctx => ctx.EditorMode == KonstruktEditorMode.Create);
````

#### **MakeReadOnly(Predicate&lt;KonstruktEditorFieldReadOnlyContext&gt; readOnlyExp, Func&lt;TValueType, string&gt; format) : KonstruktEditorFieldConfigBuilder&lt;TEntityType, TValueType&gt;**

Makes the current field read only disabling editing in the UI if the given runtime predicate is true. Provides a custom formatting expression to use when rendering the value as a string.

````csharp
// Example
fieldConfig.MakeReadOnly(ctx => ctx.EditorMode == KonstruktEditorMode.Create, distanceProp => $"{distanceProp:## 'km'}");
````

#### **MakeReadOnly(Predicate&lt;KonstruktEditorFieldReadOnlyContext&gt; readOnlyExp, object dataTypeNameOrId) : KonstruktEditorFieldConfigBuilder&lt;TEntityType, TValueType&gt;**

Makes the current field read only disabling editing in the UI if the given runtime predicate is true. Provides the name or id of a datatype to use when in readonly mode.

````csharp
// Example
fieldConfig.MakeReadOnly(ctx => ctx.EditorMode == KonstruktEditorMode.Create, "myReadOnlyEditor");
````

## Setting the visibility of a field

#### **SetVisibility(Predicate&lt;KonstruktEditorFieldVisibilityContext&gt; visibilityExpression) : KonstruktEditorFieldConfigBuilder&lt;TEntityType, TValueType&gt;**

Sets the runtime visibility of the field.

````csharp
// Example
fieldConfig.SetVisibility(ctx => ctx.EditorMode == KonstruktEditorMode.Create);
````