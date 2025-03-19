---
description: Learn how to use the Kind extension in your manifest files when extending the Umbraco CMS backoffice.
---

# Extension Kind

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

The **Extension Manifest Kind** is used to declare a preset configuration that other extensions can inherit. It ensures maintainability and consistency when creating extensions for the Umbraco CMS backoffice. By using a Kind, developers can reuse predefined settings, which reduces redundancy across extensions.

When a Kind is applied, the extension's manifest inherits the fields defined in the Kind. This approach prevents the need to repeat configuration details across multiple extensions.

## Manifest Kind Declaration

A **Kind** is declared in the `kind` field of the manifest, which is part of the extension registration process. The declaration is linked to a specific extension type.

```typescript
const manifest = {
    type: 'headerApp', // The type of the extension
    kind: 'button',  // The kind alias to inherit settings from
    ...
};
```

By setting the `kind` field, the extension automatically inherits all properties associated with that **Kind**. This is useful when you want to standardize a component (like a button) across multiple extensions.

## Using the Kind for Inheritance

A Kind not only defines the basic configuration but may also require additional metadata to fully configure the element or component.

### Example: Using the Button Kind in a Header App

```typescript
const manifest = {
    type: 'headerApp',
    kind: 'button',
    name: 'My Header App Example',
    alias: 'My.HeaderApp.Example',
    meta: {
        label: 'My Example',
        icon: 'icon-home',
        href: '/some/path/to/open/when/clicked',
    },
};
```

In this example:

- The `kind: 'button'` inherits all default settings from the **Button Kind**.
- The `meta` object is added to configure additional properties, such as the button's label, icon, and the URL to open when clicked.

The Kind allows you to extend existing functionality and tailor it to specific needs while maintaining consistency.

For a deeper dive into Kind and how to create your own, see the [Kind](extension-types/kind.md) article.
