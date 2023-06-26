---
description: This page is a work in progress. It will be updated as the software evolves.
---

# Adding configuration to a Property Editor

### Overview

This is step 2 in our guide to building a Property Editor. This step continues work on the Suggestion Data Type we built in step 1, but goes further to show how to add configuration options to our editor.

### Configuration

An important part of building good Property Editors is to build something flexible, so we can reuse it many times, for different things. Like the Rich Text Editor in Umbraco, which allows us to choose which buttons and stylesheets we want to use on each instance of the editor.

An editor can be used again and again, with different configurations, and that is what we will be working on now.

### umbraco-package.json

To add configuration options to our Suggestion Data Type, open the `umbraco-package.json` file. Inside the meta add the configuration properties:

```json
  ...
  "meta": {
    ...
    "config": {
      "properties": [
	{
		"alias": "disabled",
		"label": "Disabled",
		"description": "Disables the suggestion button",
		"propertyEditorUiAlias": "Umb.PropertyEditorUi.Toggle",
	},
	{
		"alias": "placeholder",
		"label": "Placeholder text",
		"description": "A nice placeholder description to help out our editor!",
		"propertyEditorUiAlias": "Umb.PropertyEditorUi.Textbox",
	},
	{
		"alias": "maxLength",
		"label": "Max length",
		"description": "Limit characters each suggestion may have",
		"propertyEditorUiAlias": "Umb.PropertyEditorUi.Integer",
	},
      ],
  }
  ...
```

We can also add some default data:

```json
  ...
  "meta": {
    ...
    "config": {
      "properties": [...],
      "defaultData": [
        {
          "alias": "disabled",
          "value": true,
      	},
       	{
          "alias": "maxLength",
	  "value": 20
        }
      ]
   }  
   ...
```

So what did we add? We added a prevalue editor, with a `properties` collection. This collection contains information about the UI we will render on the Data Type configuration for this editor.

The label "disabled" uses the "boolean" view. This will allow us to turn the suggestions on/off and will provide the user with a toggle button. The name "boolean" comes from the convention that all preview editors are stored in `/umbraco/views/prevalueeditors/` and then found via `boolean.html`.

Your `umbraco-package.json` file should now look something like this:

```json
{
  "$schema": "../../umbraco-package-schema.json",
  "name": "My.AwesomePackage",
  "version": "0.1.0",
  "extensions": [
    {
      "type": "propertyEditorUi",
      "alias": "My.AwesomeSuggestions",
      "name": "My Awesome Suggestions",
      "js": "/App_Plugins/Suggestions/dist/awesome-suggestions.js",
      "elementName": "my-property-editor-ui-suggestions",
      "meta": {
        "label": "Awesome Suggestions",
        "pathname": "awesome-suggestions",
        "icon": "document",
        "group": "common",
        "propertyEditorModel": "Umbraco.JSON",
        "config": {
	  "properties": [
	    {
	      "alias": "disabled",
	      "label": "Disabled",
	      "description": "Disables the suggestion button",
	      "propertyEditorUiAlias": "Umb.PropertyEditorUi.Toggle",
	    },
	    {
	      "alias": "placeholder",
	      "label": "Placeholder text",
	      "description": "A nice placeholder description to help out our editor!",
	      "propertyEditorUiAlias": "Umb.PropertyEditorUi.Textbox",
	    },
	    {
	      "alias": "maxLength",
	      "label": "Max length",
	      "description": "Limit characters each suggestion may have",
	      "propertyEditorUiAlias": "Umb.PropertyEditorUi.Integer",
	    }
	  ],
	  "defaultData": [
	    {
	      "alias": "disabled",
	      "value": true,
	    },
	    {
	      "alias": "maxLength",
	      "value": 20
	    }
	  ]
	}
      }
    }
  ]
}
```

{% hint style="info" %}
`hideLabel` is not yet an option in the new backoffice
{% endhint %}

