---
description: >-
  Contain or reuse logic across Elements. A Controller enables you to separate
  logic while still being connected with the life cycle of an element.
---

# Umbraco Controller

An Umbraco controller provides all the features of an Umbraco element within a separate class. Do this for architectural reasons or to reuse a feature across elements.

## Host Element

A Controller is assigned to a Host Element. This assignment may be indirect, since Controllers can host other Controllers.

The host element is a web component enhanced to host controllers. All [Umbraco Elements](../umbraco-element/) are controller hosts, as are all Umbraco controllers, allowing controllers to host other controllers.

To retrieve the controller’s host element, use the `getHostElement()` method.

## Element Life Cycle

Controllers can declare the following methods, which are triggered depending on the host element’s life cycle:

* `hostConnected()` — Called when the host element connects to the DOM.
* `hostDisconnected()` — Called when the host element disconnects from the DOM.
* `destroy()` — Called when the controller is taken out of commission.

Additionally, Umbraco Controllers implement a `getHostElement()` method, which enables any Controller to receive the Element that hosts the Controllers.

## Registration

A Controller should register itself with a given host. This is handled automatically when extending the `UmbControllerBase` class. The following example demonstrates a controller implementation:

<pre><code>import { UmbControllerBase } from '@umbraco-cms/backoffice/class-api';
import type { UmbControllerHost } from '@umbraco-cms/backoffice/controller-api';
<strong>
</strong>export class MyOwnControllerImplementation extends UmbControllerBase {

    #secondsAlive = 0;

    constructor(host: UmbControllerHost) {
        // Parse the host to the base class, this will trigger the registration.
        super(host);
    }
    
    hostConnected() {
        // It's important to call the super method when overriding a method of the base class.
        super.hostConnected();
        this.#timer = setInterval(this.#onInterval, 1000)
    }
    
    hostDisconnected() {
        // It's important to call the super method when overriding a method of the base class.
        super.hostDisconnected();
        clearInterval(this.#timer);
    }
    
    #onInterval = () => {
        this.#secondsAlive++;
        console.log(`My own controller have been connected in ${this.#secondsAlive} seconds.`);
    }

    override destroy(): void {
        // It's important to call the super method when overriding a method of the base class.
        super.destroy();
        // We do not need to stop the timer in the Destroy method, because the hostDisconnected method is also called if connected and destroyed.
    }
}
</code></pre>

If you don't like to extend the `UmbControllerBase`, then you can register a class as a controller as shown in the following example. Note that manual unregistration is required in this case.

```
export class MyOwnControllerImplementation {

    #host: UmbControllerHost;

    constructor(host: UmbControllerHost) {
        this.#host = host;
        this.#host.addUmbController(this);
    }
    
    override destroy(): void {
        this.#host.removeUmbController(this);
    }
}
```
