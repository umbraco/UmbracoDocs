---
description: A list of some of the key concepts with working the Umbraco Backoffice.
---

# Terminology

Understanding certain key concepts is essential when customizing the backoffice. These terminologies can help you decode the purpose of code effectively:

* **Repository:** An API that enables communication with a server.
* **State:** A reactive container holding data, when data is changed, all its Observables will be notified. You can read more about states and observables in the [States](states.md) article.
  * **Observable:** An observable is the hook for others to subscribe to the data of a State.
  * **Observe:** Observe describes what we do when subscribing to an Observable.
* **Context-API:** The name used to serve APIs (instances/classes) for a certain context in the DOM. An API that is served via the Context-API is called a Context. You can read more about this in the [Context API](context-api/) article.
  * **Context Provider:** Enables providing a class instance as a Context API.
  * **Context Consumer:** Enables the consumption of a Context API.
* **Controller:** An abstract term for a thing that hooks into the lifecycle of an element. Many things in our system are Controllers.
* **Umbraco Controller:** Enables hosting controllers. Additionally, it provides a few shortcut methods for initializing core Umbraco Controllers. You can read more about this in the [Umbraco Controllers](umbraco-controller/) article.
  * **Controller Host:** A class that can host controllers.
  * **Controller Host Element:** The element that can host controllers.
* **Umbraco Element:** The `UmbLitElement` or `UmbElemenMixin` enables hosting controllers. Additionally, it provides a few shortcut methods for initializing core Umbraco Controllers. You can read more about this in the [Umbraco Element](umbraco-element/) article.

Read more about how to get started with extending the backoffice in the [Backoffice Setup](../extending-overview/) article.
