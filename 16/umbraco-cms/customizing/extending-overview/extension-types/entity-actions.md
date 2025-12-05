---
description: Entity Actions give developers the ability to add custom actions to a fly-out menu.
---

# Entity Actions

{% hint style="info" %}
**Entity Actions** was previously known as **Tree Actions.**
{% endhint %}

Entity Actions is an extension type that provides a fly-out context menu for secondary or additional functionality to an entity (document, media, etc...).

Developers can define and associate custom actions for entities in a [tree extension](tree.md), workspace, or collection view. Access to these actions can be controlled via user permissions. The Users section of the backoffice allows Administrators to control which actions a user has permissions to access.

## Display Modes <a href="#display-modes" id="display-modes"></a>

Entity Actions extensions can be displayed in a variety of formats.

### Sidebar Context Menu <a href="#sidebar-context-menu" id="sidebar-context-menu"></a>

The sidebar context mode provides a second-level context menu that flies out from the content tree. Backoffice users will typically find default items such as sorting, moving, deleting, and publishing workflow actions here.

<img src="../../../.gitbook/assets/entity-action-sidebar-context.svg" alt="graphic representation of the sidebar context menu">

### Workspace Entity Menu <a href="#workspace-entity-action-menu" id="workspace-entity-action-menu"></a>

The workspace entity mode provides a drop-down menu that flies out from the upper decking of a workspace.

<img src="../../../.gitbook/assets/entity-action-workspace-menu.svg" alt="Workspace Entity Action Menu">

### Collection Menu <a href="#collection-menu" id="collection-menu"></a>

The collection mode provides a drop-down menu that appears above a collection view.

<img src="../../../.gitbook/assets/entity-action-collection-menu.svg" alt="Collection">

### Picker Menu <a href="#picker-menu" id="picker-menu"></a>

The picker mode provides a menu in a sidebar modal.

<img src="../../../.gitbook/assets/entity-action-picker-context-menu.svg" alt="Pickers">

## Registering an Entity Action <a href="#registering-an-entity-action" id="registering-an-entity-action"></a>

To register an entity action, developers declare the entity action in the manifest file, and then extend the `UmbEntityActionBase` class to program the action's behavior.

### Declare the Entity Action

{% code title="entity-action/manifest.ts" %}
```typescript
import { extensionRegistry } from '@umbraco-cms/extension-registry';
import { MyEntityAction } from './entity-action';

const manifest = {
    type: 'entityAction',
    alias: 'My.EntityAction',
    name: 'My Entity Action',
    weight: 10,
    api: MyEntityAction,
    forEntityTypes: ['my-entity'],
    meta: {
        icon: 'icon-add',
        label: 'My Entity Action',
    },
};

extensionRegistry.register(manifest);
```
{% endcode %}

## The Entity Action Class <a href="#the-entity-action-class" id="the-entity-action-class"></a>

Umbraco provides a few generic actions that can be used across silos, such as copy, move, trash, etc. Umbraco may include additional generic actions in the future.

Entity Action extensions will need to supply a class to the extension definition using the `api` property in the manifest file. This class will be instantiated as part of the action and will be passed a reference to the entity that invoked it.

The entity action class will provide one of the following methods:
* `getHref` - returns a url that will be used for navigation
* `execute` - programs custom imperative behaviors that can work with contexts and service apis

If both methods are provided in the entity action class, the `getHref` method will be preferred.

When the action is completed, an event on the host element will be dispatched to notify any surrounding elements.

### The `getHref()` Method <a href="#get-href-method" id="get-href-method"></a>

Entity action extensions are provided `this.args` by the `UmbEntityActionBase` superclass. The `this.args` contains a property, `unique` that allows developers to identity which element the user selected.

The `getHref()` method must return a string value, and the result will be rendered into the DOM as an anchor/link.

