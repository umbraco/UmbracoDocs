---
description: >-
  A modal is a popup layer that darkens the background and has focus lock. There
  are two types of modals: "dialog" and "sidebar".
---

# Modals

## **Modal Types**

The Dialog modal appears in the middle of the screen. and the Sidebar Modal slide in from the right.

## Modal Token

For type safety, we recommend that you use Modal Tokens. The Modal Token binds the Modal Type with a Modal Data Type and a Modal Result Type.

This can also come with defaults, for example, settings for the modal type and size.

This is an example of a Modal Token declaration:

```ts
import { ModalToken } from '@umbraco-cms/element';

export type OurSomethingPickerModalData = {
	key: string | null;
};

export type OurSomethingPickerModalResult = {
	key: string;
};

export const MY_SOMETHING_PICKER_MODAL = new UmbModalToken<UmbLinkPickerModalData, UmbLinkPickerModalResult>(
	'Our.Modal.SomethingPicker',
	{
		type: 'sidebar',
		size: 'small',
	}
);
```

### Basic Usage

Consume the `UmbModalManagerContext` and then use the modal manager context to open a modal. This examples shows how to consume the Modal Manager Context:

```ts
import { LitElement } from '@umbraco-cms/backoffice/external/lit';
import { UmbElementMixin } from '@umbraco-cms/element';
import { UmbModalManagerContext, UMB_MODAL_CONTEXT_ALIAS } from '@umbraco-cms/modal';

class MyElement extends UmbElementMixin(LitElement) {
	#modalManagerContext?: UmbModalManagerContext;

	constructor() {
		super();
		this.consumeContext(UMB_MODAL_CONTEXT_ALIAS, (instance) => {
			this.#modalManagerContext = instance;
			// modalManagerContext is now ready to be used.
		});
	}
}
```

#### Open a modal

A modal can be opened in two ways. Either you register the modal with a route or at runtime open the modal. The initial option allows users to deep-link to the modal, a potential preference in certain cases; otherwise, consider the latter.

#### Directly open a Modal

In this case, we use the Modal Token from above, this takes a key as its data. And if submitted then it returns the new key.

```typescript
const modalContext = this._modalContext?.open(MY_SOMETHING_PICKER_MODAL, {
		key: this.value
});

modalContext?.onSubmit().then((data) => {
		this.value = data.key;
}).catch(() => undefined);
```

[See the implementing a Confirm Dialog for a more concrete example.](confirm-dialog.md)

**Modal Route Registration**

A modal can be registered via the UmbModalRouteRegistrationController. The registration will accept a modal token (or extension alias).

Notice we are using a Controller here, this means your element has to be a Controller Host&#x20;

(TODO: Insert link to story about Controller Host also available through the UmbElementMixin)

```ts
this.myModalRegistration = new UmbModalRouteRegistrationController(this, UMB_LINK_PICKER_MODAL)
	.onSubmit((submitData) => {
		console.log('Modal submitted with data'.submitData);
	})
	.observeRouteBuilder((routeBuilder) => {
		this._modalRouteBuilder = routeBuilder;
	});
```

The registration holds an instance of its UmbModalHandler when the modal it active. The modal registration accepts 4 different callbacks:

* `onSetup` - called when the modal is opened
* `onSubmit` - called when the modal is submitted
* `onReject` - called when the modal is rejected
* `observeRouteBuilder` - called when the modal route changes, use the given route builder to build a route to open the modal.

**TODOS:**

describe the additional features of the route Registration:

**Hints:**

* Add unique parts to the path. (How is this done properly as part of a Property Editor)
* A modal registered in a dashboard can be straightforward.
* A modal registered in a property editor needs to become specific for the property and the variant of that property.
* Build some data for the setup.
* Reject a modal by returning false in setup.
* Use a param as part of the setup to determine the data going to the modal.

**Modal registration for UI as part of a Property Editor**

