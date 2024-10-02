# Extension Kind

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

Extension Manifest Kind enables declarations to be based upon a preset Manifest.

Either for maintainability or to inherit existing features.

## Manifest Kind Declaration

A kind is utilized by declaring it in the `kind` field of a Manifest:

```typescript
const manifest = {
    type: 'headerApp',
    kind: 'button',
    ...
};
```

By declaring a kind the Manifest will inherit fields of the defined kind preset manifest.

Typical use case is a kind that provides a element, but requires additional Meta fields, to fulfill the needs of its element.

In the following example a Manifest using the type `headerApp` utilizes the kind `button` which brings an element and requires some additional information as part of the meta object.

Providing the ability to use and configure existing functionality to a specific need:

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

## Learn more

Learn more about kinds and how to create your own:

{% content-ref url="../extension-types/kind.md" %}
[Kind Extension Type](../extension-types/kind.md)
{% endcontent-ref %}
