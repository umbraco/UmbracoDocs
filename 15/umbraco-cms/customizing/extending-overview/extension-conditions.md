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

## Built-in conditions types <a href="#core-conditions-types" id="core-conditions-types"></a>

The following conditions are available out of the box, for all extension types that support Conditions.

* `Umb.Condition.Switch` - Toggles on and off based on the `frequency` set in seconds.
* `Umb.Condition.MultipleAppLanguages` - Requires the app to have more than one language, that is a multi-language site.
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
* `Umb.Condition.UserPermission.Document` - Requires the current user to have specific Document permissions. Example: 'Umb.Document.Save'.
* `Umb.Condition.CurrentUser.GroupId` - Requires the current user to belong to a specific group by GUID. Accepts `match` (GUID), `oneOf` (array), `allOf` (array), and `noneOf` (array). Example: '8d2b3c4d-4f1f-4b1f-8e3d-4a6b7b8c4f1e'.
* `Umb.Condition.CurrentUser.IsAdmin` - Requires the current user to be an admin as defined by the backend, for example, that they belong to the Administrator group.

## Condition Configuration

The conditions are defined as an array of condition configurations. Each entry can contain the following properties:

* `alias`- The alias of the condition to utilize.
* `...` - The rest of the properties of the object are specific to the condition configuration.

## Learn more

Learn about built-in conditions and how to create your own:

{% content-ref url="extension-types/condition.md" %}
Condition Extension Type
{% endcontent-ref %}