```ts


	@property()
	public set alias(value: string | undefined) {
		this.myModalRegistration.setUniquePathValue('propertyAlias', value);
	}

	@property()
	public set variantId(value: string | UmbVariantId | undefined) {
		this.myModalRegistration.setUniquePathValue('variantId', value?.toString());
	}

	private _items = [
		{ name: 'Item 1' },
		{ name: 'Item 2' },
		{ name: 'Item 3' },
	]


	constructor() {
		super();

		this.myModalRegistration = new UmbModalRouteRegistrationController(
			this,
			MY_MODAL_TOKEN
		)
		.addAdditionalPath(`:index`)
		.addUniquePaths(['propertyAlias', 'variantId'])
		.onSetup((params) => {
			// Get item index:
			const indexParam = params.index;
			if (!indexParam) return false;
			let index: number | null = parseInt(params.index);
			if (Number.isNaN(index)) return false;

			// Use the index to find data:
			let data = null;
			if (index >= 0 && index < this._items.length) {
				data = this._items[index];
			} else {
				// If not then make a new pick:
				index = null;
			}

			return {
				index: index,
				itemData: {
					name: data?.name
				},
			};
		})
		.onSubmit((submitData) => {
			if (!submitData) return;
			this._items[submitData.index] = submitData.itemData;
		})
		.observeRouteBuilder((routeBuilder) => {
			this._modalRouteBuilder = routeBuilder;
		});
	}

	render() {
		return html`
			${this._items?.map((item, index) =>
				html`<uui-button look="placeholder" label="Edit item ${index}" .href=${this._modalRouteBuilder?.({ index })}>Add</uui-button>`
			)}
		`;
	}
```

**Generate the URL to a Modal Route Registration**

The Modal registration has an option to retrieve a URL Builder. This is a function that can be used to generate a URL to a modal.

```ts
const modalLink = _myUrlBuilder?.({ alias: 'my-input-alias' });
```

The `modalLink` from above could look like this: `/umbraco/backoffice/my/location/modal/Our.Modal.SomethingPicker/my-input-alias`

Notice the Property Editor registration will add the property alias and variant ID to the URL, so it becomes:

`/umbraco/backoffice/my/location/modal/Our.Modal.SomethingPicker/my-property-alias/en-us/my-input-alias`

### Create a custom modal

#### Register in the extension registry

The manifest

```json
{
	"type": "modal",
	"alias": "My.Modal",
	"name": "My Modal",
	"js": "../path/to/my-modal.element.js"
}
```

#### Create a modal token

A modal token is a string that identifies a modal. It should be the modal extension alias. It is used to open a modal and is also to set default options for the modal.

```ts
interface MyModalData = {
	headline: string;
	content: string;
}

interface MyModalResult = {
	myReturnData: string;
}

const MY_MODAL_TOKEN = new ModalToken<MyModalData, MyModalResult>('My.Modal', {
	type: 'sidebar',
	size: 'small'
});
```

The Modal element:

```ts
import { html, LitElement } from '@umbraco-cms/backoffice/external/lit';
import { UmbElementMixin } from '@umbraco-cms/element';
import type { UmbModalHandler } from '@umbraco-cms/modal';

class MyDialog extends UmbElementMixin(LitElement) {
	// the modal handler will be injected into the element when the modal is opened.
	@property({ attribute: false })
	modalContext?: UmbModalHandler<MyModalData, MyModalResult>;

	private _handleCancel() {
		this.modalContext?.close();
	}

	private _handleSubmit() {
		/* Optional data of any type can be applied to the submit method to pass it
		   to the modal parent through the onSubmit promise. */
		this.modalContext?.submit({ myReturnData: 'hello world' });
	}

	render() {
		return html`
			<div>
				<h1>My Modal</h1>
				<button @click=${this._handleCancel}>Cancel</button>
				<button @click=${this._handleSubmit}>Submit</button>
			</div>
		`;
	}
}
```
