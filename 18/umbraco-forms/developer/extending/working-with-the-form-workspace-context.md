---
description: >-
  Learn how to consume the Form Workspace Context in a backoffice extension to
  read a form's pages, fields, and other structure.
---

# Working with the Form Workspace Context

When you build a backoffice extension for Umbraco Forms, you often need access to the form that is currently open. A common example is a [property editor](https://docs.umbraco.com/umbraco-cms/customizing/property-editors) that lets an editor map to or pick one of the form's fields.

Umbraco Forms exposes the open form through the **Form Workspace Context**. This article explains how to consume the context, how to read the form's structure, and how to register a property editor that uses it.

Before you start, install and configure the `@umbraco-forms/backoffice` package as described in the [Extending](README.md#extending-the-backoffice) article. For an overview of the available extension points, see [Backoffice Extension Points](backoffice-extension-points.md).

## Consuming the Form Workspace Context

The Form Workspace Context is published through the `FORMS_FORM_WORKSPACE_CONTEXT` context token. Import the token from `@umbraco-forms/backoffice` and consume it in your element's constructor.

{% code title="my-field-picker.element.ts" %}
```typescript
import { html, customElement } from "@umbraco-cms/backoffice/external/lit";
import { UmbLitElement } from "@umbraco-cms/backoffice/lit-element";
import type { UmbPropertyEditorUiElement } from "@umbraco-cms/backoffice/property-editor";
import { FORMS_FORM_WORKSPACE_CONTEXT } from "@umbraco-forms/backoffice";

const elementName = "my-field-picker";

@customElement(elementName)
export class MyFieldPickerElement
  extends UmbLitElement
  implements UmbPropertyEditorUiElement
{
  #workspaceContext?: typeof FORMS_FORM_WORKSPACE_CONTEXT.TYPE;

  constructor() {
    super();

    this.consumeContext(FORMS_FORM_WORKSPACE_CONTEXT, (context) => {
      this.#workspaceContext = context;
    }).passContextAliasMatches();
  }

  render() {
    return html`<p>Field picker</p>`;
  }
}

export default MyFieldPickerElement;

declare global {
  interface HTMLElementTagNameMap {
    [elementName]: MyFieldPickerElement;
  }
}
```
{% endcode %}

### Why `passContextAliasMatches()` is required

The `FORMS_FORM_WORKSPACE_CONTEXT` token is registered under the shared `UmbWorkspaceContext` alias. A type-guard narrows the alias to the form workspace by checking the entity type.

By default, the Context API stops at the first context that matches the alias. This avoids consuming unrelated descending contexts. Inside a modal, such as the field or workflow settings dialog, the nearest `UmbWorkspaceContext` is the modal's own workspace. That context fails the type-guard, so consumption stops and your callback never receives the form workspace.

Calling `passContextAliasMatches()` tells the consumer to pass beyond alias matches that fail the type-guard. The consumer then keeps looking up the tree until it finds the form workspace.

{% hint style="warning" %}
Omit `passContextAliasMatches()` only when your element is rendered directly in the form workspace and not inside a modal. When in doubt, add it. Field and workflow settings are rendered in modals, so they always need it.
{% endhint %}

## Reading the form structure

A form is organized into pages, fieldsets, containers, and fields. The Form Workspace Context provides helper methods so you do not have to traverse this structure yourself.

| Method                     | Returns                                                  |
| -------------------------- | ------------------------------------------------------- |
| `getAllPages()`            | All pages on the form.                                  |
| `getAllContainers()`       | All containers across every page and fieldset.          |
| `getAllFields()`           | All fields across the whole form.                       |
| `getAllFieldAliases()`     | The alias of every field on the form.                   |
| `getField(id)`             | A single field by its ID, or `null` when not found.     |

Each field is a `Field` object. The properties used most often are `id`, `alias`, and `caption`.

The following snippet reads the form's fields from the consumed context and maps them to a list of options. The `Field` type is also exported from `@umbraco-forms/backoffice`:

{% code title="my-field-picker.element.ts" %}
```typescript
import type { Field } from "@umbraco-forms/backoffice";

// this.#workspaceContext is the consumed FORMS_FORM_WORKSPACE_CONTEXT.
const fields = this.#workspaceContext?.getAllFields() ?? [];
const options = fields.map((field: Field) => ({
  name: field.caption,
  value: field.id,
}));
```
{% endcode %}

{% hint style="info" %}
The methods read the form's current in-memory state. Call them inside the context callback, or after it has run, so the workspace is available.
{% endhint %}

## Example: a property editor that picks a form field

This example registers a property editor that lets an editor select one of the current form's fields. The selected field ID is stored as the property value.

The example uses two files: the element and its manifest.

{% code title="field-picker.element.ts" %}
```typescript
import { html, customElement, property, state } from "@umbraco-cms/backoffice/external/lit";
import { UmbLitElement } from "@umbraco-cms/backoffice/lit-element";
import { UmbChangeEvent } from "@umbraco-cms/backoffice/event";
import type { UmbPropertyEditorUiElement } from "@umbraco-cms/backoffice/property-editor";
import type { UUISelectEvent, UUISelectOption } from "@umbraco-cms/backoffice/external/uui";
import { FORMS_FORM_WORKSPACE_CONTEXT } from "@umbraco-forms/backoffice";
import type { Field } from "@umbraco-forms/backoffice";

const elementName = "my-forms-field-picker";

@customElement(elementName)
export class MyFormsFieldPickerElement
  extends UmbLitElement
  implements UmbPropertyEditorUiElement
{
  #workspaceContext?: typeof FORMS_FORM_WORKSPACE_CONTEXT.TYPE;

  // The selected field ID, stored as the property value.
  @property({ type: String })
  value = "";

  @state()
  private _options: Array<UUISelectOption> = [];

  constructor() {
    super();

    // passContextAliasMatches() is required so the context resolves inside modals.
    this.consumeContext(FORMS_FORM_WORKSPACE_CONTEXT, (context) => {
      this.#workspaceContext = context;
      this.#buildOptions();
    }).passContextAliasMatches();
  }

  #buildOptions() {
    const fields = this.#workspaceContext?.getAllFields() ?? [];
    this._options = fields.map((field: Field) => ({
      name: field.caption,
      value: field.id,
      selected: field.id === this.value,
    }));
  }

  #onChange(event: UUISelectEvent) {
    this.value = event.target.value as string;
    // Notify the backoffice that the property value changed.
    this.dispatchEvent(new UmbChangeEvent());
  }

  render() {
    return html`
      <uui-select
        label="Form field"
        placeholder="Select a field"
        .options=${this._options}
        @change=${this.#onChange}
      ></uui-select>
    `;
  }
}

export default MyFormsFieldPickerElement;

declare global {
  interface HTMLElementTagNameMap {
    [elementName]: MyFormsFieldPickerElement;
  }
}
```
{% endcode %}

Register the element as a property editor UI through a manifest:

{% code title="manifests.ts" %}
```typescript
import type { ManifestPropertyEditorUi } from "@umbraco-cms/backoffice/property-editor";

const fieldPickerManifest: ManifestPropertyEditorUi = {
  type: "propertyEditorUi",
  alias: "My.PropertyEditorUi.FormsFieldPicker",
  name: "Forms Field Picker Property Editor UI",
  element: () => import("./field-picker.element.js"),
  meta: {
    label: "Forms Field Picker",
    icon: "icon-checkbox",
    group: "common",
  },
};

export const manifests = [fieldPickerManifest];
```
{% endcode %}

You can now use the property editor UI in a field or workflow setting. The dropdown lists every field on the open form.

## Other building blocks

The `@umbraco-forms/backoffice` package exposes more than the workspace context. The types and base classes below help you build common extensions:

* `ManifestFormsFieldPreview` and `FormsFieldPreviewBaseElement` for rendering a custom field preview in the form designer.
* `FormsSettingValueConverterApi` and `ManifestFormsSettingValueConverterPreview` for converting setting values between the editor and storage.
* `Field`, `Page`, `FieldsetContainer`, and `Setting` types for working with the form model.

Most server-side providers, such as field types and workflow types, are documented separately:

* [Adding A Field Type To Umbraco Forms](adding-a-fieldtype.md)
* [Adding A Workflow Type To Umbraco Forms](adding-a-workflowtype.md)
* [Setting Types](setting-types.md)

## Versioning

The client-side extension API is still evolving. Methods and context shapes can change between minor releases.

{% hint style="warning" %}
Install the version of `@umbraco-forms/backoffice` that matches your Umbraco Forms installation. Pin the version, then review the [Release Notes](../../release-notes.md) before upgrading. You can find compatible versions on the [`@umbraco-forms/backoffice` npm page](https://www.npmjs.com/package/@umbraco-forms/backoffice).
{% endhint %}
