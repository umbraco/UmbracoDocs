---
description: Presenting the Editing Experience of a Property Editor
---

# Property Editor UI

{% hint style="warning" %}
This page is a work in progress. It will be updated as the software evolves.
{% endhint %}

The Property Editor UI is a pure front-end extension. This determines how the data of a Property Editor is presented and manipulated. The Extension points to a Web Component.

### Property Editor UI

```json
{
	"type": "propertyEditorUi",
	"alias": "Umb.PropertyEditorUi.TextBox",
	"name": "Text Box Property Editor UI",
	"elementName": "my-text-box",
	"js": "/App_Plugins/my-text-box/dist/my-text-box.js",
	"meta": {
		"label": "My Text Box",
		"propertyEditorSchema": "Umbraco.TextBox",
		"icon": "umb:autofill",
		"group": "common"
	}
}
```

If no Property Editor Schema is specified in the manifest, the Property Editor UI cannot be used for Content Types. However, it can still be utilized to manipulate JSON. A case of that could be a Settings property for another Property Editor UI or Schema.

### Settings

Defines the configuration for a Property Editor UI. This is the same for Property Editor Schemas:

{% hint style="info" %}
The Property Editor UI inherits the Settings of its Property Editor Schema.
{% endhint %}

**Manifest**

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
					"propertyEditorUi": "Umb.PropertyEditorUi.Number",
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

## The Property Editor UI Element

Inherit the interface, to secure your Element live up to the requirements of this.

```ts
// TODO: get interface
interface UmbPropertyEditorUIElement {}
```

**Example with LitElement**

```ts
import { LitElement, html, css, customElement, property } from '@umbraco-cms/backoffice/external/lit';
import { UmbElementMixin } from '@umbraco-cms/backoffice/element-api';

@customElement('my-text-box')
export default class UmbPropertyEditorUITextBoxElement extends UmbElementMixin(LitElement) {
	
	@property()
	value: string | undefined;

	@property({ attribute: false })
	public config: UmbPropertyEditorConfigCollection | undefined;

	private onInput(e: InputEvent) {
		this.value = (e.target as HTMLInputElement).value;
		this.dispatchEvent(new CustomEvent('property-value-change'));
	}

	render() {
		return html`<uui-input .value=${this.value} type="text" @input=${this.onInput}></uui-input>`;
	}
	
	static styles = [
		css`
			uui-input {
				width: 100%;
			}
		`,
	];
}
```
