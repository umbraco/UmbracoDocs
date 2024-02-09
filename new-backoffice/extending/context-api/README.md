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
import { UmbContextToken } from "@umbraco-cms/backoffice/context";

type MyContext = {
    foo: string;
    bar: number;
};

const MY_CONTEXT = new UmbContextToken <MyContext>("My.Context.Token");
```

### **Context Token with an API Alias**

For additions to Contexts, we can use the API Aliases to identify the additional API. Using the same Context Alias for additional APIs will ensure that such API has to be present with the first encounter of that Context Alias. Otherwise, a request will be rejected.
In other words, if the addition is not part of the nearest matching Context, then a request will be rejected.

{% hint style="info" %}
Using API Alias only provides value when two or more APIs should share the same Context.
This is needed for Context Extensions that are provided along with other Contexts.
{% endhint %}

```ts
import { UmbContextToken } from "@umbraco-cms/backoffice/context";

type MyAdditionalContext = {
    additional: string;
};

const MY_ADDITIONAL_API_TOKEN = new UmbContextToken<MyAdditionalContext>(
    "My.ContextFrame.Alias",
    "My.API.Alias"
);
```

The Token declared above can then be used to provide an additional Context API at the same Element as another Context API is provided at.
The example below shows how the two APIs are made available.

```ts
const contextElement = new UmbLitElement();
contextElement.provideContext(
    MY_API_TOKEN,
    new MyAPiFromSomewhereNotPartOfThisExample()
);
contextElement.provideContext(
    MY_ADDITIONAL_API_TOKEN,
    new MyAdditionalAPiFromSomewhereNotPartOfThisExample()
);

const consumerElement = new UmbLitElement();
contextElement.appendChild(consumerElement);
consumerElement.consumeContext(MY_API_TOKEN, (context) => {
    console.log("I've got the default api", context);
});
consumerElement.consumeContext(MY_ADDITIONAL_API_TOKEN, (context) => {
    console.log("I've got the additional api", context);
});
```

This is no different than using two different Context Aliases. But has an important effect on what happens in one of them are not provided. This is begin demonstrated in the example below:

```ts
const upperContextElement = new UmbLitElement();

const contextElement = new UmbLitElement();
upperContextElement.appendChild(contextElement);
contextElement.provideContext(
    MY_API_TOKEN,
    new MyAPiFromSomewhereNotPartOfThisExample()
);

const consumerElement = new UmbLitElement();
contextElement.appendChild(consumerElement);
consumerElement.consumeContext(MY_API_TOKEN, (context) => {
    console.log("I've got the default api", context);
});
consumerElement.consumeContext(MY_ADDITIONAL_API_TOKEN, (context) => {
    // This will never happen
    console.log("I've got the additional api", context);
});
```

The consumption of the Additional API will never happen as the token uses the same Context Alias as `MY_API_TOKEN`. That means the request will never go further up than its first encounter with this Context Alias. Securing that the addition was of this Context has to be local to the nearest present API of that Context Alias.

### **Context Token with a Type Discriminator**

{% hint style="info" %}
Discriminator only gives value for consumption of Context APIs that have a varying interface.
Backoffice uses this for the different types of Workspace Contexts.
{% endhint %}

In some cases, it is needed to have different APIs for the same context. The [Workspace Contexts](../extension-types/workspaces/workspace-context.md) is a good example of this.

If someone wants the workspace name, they might not care about the specific API of the Workspace Context. These implementations can use a standard Context Token with a type of generic Workspace Context.

The **Document Workspace Context** has features around Publishing. A new Context is not needed for these features, as when in a Workspace we shouldn't accidentally retrieve the workspace context of a parent workspace. So we need to provide a workspace context in each workspace, the one we retrieve is the one we will be using. But since publishing is not part of the generic Workspace Context, we need to identify if the context is a Document Workspace Context. Then it needs to be recast.

To avoid each implementation taking care of this, Context Tokens can be extended with a **type discriminator**. This will discard the given API if it does not live up to the needs. When it is the desired type, it will cast the API to the desired type.

This example shows how to create a discriminator Context Token, that will discard the API if it is not a Publishable Context:

Context token example:

```ts
import { UmbContextToken } from "@umbraco-cms/backoffice/context";


interface MyBaseContext {
    foo: string;
    bar: number;
}

interface MyPublishableContext extends MyBaseContext {
    publish();
}

const MY_PUBLISHABLE_CONTEXT = new UmbContextToken<

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
