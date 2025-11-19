---
description: The Server side part of a Property Editor
---

# Property Editor Schema
A Property Editor Schema is the data part of a Property Editor in Umbraco. It defines what type of data can be stored (string, number, date, JSON, etc.) and how that data should be validated. It can also perform conversions of the data going in or coming out of the data storage. The Schema also defines the configuration options for that Property Editor if there are any. In essence, the Property Editor Schema defines the data contact for a Property Editor.

{% hint style="info" %}
For complete manifest reference documentation including all available properties and configuration options, see the [Property Editor Schema Extension Type](../../extending-overview/extension-types/property-editor-schema.md) reference.
{% endhint %}

{% hint style="info" %}
Umbraco ships with a number of [default property editor schemas](../../../tutorials/creating-a-property-editor/default-property-editor-schema-aliases) that cover most less demanding scenarios.
{% endhint %}

{% hint style="info" %}
When you want to use a Property Editor to edit content in Umbraco, you need to have a schema. If it does not have a schema, you cannot select the Property Editor when creating a [Data Type](../../../fundamentals/data/data-types). In other scenario's - when using a Property Editor to edit Data Type settings for instance - a schema is not required.
{% endhint %}

The Property Editor Schema runs server side (in C# code) has the final say on whether data is valid to commit to the database. The Property Editor UI is where the User inputs their data and you can have client side validation, but the Property Editor Schema has the final say. This means that if there is a mismatch in client-side and server-side validation, the server side validation can reject data that the client-side validation considers valid.

Because the Property Editor Schema is a definition on how to process and validate data, you can have multiple Property Editor UIs using the same schema. As long as they work with the data as defined in the Schema, this works. It also makes it possible to swap out the UI while maintaining the same data.

You can see the used schema of a Property Editor in the backoffice of Umbraco when you create a new [Data Type](../../../fundamentals/data/data-types).

![The Property Editor Schema Alias in the Backoffice](images/property-editor-schema-alias-in-backoffice.jpg)

## Property Editor Schema anatomy

On the server side, a Property Editor Schema is built from two collaborating components. The `DataEditor` serves as the definition and factory, while `DataValueEditor` instances perform the actual data handling work. This separation allows Umbraco to efficiently reuse schema definitions across multiple Data Type configurations.

### DataEditor
The `DataEditor` is the C# class that implements the Property Editor Schema on the server side. It serves as the blueprint that defines how a Property Editor should work. The `DataEditor` defines the schema's unique alias, the type of data stored in the database, and the default configuration settings. Think of it as a template that describes the Property Editor's capabilities. There is only one `DataEditor` instance per Property Editor Schema.

### DataValueEditor
The `DataValueEditor` is the workhorse that handles all data operations for the Property Editor Schema. When property values need saving or loading, the `DataEditor` creates a `DataValueEditor` instance to do the actual work. This instance converts data between what the editor displays and what gets stored in the database. It also runs server-side validation to ensure data integrity and handles any necessary data transformations.

The `DataEditor` creates a new `DataValueEditor` instance for each operation. Each instance is configured with specific settings from the [Data Type](../../../fundamentals/data/data-types). For example, a textbox Property Editor might have one Data Type configured for short text and another for long text. Both use the same `DataEditor` (the blueprint), but each creates `DataValueEditor` instances with different maximum length settings.

### Register the schema client side

The Property Editor Schema must also be registered on the client side using a manifest. This manifest connects the backend schema to the frontend UI and is required before a Property Editor UI can use the schema.

**Basic Manifest**

At minimum, the schema manifest must specify the type, alias, name, and which Property Editor UI should be used by default:

```json
{
	"type": "propertyEditorSchema",
	"name": "Text Box",
	"alias": "Umbraco.TextBox",
	"meta": {
		"defaultPropertyEditorUiAlias": "Umb.PropertyEditorUi.TextBox"
	}
}
```

{% hint style="warning" %}
The `alias` in the manifest **must exactly match** the alias used in the C# `DataEditor` attribute. This alias string is the only connection between the server-side implementation and the client-side manifest.
{% endhint %}

{% hint style="info" %}
For complete manifest reference including configuration settings, see the [Property Editor Schema Extension Type](../../extending-overview/extension-types/property-editor-schema.md) documentation.
{% endhint %}

For a complete example, there is a tutorial for creating a Property Editor that shows how to [add server-side validation](../../../tutorials/creating-a-property-editor/adding-server-side-validation.md).
