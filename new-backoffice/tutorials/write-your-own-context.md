---
description: Provide your own Context, to enable communication across extensions
---

# Write your own Context API

A Context is an instance of a class that is provided with the Context API.

To give your Context API power and encapsulate the execution you should base your Context API on an Umbraco Controller. [Read more about Controllers here](../extending/umbraco-element/controllers/)

Notice how you can provide a Global Context API via the [GlobalContext Extension Type](../extending/extension-types/global-context.md).

### Provide Context

The following example shows how to write a self-providing Context:

```typescript
import { UmbController, type UmbControllerHost } from '@umbraco-cms/backoffice/controller-api';
import { UmbContextToken } from '@umbraco-cms/backoffice/context-api';

export const MY_OWN_CONTEXT = new UmbContextToken<MyOwnContext>('my-own-context')

class MyOwnContext extends UmbController {
	constructor(host: UmbControllerHost) {
		super(host);
		this.provideContext('umbPropertyActionMenu', this);
	}
}
```

Example of an element that instantiates your Context, for itself or any descending elements or Controllers to consume:

```typescript
export class MyElement extends UmbElementMixin(LitElement) {
  
  constructor() {
    super();
    new MyOwnContext(this);
  }
```
