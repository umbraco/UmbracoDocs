---
description: A guide for getting started working with the Umbraco UI Library
---

# UI Library

{% hint style="info" %}
The UI Library is currently _opt-in_. We recommend Backoffice and package developers start getting familiar with it.

In the [Backoffice UI API Documentation](backoffice-ui-api-documentation.md) article you can find links to relevant resources for working with the Umbraco backoffice.
{% endhint %}

The Umbraco UI Library is a set of web components that can be used to build Umbraco User Interfaces. The UI Library separates the user interface from Umbraco’s business logic and creates a unified user experience. This is done with coherent styling and naming, across all the Umbraco platforms and projects including the ones developed by you.

With the UI Library, you get a collection of visual building blocks that consists of pieces to build any UI in Umbraco. Each component is a building block updating its display according to the data passed to it.

## UI Library Storybook

[Storybook](https://uui.umbraco.com/) is an application that gathers all the components together of the UI Library. It holds the documentation for the components and showcases different use case scenarios. You can explore all the components through stories reflecting their use cases.

Each story has interactive controls that allows you to change the state of the component in real-time. Every publicly available property is editable in Storybook, so you can test out custom configurations and use-cases.

You can also change the stylesheet of custom properties to see how the component will look like. Every story has a code example that you can copy and paste into your project. This will allow you to implement the components in your own packages and extensions.

## Installing the UI Library Components

You can download the UI Library package from [GitHub](https://github.com/umbraco/Umbraco.UI/tree/v1/contrib/packages).

If you are installing a component via npm, there are two ways to import it:

1.  To import a specific component and register it at the same time, use the following command:

    ```sql
    import '@umbraco-ui/uui-button/lib';
    ```
2.  To build on top of the components functionality, you can extend its class:

    ```sql
    import { UUIButtonElement } from
    '@umbraco-ui/uui-button/lib/uui-button.element';
    ```

For more information on installation, Content Delivery Networks (CDN), or included components, see the[ Readme file in the GitHub ](https://github.com/umbraco/Umbraco.UI#readme)project.

## Getting Started with the UI Library

The [Storybook](https://uui.umbraco.com/) is the starting point for working with the Umbraco UI Library. The Storybook contains two tabs:

1.  Canvas - The Canvas tab allows to use the interactive controls.

    <figure><img src="images/Canvas_tab.png" alt=""><figcaption></figcaption></figure>
2.  Docs - Here, you can find code examples for all the stories and use them in your markup. You can look it up by tag name or head to the project repository, where, in the packages folder, you will find all the component packages with all the necessary scripts and examples in the readme files.

    <figure><img src="images/Docs_tab.png" alt=""><figcaption></figcaption></figure>
