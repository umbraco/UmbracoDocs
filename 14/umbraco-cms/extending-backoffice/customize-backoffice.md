---
description: This is how you get started with the new Backoffice and Umbraco 14.
---

# Customize Backoffice

{% hint style="warning" %}
This page is a work in progress. It will be updated as the software evolves.
{% endhint %}

Whether you're building Umbraco packages or implementing backoffice extensions, you can find resources for development here.

[Lit](https://lit.dev/) and [TypeScript](https://www.typescriptlang.org/) have been used for building the new backoffice. Developers are free to use any framework and libraries of their choice to implement the backoffice extensions.

In this section of the documentation, we'll provide an overview of the different ways you can extend the backoffice using the new frameworks.

<table data-view="cards"><thead><tr><th></th><th></th><th></th><th data-hidden data-card-cover data-type="files"></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody><tr><td></td><td><a href="development-flow/"><strong>Setup</strong></a></td><td>Discover how to get started with the new backoffice.</td><td><a href="../.gitbook/assets/Documentations Icons_Umbraco_CMS_Fundamentals_Setup (1).png">Documentations Icons_Umbraco_CMS_Fundamentals_Setup (1).png</a></td><td><a href="development-flow/">development-flow</a></td></tr><tr><td></td><td><a href="ui-documentation.md"><strong>UI Documentation</strong></a></td><td>Discover how to extend the backoffice using the Umbraco UI Library, UI API and Storybook.</td><td><a href="../.gitbook/assets/Documentations Icons_Umbraco_CMS_Fundamentals_Design.png">Documentations Icons_Umbraco_CMS_Fundamentals_Design.png</a></td><td><a href="ui-documentation.md">ui-documentation.md</a></td></tr></tbody></table>

## Terminology <a href="#terminology" id="terminology"></a>

There are a few words that cover certain concepts, which is good to learn to decode the purpose of code.

* **Resource:** An API enables communication with a server.
* **Store:** An API representing data, generally coming from the server. Most stores would talk with one or more resources. You can read more about this in the [Store](working-with-data/store.md) article.
* **State:** A reactive container holding data, when data is changed all its Observables will be notified. You can read more about state and observables in the [States](working-with-data/states.md) article.
  * **Observable:** An observable is the hook for others to subscribe to the data of a State.
  * **Observe:** Observe is the term of what we do when subscribing to an Observable.
* **Context-API:** The name of the system used to serve APIs (instances/classes) for a certain context in the DOM. An API that is served via the Context-API is called a Context. You can read more about this in the [Context API](working-with-data/context-api.md) article.
  * **Context Provider:** One that provides a class instance as a Context API.
  * **Context Consumer:** One that consumer subscribes to a class instance as a Context API.
* **Controller:** An abstract term for a thing that hooks into the lifecycle of an element. Many things in our system are Controllers.
* **Umbraco Controller:** Enables hosting controllers. Additionally, it provides a few shortcut methods for initializing core Umbraco Controllers. You can read more about this in the [Controllers](umbraco-element/controllers/) article.
  * **Controller Host:** A class that can host controllers.
  * **Controller Host Element:** The element that can host controllers.
* **Umbraco Element:** The `UmbLitElement` or `UmbElemenMixin` enables hosting controllers. Additionally, it provides a few shortcut methods for initializing core Umbraco Controllers. You can read more about this in the [Umbraco Element](umbraco-element/) article.