Save the files and rebuild the application. To access the configuration options, enable/disable the `disabled` option. Additionally, you can set a default value in the `placeholder` field and see the Suggestions Data Type at play.

<figure><img src="../../.gitbook/assets/suggestions-datatype.png" alt=""><figcaption></figcaption></figure>

### Using the configuration

The next step is to gain access to our new configuration options. For this, open the `property-editor-ui-suggestion.element` file.

First, let's create some state variables that can store our configurations

```typescript
import { customElement, property, state } from 'lit/decorators.js';
```

```typescript
@state()
private _disabled?: boolean;

@state()
private _placeholder?: string;

@state()
private _maxLength?: number;
```

Now let's update the config property. We look up the alias of the property and then grab the value of said alias.

```typescript
@property({ type: Array, attribute: false })
public set config(config: UmbDataTypePropertyCollection) {
	const disabled = config.find((x) => x.alias === 'disabled');
	if (disabled) this._disabled = disabled.value;

	const placeholder = config.find((x) => x.alias === 'placeholder');
	if (placeholder) this._placeholder = placeholder.value;

	const maxLength = config.find((x) => x.alias === 'maxLength');
	if (maxLength) this._maxLength = maxLength.value;
}
```

We then want our input component to use these configurations, add ifDefined to our imports and update the render method:

```typescript
import { ifDefined } from 'lit/directives/if-defined.js';
```

