---
description: Communicate across different boundaries with the Context API
---

# Context API

The Context API enables receiving APIs. Depending on where your code is executed from, it affects which and what instances of APIs can be received.\
\
The Context API enables an element or a controller, to receive an API provided via any ascending element. In other words, it can receive APIs provided via a parent element or parent of a parent element, and so forth.

### Consume a Context API

There a different ways to consume a Context API. The most straightforward implementation is done on an Umbraco Element with a Context Token.

A Context Token is a context identifier.

All Umbraco Context APIs have a Context Token which can be imported and used for consumption. Similar to this example:

```typescript
import { UMB_NOTIFICATION_CONTEXT } from '@umbraco-cms/backoffice/notification';

...

this.consumeContext(UMB_NOTIFICATION_CONTEXT, (context) => {
	// Notice this is a subscription, as the context might change or a new one appears.
	console.log("I've got the typed context: ", context);
});
```

The above example takes place in an Umbraco Element or Umbraco Controller.

### Alternative solutions

The above examples utilize an Umbraco Controller to hook into an element's life cycle, this Controller is named `UmbContextConsumerController`.

If you need to consume a Context API from a non-controller host, then look at the `UmbContextConsumer`.
