# Extension Conditions

Extension conditions are used to determine if an extension should be used or not. Many of the Extension Types support conditions, but not all of them.

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

All given conditions for an extension must be valid for an extension to be utilized.

## Using conditions <a href="#using-conditions" id="using-conditions"></a>

In the following example we define the manifest for a Workspace Action, this action will only be available in the workspace with the alias `My.Example.Workspace`.

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
  }
 ]
}
```

The conditions are defined as an array of conditions. Each condition is an object with the following properties:

* `alias`- The alias of the condition to utilize.
* `...` - The rest of the properties of the object are specific to the condition.

In the above example the `Umb.Condition.SectionAlias` condition is used, this condition takes a property `match` which must be set to the alias of the section to match.

## Built-in conditions types <a href="#core-conditions-types" id="core-conditions-types"></a>

The following conditions are available out of the box, for all extension types that support conditions.

* `Umb.Condition.SectionAlias` - Checks if the current section alias matches the one specified.
* `Umb.Condition.WorkspaceAlias` - Checks if the current workspace alias matches the one specified.

## Make your own conditions <a href="#make-your-own-conditions" id="make-your-own-conditions"></a>

You can make your own conditions by creating a class that implements the `UmbExtensionCondition` interface.

```typescript
import {
  ManifestCondition,
  UmbConditionConfigBase,
  UmbConditionControllerArguments,
  UmbExtensionCondition
} from '@umbraco-cms/backoffice/extension-api';
import { UmbConditionBase } from '@umbraco-cms/backoffice/extension-registry';
import { UmbControllerHost } from '@umbraco-cms/backoffice/controller-api';

export type MyConditionConfig = UmbConditionConfigBase & {
  match: string;
};

export class MyExtensionCondition extends UmbConditionBase<MyConditionConfig> implements UmbExtensionCondition {
  constructor(host: UmbControllerHost, args: UmbConditionControllerArguments<MyConditionConfig>) {
    super(host, args);

    // enable extension after 10 seconds
    setTimeout(() => {
      this.permitted = true;
      args.onChange();
    }, 10000);
  }
}
```

This has to be registered in the extension registry like shown below:

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

export class MyExtensionCondition extends UmbConditionBase<MyConditionConfig> implements UmbExtensionCondition {
  constructor(host: UmbControllerHost, args: UmbConditionControllerArguments<MyConditionConfig>) {
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
  } as MyConditionConfig
 ]
}
```
