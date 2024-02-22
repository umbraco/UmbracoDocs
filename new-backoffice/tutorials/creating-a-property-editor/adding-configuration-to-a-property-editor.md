---
description: This page is a work in progress. It will be updated as the software evolves.
---

# Adding configuration to a Property Editor

{% hint style="warning" %}
This page is a work in progress. It will be updated as the software evolves.
{% endhint %}

## Overview

This is step 2 in our guide to building a Property Editor. This step continues work on the Suggestion Data Type we built in step 1, but goes further to show how to add configuration options to our editor.

## Configuration

An important part of building good Property Editors is to build something flexible, so we can reuse it many times, for different things. Like the Rich Text Editor in Umbraco, which allows us to choose which buttons and stylesheets we want to use on each instance of the editor.

An editor can be used again and again, with different configurations, and that is what we will be working on now.

## umbraco-package.json

To add a Data Type configuration fields when using our Suggestion Property Editor, open the `umbraco-package.json` file. Inside the `meta` object, we can add the `settings` object, which has the optional objects `properties` and `defaultData`. Let's start by adding some `properties`:

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
            ]
        }
        ...
    }
```

Above we add two configuration fields. Each entry of the `properties` collection represents a Configuration field. Each has the information needed for a field. Notice you have to declare a Property Editor UI, this declares what User Interface should be used for this field.

The field with the label "Disabled" uses the Toggle Property Editor UI. This will allow us to turn the suggestion button on/off and will provide the user with a toggle button. The field with the label "Placeholder text" uses the TextBox Property Editor UI. This will allow the user to write a text.

We can now also set some default data on our new configurations:

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
        }
      ]
   }
   ...
```

Your `umbraco-package.json` file should now look something like this:

```json
{
    "$schema": "../../umbraco-package-schema.json",
    "name": "My.AwesomePackage",
    "version": "0.1.0",
    "extensions": [
        {
            "type": "propertyEditorUi",
            "alias": "My.PropertyEditorUi.Suggestions",
            "name": "My Suggestions Property Editor UI",
            "js": "/App_Plugins/Suggestions/dist/suggestions-property-editor-ui.element.js",
            "elementName": "my-suggestions-property-editor-ui",
            "meta": {
                "label": "Suggestions",
                "icon": "umb:list",
                "group": "common",
                "propertyEditorSchemaAlias": "Umbraco.TextBox",
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
                        }
                    ]
                }
            }
        }
    ]
}
```

Save the files and rebuild the application. To access the configuration options, enable/disable the `disabled` option. Additionally, you can set a default value in the `placeholder` field and see the Suggestions Data Type at play.

Since we are using the `Umbraco.TextBox` Property Editor Schema, we inherits a `maxChars` configuration field from the Property Editor Schema. Let's save it as 20.

<figure><img src="../../.gitbook/assets/property-editor-config.png" alt=""><figcaption></figcaption></figure>

## Using the configuration

The next step is to gain access to our new configuration options. For this, open the `suggestions-property-editor-ui.element.ts` file.

First, let's create some state variables that can store our configurations

```typescript
  @state()
  private _disabled?: boolean;

  @state()
  private _placeholder?: string;

  @state()
  private _maxChars?: number;
```

Now let's create a config property. We look up the alias of the config and then grab the value by said alias.

```typescript
import { type UmbPropertyEditorConfigCollection } from "@umbraco-cms/backoffice/property-editor";
```

```typescript
  @property({ attribute: false })
  public set config(config: UmbPropertyEditorConfigCollection) {
    this._disabled = config.getValueByAlias("disabled");
    this._placeholder = config.getValueByAlias("placeholder");
    this._maxChars = config.getValueByAlias("maxChars");
  }
```

We can now use the configurations. Let's use the `placeholder` and `maxChars` for the input field and the `disabled` option for the suggestion button.

Add `ifDefined` to our imports and update the render method:

```typescript
import { ifDefined } from "@umbraco-cms/backoffice/external/lit";
```

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

<details>

<summary>See the entire file: <code>property-editor-ui-suggestions.element.ts</code></summary>

```typescript
import { LitElement, css, html, customElement, property, state, ifDefined } from "@umbraco-cms/backoffice/external/lit";
import { type UmbPropertyEditorExtensionElement } from "@umbraco-cms/backoffice/extension-registry";
import { type UmbPropertyEditorConfigCollection } from "@umbraco-cms/backoffice/components";

@customElement("my-suggestions-property-editor-ui")
export class MySuggestionsPropertyEditorUIElement
    extends LitElement
    implements UmbPropertyEditorExtensionElement
{
    @property({ type: String })
    public value = "";

    @state()
    private _disabled?: boolean;

    @state()
    private _placeholder?: string;

    @state()
    private _maxChars?: number;

    @state()
    private _suggestions = [
        "You should take a break",
        "I suggest that you visit the Eiffel Tower",
        "How about starting a book club today or this week?",
        "Are you hungry?",
    ];

    @property({ attribute: false })
    public set config(config: UmbPropertyEditorConfigCollection) {
        this._disabled = config.getValueByAlias("disabled");
        this._placeholder = config.getValueByAlias("placeholder");
        this._maxChars = config.getValueByAlias("maxChars");
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
        this.dispatchEvent(new CustomEvent("property-value-change"));
    }

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

    static styles = [
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
        "my-suggestions-property-editor-ui": MySuggestionsPropertyEditorUIElement;
    }
}
```

</details>

<figure><img src="../../.gitbook/assets/property-editor-config-on.png" alt=""><figcaption></figcaption></figure>
