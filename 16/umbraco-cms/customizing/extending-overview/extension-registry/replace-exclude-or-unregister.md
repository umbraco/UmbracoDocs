---
description: >-
  You may want to replace or completely remove an extension. Depending on your
  interest, 3 different options are available.
---


# Replace, Exclude or Unregister
Besides adding extensions to Umbraco, sometimes you want to change what is already there. You can replace extensions with your own and exclude or unregister extensions.


## Replace
You can replace an existing extension by another one.
You can do this by defining the `overwrites` property in your [Extension Manifest](extension-manifest.md) with one Extension Alias. For multiple `overwrites` you can provide the Extension Aliases that need to be replaced as an array.




This example overrides the `save and preview` button with an external "preview" button (single overwrite):

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


If your extension has conditions, the overwritten extensions will only be hidden when your extension is displayed. This means that the overwrites only have an effect if all the conditions are permitted and the extensions are displayed at the same spot.


## Exclude
When you exclude an extension, the extension will never be displayed. This allows you to permanently hide, for example, a menu or a button. This does not unregister the extensions, but rather flags them as excluded. This also means that no one else can register an extension with the same alias as the excluded extension.


{% hint style="warning" %}
Currently, it is not possible to un-exclude extensions once excluded.
{% endhint %}


The following JavaScript code hides the `Save and Preview` button from the Document Workspace.

```typescript
import { UmbExtensionRegistry } from '@umbraco-cms/backoffice/extension-api';

UmbExtensionRegistry.exclude('Umb.WorkspaceAction.Document.SaveAndPreview');
```

When and where you execute this code depends on your situation. In many cases, it makes sense to execute this on boot, using the [entry point approach](../extension-types/backoffice-entry-point.md).


## Unregister
You can also choose to unregister an extension. You should only use this on extensions you registered yourself and have control over. Otherwise, you might try to remove an extension before it is registered. A use case for this is if you temporarily registered an extension and you want to remove it again.

In other cases, you can use the `overwrites` or `exclude` option. The difference with the `exclude` approach is that unregistering removes the extension from the Extension Registry. This allows you to re-register extensions with the same alias.

```typescript
import { umbExtensionsRegistry } from '@umbraco-cms/backoffice/extension-registry';

umbExtensionsRegistry.unregister('My.WorkspaceAction.AutoFillWithUnicorns');
```


When and where you execute this code depends on your situation. In many cases, it makes sense to execute this on boot, using the [entry point approach](../extension-types/backoffice-entry-point.md).


