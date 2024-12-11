---
description: >-
  Learn how to declare requirements for your extensions using the Extension
  Conditions.
---

# Extension Conditions

Extension Conditions declare requirements that should be permitted for the extension to be available. Many, but not all, Extension Types support Conditions.

[Read about utilizing conditions in Manifests](../extension-conditions.md#utilizing-conditions-in-your-manifest).

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
export const manifest: UmbExtensionManifest = {
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
