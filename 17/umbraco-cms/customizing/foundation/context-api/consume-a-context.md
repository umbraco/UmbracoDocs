---
description: >-
  Learn how to consume contexts in Umbraco elements using one-time references
  or subscriptions to access data and functionality through the Context API.
---
# Consume a Context
There are two ways to consume a context: get a __one-time reference__ to the context, or get a __subscription__ for handling context changes. The Context API is a flexible system where contexts can get disconnected or replaced. A subscription allows for the handling of these changes. However, subscriptions use more resources. They are typically consumed in the constructor, a time when the computer is already processing a lot. Which way to go depends on your use case.

A one-time reference approach is suitable for fire-and-forget events. The key here is that the context is not needed on initialization, but is only needed when a specific criteria is met. For instance, events that occur after user interaction or when a specific function is called. In that case, you need to get a context, do something and forget about the context after that.

If you need a context during initialization which is then set as a variable, you should always use a subscription. Otherwise, you risk holding on to a context that could be disconnected or replaced without you knowing.

## Consuming contexts in an element
An [Umbraco Element](../umbraco-element/) is **any web component** that extends `UmbLitElement` or uses the `UmbElementMixin` to wrap its base class. Whether you are building with Lit, vanilla JavaScript, or any other web component framework, you can make it an Umbraco Element. This gives it full access to the Context API.

Umbraco Elements provide two methods for consuming contexts:

- **`getContext(token)`** - Retrieves a one-time reference to a context
- **`consumeContext(token, callback)`** - Creates a reactive subscription to a context

Both methods accept a Context Token (or string alias) to identify which context to consume.

### Get as one-time reference
The first example uses Lit and that is the way Umbraco builds their elements. If you do not want to use Lit, there is also an example using vanilla JavaScript. Both examples do not have any TypeScript specific code. You can use them in either a JavaScript or a TypeScript file.

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
    async #notificationButtonClick() {
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
    async #notificationButtonClick() {
        
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
When you are dealing with a subscription, it is good practice to consume the context in the constructor for the following reasons:

* The constructor runs once when the element is created. This ensures your context subscription is set up before the element connects to the DOM. This guarantees you will not miss any context updates that occur during the element's initialization.
* Context consumers created in the constructor are automatically connected when the element enters the DOM (`connectedCallback`). They are disconnected when it is removed (`disconnectedCallback`). You do not need to manually manage this lifecycle as Umbraco's controller system handles it for you.
* By establishing context subscriptions in the constructor, your element's state is consistent from the moment it is created. This prevents race conditions where the element might render or perform actions before its required contexts are available.
* Creating context consumers in the constructor is more efficient than creating them in lifecycle methods that are called multiple times. For example, `connectedCallback` fires every time the element is added to the DOM.

The first example uses Lit and that is the way Umbraco builds their elements. If you do not want to use Lit, there is also an HTML element example. Both examples do not have any TypeScript specific code. You can use them in either a JavaScript or a TypeScript file.

{% tabs %}
{% tab title="Lit element" %}
```javascript
import { UmbLitElement } from '@umbraco-cms/backoffice/lit-element';
import { UMB_DOCUMENT_WORKSPACE_CONTEXT } from '@umbraco-cms/backoffice/document';

// The example element extends the UmbLitElement (which is the same as UmbElementMixin(LitElement))
// This gives us all the helpers we need to get or consume contexts
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
Not all code that needs contexts lives in UI elements (web components). Services, managers, repositories, and helper classes often need access to contexts. These may include notifications, workspaces, or application state. However, they do not exist as elements in the DOM.

For these non-UI classes, extend `UmbControllerBase` to gain the same context consumption capabilities as elements. This base class provides `getContext()` and `consumeContext()` methods. This allows any class with a controller host to access the Context API.

### Get as one-time reference
This example creates an example service that can show a notification in the backoffice of Umbraco based on the given text.

```javascript
import { UmbControllerBase } from '@umbraco-cms/backoffice/class-api';
import { UMB_NOTIFICATION_CONTEXT } from '@umbraco-cms/backoffice/notification';

// This service class extends UmbControllerBase
// This gives us access to getContext() and consumeContext()
export default class ExampleService extends UmbControllerBase {
    async showNotification(notificationText) {
        
        // We try to get an instance of the context
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

        // The notification is sent, now forget the context
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
        
        // Subscribe to the document workspace context
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
In rare cases, you may need complete manual control over context consumption. This means not extending `UmbControllerBase` or using element mixins. This is typically necessary when:

- Integrating with third-party libraries or frameworks
- Working with legacy code that cannot be refactored
- Building custom architectural patterns outside Umbraco's standard controller system

For these scenarios, use `UmbContextConsumer` directly. This low-level API gives you full control but requires manual lifecycle management. You must call `hostConnected()`, `hostDisconnected()`, and `destroy()`.

{% hint style="warning" %}
**Use this approach only when necessary.** The methods shown in previous sections handle lifecycle management automatically. These include `UmbLitElement`, `UmbElementMixin`, and `UmbControllerBase`. They are suitable for most use cases.
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
        
        try {
            // Trigger connection and get result as Promise
            consumer.hostConnected();

            // The promise will reject if the context is not found within one animation frame
            // You can prevent this with: consumer.asPromise({ preventTimeout: true })
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
        } finally {
            // Manually clean up to ensure proper disconnection
            consumer.hostDisconnected();
            consumer.destroy();
        }
    }
}
```

### Get as a subscription
In contrast to the one-time reference, a callback is provided. This makes it a subscription. You need to disconnect and destroy the context consumer yourself. This example creates a custom `DocumentService` that consumes the Document Workspace Context.

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
                    // Context is available
                    console.log("I've got the document workspace context: ", context);
                    this.#workspaceContext = context;
                } else {
                    // Context not yet available OR has been removed
                    // This can happen on initial creation or when unprovided                    
                    console.log("The document workspace context is gone, I will make sure my code disassembles properly.");
                    this.#workspaceContext = null;
                }
            }
        );
    }

    // Public method that should be called by the host element's connectedCallback
    hostConnected() {
        this.#workspaceContextConsumer.hostConnected();
    }

    // Public method that should be called by the host element's disconnectedCallback
    hostDisconnected() {
        this.#workspaceContextConsumer.hostDisconnected();
    }

    destroy() {
        // Manually clean up
        this.#workspaceContextConsumer.destroy();
    }
}
```

To use this service, the host element must call the lifecycle methods:

```javascript
import { UmbLitElement } from '@umbraco-cms/backoffice/lit-element';
import { DocumentService } from './document-service.js';

export default class MyElement extends UmbLitElement {
    #documentService;

    constructor() {
        super();
        this.#documentService = new DocumentService(this);
    }

    connectedCallback() {
        super.connectedCallback();
        // Notify the service that the host is connected
        this.#documentService.hostConnected();
    }

    disconnectedCallback() {
        super.disconnectedCallback();
        // Notify the service that the host is disconnected
        this.#documentService.hostDisconnected();
    }
}
```
