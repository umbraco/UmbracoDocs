---
description: Guide on how to work with and create Property Editors in Umbraco
---

# Property Editors

{% hint style="info" %}
[This tutorial](../../tutorials/creating-a-property-editor/) contains step-by-step instructions for building a custom Property Editor.
{% endhint %}

This section describes how to work with and create Property Editors. A Property Editor is the editor used to insert content into Umbraco. [See the Property Editors overview for a detailed definition](../../fundamentals/backoffice/property-editors/).

## [Umbraco Package](../umbraco-package.md)

Custom Property Editors are registered in the [`umbraco-package.json`](../umbraco-package.md) file. This manifest file declares your Property Editor UI extension and links it to a Property Editor Schema. Learn more about the [package manifest format and registration](../umbraco-package.md).

## [Property Editor Validation](property-editor-validation.md)

Add validation rules to your custom Property Editors to ensure data integrity. Learn how to implement client-side validation using the Form Control Mixin and create custom validation logic for your Property Editor UI.

## [Property Editors Composition](composition/)

A Property Editor is composed of two key extensions: [Property Editor Schema](composition/property-editor-schema.md) and [Property Editor UI](composition/property-editor-ui.md). These components work together to define the data structure and user interface for content entry in the Umbraco backoffice.

Optionally, you can use a [Property Editor Data Source](composition/property-editor-data-source.md) to provide data to your Property Editor UI. This will allow the same UI to work with different data sources.

## [Property Value Converters](property-value-converters.md)

Convert the stored property data value to a useful, strongly-typed object returned by the [Published Content APIs](../../reference/querying/). This allows you to work with rich data types in your views and controllers instead of raw stored values.

## [Property Actions](property-actions.md)

Use Property Actions to add additional functionality to your custom Property Editors. This could include custom buttons or actions that appear alongside the editor in the backoffice.

## [Integrate Property Editors](integrate-property-editors.md)

Learn how to integrate and use Property Editors anywhere in the Umbraco backoffice using the `umb-property` and `umb-property-dataset` components. This guide covers implementing Property Editors in custom interfaces and scenarios.

## [Tracking References](tracking.md)

Learn how to extend Property Editors to track entity references within the Property Editor. This enables Umbraco to understand relationships between content and helps with features like dependency tracking and content deletion warnings.

## [Property Dataset](property-dataset.md)

Understand how to use the Property Dataset Context API to manage data for multiple properties. This is essential when integrating Property Editors into custom views, workspaces, or scenarios outside of standard content editing.

## More Information

* [Built-in Property Editors](../../fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/) - Explore the Property Editors that come out of the box with Umbraco.
* [Creating a Property Editor Tutorial](../../tutorials/creating-a-property-editor/) - Step-by-step guide to building your first custom Property Editor.
* [Adding Configuration](../../tutorials/creating-a-property-editor/adding-configuration-to-a-property-editor.md) - Learn how to add configurable settings to your Property Editor.
* [Adding Server-side Validation](../../tutorials/creating-a-property-editor/adding-server-side-validation.md) - Implement server-side validation for your Property Editor.
* [Custom Value Conversion](../../tutorials/creating-a-property-editor/custom-value-conversion-for-rendering.md) - Create Property Value Converters for custom rendering.
* [Integrating Context](../../tutorials/creating-a-property-editor/integrating-context-with-a-property-editor.md) - Work with Umbraco's Context API in your Property Editor.
* [Default Property Editor Schema Aliases](../../tutorials/creating-a-property-editor/default-property-editor-schema-aliases.md) - Reference list of available Property Editor Schemas.
* [Full Property Value Converter Examples](full-examples-value-converters.md) - Complete code examples for implementing Property Value Converters.
* [Development Flow](../development-flow/) - Learn about the development workflow for building Umbraco extensions.
