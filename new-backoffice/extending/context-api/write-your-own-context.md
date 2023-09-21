---
description: Provide your own Context, to enable communication across extensions
---

# Write your own Context

A Context is an instance of a class that is provided with the Context API.

### Provide

The following example shows how to provide your own Context via an Umbraco Element.

```typescript
import { UmbContextToken } from '@umbraco-cms/backoffice/context-api';

class MyOwnContext {
  // Your code here
}

export const MY_OWN_CONTEXT = new UmbContextToken<MyOwnContext>('my-own-context')

// Example of the element which provides a Context:
export class MyElement extends UmbElementMixin(LitElement) {
  
  constructor() {
    super();

    this.provideContext(MY_OWN_CONTEXT, new MyOwnContext())
  }
```