{% code title="entity-action/my-entity-action.ts" %}
```typescript
import {UmbEntityActionBase} from '@umbraco-cms/backoffice/entity-action';

export class MyEntityAction extends UmbEntityActionBase<never> {
    async getHref() {
        return `my-link/path-to-something/${this.args.unique}`;
    }
}
```
{% endcode %}

### The `execute()` Method <a href="#execute-method" id="execute-method"></a>

The `execute()` method is flexible and allows developers to perform nearly any task on an entity. Developers can perform network requests using `fetch()`, or access a repository.

{% hint style="info" %}
The [Executing Requests](../../foundation/fetching-data) article provides an overview of the methods for fetching data from Umbraco, including `tryExecute()` requests.
{% endhint %}

{% code title="entity-action/enable-xgrid-action.ts" %}
```typescript
import {
    UmbEntityActionBase,
} from "@umbraco-cms/backoffice/entity-action";

export class EnableXgridAction extends UmbEntityActionBase<never> {
    async execute() {
        // perform a network request
        // fetch(`/server-resource/${this.args.unique}`)

        // or fetch repository
        //const repository = ...

        console.log(this.args.unique);
    }
}
```
{% endcode %}

### Overriding the UmbEntityActionBase Constructor <a href="#umbentityaction-constructor" id="umbentityaction-constructor"></a>

If additional contexts are needed, they can be consumed from the host element via the `constructor` method.

{% code title="entity-action/link-to-server-services-action.ts" %}
```typescript
import {
    UmbEntityActionBase,
    UmbEntityActionArgs,
} from "@umbraco-cms/backoffice/entity-action";
import { UmbControllerHostElement } from "@umbraco-cms/backoffice/controller-api";
import { UmbContextConsumerController } from '@umbraco-cms/controller';
import { UMB_MODAL_SERVICE_CONTEXT } from '@umbraco-cms/modal';

export class LinkToServerServicesAction extends UmbEntityActionBase<never> {
    constructor(
        host: UmbControllerHostElement,
        args: UmbEntityActionArgs<never>,
    ) {
        super(host, args);

        new UmbContextConsumerController(this.host, UMB_MODAL_SERVICE_CONTEXT, (instance) => {
            this.#modalService = instance;
        });
    }

    // ...
}
```
{% endcode %}

## User Permission Codes <a href="#user-permission-codes" id="user-permission-codes"></a>

Developers can define custom user permission codes to control access to their actions, in addition to the standard Umbraco user permission codes. Custom permission codes need to be unique and should not clash with existing permission codes.

Each permission has a set of verbs that will be checked against on both the client and server.

### Standard Umbraco Permission Letters <a href="#standard-permission-letters" id="standard-permission-letters"></a>

| Current Backoffice letter | Verb                             |
|---------------------------|----------------------------------|
| C                         | Umb.Document.Create              |
| F                         | Umb.Document.Read                |
| A                         | Umb.Document.Update              |
| D                         | Umb.Document.Delete              |
| I                         | Umb.Document.CreateBlueprint     |
| N                         | Umb.Document.Notifications       |
| U                         | Umb.Document.Publish             |
| R                         | Umb.Document.Permissions         |
| Z                         | Umb.Document.Unpublish           |
| O                         | Umb.Document.Duplicate           |
| M                         | Umb.Document.Move                |
| S                         | Umb.Document.Sort                |
| I                         | Umb.Document.CultureAndHostnames |
| P                         | Umb.Document.PublicAccess        |
| K                         | Umb.Document.Rollback            |
| V                         | Umb.DocumentRecycleBin.Restore   |

### Custom Permission Letters <a href="#custom-permission-letters" id="custom-permission-letters"></a>

