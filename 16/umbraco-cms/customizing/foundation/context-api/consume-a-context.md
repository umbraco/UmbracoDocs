---
description: >-
  Consuming a Context via the Context API is the way to start the communication
  with the rest of the application
---


----
New structure:
•	Section 3: How to Consume Contexts
•	Using consumeContext() method
•	Working with context callbacks
•	Handling undefined/unavailable contexts
•	One simple example

----

# Consume a Context

## Start consuming

There are different ways to consume a Context API. The most straightforward implementation is done on an [Umbraco Element](../umbraco-element/) with a Context Token.

All Umbraco Context APIs have a Context Token which can be imported and used for consumption, for example:

```typescript
import { UMB_NOTIFICATION_CONTEXT } from '@umbraco-cms/backoffice/notification';

...

this.consumeContext(UMB_NOTIFICATION_CONTEXT, (context) => {
    // Notice this is a subscription, meaning the context can change and even disappear again.
    if (context) {
        console.log("I've got the Notification Context: ", context);
    } else {
        console.log("The Notification Context is gone, I will make sure my code disassembles properly.")
    }
});
```

The above example takes place in an Umbraco Element or Umbraco Controller.

### Alternative solutions

The above examples utilize an Umbraco Controller to hook into an element's life cycle. This Controller is named `UmbContextConsumerController`.

If you need to consume a Context API from a non-controller host, then look at the `UmbContextConsumer`.

## Get a context once

You can retrieve a Context without getting updated if the Context disconnects or another better Context matches your request.

This is useful if your code is a one-time execution, for example, when the user triggers an action that needs to communicate with a context:

<pre class="language-typescript"><code class="lang-typescript">async execute() {
<strong>    const notificationContext = await this.getContext(UMB_NOTIFICATION_CONTEXT);
</strong>    if (!notificationContext) {
	throw new Error('Notification context not found');
    }
    const notification = { data: { message: `High five, you executed this method!` } };
    notificationContext.peek('positive', notification);
}
</code></pre>

## **Write your own Context Token**

A Context Token is a context identifier and is generally a string matched with a type. In this way, users of the token can be sure to get the right type of context.

```typescript
import { UmbContextToken } from "@umbraco-cms/backoffice/context-api";

type MyContext = {
    foo: string;
    bar: number;
};

const MY_CONTEXT = new UmbContextToken <MyContext>("My.Context.Token");
```

### **Context Token with an API Alias**

For additions to already existing Contexts, the API Aliases should be used to identify the additional API. Using the same Context Alias for additional APIs will ensure that such API must be present with the first encounter of that Context Alias. Otherwise, a request will be rejected. In other words, if the addition is not part of the nearest matching Context, the request will be rejected.

For a concrete example of this in practice, read the [Extension Type Workspace Context](../../extending-overview/extension-types/workspaces/workspace-context.md) article.

{% hint style="info" %}
Using API Alias is highlight recommended when implementing Additional Contexts to Existing Contexts. Most Context extensions should do this.
{% endhint %}

```typescript
import { UmbContextToken } from "@umbraco-cms/backoffice/context-api";

type MyAdditionalContext = {
    additional: string;
};

const MY_ADDITIONAL_API_TOKEN = new UmbContextToken<MyAdditionalContext>(
    "My.ContextFrame.Alias",
    "My.API.Alias"
);
```

The Token declared above can be used to provide an additional Context API at the same Element as another Context API is provided at. Below is an example of how the two APIs are made available.

```typescript
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

This is no different than using two different Context Aliases. But it has an important effect on what happens if one of them is not provided. This is demonstrated in the example below:

```typescript
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
    console.log("I will just get undefined: ", context);
});
```

The consumption of the Additional API will never happen as the token uses the same Context Alias as `MY_API_TOKEN`. This means that any request containing this Context Alias will be stopped at the first API it encounters. To ensure addition to a specific context, do it locally at the nearest API that uses the same Context Alias.

### **Context Token with a Type Discriminator**

{% hint style="info" %}
This is only relevant if you are going to make multiple context API for the same context. Discriminator only gives value for consumption of Context APIs that have a varying interface. The backoffice uses this for the different types of Workspace Contexts.
{% endhint %}

In some cases, it is needed to have different APIs for the same context. For example, the [Workspace Contexts](../../extending-overview/extension-types/workspaces/workspace-context.md).

If someone wants the workspace name, they might not care about the specific API of the Workspace Context. These implementations can use a standard Context Token with a type of generic Workspace Context.

The features related to Publishing in the **Document Workspace Context** do not require a new Context. However, we should not accidentally retrieve the workspace context of a parent workspace when in a Workspace. Therefore, we need to provide a workspace context in each workspace, and the one we retrieve is the one we will be using. Since Publishing is not part of the generic Workspace Context, check if the context is a Document Workspace Context and recast it accordingly.

To avoid each implementation taking care of this, Context Tokens can be extended with a **Type Discriminator**. This will discard the given API if it does not meet the necessary requirements. When it is the desired type, the API will be converted to the appropriate type.

This example shows how to create a discriminator Context Token that will discard the API if it is not a Publishable Context:

**Context Token Example:**

```typescript
import { UmbContextToken } from "@umbraco-cms/backoffice/context-api";

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
>("My.Context.Token", undefined, (context): context is MyPublishableContext => {
    return "publish" in context;
});
```

**Implementation of Context Token Example:**

```typescript
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

This allows implementers to request a publishable context without needing to know the Type or how to identify the context.

In detail, the Context API will search for the first API that matches the alias `My.Context.Token`, and not look further. If the API meets the type discriminator, it will be returned, otherwise the consumer will never reply.
