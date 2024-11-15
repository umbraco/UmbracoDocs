---
description: Learn how to use Extension Conditions when working with the Umbraco backoffice.
---

# Extension Conditions

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

Extension Manifest Conditions enable you to declare requirements for an Extension before it becomes available.

## Utilizing Conditions in your Manifest

Conditions are referenced via their alias. The Declaration of a Condition is shown in the following example:

```typescript
const manifest = {
    type: 'workspaceView',
    ...
    conditions: [
        {
            alias: 'Umb.Condition.WorkspaceAlias',
            match: 'Umb.Workspace.Document',
        },
    ],
};
```

By declaring a condition the extension will become available only once the condition is permitted.

The example above requires the nearest Workspaces Alias to be equal to `'Umb.Workspace.Document'`.

When declaring multiple conditions all of them must be permitted for the extension to be available.

## Condition Configuration

The conditions are defined as an array of condition configurations. Each entry can contain the following properties:

* `alias`- The alias of the condition to utilize.
* `...` - The rest of the properties of the object are specific to the condition configuration.

## Learn more

Learn about built-in conditions and how to create your own:

{% content-ref url="extension-types/condition.md" %}
Condition Extension Type
{% endcontent-ref %}