Developers who create packages with custom entity actions are encouraged to update this document by submitting pull requests to the [documentation repository](https://github.com/umbraco/UmbracoDocs). This will inform other developers which permission letters they should avoid defining.

| Custom Backoffice letter | Verb                           |
|--------------------------|--------------------------------|
| ⌘                        | *Placeholder*                  |

## Entity Action Permissions <a href="#user-permissions" id="user-permissions"></a>

Umbraco provides two extension types for user permissions: **entity user permissions** and **granular user permissions.**

These two extension types are used in tandem with each other.

* `entityUserPermission`: Defines _what_ can be done and allows assigning them globally to a User Group.
* `userGranularPermission`: Defines _how_ those same verbs can be assigned to specific nodes in the User Management UI. These extension types provide an interactive interface in the backoffice to control permission assignment.

### Entity User Permissions

Entity user permissions are assigned to a document, media, member, etc., and are registered using the `entityUserPermission` type in the extension's manifest.

{% code title="entity-action/manifests.json" %}
```json
{
    "$schema": "../../umbraco-package-schema.json",
    "name": "My Package",
    "version": "0.1.0",
    "extensions": [
        {
            "type": "entityUserPermission",
            "alias": "My.UserPermission.Document.Archive",
            "name": "Document Archive User Permission",
            "forEntityTypes": ["document"],
            "meta": {
                "verbs": ["My.Document.Archive"],
                "label": "Archive Document",
                "description": "Allow user to archive documents",
                "group": "administration"
            }
        }
    ]
}
```
{% endcode %}

#### Management Interface

The `entityUserPermission` extension type will render a toggle control in the **Default permissions** pane in the Users > User Groups editor.

<figure><img src="../../../.gitbook/assets/entity-user-permissions-ui.png" alt=""><figcaption><p><strong>Entity User Permissions UI</strong></p></figcaption></figure>

### Granular User Permission

Extension developers can customize the selection and interaction style of a granular permission using the `element` property. The `element` property accepts the file location of a custom web component, and will render that component in the management interface.

{% code title="entity-action/manifests.json" %}
```json
{
    "$schema": "../../umbraco-package-schema.json",
    "name": "My Package",
    "version": "0.1.0",
    "extensions": [
        {
            "type": "userGranularPermission",
            "alias": "Umb.UserGranularPermission.Document",
            "name": "Document Granular User Permission",
            "element": "element.js",
            "meta": {
                "schemaType": "DocumentPermissionPresentationModel",
                "label": "Documents",
                "description": "Assign permissions to specific documents"
            }
        }
    ]
}
```
{% endcode %}

#### Management Interface

The `userGranularPermission` extension type will render a document selection control in the **Granular permissions** pane in the Users > User Groups editor by default. The default selector can be replaced with a custom web component.

<figure><img src="../../../.gitbook/assets/granular-user-permissions-ui.png" width="796" alt=""><figcaption><p><strong>Default Granular User Permission UI</strong></p></figcaption></figure>

<figure><img src="../../../.gitbook/assets/granular-user-permissions-ui-custom.png" width="796" alt=""><figcaption><p><strong>Custom Granular User Permission UI</strong></p></figcaption></figure>

### Enforcing Permissions

Developers can enforce permission controls on **Entity Action** extensions by defining conditions in the `conditions` array.

In the following example, the `conditions:alias` property of an `entityAction` extension matches the `alias` property of the `entityUserPermission` extension definition.

Similarly, the `conditions:config:allOf` array must contain the one of the values from the `meta:verbs` array of the `entityUserPermission` extension definition.

{% code title="entity-action/manifests.json" %}
```json
{
    "$schema": "../../umbraco-package-schema.json",
    "name": "My Package",
    "version": "0.1.0",
    "extensions": [
        {
            "type": "entityAction",
            "alias": "My.EntityAction.Archive",
            "name": "Archive Document Action",
            "forEntityTypes": ["document"],
            "api": "...",
            "meta": {
                "icon": "icon-box",
                "label": "Archive"
            },
            "conditions": [
                {
                    "alias": "Umb.Condition.UserPermission.Document",
                    "config": {
                        "allOf": ["My.Document.Archive"]
                    }
                }
            ]
        }
    ]
}
```
{% endcode %}
