---
description: Extend the Umbraco backoffice by building custom extensions using the extension system, foundation APIs, and UI utilities.
---

# Backoffice Extensions

The Umbraco backoffice is built on an extension system. Almost every part of the UI is an extension, which means you can append, replace, or remove UI elements to tailor the backoffice to your needs.

<table data-view="cards"><thead><tr><th></th><th></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody><tr><td><strong>Setup Your Development Environment</strong></td><td>Configure your local environment to build and test backoffice extensions.</td><td><a href="development-flow/">development-flow</a></td></tr><tr><td><strong>Extending Overview</strong></td><td>Understand the extension architecture and how to append, replace, or remove parts of the backoffice UI.</td><td><a href="extending-overview/">extending-overview</a></td></tr><tr><td><strong>Foundation</strong></td><td>Learn the core framework for building extensions, including integration, communication, and reactive UIs.</td><td><a href="foundation/">foundation</a></td></tr><tr><td><strong>Contexts</strong></td><td>Use the Context API to access commonly used backoffice contexts in your extensions.</td><td><a href="contexts/">contexts</a></td></tr><tr><td><strong>Property Editors</strong></td><td>Build custom property editors for use in Document Types and content editing.</td><td><a href="property-editors/">property-editors</a></td></tr><tr><td><strong>Utilities</strong></td><td>Use code utilities available for customizing the backoffice in your extensions.</td><td><a href="utilities/">utilities</a></td></tr></tbody></table>

## Additional Resources

* [Umbraco Package](umbraco-package.md) - start every extension with an Umbraco Package manifest.
* [Workspaces](workspaces.md) - create dedicated editing environments for specific entity types.
* [UI Library](ui-library.md) - use the Umbraco Backoffice UI Library, UI API, and Storybook.
* [Icons](icons.md) - work with icons in the backoffice.
* [Signs](signs.md) - use flag information from Management API responses in your extensions.
* [Property-Level UI Permissions](property-level-ui-permissions.md) - control UI visibility at the property level.
* [Examples and Playground](examples-and-playground.md) - explore examples and a live playground for backoffice extensions.

## Umbraco Training

{% include "../../.gitbook/includes/umbraco-extending-the-backoffice-training-course.md" %}
