---
description: >-
  Looking to add Validation rules for your own Property Editor? This article
  describes how to append validation rules to your Property Editor.
---

# Property Editor Validation

Adding Validation rules to a Property Editor is the same as adding Validation Rules to any Web Component. But it does require that your Web Component be a Form Control.

To achieve this, you can use a Mixin called `UmbFormControlMixin` . The following example shows how this could look:

```typescript
import { customElement } from '@umbraco-cms/backoffice/external/lit';
import { UmbLitElement } from '@umbraco-cms/backoffice/lit-element';
import { UmbFormControlMixin } from '@umbraco-cms/backoffice/validation';

@customElement('my-property-editor')
export class MyPropertyEditorElement
	extends UmbFormControlMixin<string | undefined, typeof UmbLitElement, undefined>(UmbLitElement)
	implements UmbPropertyEditorUiElement {
	
	/**
	Notice 'value'-property is already defined via the FormControlMixin, based on the first generic type given to it
	*/
	
	...

}

export default MyPropertyEditorElement;

declare global {
	interface HTMLElementTagNameMap {
		'my-property-editor': MyPropertyEditorElement;
	}
}

```

Once your Property Editor is a Form Control, you can append validation rules to it.

```typescript
...
	
	constructor() {
		super();

		this.addValidator(
			'customError',
			() => 'This field must contain a "Unicorn"',
			() => !this.value.includes("unicorn"),
		);
	}

...
```

The first argument declares what type of validation error you are evaluating. You can see the various types that browsers support on the [Mozilla Development Docs](https://developer.mozilla.org/en-US/docs/Web/API/ValidityState#instance_properties).

The second argument is a method that returns the message; this message will be displayed if the Validator Check returns `true`.

The third argument is the Validator check, which is executed every time there is a change in the properties of this Web Component. If it returns `true` , the component will turn invalid, and the messages of argument two will be used as feedback to the user.

{% hint style="info" %}
If you're looking to make server requests as part of your check, then it is recommended to avoid calling the server more often than needed. Do only ask the server if there is a value, and only ask the server again if the value is different from last time.
{% endhint %}

Notice that `value` is already defined in the FormControlMixin, and ideally, you do not overwrite it. If so, then please make sure to still set the value property of the Mixin. As that will trigger a validation update.

```typescript
	@property({ type: String })
	public override set value(value: string) {
		// [ What you needed to do... ]
		super.value = value;
	}
	public override get value() {
		return super.value;
	}
```
