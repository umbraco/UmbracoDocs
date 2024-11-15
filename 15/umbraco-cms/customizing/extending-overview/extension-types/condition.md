---
description: Learn how to declare requirements for your extensions using the Extension Conditions.
---

# Extension Conditions

Extension Conditions declare requirements that should be permitted for the extension to be available. Many, but not all, Extension Types support Conditions.

[Read about utilizing conditions in Manifests](../extension-conditions/extension-conditions.md).

## Built-in conditions types <a href="#core-conditions-types" id="core-conditions-types"></a>

The following conditions are available out of the box, for all extension types that support Conditions.

* `Umb.Condition.SectionAlias` - Requires the current Section Alias to match the one specified.
* `Umb.Condition.MenuAlias` - Requires the current Menu Alias to match the one specified.
* `Umb.Condition.WorkspaceAlias` - Requires the current Workspace Alias to match the one specified.
* `Umb.Condition.WorkspaceEntityType` - Requires the current workspace to work on the given Entity Type. Examples: 'document', 'block' or 'user'.
* `Umb.Condition.WorkspaceContentTypeAlias` - Requires the current workspace to be based on a Content Type which Alias matches the one specified.
* `Umb.Condition.Workspace.ContentHasProperties` - Requires the Content Type of the current Workspace to have properties.
* `Umb.Condition.WorkspaceHasCollection` - Requires the current Workspace to have a Collection.
* `Umb.Condition.WorkspaceEntityIsNew` - Requires the current Workspace data to be new, not yet persisted on the server.
* `Umb.Condition.EntityIsTrashed` - Requires the current entity to be trashed.
* `Umb.Condition.EntityIsNotTrashed` - Requires the current entity to not be trashed.
* `Umb.Condition.SectionUserPermission` - Requires the current user to have permissions to the given Section Alias.
* `Umb.Condition.UserPermission.Document` - Requires the current user to have specific Document permissions. Example: 'Umb.Document.Save'

## Make your own conditions

```html
<a href="#make-your-own-conditions" id="make-your-own-conditions"></a>
```

You can make your own Conditions by creating a class that implements the `UmbExtensionCondition` interface.

```typescript
import {
  ManifestCondition,
  UmbConditionConfigBase,
  UmbConditionControllerArguments,
  UmbExtensionCondition
} from '@umbraco-cms/backoffice/extension-api';
import { UmbConditionBase } from '@umbraco-cms/backoffice/extension-registry';
import { UmbControllerHost } from '@umbraco-cms/backoffice/controller-api';

export type MyExtensionConditionConfig = UmbConditionConfigBase & {
  match: string;
};

export class MyExtensionCondition extends UmbConditionBase<MyExtensionConditionConfig> implements UmbExtensionCondition {
  constructor(host: UmbControllerHost, args: UmbConditionControllerArguments<MyExtensionConditionConfig>) {
    super(host, args);

    // enable extension after 10 seconds
    setTimeout(() => {
      this.permitted = true;
      args.onChange();
    }, 10000);
  }
}

// Declare the Condition Configuration Type in the global UmbExtensionConditionConfigMap interface:
declare global {
    interface UmbExtensionConditionConfigMap {
        MyExtensionConditionConfig: MyExtensionCondition;
    }
}
```

This has to be registered in the extension registry, shown below:

```typescript
export const manifest: ManifestCondition = {
 type: 'condition',
 name: 'My Condition',
 alias: 'My.Condition.CustomName',
 api: MyExtensionCondition,
};
```

Finally, you can make use of the condition in your configuration. See an example of this below:

```typescript
{
 type: 'workspaceAction',
 name: 'example-workspace-action',
 alias: 'My.Example.WorkspaceAction',
 elementName: 'my-workspace-action-element',
 conditions: [
  {
    alias: 'Umb.Condition.SectionAlias',
    match: 'My.Example.Workspace'
  },
  {
    alias: 'My.Condition.CustomName'
  }
 ]
}
```

As can be seen in the code above, we never make use of `match`. We can do this by replacing the timeout with some other check.

```typescript
// ...

export class MyExtensionCondition extends UmbConditionBase<MyExtensionConditionConfig> implements UmbExtensionCondition {
  constructor(host: UmbControllerHost, args: UmbConditionControllerArguments<MyExtensionConditionConfig>) {
    super(host, args);

    if (args.config.match === 'Yes') {
      this.permitted = true;
      args.onChange();
    }
  }
}

// ...
```

With all that in place, the configuration can look like shown below:

```typescript
{
 // ...
 conditions: [
  // ...
  {
    alias: 'My.Condition.CustomName',
    match: 'Yes'
  }
 ]
}
```
