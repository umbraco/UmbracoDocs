---
description: >-
  Consuming a Context via the Context API is the way to start the communication
  with the rest of the application
---
# Consume a Context
There are two ways to consume a context: get a __one-time reference__ to the context, or get a __subscription__ for handling context changes. The Context API is a flexible system where contexts can get disonnected or replaced. A subscription allows for the handling of these changes. However, subscriptions use more resources and are typically consumed in the constructor, a time when the computer is already processing a lot. Which way to go depends on your use case.

If you need a context from the moment your element loads and you hold on to the context by putting it into a variable, you should always use the subscription. Otherwise you risk holding on to a context that could be disconnected or replaced without you knowing. Also if you're observing properties of a context, you want know if the context is still available and a subscription also makes the best sense.

A one-time reference is great for fire-and-forget events in your element. Those include events that occur after user interaction. The key here is that the context is not needed when the element is initialized, but only needed then a specific criteria is met. We just need to get a context to do something, but after that, there is no reason to keep the context. 

When you're dealing with a subscription, it's good practice to consume the context in the constructor for the following reasons:

* The constructor runs once when the element is created, ensuring your context subscription is set up before the element connects to the DOM. This guarantees you won't miss any context updates that occur during the element's initialization.
* Context consumers created in the constructor are automatically connected when the element enters the DOM (`connectedCallback`) and disconnected when it's removed (`disconnectedCallback`). You don't need to manually manage this lifecycle—Umbraco's controller system handles it for you.
* By establishing context subscriptions in the constructor, your element's state is consistent from the moment it's created. This prevents race conditions where the element might render or perform actions before its required contexts are available.
* Creating context consumers in the constructor is more efficient than creating them in lifecycle methods that can be called multiple times (like `connectedCallback`, which fires every time the element is added to the DOM).

## Consuming contexts in an element
An [Umbraco Element](../umbraco-element/) is **any web component** that extends `UmbLitElement` or uses `UmbElementMixin` to wrap its base class. Whether you're building with Lit, vanilla JavaScript, or any other web component framework, you can make it an Umbraco Element with full access to the Context API.

Umbraco Elements provide two methods for consuming contexts:

- **`getContext(token)`** - Retrieves a one-time reference to a context
- **`consumeContext(token, callback)`** - Creates a reactive subscription to a context

Both methods accept a Context Token (or string alias) to identify which context to consume.

### Get as one-time reference
The first example uses Lit and that is the way Umbraco builds their elements. If you don't want to use Lit, there is also an example using vanilla Javascript. Both examples don't have any TypeScript specific code, so you either use them in a JavaScript or TypeScript file.

{% tabs %}
{% tab title="Lit element" %}
```javascript
import { UMB_NOTIFICATION_CONTEXT } from '@umbraco-cms/backoffice/notification';
import { html } from '@umbraco-cms/backoffice/external/lit';
import { UmbLitElement } from '@umbraco-cms/backoffice/lit-element';

//The example element extends the UmbLitElement (which is the same as UmbElementMixin(LitElement))
//This gives us all the helpers we need to get or consume contexts
export default class ExampleElement extends UmbLitElement {

    /** Notification handler for the notification button */
    async #notificationButtonClick {
        //We try to get an instance of the context
        const notificationContext = await this.getContext(UMB_NOTIFICATION_CONTEXT);
        if (!notificationContext) {
            throw new Error('Notification context not found!');
        }
        
        notificationContext?.peek("positive", {
            data: {
                headline: "Success",
                message: "The notification button was clicked successfully!"
            }
        });

        //The notification is sent, now forget the context
    }

    /**
     * Renders the lit component
     * @see https://lit.dev/docs/components/rendering/
     */
    render() {
        return html`
            <uui-button look="primary" color="default" @click="${this.#notificationButtonClick}">
                Click me for a notification!
            </uui-button>
        `;
    }
}

// Register the custom element
customElements.define('example-element', ExampleElement);
```
{% endtab %}
{% tab title="HTML element" %}
```javascript
import { UMB_NOTIFICATION_CONTEXT } from '@umbraco-cms/backoffice/notification';
import { UmbElementMixin } from '@umbraco-cms/backoffice/element-api';

// The example element extends UmbElementMixin with HTMLElement
// This gives us all the helpers we need to get or consume contexts
export default class ExampleElement extends UmbElementMixin(HTMLElement) {
    constructor() {
        super();
        this.attachShadow({ mode: 'open' });
        this.#render();
    }

    /** Renders the element **/
    #render() {
        if (!this.shadowRoot) 
            return;
        
        this.shadowRoot.innerHTML = `
            <uui-button look="primary" color="default" id="notificationButton">
                Click me for a notification!
            </uui-button>
        `;
        
        const button = this.shadowRoot.querySelector('#notificationButton');
        button?.addEventListener('click', this.#notificationButtonClick.bind(this));
    }

    /** Notification handler for the notification button */
    async #notificationButtonClick {
        
        //We try to get an instance of the context
        const notificationContext = await this.getContext(UMB_NOTIFICATION_CONTEXT);
        if (!notificationContext) {
            throw new Error('Notification context not found!');
        }
        
        notificationContext?.peek("positive", {
            data: {
                headline: "Success",
                message: "The notification button was clicked successfully!"
            }
        });

        //The notification is sent, now forget the context
    }
}

// Register the custom element
customElements.define('example-element', ExampleElement);
```
{% endtab %}
{% endtabs %}

