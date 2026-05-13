---
description: Create a custom Web Component to visually represent blocks in Umbraco's Block editors.
---

# Block Custom View

The Block Custom View extension type allows you to define a custom Web Component to visually represent blocks (for example: Block List, Block Grid).

## Build a Custom View

{% hint style="info" %}
Before creating a Block Custom View, make sure you are familiar with the [Extension Registry in Umbraco](../../../customizing/extending-overview/extension-registry/register-extensions.md).
You can also refer to the tutorial [Custom Views for Block List](../../../tutorials/creating-custom-views-for-blocklist.md) for a step-by-step guide.
{% endhint %}

1. Create a Document Type with a property that uses a Block Editor.
2. Configure at least one Block Type on the Block Editor.
3. Make sure the Element Type used as the block's Content Model has properties you want to display. For example, a property with alias `headline`.
4. Note the **Element Type** Alias. You will need it shortly.
5. (Optional) Create a **Settings Model** for the above Element Type if you want to include settings data. For example, add a property with alias `theme`.
6. Register the custom view in `umbraco-package.json` file:

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
	  "forContentTypeAlias": "myElementTypeAlias", // your Element Type Alias from Step 4 (e.g. "myHeroBlock")
	  "forBlockEditor": "block-list" // insert block editor type here: "block-list" or "block-grid"
	}
  ]
}
```

{% endcode %}

## The Web Component

The code of your Web Component could look like this:

The TypeScript component (`ExampleBlockCustomView`) implements `UmbBlockEditorCustomViewElement` and receives the following reactive properties:

- `content` — the block's content data (for example, `this.content?.headline`)
- `settings` — the block's settings data, if a Settings Model is configured (for example, `this.settings?.theme`)

These map directly to the properties defined on the Element Type and its Settings Model (if configured). The component renders them in a styled container using Lit and standard CSS.

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
