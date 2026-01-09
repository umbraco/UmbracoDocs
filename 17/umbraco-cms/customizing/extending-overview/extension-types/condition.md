---
description: >-
    Learn how to declare requirements for your extensions using the Extension Conditions.
---

# Extension Conditions

Extension Conditions let you define specific requirements that must be met for an extension to be available. While not all Extension Types support Conditions, many do.

For information on how to utilize conditions in your Manifest, see the [Utilizing Conditions in your Manifest](../extension-conditions.md#utilizing-conditions-in-your-manifest) section.

## Built-in Conditions Types

The following conditions are available out of the box, for all extension types that support Conditions.

-   `Umb.Condition.Switch` - Toggles on and off based on the `frequency` set in seconds.
-   `Umb.Condition.MultipleAppLanguages` - Requires the app to have more than one language, such as a multi-language site.
-   `Umb.Condition.SectionAlias` - Requires the current Section Alias to match the one specified.
-   `Umb.Condition.MenuAlias` - Requires the current Menu Alias to match the one specified.
-   `Umb.Condition.WorkspaceAlias` - Requires the current Workspace Alias to match the one specified.
-   `Umb.Condition.WorkspaceEntityType` - Requires the current workspace to work on the given Entity Type. Examples: 'document', 'block', or 'user'.
-   `Umb.Condition.WorkspaceContentTypeAlias` - Requires the current workspace to be based on a Content Type whose Alias matches the one specified.
-   `Umb.Condition.WorkspaceContentTypeUnique` - Requires the current workspace to be based on a Content Type that uniquely matches the one specified.
-   `Umb.Condition.Workspace.ContentHasProperties` - Requires the Content Type of the current Workspace to have properties.
-   `Umb.Condition.WorkspaceHasCollection` - Requires the current Workspace to have a Collection.
-   `Umb.Condition.WorkspaceEntityIsNew` - Requires the current Workspace data to be new, not yet persisted on the server.
-   `Umb.Condition.EntityIsTrashed` - Requires the current entity to be trashed.
-   `Umb.Condition.EntityIsNotTrashed` - Requires the current entity not to be trashed.
-   `Umb.Condition.SectionUserPermission` - Requires the current user to have permissions to the given Section Alias.
-   `Umb.Condition.UserPermission.Document` - Requires the current user to have specific Document permissions. Example: 'Umb.Document.Save'.
-   `Umb.Condition.CurrentUser.GroupId` - Requires the current user to belong to a specific group by GUID. Accepts `match` (GUID), `oneOf` (array), `allOf` (array), and `noneOf` (array). Example: '8d2b3c4d-4f1f-4b1f-8e3d-4a6b7b8c4f1e'.
-   `Umb.Condition.CurrentUser.IsAdmin` - Requires the current user to be an admin as defined by the backend, for example, that they belong to the Administrator group.

## Make your own Conditions

You can make your own Conditions by creating a class that implements the `UmbExtensionCondition` interface.

```typescript
import {
    UmbConditionConfigBase,
    UmbConditionControllerArguments,
    UmbExtensionCondition,
} from "@umbraco-cms/backoffice/extension-api";
import { UmbConditionBase } from "@umbraco-cms/backoffice/extension-registry";
import { UmbControllerHost } from "@umbraco-cms/backoffice/controller-api";

export type MyExtensionConditionConfig =
    UmbConditionConfigBase<"My.Condition.CustomName"> & {
        match?: string;
    };

export class MyExtensionCondition
    extends UmbConditionBase<MyExtensionConditionConfig>
    implements UmbExtensionCondition
{
    constructor(
        host: UmbControllerHost,
        args: UmbConditionControllerArguments<MyExtensionConditionConfig>
    ) {
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
        MyExtensionConditionConfig: MyExtensionConditionConfig;
    }
}
```

The global declaration on the last five lines makes your Condition appear valid for manifests using the type `UmbExtensionManifest`. Also, the Condition Config Type alias should match the alias given when registering the condition below.

The Condition then needs to be registered in the Extension Registry:

```typescript
export const manifest: UmbExtensionManifest = {
    type: "condition",
    name: "My Condition",
    alias: "My.Condition.CustomName",
    api: MyExtensionCondition,
};
```

Finally, you can make use of your condition in any manifests:

```typescript
export const manifest: UmbExtensionManifest = {
    type: "workspaceAction",
    name: "example-workspace-action",
    alias: "My.Example.WorkspaceAction",
    elementName: "my-workspace-action-element",
    conditions: [
        {
            alias: "Umb.Condition.SectionAlias",
            match: "My.Example.Workspace",
        },
        {
            alias: "My.Condition.CustomName",
        },
    ],
};
```

As shown in the code above, the configuration property `match` isn't used for our condition. We can do this by replacing the timeout with some other check:

```typescript
// ...

export class MyExtensionCondition
    extends UmbConditionBase<MyExtensionConditionConfig>
    implements UmbExtensionCondition
{
    constructor(
        host: UmbControllerHost,
        args: UmbConditionControllerArguments<MyExtensionConditionConfig>
    ) {
        super(host, args);

        if (args.config.match === "Yes") {
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
            alias: "My.Condition.CustomName",
            match: "Yes",
        },
    ];
}
```
