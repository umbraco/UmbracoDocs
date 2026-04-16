---
description: >-
    Learn how to declare requirements for your extensions using the Extension Conditions.
---

# Extension Conditions

Extension Conditions let you define specific requirements that must be met for an extension to be available. While not all Extension Types support Conditions, many do.

For information on how to utilize conditions in your Manifest, see the [Utilizing Conditions in your Manifest](../extension-conditions.md#utilizing-conditions-in-your-manifest) section.

## Built-in Conditions Types

The following conditions are available out of the box, for all extension types that support Conditions.

### General / Environment

These conditions don't depend on a specific area of the backoffice.

- `Umb.Condition.Switch` - Toggles on and off based on the `frequency` set in seconds.
- `Umb.Condition.MultipleAppLanguages` - Requires the app to have more than one language, such as a multi-language site.
- `Umb.Condition.InModal` - Requires the extension to be rendered inside a modal.
- `Umb.Condition.Server.IsProductionMode` - Requires the server to be running in production mode.
- `Umb.Condition.Delay` - Delays availability of the extension by the number of milliseconds set in `offset`.
- `Umb.Condition.IsRoutableContext` - Requires (or excludes) the extension being rendered within a routable context. Accepts `match` (boolean, defaults to `true`).

### Section

Conditions that depend on the currently active section of the backoffice.

- `Umb.Condition.SectionAlias` - Requires the current Section Alias to match the one specified.
- `Umb.Condition.SectionUserPermission` - Requires the current user to have permissions to the given Section Alias.

### Menu

Conditions that depend on the currently active menu.

- `Umb.Condition.MenuAlias` - Requires the current Menu Alias to match the one specified.

### Workspace

Conditions that depend on the currently active workspace.

- `Umb.Condition.WorkspaceAlias` - Requires the current Workspace Alias to match the one specified.
- `Umb.Condition.WorkspaceEntityType` - Requires the current workspace to work on the given Entity Type. Examples: 'document', 'block', or 'user'.
- `Umb.Condition.WorkspaceEntityIsNew` - Requires the current Workspace data to be new, not yet persisted on the server.
- `Umb.Condition.WorkspaceContentTypeAlias` - Requires the current workspace to be based on a Content Type whose Alias matches the one specified.
- `Umb.Condition.WorkspaceContentTypeUnique` - Requires the current workspace to be based on a Content Type that uniquely matches the one specified.
- `Umb.Condition.Workspace.ContentHasProperties` - Requires the Content Type of the current Workspace to have properties.
- `Umb.Condition.WorkspaceHasContentCollection` - Requires the current Workspace to have a Content Collection.
- `Umb.Condition.Workspace.DocumentIsTrashed` - Requires the document in the current Workspace to be in the recycle bin.
- `Umb.Condition.Workspace.DocumentIsNotTrashed` - Requires the document in the current Workspace not to be in the recycle bin.
- `Umb.Condition.Workspace.ContentIsLoaded` - Requires the entity in the current Workspace to have finished loading.

### Entity

Conditions that depend on the current entity.

- `Umb.Condition.Entity.Type` - Requires the current entity to be of the given type. Accepts `match` (string) or `oneOf` (array of strings).
- `Umb.Condition.Entity.Unique` - Requires the current entity's unique identifier to match the one specified.
- `Umb.Condition.EntityHasChildren` - Requires the current entity to have one or more children.
- `Umb.Condition.EntityContentType.Unique` - Requires the current entity's Content Type unique identifier to match the one specified.
- `Umb.Condition.EntityIsTrashed` - Requires the current entity to be trashed.
- `Umb.Condition.EntityIsNotTrashed` - Requires the current entity not to be trashed.

### Collection

Conditions that depend on the currently active collection.

- `Umb.Condition.CollectionAlias` - Requires the current Collection Alias to match the one specified.
- `Umb.Condition.CollectionHasItems` - Requires the current Collection to contain one or more items.

### Property

Conditions that depend on the currently active property.

- `Umb.Condition.Property.HasValue` - Requires the current property to have a value.
- `Umb.Condition.Property.Writable` - Requires the current property to be writable (not read-only).

### Current User

Conditions based on the user who is currently signed in.

- `Umb.Condition.CurrentUser.IsAdmin` - Requires the current user to be an admin as defined by the backend, for example, that they belong to the Administrator group.
- `Umb.Condition.CurrentUser.GroupId` - Requires the current user to belong to a specific group by GUID. Accepts `match` (GUID), `oneOf` (array), `allOf` (array), and `noneOf` (array).
  Example: '8d2b3c4d-4f1f-4b1f-8e3d-4a6b7b8c4f1e'.
- `Umb.Condition.CurrentUser.AllowChangePassword` - Requires the current user to be allowed to change their password.
- `Umb.Condition.CurrentUser.AllowMfaAction` - Requires the current user to be allowed to manage Multi-Factor Authentication.
- `Umb.Condition.CurrentUser.AllowDocumentRecycleBin` - Requires the current user to be allowed to access the Document recycle bin.
- `Umb.Condition.CurrentUser.AllowMediaRecycleBin` - Requires the current user to be allowed to access the Media recycle bin.
- `Umb.Condition.CurrentUser.AllowElementRecycleBin` - Requires the current user to be allowed to access the Element recycle bin.

### User Management Actions

Conditions used by entity actions in the Users workspace. They apply to the user that the action is being performed on.

- `Umb.Condition.User.AllowChangePassword` - Requires the selected user to allow a password-change action.
- `Umb.Condition.User.AllowDeleteAction` - Requires the selected user to be deletable.
- `Umb.Condition.User.AllowDisableAction` - Requires the selected user to be allowed to be disabled.
- `Umb.Condition.User.AllowEnableAction` - Requires the selected user to be allowed to be enabled.
- `Umb.Condition.User.AllowUnlockAction` - Requires the selected user to be allowed to be unlocked.
- `Umb.Condition.User.AllowExternalLoginAction` - Requires external-login actions to be available for the selected user.
- `Umb.Condition.User.AllowMfaAction` - Requires Multi-Factor Authentication actions to be available for the selected user.
- `Umb.Condition.User.IsDefaultKind` - Requires the selected user to be of the default user kind.
- `Umb.Condition.User.AllowResendInviteAction` - Requires the selected user to be allowed to have an invite resent.

### User Permissions

Conditions that check whether the current user has a specific permission.

- `Umb.Condition.UserPermission.Document` - Requires the current user to have specific Document permissions. Example: 'Umb.Document.Save'.
- `Umb.Condition.UserPermission.Document.PropertyValue` - Requires the current user to have the required permission for the Document's property values.
- `Umb.Condition.UserPermission.Language` - Requires the current user to have the required permission for the given Language.
- `Umb.Condition.UserPermission.Fallback` - Requires the current user to have specific fallback permissions. Accepts `allOf` (array of permission verbs) and `oneOf` (array of permission verbs).
- `Umb.Condition.UserPermission.Element` - Requires the current user to have specific Element permissions. Accepts `allOf` and `oneOf` (arrays of permission verbs).

### Templating & Data Types

Conditions related to template and Data Type management.

- `Umb.Condition.Template.AllowDeleteAction` - Requires the selected Template to be allowed to be deleted.
- `Umb.Condition.DataType.AllowDeleteAction` - Requires the selected Data Type to be allowed to be deleted.

### Property Editors

Conditions specific to property editor extensions.

- `Umb.Condition.EntityDataPicker.SupportsTextFilter` - Requires the current Entity Data Picker to support text filtering.

### Block

Conditions specific to the Block workspace (used by Block List, Block Grid and similar block-based editors).

- `Umb.Condition.BlockWorkspaceHasSettings` - Requires the block in the current Workspace to have a settings model.
- `Umb.Condition.BlockEntryShowContentEdit` - Requires the block entry to be configured to show the content-edit UI.
- `Umb.Condition.BlockWorkspaceIsExposed` - Requires the block in the current Workspace to be exposed for the current variant.
- `Umb.Condition.BlockWorkspaceIsReadOnly` - Requires the block in the current Workspace to be read-only.

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
        args: UmbConditionControllerArguments<MyExtensionConditionConfig>,
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
        args: UmbConditionControllerArguments<MyExtensionConditionConfig>,
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
