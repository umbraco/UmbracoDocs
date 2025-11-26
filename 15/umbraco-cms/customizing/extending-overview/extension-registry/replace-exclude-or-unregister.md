---
description: >-
  You may want to replace or completely remove an extension. Depending on your
  interest, 3 different options are available.
---

# Replace, Exclude or Unregister

## Replace

If you want to bring your own extension and remove an existing,  define your Extension to replace one or more other Extensions.

This can be done by defining `overwrites` of your manifest with one Extension-alias or an array of Extension-aliases. [Read more about the Manifest Declaration here.](extension-manifest.md)

Overwrite a single extension:

```typescript
const manifest = {
    type: 'workspaceAction',
    alias: 'my.WorkspaceAction.ExternalPreview',
    name: 'My workspace action for external preview',
    overwrites: 'Umb.WorkspaceAction.Document.SaveAndPreview'
    ...
};
```

Overwrite multiple extensions:

```typescript
const manifest = {
    type: 'workspaceAction',
    alias: 'my.WorkspaceAction.ExternalPreview',
    name: 'My workspace action for external preview',
    overwrites: ['Umb.WorkspaceAction.Document.SaveAndPreview', 'Umb.WorkspaceAction.Document.Save']
    ...
};
```

Once your extension is displayed in the same spot as the one defined in `overwrites`, those will be hidden.

If your extension has conditions, then the overwrites will only be hidden when your extension is displayed. This means that the overwrites only have an effect if all the conditions are permitted and the extensions are displayed at the same spot.

## Exclude

To make an extension go away completely, you should exclude it. This approach secures that the extension will never be presented.

The following JavaScript code hides the `Save and Preview` button from the Document Workspace.

```typescript
import { UmbExtensionRegistry } from '@umbraco-cms/backoffice/extension-api';

UmbExtensionRegistry.exclude('Umb.WorkspaceAction.Document.SaveAndPreview');
```

## Unregister

You can also choose to unregister an extension, this is only preferred if you registered the extension and are in control of the flow. If it's not your Extension, seek to use the `Overwrites` or `Exclude` feature.

```typescript
import { umbExtensionsRegistry } from '@umbraco-cms/backoffice/extension-registry';

umbExtensionsRegistry.unregister('My.WorkspaceAction.AutoFillWithUnicorns');
```

This will not prevent the Extension from being registered again.

A use case for this is if you temporarily registered an extension and you like to remove it again.