```typescript
render() {
  return html`<my-suggestions-input
      .value=${this.value}
      placeholder=${ifDefined(this._placeholder)}
      maxLength=${ifDefined(this._maxLength)}
      @change=${this.#onChange}
      ?disabled=${this._disabled}></my-suggestions-input> `;
}
```

Our `property-editor-ui-suggestions.element` should now look something like this:

```typescript
import { html } from 'lit';
import { customElement, property } from 'lit/decorators.js';
import { ifDefined } from 'lit/directives/if-defined.js';
import { MySuggestionsInputElement } from './suggestions-input.element.ts';
import { UmbPropertyEditorExtensionElement } from '@umbraco-cms/backoffice/extension-registry';
import { UmbLitElement } from '@umbraco-cms/internal/lit-element';
import { UmbDataTypePropertyCollection } from '@umbraco-cms/backoffice/data-type';
import './suggestions-input.element.ts';

@customElement('my-property-editor-ui-suggestions')
export class MyPropertyEditorUISuggestionsElement extends UmbLitElement implements UmbPropertyEditorExtensionElement {

  @property({ type: String })
  public value = '';
    
  @state()
  private _disabled?: boolean;
	
  @state()
  private _placeholder?: string;
	
  @state()
  private _maxLength?: number;
    
  @property({ type: Array, attribute: false })
    public set config(config: UmbDataTypePropertyCollection) {
      const disabled = config.find((x) => x.alias === 'disabled');
      if (disabled) this._disabled = disabled.value;
	
      const placeholder = config.find((x) => x.alias === 'placeholder');
      if (placeholder) this._placeholder = placeholder.value;
    }
    
  #onChange(e: CustomEvent) {
    this.value = (e.target as MySuggestionsInputElement).value as string;
    this.dispatchEvent(new CustomEvent('property-value-change'));
  }

  render() {
    return html`<my-suggestions-input
        .value=${this.value}
	placeholder=${ifDefined(this._placeholder)}
	maxLength=${ifDefined(this._maxLength)}
	@change=${this.#onChange}
	?disabled=${this._disabled}></my-suggestions-input> `;
  }
}

export default MyPropertyEditorUISuggestionsElement;

declare global {
  interface HTMLElementTagNameMap {
    'my-property-editor-ui-suggestions': MyPropertyEditorUISuggestionsElement;
  }
}
```

Now our my-suggestions-input component needs to take these in as a property so that we can use them. We will use the placeholder configuration in the uui-input and the disabled configuration on the "Give me suggestions!" uui-button.

In the `suggestions-input.element` file, add the properties:

```typescript
import { customElement, property, state } from 'lit/decorators.js';
```

```typescript
@property({ type: Boolean })
disabled = false;

@property({ type: String })
placeholder?: string;

@property({ type: Number })
maxLength?: number;
```

Bind the properties to the input and button in the render method:

```typescript
render() {
  return html`<div class="blue-text">${this.value}</div>
    <uui-input
      id="suggestion-input"
      class="element"
      label="text input"
      .placeholder="${this.placeholder}"
      .maxlength=${this.maxLength}
      .value="${this.value || ''}"
      @input=${this.#onInput}></uui-input>
    <div id="wrapper">
      <uui-button
        id="suggestion-button"
	class="element"
	look="primary"
	label="give me suggestions"
	@click=${this.#onSuggestion}
	?disabled=${this.disabled}>
	Give me suggestions!
     </uui-button>
     <uui-button
	id="suggestion-trimmer"
	class="element"
	look="outline"
	label="Trim text"
	@click=${this.#onTextTrim}>
	Trim text
      </uui-button>
    </div> `;
  }
```

<figure><img src="../../.gitbook/assets/Pasted image 20230525192217 (1).png" alt=""><figcaption></figcaption></figure>

<details>

<summary>suggestions-input.element.ts</summary>

```typescript
import { LitElement, css, html } from 'lit';
import { customElement, property, state } from 'lit/decorators.js';
import { UUIInputEvent } from '@umbraco-ui/uui';
import { FormControlMixin } from '@umbraco-ui/uui-base/lib/mixins';

@customElement('my-suggestions-input')
export class UmbMySuggestionsInputElement extends FormControlMixin(LitElement) {
	@property({ type: Boolean })
	disabled = false;

	@property({ type: String })
	placeholder?: string;

	@property({ type: Number })
	maxLength?: number;

	@state()
	private _suggestions = [
		'You should take a break',
		'I suggest that you visit the Eiffel Tower',
		'How about starting a book club today or this week?',
		'Are you hungry?',
	];

	protected getFormElement() {
		return undefined;
	}

	#onInput(e: UUIInputEvent) {
		this.value = e.target.value as string;
		this.#dispatchChangeEvent();
	}
	#onSuggestion() {
		const randomIndex = (this._suggestions.length * Math.random()) | 0;
		this.value = this._suggestions[randomIndex];
		this.#dispatchChangeEvent();
	}
	#onTextTrim() {
		/* This method will trim our text later! */
	}

	#dispatchChangeEvent() {
		this.dispatchEvent(new CustomEvent('change', { bubbles: true, composed: true }));
	}

	render() {
		return html`<div class="blue-text">${this.value}</div>
			<uui-input
				id="suggestion-input"
				class="element"
				label="text input"
				.placeholder="${this.placeholder}"
				.maxlength=${this.maxLength}
				.value="${this.value || ''}"
				@input=${this.#onInput}></uui-input>
			<div id="wrapper">
				<uui-button
					id="suggestion-button"
					class="element"
					look="primary"
					label="give me suggestions"
					@click=${this.#onSuggestion}
					?disabled=${this.disabled}>
					Give me suggestions!
				</uui-button>
				<uui-button id="suggestion-trimmer" class="element" look="outline" label="Trim text" @click=${this.#onTextTrim}>
					Trim text
				</uui-button>
			</div> `;
	}

	static styles = [
		css`
			.blue-text {
				color: var(--uui-color-focus);
			}
			#wrapper {
				margin-top: 10px;
				display: flex;
				gap: 10px;
			}
			.element {
				width: 100%;
			}
		`,
	];
}

export default UmbMySuggestionsInputElement;

declare global {
	interface HTMLElementTagNameMap {
		'my-suggestions-input': UmbMySuggestionsInputElement;
	}
}
```

</details>
