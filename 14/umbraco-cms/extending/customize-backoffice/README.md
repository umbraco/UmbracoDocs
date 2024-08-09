---
description: Get started with the New Backoffice in Umbraco 14.
---

# Customize Backoffice

## Overview

"Bellissima", code name for the frontend code of the backoffice, is a re-creation of the backoffice of Umbraco with a more modern approach. While replacing the deprecated angular code with [Vite](https://vitejs.dev/), [Lit](https://lit.dev/) and [TypeScript](https://www.typescriptlang.org/), you can customize or extend more or less everything in the backoffice:

<figure><img src="../../.gitbook/assets/backoffice-overview-customizations.png" alt=""><figcaption><p>Backoffice Overview Customizable items</p></figcaption></figure>

Each block is an extension point that can be extended, customized, replaced, or removed.

You are also not limited to the mentioned frameworks. You can use any other framework or library of your choice. The new backoffice will be available in the Umbraco CMS from Version 14.

## Resources

In this article, we'll provide an overview of how you can extend the backoffice using the new frameworks.

<table data-view="cards"><thead><tr><th></th><th></th><th></th><th data-hidden data-card-cover data-type="files"></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody><tr><td></td><td><a href="development-flow/"><strong>Setup Your Development Environment</strong></a></td><td>Discover how to get started with the new backoffice.</td><td><a href="../../.gitbook/assets/Documentations Icons_Umbraco_CMS_Fundamentals_Setup (1).png">Documentations Icons_Umbraco_CMS_Fundamentals_Setup (1).png</a></td><td><a href="development-flow/">development-flow</a></td></tr><tr><td></td><td><a href="../ui-documentation.md"><strong>UI Documentation</strong></a></td><td>Discover how to extend the backoffice using the Umbraco UI Library, UI API and Storybook.</td><td><a href="../../.gitbook/assets/Documentations Icons_Umbraco_CMS_Fundamentals_Design.png">Documentations Icons_Umbraco_CMS_Fundamentals_Design.png</a></td><td><a href="../ui-documentation.md">ui-documentation.md</a></td></tr><tr><td></td><td><a href="../../tutorials/overview.md"><strong>Tutorials</strong></a></td><td><a href="../../tutorials/creating-your-first-extension.md">Creating your first extension</a><br><br><a href="../../tutorials/creating-a-custom-dashboard/">Creating a custom dashboard</a><br><br><a href="../../tutorials/creating-a-property-editor/">Creating a property editor</a></td><td><a href="../../.gitbook/assets/Documentations Icons_Umbraco_CMS_Tutorials_the_Starter_Kit (1).png">Documentations Icons_Umbraco_CMS_Tutorials_the_Starter_Kit (1).png</a></td><td></td></tr></tbody></table>

{% hint style="info" %}
You can also find a list of other resources related to the new backoffice of Umbraco in the [Umbraco v14 "Bellissima" Resources](https://github.com/umbraco/Umbraco.Packages/tree/main/bellissima) article.
{% endhint %}

## Terminology <a href="#terminology" id="terminology"></a>

There are a few words that cover certain concepts, which is good to learn to decode the purpose of code. These terminologies can be handy when starting to customize the new backoffice:

* **Resource:** An API enables communication with a server.
* **Store:** An API representing data, generally coming from the server. Most stores would talk with one or more resources. You can read more about this in the [Store](../foundation/working-with-data/store.md) article.
* **State:** A reactive container holding data, when data is changed all its Observables will be notified. You can read more about state and observables in the [States](../foundation/working-with-data/states.md) article.
  * **Observable:** An observable is the hook for others to subscribe to the data of a State.
  * **Observe:** Observe is the term of what we do when subscribing to an Observable.
* **Context-API:** The name of the system used to serve APIs (instances/classes) for a certain context in the DOM. An API that is served via the Context-API is called a Context. You can read more about this in the [Context API](../foundation/working-with-data/context-api.md) article.
  * **Context Provider:** One that provides a class instance as a Context API.
  * **Context Consumer:** One that consumer subscribes to a class instance as a Context API.
* **Controller:** An abstract term for a thing that hooks into the lifecycle of an element. Many things in our system are Controllers.
* **Umbraco Controller:** Enables hosting controllers. Additionally, it provides a few shortcut methods for initializing core Umbraco Controllers. You can read more about this in the [Controllers](../foundation/umbraco-element/controllers/) article.
  * **Controller Host:** A class that can host controllers.
  * **Controller Host Element:** The element that can host controllers.
* **Umbraco Element:** The `UmbLitElement` or `UmbElemenMixin` enables hosting controllers. Additionally, it provides a few shortcut methods for initializing core Umbraco Controllers. You can read more about this in the [Umbraco Element](../foundation/umbraco-element/) article.

Read more about various ways how to get started with extending the backoffice in the [Backoffice Setup](broken-reference) article.
