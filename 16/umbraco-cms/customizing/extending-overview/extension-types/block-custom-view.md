---
description: Bring your own representation for Blocks.
---

# Block Custom View

The Block Custom View extension type lets you define a Web Component for representing blocks.

## Build a Custom View

{% hint style="info" %}
Before creating a Block Custom View, make sure you are familiar with the [Extension Registry in Umbraco](../../../customizing/extending-overview/extension-registry/register-extensions.md).
You can also refer to the tutorial [Custom Views for Block List](../../../tutorials/creating-custom-views-for-blocklist.md) for a step-by-step guide. 
{% endhint %}

1. Make a Document Type with a Property using a Block Editor of choice.
2. Configure at least one Block Type on the Block Editor.
3. Ensure the Element Type of the Blocks Content Model has a property using `headline` as the Property Alias.
4. Take note of the Element Type Alias as you will use that in the next step.
5. Create a Settings Model for the above Element Type and add a property with alias `theme`.
6. Add the following code to the `umbraco-package.json` file:

{% code title="umbraco-package.json" %}
```json
{
  "$schema": "../../umbraco-package-schema.json",
  "name": "My.CustomViewPackage",
  "version": "0.1.0",
  "extensions": [
    {
      "type": "blockEditorCustomView",
      "alias": "my.blockEditorCustomView.Example",
      "name": "My Example Custom View",
      "element": "/App_Plugins/block-custom-view/dist/example-block-custom-view.js",
      "forContentTypeAlias": "myElementTypeAlias", // insert element type alias here
      "forBlockEditor": "block-list" // insert block type(s) here
    }
  ]
}
```
{% endcode %}

The code of your Web Component could look like this:

{% code title="example-custom-view.ts" %}
```typescript
import { html, customElement, LitElement, property, css } from '@umbraco-cms/backoffice/external/lit';
import { UmbElementMixin } from '@umbraco-cms/backoffice/element-api';
import type { UmbBlockDataType } from '@umbraco-cms/backoffice/block';
import type { UmbBlockEditorCustomViewElement } from '@umbraco-cms/backoffice/block-custom-view';

@customElement('example-block-custom-view')
export class ExampleBlockCustomView extends UmbElementMixin(LitElement) implements UmbBlockEditorCustomViewElement {
	
	@property({ attribute: false })
	content?: UmbBlockDataType;

	@property({ attribute: false })
	settings?: UmbBlockDataType;

	render() {
		return html`
			<h5>My Custom View</h5>
			<p>Headline: ${this.content?.headline}</p>
			<p>Theme: ${this.settings?.theme}</p>
		`;
	}

	static styles = [
		css`
			:host {
				display: block;
				height: 100%;
				box-sizing: border-box;
				background-color: darkgreen;
				color: white;
				border-radius: 9px;
				padding: 12px;
			}
		`,
	];
	
}
export default ExampleBlockCustomView;

declare global {
	interface HTMLElementTagNameMap {
		'example-block-custom-view': ExampleBlockCustomView;
	}
}

```
{% endcode %}
