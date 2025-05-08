---
description: Adding configuration options to the editor.
---

# Adding configuration to a Property Editor

## Overview

This is step two in our guide to building a Property Editor. This step continues work on the Suggestion Data Type we built in part one but goes further to show how to add configuration options to our editor.

The steps we will go through in the second part are:

* [Adding settings object to umbraco-package.json](adding-configuration-to-a-property-editor.md#adding-settings-object-to-umbraco-package.json)
* [Using the configuration](adding-configuration-to-a-property-editor.md#using-the-configuration)

### Configuration

An important part of building good Property Editors is to build something flexible, so we can reuse it many times, for different things. Like the Rich Text Editor in Umbraco, which allows us to choose which buttons and stylesheets we want to use on each instance of the editor.

An editor can be used again and again, with different configurations, and that is what we will be working on now.

## Adding settings object to umbraco-package.json

To add a Data Type configuration field when using our Suggestion Property Editor, open the `umbraco-package.json` file. Inside the `meta` object, we can add the `settings` object, which has the optional objects `properties` and `defaultData`.

1. Add some `properties`:

{% code title="umbraco-package.json" %}
```json
    ...
    "meta": {
        ...
        "settings": {
            "properties": [
                {
                    "alias": "disabled",
                    "label": "Disabled",
                    "description": "Disables the suggestion button",
                    "propertyEditorUiAlias": "Umb.PropertyEditorUi.Toggle"
                },
                {
                    "alias": "placeholder",
                    "label": "Placeholder text",
                    "description": "A nice placeholder description to help out our editor!",
                    "propertyEditorUiAlias": "Umb.PropertyEditorUi.TextBox"
                },
                {
                    "alias": "maxChars",
                    "label": "Max characters allowed",
                    "description": "The maximum number of allowed characters in a suggestion",
                    "propertyEditorUiAlias": "Umb.PropertyEditorUi.Integer"
                }
            ]
        }
        ...
    }
```
{% endcode %}

In the section above, we added three configuration fields. Each entry in the `properties` collection represents a Configuration field. It contains the necessary information for that field.

* The field labeled "`Disabled`" uses the Toggle Property Editor UI. This enables to switch the suggestion button on or off and provides the user with a toggle button.
* The field labeled "`Placeholder text`" uses the TextBox Property Editor UI, allowing the user to write a text.
* The field labeled "`Max characters allowed`" uses the Integer Property Editor UI, enabling the user to enter a numeric value.

{% hint style="info" %}
The Property Editor UI needs to be declared as it declares what User Interface should be used for this field.

You can use any Property Editor UI to define Configuration fields. The alias of a given Property Editor UI can be found in Data Type configurations using that Property Editor.
{% endhint %}

2. We can now also set some default data on our new configurations:

{% code title="umbraco-package.json" %}
```json
  ...
  "meta": {
    ...
    "settings": {
      "properties": [...],
      "defaultData": [
        {
          "alias": "disabled",
          "value": true
        },
        {
          "alias": "placeholder",
          "value": "Write a suggestion"
        },
        {
          "alias": "maxChars",
          "value": 50
        }
      ]
   }
   ...
```
{% endcode %}

<details>

<summary>See the entire file: umbraco-package.json</summary>

{% code title=" umbraco-package.json" %}
```json
{
    "$schema": "../../umbraco-package-schema.json",
    "id": "My.AwesomePackage",
    "name": "My Awesome Package",
    "version": "0.1.0",
    "extensions": [
        {
            "type": "propertyEditorUi",
            "alias": "My.PropertyEditorUi.Suggestions",
            "name": "My Suggestions Property Editor UI",
            "element": "/App_Plugins/Suggestions/dist/suggestions.js",
            "elementName": "my-suggestions-property-editor-ui",
            "meta": {
                "label": "Suggestions",
                "icon": "icon-list",
                "group": "common",
                "propertyEditorSchemaAlias": "Umbraco.Plain.String",
                "settings": {
                    "properties": [
                        {
                            "alias": "disabled",
                            "label": "Disabled",
                            "description": "Disables the suggestion button",
                            "propertyEditorUiAlias": "Umb.PropertyEditorUi.Toggle"
                        },
                        {
                            "alias": "placeholder",
                            "label": "Placeholder text",
                            "description": "A nice placeholder description to help out our editor!",
                            "propertyEditorUiAlias": "Umb.PropertyEditorUi.TextBox"
                        },
                        {
                            "alias": "maxChars",
                            "label": "Max characters allowed",
                            "description": "The maximum number of allowed characters in a suggestion",
                            "propertyEditorUiAlias": "Umb.PropertyEditorUi.Integer"
                        }
                    ],
                    "defaultData": [
                        {
                            "alias": "disabled",
                            "value": true
                        },
                        {
                            "alias": "placeholder",
                            "value": "Write a suggestion"
                        },
                        {
                            "alias": "maxChars",
                            "value": 50
                        }
                    ]
                }
            }
        }
    ]
}
```
{% endcode %}

</details>

3. Save the files and reload the backoffice. We can now configure our Data Type:

<figure><img src="images/suggestion-editor-config_3.png" alt=""><figcaption><p>Data Type configuration.</p></figcaption></figure>

## Using the configuration

The next step is to gain access to our new configuration options. For this, open the `suggestions-property-editor-ui.element.ts` file.

1. Create some state variables that can store our configurations:

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
  @state()
  private _disabled?: boolean;

  @state()
  private _placeholder?: string;

  @state()
  private _maxChars?: number;
```
{% endcode %}

2. Let's create a config property. Add a new import and add the following property:

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
import { type UmbPropertyEditorConfigCollection } from '@umbraco-cms/backoffice/property-editor';
```
{% endcode %}

3. Look up the alias of the config and then grab the value by said alias:

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
  @property({ attribute: false })
  public set config(config: UmbPropertyEditorConfigCollection) {
    this._disabled = config.getValueByAlias("disabled");
    this._placeholder = config.getValueByAlias("placeholder");
    this._maxChars = config.getValueByAlias("maxChars");
  }
```
{% endcode %}

We can now use the configurations. Let's use the `placeholder` and `maxChars` for the input field and the `disabled` option for the suggestion button.

4. Add a new import `ifDefined` :

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
import { ifDefined } from '@umbraco-cms/backoffice/external/lit';
```
{% endcode %}

5. Update the render method:

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
  render() {
    return html`
      <uui-input
        id="suggestion-input"
        class="element"
        label="text input"
        placeholder=${ifDefined(this._placeholder)}
        maxlength=${ifDefined(this._maxChars)}
        .value=${this.value || ""}
        @input=${this.#onInput}
      >
      </uui-input>
      <div id="wrapper">
        <uui-button
          id="suggestion-button"
          class="element"
          look="primary"
          label="give me suggestions"
          ?disabled=${this._disabled}
          @click=${this.#onSuggestion}
        >
          Give me suggestions!
        </uui-button>
        <uui-button
          id="suggestion-trimmer"
          class="element"
          look="outline"
          label="Trim text"
        >
          Trim text
        </uui-button>
      </div>
    `;
  }
```
{% endcode %}

<details>

<summary>See the entire file: suggestions-property-editor-ui.element.ts</summary>

{% code title="suggestions-property-editor-ui.element.ts" lineNumbers="true" overflow="wrap" %}
```typescript
import { UmbChangeEvent } from '@umbraco-cms/backoffice/event';
import { css, customElement, html, ifDefined, LitElement, property, state } from '@umbraco-cms/backoffice/external/lit';
import type {
	UmbPropertyEditorConfigCollection,
	UmbPropertyEditorUiElement,
} from '@umbraco-cms/backoffice/property-editor';
import { UmbTextStyles } from '@umbraco-cms/backoffice/style';

@customElement('my-suggestions-property-editor-ui')
export default class MySuggestionsPropertyEditorUIElement extends LitElement implements UmbPropertyEditorUiElement {
	@property({ type: String })
	public value = '';

	@state()
	private _disabled?: boolean;

	@state()
	private _placeholder?: string;

	@state()
	private _maxChars?: number;

	@state()
	private _suggestions = [
		'You should take a break',
		'I suggest that you visit the Eiffel Tower',
		'How about starting a book club today or this week?',
		'Are you hungry?',
	];

	@property({ attribute: false })
	public set config(config: UmbPropertyEditorConfigCollection) {
		this._disabled = config.getValueByAlias('disabled');
		this._placeholder = config.getValueByAlias('placeholder');
		this._maxChars = config.getValueByAlias('maxChars');
	}

	#onInput(e: InputEvent) {
		this.value = (e.target as HTMLInputElement).value;
		this.#dispatchChangeEvent();
	}

	#onSuggestion() {
		const randomIndex = (this._suggestions.length * Math.random()) | 0;
		this.value = this._suggestions[randomIndex];
		this.#dispatchChangeEvent();
	}

	#dispatchChangeEvent() {
		this.dispatchEvent(new UmbChangeEvent());
	}

	override render() {
		return html`
			<uui-input
				id="suggestion-input"
				class="element"
				label="text input"
				placeholder=${ifDefined(this._placeholder)}
				maxlength=${ifDefined(this._maxChars)}
				.value=${this.value || ''}
				@input=${this.#onInput}>
			</uui-input>
			<div id="wrapper">
				<uui-button
					id="suggestion-button"
					class="element"
					look="primary"
					label="give me suggestions"
					?disabled=${this._disabled}
					@click=${this.#onSuggestion}>
					Give me suggestions!
				</uui-button>
				<uui-button id="suggestion-trimmer" class="element" look="outline" label="Trim text"> Trim text </uui-button>
			</div>
		`;
	}

	static override readonly styles = [
		UmbTextStyles,
		css`
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

declare global {
	interface HTMLElementTagNameMap {
		'my-suggestions-property-editor-ui': MySuggestionsPropertyEditorUIElement;
	}
}
```
{% endcode %}

</details>

6. Run the command `npm run build` in the `suggestions` folder.&#x20;
7. Run the project.&#x20;
8. Go to the **Content** section of the Backoffice to see the new changes in the property editor:

<figure><img src="images/suggestion-editor-backoffice_2.png" alt=""><figcaption><p>Suggestions Property Editor with disabled suggestions option</p></figcaption></figure>

## Going further

We have now added some configurations to our data type and used them in our Property Editor.

In the next step, we are going to integrate context with our Property Editor.