### Get as a subscription
The first example uses Lit and that is the way Umbraco builds their elements. If you don't want to use Lit, there is also a Lit-less example. Both examples don't have any TypeScript specific code, so you either use them in a JavaScript or TypeScript file.

{% tabs %}
{% tab title="Lit element" %}
```javascript
import { UmbLitElement } from '@umbraco-cms/backoffice/lit-element';
import { UMB_DOCUMENT_WORKSPACE_CONTEXT } from '@umbraco-cms/backoffice/document';

//The example element extends the UmbLitElement (which is the same as UmbElementMixin(LitElement))
//This gives us all the helpers we need to get or consume contexts
export default class ExampleElement extends UmbLitElement {
    #workspaceContext;

    constructor() {
        super();

        // This is a subscription that gets executed if:
        // - The context gets connected
        // - The context instance changes (replaced)
        // - The context instance disconnects
        this.consumeContext(UMB_DOCUMENT_WORKSPACE_CONTEXT, (context) => {
            if (context) {
                console.log("I've got the document workspace context: ", context);
                this.#workspaceContext = context;
            } else {
                console.log("The document workspace context is gone, I will make sure my code disassembles properly.")
                this.#workspaceContext = null;
            }
        });
    }
}

// Register the custom element
customElements.define('example-element', ExampleElement);
```
{% endtab %}
{% tab title="HTML element" %}
```javascript
import { UmbElementMixin } from '@umbraco-cms/backoffice/element-api';
import { UMB_DOCUMENT_WORKSPACE_CONTEXT } from '@umbraco-cms/backoffice/document';

// The example element extends UmbElementMixin with HTMLElement
// This gives us all the helpers we need to get or consume contexts
export default class ExampleElement extends UmbElementMixin(HTMLElement) {
    #workspaceContext;

    constructor() {
        super();

        // This is a subscription that gets executed if:
        // - The context gets connected
        // - The context instance changes (replaced)
        // - The context instance disconnects
        this.consumeContext(UMB_DOCUMENT_WORKSPACE_CONTEXT, (context) => {
            if (context) {
                console.log("I've got the document workspace context: ", context);
                this.#workspaceContext = context;
            } else {
                console.log("The document workspace context is gone, I will make sure my code disassembles properly.")
                this.#workspaceContext = null;
            }
        });
    }
}

// Register the custom element
customElements.define('example-element', ExampleElement);
```
{% endtab %}
{% endtabs %}

## Consuming contexts in non-UI elements
Not all code that needs contexts lives in UI elements (web components). Services, managers, repositories, and helper classes often need access to contexts like notifications, workspaces, or application state, but they don't exist as elements in the DOM.

For these non-UI classes, extend `UmbControllerBase` to gain the same context consumption capabilities as elements. This base class provides `getContext()` and `consumeContext()` methods, allowing any class with a controller host to access the Context API.

### Get as one-time reference
This example creates an example service that can show a notification in the backoffice of Umbraco based on the given text.

