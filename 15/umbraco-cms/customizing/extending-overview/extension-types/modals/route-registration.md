# Route Registration

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

You can register modals with a route, making it possible to link directly to that specific modal. This also means the user can navigate back and forth in the browser history.&#x20;

A modal can be registered via the `UmbModalRouteRegistrationController`. The registration accepts a modal token (or extension alias).

```ts
this.myModalRegistration = new UmbModalRouteRegistrationController(
    this,
    UMB_LINK_PICKER_MODAL
)
    .onSubmit((submitData) => {
        console.log("Modal submitted with data".submitData);
    })
    .observeRouteBuilder((routeBuilder) => {
        this._modalRouteBuilder = routeBuilder;
    });
```

The registration holds an instance of its `UmbModalHandler` when the modal is active. The modal registration accepts 4 different callbacks:

* `onSetup` - called when the modal is opened
* `onSubmit` - called when the modal is submitted
* `onReject` - called when the modal is rejected
* `observeRouteBuilder` - called when the modal route changes. Use the given route builder to build a route to open the modal

**Additional features of the route Registration:**

* Adds unique parts to the path.&#x20;
* A modal registered in a dashboard can be setup in few steps
* A modal registered in a property editor needs to become specific for the property and the variant of that property.
* Builds some data for the setup.
* Rejects a modal by returning false in setup.
* Uses a parameter as part of the setup to determine the data going to the modal.

## Modal registration for UI as part of a Property Editor

When configuring a routed modal from a Property Editor, it's important to be aware of some facts. Those facts are that the Property Editor shares the same URL path as other Property Editors. This means we need to ensure the registration is unique so it doesn't collide with other Property Editors. To do so we will make use of the Property Alias and the Variant ID.

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

The Modal registration has an option to retrieve a URL Builder. This is a function that can be used to generate a URL to a modal:

```ts
const modalLink = _myUrlBuilder?.({ alias: "my-input-alias" });
```

The `modalLink` from above could look like this: `/umbraco/backoffice/my/location/modal/Our.Modal.SomethingPicker/my-input-alias`

Notice the Property Editor registration will add the property alias and variant ID to the URL, so it becomes:

`/umbraco/backoffice/my/location/modal/Our.Modal.SomethingPicker/my-property-alias/en-us/my-input-alias`
