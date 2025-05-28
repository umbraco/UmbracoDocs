---
description: >-
  A store holds data throughout the session. It is used to create reactivity
  across different parts.
---

# Store

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

## Store

A store is the link between a Resource and a Repository. A store is mainly taken from a Context API. In other words, we have to Consume the Context (Store) to get the Store.

Generally, a Store will hold one or more [State Objects](states.md), with each Subject made available for Observation via Observables.

### A Basic Store

```typescript
class MyProductStore {
	#products = new UmbArrayState(<Array<MyProductType>>[], (product) => product.id);

	public readonly products = this.#products.asObservable();

	protected host: UmbControllerHostElement;
	constructor(host: UmbControllerHostElement) {
		this.host = host;

		// The Store provides it self as a Context-API.
		new UmbContextProviderController(_host, 'MyStoreContextAlias', this);
	}
}
```

In this example, we created an ArrayState, A State which is specific to Arrays. This holds the data for one or more Observables to convey to outsiders.

This example shows how to use the store:

```typescript
class MyImplementation extends UmbLitElement {
	private _myProductStore?: MyProductStore;

	constructor() {
		super();

		// Notice the consume callback is triggered initially and every time the Context is changed.
		this.consume('MyStoreContextAlias', (context) => {
			this._myProductStore = context;

			this._observeAllProducts();
		});
	}

	private _observeAllProducts() {

		// Notice this callback will be triggered initially and each time the products change:
		this.observe(this._myProductStore?.products, (products) => {
			console.log('The data of all products is:', products);
		});
	}
}
```

#### A bit more meaningful Store

Here we added a method that returns an Observable that is specific to the requested product.

```typescript
class MyProductStore {

	...

	getByKey(id: string) {

		// Request data via a Resource to then take part of this state when received.
		tryExecuteAndNotify(this.host, ProductResource.getByKey({id})).then(({ data }) => {
			if (data) {
				this.#products.append(data.items);
			}
		});

		// Return a Observable part, to listen for this specific product and the future changes of it.
		return this.#data.asObservablePart((documents) =>
			documents.find((document) => document.id === id)
		);
	}
}
```

An example implementation using this method:

```typescript
class MyImplementation extends UmbLitElement {
	private _myProductStore?: MyProductStore;

	constructor() {
		super();

		// Notice the consume callback is triggered initially and every time the Context is changed.
		this.consume('MyStoreContextAlias', (context) => {
			this._myProductStore = context;

			this._observeASpecificProduct();
		});
	}

	private _observeASpecificProduct() {

		// Notice this callback will be triggered initially and each time the specific product change:
		this.observe(this._myProductStore?.getByKey('1234'), (product) => {
			console.log('The data of product `1234`` is:', product);
		});
	}
}
```

**Create many Observables**

A Store must hold different Observables, some exceptionally general and others highly specific, all in perspective of the types of observers we aim to accommodate.

This example gives some inspiration to how fine-grained this can become:

```typescript
class MyProductStore {
  #products = new UmbArrayState(<Array<MyProductType>>[]);

  public readonly products = this.#products.asObservable();
  public readonly amountOfProducts = this.#products.asObservablePart((products) => products.length);
  public readonly topTenRatedProducts = this.#products.asObservablePart((products) => products.sort((a, b) => b.rating - a.rating).slice(0, 10));

  ...
}
```

An observer of an Observable will only be triggered if the specific part of that data has changed. With this we can make a high-performance application, only triggering the parts that need to update when data is changed.

**Ensure unique data**

For incoming data to replace existing data, we need to clarify what makes an entry of the array unique. In the examples of this guide, each product has an `id`. We have clarified this to the State by giving it the little method `(product) => product.id` as part of its creation:

```typescript
class MyProductStore {
  #products = new UmbArrayState(<Array<MyProductType>>[], (product) => product.id);
  ...
}
```