```javascript
import { UmbControllerBase } from '@umbraco-cms/backoffice/class-api';
import { UMB_NOTIFICATION_CONTEXT } from '@umbraco-cms/backoffice/notification';

//The example element extends the UmbLitElement (which is the same as UmbElementMixin(LitElement))
//This gives us all the helpers we need to get or consume contexts
export default class ExampleService extends UmbControllerBase {
    async ShowNotification(notificationText) {
        
        //We try to get an instance of the context
        const notificationContext = await this.getContext(UMB_NOTIFICATION_CONTEXT);
        if (!notificationContext) {
            throw new Error('Notification context not found!');
        }
        
        notificationContext?.peek("positive", {
            data: {
                headline: "Success",
                message: notificationText
            }
        });

        //The notification is sent, now forget the context
    }
}
```

### Get as a subscription
This example consumes the document workspace context and saves it to a variable to be used later.

```javascript
import { UmbControllerBase } from '@umbraco-cms/backoffice/class-api';
import { UMB_DOCUMENT_WORKSPACE_CONTEXT } from '@umbraco-cms/backoffice/document';

// This service class extends UmbControllerBase
// This gives us access to getContext() and consumeContext()
export class ExampleService extends UmbControllerBase {
    #workspaceContext;

    constructor(host) {
        super(host);
        
        // Subscribe to the notification context
        this.consumeContext(UMB_DOCUMENT_WORKSPACE_CONTEXT, (context) => {
            if (context) {
                console.log("I've got the document workspace context: ", context);
                this.#workspaceContext = context;
            } else {
                console.log("The document workspace context is gone, I will make sure my code disassembles properly.")
                this.#workspaceContext = null;
            }
        });
    }
}
```

## Manual context control
In rare cases, you may need complete manual control over context consumption without extending `UmbControllerBase` or using element mixins. This is typically necessary when:

- Integrating with third-party libraries or frameworks
- Working with legacy code that can't be refactored
- Building custom architectural patterns outside Umbraco's standard controller system

For these scenarios, use `UmbContextConsumer` directly. This low-level API gives you full control but requires manual lifecycle management (`hostConnected()`, `hostDisconnected()`, and `destroy()`).

{% hint style="warning" %}
**Use this approach only when necessary.** The methods shown in previous sections (`UmbLitElement`, `UmbElementMixin`, `UmbControllerBase`) handle lifecycle management automatically and suitable for most use cases.
{% endhint %}

### Get as one-time reference
To create the one-time reference, you don't provide a callback when calling the UmbContextConsumer. This makes it destroy itself when going out of scope.
```javascript
import { UmbContextConsumer } from '@umbraco-cms/backoffice/context-api';
import { UMB_NOTIFICATION_CONTEXT } from '@umbraco-cms/backoffice/notification';

export class NotificationService {
    #hostElement;

    constructor(hostElement) {
        this.#hostElement = hostElement;
    }

    async showSuccess(message) {
        // Create a consumer WITHOUT a callback
        const consumer = new UmbContextConsumer(
            this.#hostElement,
            UMB_NOTIFICATION_CONTEXT
            // No callback = one-time use
        );
        
        // Trigger connection and get result as Promise
        consumer.hostConnected();
        const notificationContext = await consumer.asPromise();
        
        if (!notificationContext) {
            throw new Error('Notification context not found!');
        }
        
        notificationContext.peek("positive", {
            data: {
                headline: "Success",
                message: message
            }
        });
        
        // Consumer auto-destroys when no callback provided
    }
}
```

### Get as a subscription
In contrast to the one-time reference, a callback is provided. This makes it a subscription. You need to disconnect and destroy the context consumer yourself. This example creates a custom `DocumentService` that consumes the `Document Workspace Context`.

```javascript
import { UmbContextConsumer } from '@umbraco-cms/backoffice/context-api';
import { UMB_DOCUMENT_WORKSPACE_CONTEXT } from '@umbraco-cms/backoffice/document';

export class DocumentService {
    #workspaceContext;
    #workspaceContextConsumer;

    constructor(hostElement) {
        // Manually create the context consumer
        this.#workspaceContextConsumer = new UmbContextConsumer(
            hostElement,
            UMB_DOCUMENT_WORKSPACE_CONTEXT,
            (context) => {
                if (context) {
                    console.log("I've got the document workspace context: ", context);
                    this.#workspaceContext = context;
                } else {
                    console.log("The document workspace context is gone, I will make sure my code disassembles properly.");
                    this.#workspaceContext = null;
                }
            }
        );
        
        // Manually trigger the connection
        this.#workspaceContextConsumer.hostConnected();
    }

    destroy() {
        // Manually clean up
        this.#workspaceContextConsumer.hostDisconnected();
        this.#workspaceContextConsumer.destroy();
    }
}

```