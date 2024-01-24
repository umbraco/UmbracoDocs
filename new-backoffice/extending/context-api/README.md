---
description: Communicate across different boundaries with the Context API
---

# Context API

The Context API enables receiving APIs. Depending on where your code is executed from, it affects which and what instances of APIs can be received.\
\
The Context API enables an element or a controller, to receive an API provided via any ascending element. In other words, it can receive APIs provided via a parent element or parent of a parent element, and so forth.

## Consume a Context API

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

## **Write your own Context Token**

A Context Token is generally a string matched with a type. In this way, users of the token can be sure to get the right type of context.

```ts
import { ContextToken } from "@umbraco-cms/backoffice/context";

type MyContext = {
    foo: string;
    bar: number;
};

const MY_CONTEXT = new ContextToken<MyContext>("My.Context.Token");
```

### **Context Token with a Type Discriminator**

{% hint style="info" %}
This is only relevant if you are going to make multiple context APIs for the same context.
{% endhint %}

In some cases, it is needed to have different APIs for the same context. The [Workspace Contexts](../extension-types/workspaces/workspace-context.md) is a good example of this.

If someone wants the workspace name, they might not care about the specific API of the Workspace Context. These implementations can use a standard Context Token with a type of generic Workspace Context.

The **Document Workspace Context** has features around Publishing. A new Context is not needed for these features, as when in a Workspace we shouldn't accidentally retrieve the workspace context of a parent workspace. So we need to provide a workspace context in each workspace, the one we retrieve is the one we will be using. But since publishing is not part of the generic Workspace Context, we need to identify if the context is a Document Workspace Context. Then it needs to be recast.

To avoid each implementation taking care of this, Context Tokens can be extended with a **type discriminator**. This will discard the given API if it does not live up to the needs. When it is the desired type, it will cast the API to the desired type.

This example shows how to create a discriminator Context Token, that will discard the API if it is not a Publishable Context:

Context token example:

```ts
import { ContextToken } from "@umbraco-cms/backoffice/context";

interface MyBaseContext {
    foo: string;
    bar: number;
}

interface MyPublishableContext extends MyBaseContext {
    publish();
}

const MY_PUBLISHABLE_CONTEXT = new ContextToken<
    MyContext,
    MyPublishableContext
>("My.Context.Token", (context): context is MyPublishableContext => {
    return "publish" in context;
});
```

Implementation of context token example:

```ts
const contextElement = new UmbLitElement();
contextElement.provideContext(
    MY_PUBLISHABLE_CONTEXT,
    new MyPublishableContext()
);

const consumerElement = new UmbLitElement();
contextElement.appendChild(contextElement);
consumerElement.consumeContext(MY_PUBLISHABLE_CONTEXT, (context) => {
    // context is of type 'MyPublishableContext'
    console.log("I've got the context of the right type", context);
});
```

This enables implementors to request a publishable context, without the knowledge about how to identify such, nor do they need to know about the Type.

In detail, the Context API will find the first API matching alias`My.Context.Token`, and never look further. If that API does live up to the type discriminator, it will be returned. If not the consumer will never reply.
