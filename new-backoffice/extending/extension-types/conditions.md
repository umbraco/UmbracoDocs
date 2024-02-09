---
description: >-
    Extension conditions are used to determine if an extension should be used or not. Many of the Extension Types support conditions, but not all of them.
---

# Conditions

### Using conditions

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

-   `alias`- The alias of the condition to utilize.
-   `...` - The rest of the properties of the object are specific to the condition.

In the above example the `Umb.Condition.SectionAlias` condition is used. This condition takes a property `match` that must be set to the `alias` of the section to match.

### Builtin Conditions types

The following conditions are available out of the box, for all extension types that support conditions.

-   `Umb.Condition.SectionAlias` - Checks if the current section alias matches the one specified.
-   `Umb.Condition.WorkspaceAlias` - Checks if the current workspace alias matches the one specified.

### Make your own Condition Type

You can make your own conditions by creating a class that implements the `UmbExtensionCondition` interface.

```typescript
import { UmbBaseController } from "@umbraco-cms/backoffice/controller-api";
import {
    ManifestCondition,
    UmbConditionConfigBase,
    UmbConditionControllerArguments,
    UmbExtensionCondition,
} from "@umbraco-cms/backoffice/extension-api";
import { UMB_SECTION_CONTEXT } from "@umbraco-cms/backoffice/section";

type MyConditionConfig = UmbConditionConfigBase & {
    match: string;
};

export class MyExtensionCondition
    extends UmbBaseController
    implements UmbExtensionCondition
{
    config: MyConditionConfig;
    permitted = false;

    constructor(args: UmbConditionControllerArguments<MyConditionConfig>) {
        super(args.host);
        // This condition aproves after 10 seconds
        setTimeout(() => {
            this.permitted = strue;
            args.onChange();
        }, 10000);
    }

}
```

This has to be registered in the extension registry, like this:

TODO: Make an example that will work from JSON (not a direct reference to the class).

```typescript
export const manifest: ManifestCondition = {
    type: "condition",
    name: "My Condition",
    alias: "My.Condition.TenSecondDelay",
    class: MyExtensionCondition,
};
```
