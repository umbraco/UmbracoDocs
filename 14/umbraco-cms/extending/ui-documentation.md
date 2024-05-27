---
description: Find out more about Umbraco UI Library, UI API and Storybook.
---

# UI Documentation

## UI Library and UI API

With the UI Library, you get a collection of visual building blocks that consists of pieces to build any UI in Umbraco. Each component is a building block updating its display according to the data passed to it.

With the UI API, you get a set of collections related to modules export, interfaces, and hierarchy. This includes code examples and much more that you can use to extend the backoffice.

<table data-card-size="large" data-view="cards" data-full-width="false"><thead><tr><th></th><th></th><th data-hidden data-card-target data-type="content-ref"></th><th data-hidden data-card-cover data-type="files"></th></tr></thead><tbody><tr><td><a href="https://apidocs.umbraco.com/v14/ui/"><strong>Backoffice UI Library</strong></a></td><td>See, test, and get a feel for the familiar backoffice components built using the new UI components.</td><td><a href="https://apidocs.umbraco.com/v14/ui/">https://apidocs.umbraco.com/v14/ui/</a></td><td><a href="../.gitbook/assets/Documentations Icons_Umbraco_CMS_Fundamentals_Backoffice (1) (2).png">Documentations Icons_Umbraco_CMS_Fundamentals_Backoffice (1) (2).png</a></td></tr><tr><td><a href="https://apidocs.umbraco.com/v14/ui-api/index.html"><strong>Backoffice UI API</strong></a></td><td>See what all of the modules export, interfaces, hierarchy, code examples, and much more.</td><td><a href="https://apidocs.umbraco.com/v14/ui-api/index.html">https://apidocs.umbraco.com/v14/ui-api/index.html</a></td><td><a href="../.gitbook/assets/Documentations Icons_Umbraco_CMS_Tutorials_the_Starter_Kit (1).png">Documentations Icons_Umbraco_CMS_Tutorials_the_Starter_Kit (1).png</a></td></tr></tbody></table>

## UI Icons

The icons from the Umbraco backoffice are based on [Lucide Icons](https://lucide.dev/). The syntax for getting the icons starts with`icon-`. You can find the list of all icons in the [Icon registry list on Github](https://github.com/umbraco/Umbraco.CMS.Backoffice/tree/762e43b2f49ca483df9cfe28de20f31ca07bb22b/src/packages/core/icon-registry/icons).

## UI Library Storybook

The Umbraco UI Library is a set of web components that can be used to build Umbraco User Interfaces. The UI Library separates the user interface from Umbraco’s business logic and creates a unified user experience. This is done with coherent styling and naming, across all the Umbraco platforms and projects including the ones developed by you.

[Storybook](https://uui.umbraco.com/) is an application that gathers all the components together of the UI Library. It holds the documentation for the components and showcases different use case scenarios. You can explore all the components through stories reflecting their use cases.

Each story has interactive controls that allow you to change the state of the component in real time. Every publicly available property is editable in Storybook, so you can test out custom configurations and use cases.

You can also change the stylesheet of custom properties to see how the component will look like. Every story has a code example that you can copy and paste into your project. This will allow you to implement the components in your own packages and extensions.

### Getting Started with the UI Library

The [Storybook](https://uui.umbraco.com/) is the starting point for working with the Umbraco UI Library. The Storybook contains two tabs:

1. Canvas - The Canvas tab allows to use the interactive controls.

    <figure><img src="../../../10/umbraco-cms/extending/images/Canvas_tab (1).png" alt=""><figcaption></figcaption></figure>
2. Docs - Here, you can find code examples for all the stories and use them in your markup. You can look it up by tag name or head to the project repository, where, in the packages folder, you will find all the component packages with all the necessary scripts and examples in the readme files.

    <figure><img src="../../../10/umbraco-cms/extending/images/Docs_tab (1) (2).png" alt=""><figcaption></figcaption></figure>

### Install the UI Library Components

You can download the UI Library package from [Github](https://github.com/umbraco/Umbraco.UI/tree/v1/contrib/packages).

If you are installing a component via npm, there are two ways to import it:

1. To import a specific component and register it at the same time, use the following command:

```sql
import { UUIButtonElement } from '@umbraco-ui/uui-button';
```

2. To build on top of the components functionality, you can extend its class:

```sql
import { UUIButtonElement } from '@umbraco-ui/uui-button/lib/uui-button.element';
```

For more information on installation, Content Delivery Networks (CDN), or included components, see the[Readme file in the Github](https://github.com/umbraco/Umbraco.UI#readme)project.

### Import UI Library Components

You can also work with the components on a code level. If you want to do so here is how you import it:

```typescript
import { UUIButtonElement } from '@umbraco-cms/backoffice/external/uui';
```

This requires that your Package has the `@umbraco-cms/backoffice` dependency.
