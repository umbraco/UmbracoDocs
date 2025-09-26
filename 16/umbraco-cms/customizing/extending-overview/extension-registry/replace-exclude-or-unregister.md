---
description: >-
  You may want to replace or completely remove an extension. Depending on your
  interest, 3 different options are available.
---

# Replace, Exclude or Unregister
Besides adding extensions to Umbraco, sometimes you want to change what's already there. You can replace extensions with your own and exclude or unregister extensions.

## Replace
You can have an extension that replaces another extension.
This can be done by defining `overwrites` of your [manifest](extension-manifest.md) with one Extension-alias or an array of Extension-aliases that need to be replaced.



This example overrides the save and preview button with an external preview button (single overwrite):

```typescript
const manifest = {
    type: 'workspaceAction',
    alias: 'my.WorkspaceAction.ExternalPreview',
    name: 'My workspace action for external preview',
    overwrites: 'Umb.WorkspaceAction.Document.SaveAndPreview'
    ...
};
```

This example overrides both the save and preview button as well as the save button with an external preview button (multiple overwrite):

```typescript
const manifest = {
    type: 'workspaceAction',
    alias: 'my.WorkspaceAction.ExternalPreview',
    name: 'My workspace action for external preview',
    overwrites: ['Umb.WorkspaceAction.Document.SaveAndPreview', 'Umb.WorkspaceAction.Document.Save']
    ...
};
```

If your extension has conditions, then the overwrites will only be hidden when your extension is displayed. This means that the overwrites only have an effect if all the conditions are permitted and the extensions are displayed at the same spot.

## Exclude
When you exclude an extension, the extension will never be displayed. This allows for permanently hiding for example a menu or a button. This does not unregister the extensions, but rather flags it as excluded. This also means that no-one else can register an extension with the same alias as the excluded extension.

{% hint style="warning" %}
Currently, it's not possible to un-exclude extensions once excluded.
{% endhint %}

The following JavaScript code hides the `Save and Preview` button from the Document Workspace.

```typescript
import { UmbExtensionRegistry } from '@umbraco-cms/backoffice/extension-api';

UmbExtensionRegistry.exclude('Umb.WorkspaceAction.Document.SaveAndPreview');
```
When and where to execute this code is up to you and depending on your situation. But in a lot of cases, it makes sense to execute this on boot, using the [the entry point approach](../extension-types/backoffice-entry-point.md).

## Unregister
You can also choose to unregister an extension. It's recommended to only use this of on extension you registered yourself and have control over. Otherwise you might try to remove an extension before it's registered. A use case for this is if you temporarily registered an extension and you like to remove it again.

In other cases you can use the `overwrites` or `exclude` option. The difference with the `exclude` approach, is that unregistering removes the extension from the extension registry. This allows for re-registering extensions with the same alias.

```typescript
import { umbExtensionsRegistry } from '@umbraco-cms/backoffice/extension-registry';

umbExtensionsRegistry.unregister('My.WorkspaceAction.AutoFillWithUnicorns');
```

When and where to execute this code is up to you and depending on your situation. But in a lot of cases, it makes sense to execute this on boot, using the [the entry point approach](../extension-types/backoffice-entry-point.md).


