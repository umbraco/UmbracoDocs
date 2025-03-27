---
description: Presenting the Editing Experience of a Property Editor
---

# Property Editor UI

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

The Property Editor UI is the UI that is used to edit the data in the backoffice.

The Property Editor UI is a pure front-end extension. This determines how the data of a Property Editor is presented and manipulated. The Extension points to a Web Component.

### Property Editor UI

{% code title="umbraco-package.json" %}
```json
{
 "type": "propertyEditorUi",
 "alias": "Umb.PropertyEditorUi.TextBox",
 "name": "Text Box Property Editor UI",
 "element": "/App_Plugins/my-text-box/dist/my-text-box.js",
 "elementName": "my-text-box",
 "meta": {
  "label": "My Text Box",
  "propertyEditorSchemaAlias": "Umbraco.TextBox",
  "icon": "icon-autofill",
  "group": "common"
 }
}
```
{% endcode %}

The Property Editor UI cannot be used for Content Types if no Property Editor Schema is specified in the manifest. However, it can still be utilized to manipulate JSON. A case of that could be a Settings property for another Property Editor UI or Schema.

### Settings

The Property Editor UI settings are used for configuration related to rendering the UI in the backoffice. This is the same for Property Editor Schemas:

{% hint style="info" %}
The Property Editor UI inherits the Settings of its Property Editor Schema.
{% endhint %}

**Manifest**

{% code title="umbraco-package.json" %}
```json
{
 "type": "propertyEditorUi",
 "alias": "My.PropertyEditorUI.TextArea",
 //... more
 "meta": {
  //... more
  "settings": {
   "properties": [
    {
     "alias": "rows",
     "label": "Number of rows",
     "description": "If empty - 10 rows would be set as the default value",
     "propertyEditorUiAlias": "Umb.PropertyEditorUi.Integer",
    },
   ],
   "defaultData": [
    {
     "alias": "rows",
     "value": 10,
    },
   ],
  },
 },
};
```
{% endcode %}

## The Property Editor UI Element

Implement the `UmbPropertyEditorUiElement` interface, to secure your Element live up to the requirements of this.

```typescript
interface UmbPropertyEditorUiElement extends HTMLElement {
	name?: string;
	value?: unknown;
	config?: UmbPropertyEditorConfigCollection;
	mandatory?: boolean;
	mandatoryMessage?: string;
	destroy?: () => void;
}
```

{% hint style="info" %}
The `UmbPropertyEditorUiElement` interface is a TypeScript interface that ensures that your Element has the necessary properties and methods to be used as a Property Editor UI Element. See the [UI API documentation](https://apidocs.umbraco.com/v15/ui-api/interfaces/packages_core_property-editor.UmbPropertyEditorUiElement.html) for more information.
{% endhint %}

**Example with LitElement**

{% code title="my-text-box.ts" lineNumbers="true" %}
```typescript
import { UmbChangeEvent } from '@umbraco-cms/backoffice/event';
import { css, customElement, html, property } from '@umbraco-cms/backoffice/external/lit';
import { UmbLitElement } from '@umbraco-cms/backoffice/lit-element';
import type {
	UmbPropertyEditorConfigCollection,
	UmbPropertyEditorUiElement,
} from '@umbraco-cms/backoffice/property-editor';
import { UmbTextStyles } from '@umbraco-cms/backoffice/style';

@customElement('umb-property-editor-ui-text-box')
export default class UmbPropertyEditorUITextBoxElement extends UmbLitElement implements UmbPropertyEditorUiElement {
	@property()
	value?: string;

	@property({ attribute: false })
	config?: UmbPropertyEditorConfigCollection;

	#onInput(e: InputEvent) {
		this.value = (e.target as HTMLInputElement).value;
		this.dispatchEvent(new UmbChangeEvent());
	}

	override render() {
		return html`<uui-input .value=${this.value ?? ''} type="text" @input=${this.#onInput}></uui-input>`;
	}

	static override readonly styles = [
		UmbTextStyles,
		css`
			uui-input {
				width: 100%;
			}
		`,
	];
}

declare global {
	interface HTMLElementTagNameMap {
		'umb-property-editor-ui-text-box': UmbPropertyEditorUITextBoxElement;
	}
}
```
{% endcode %}
