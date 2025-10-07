---
description: Entity Actions give extension authors the ability to add custom actions to a fly-out menu.
---

# Entity Actions

{% hint style="info" %}
**Entity Actions** was previously known as **Tree Actions.**
{% endhint %}

Entity Actions is an extension type that provides a fly-out context menu for secondary or additional functionality to
an entity (document, media, etc...).

Extension authors can define and associate custom actions for entities in a [tree extension](tree.md), workspace or 
collection view. Access to these actions can be controlled via user permissions. Site administrators can control which 
actions a user has permissions to access, for each item in the content tree, in the Users Section of the backoffice.

## Display Modes <a href="#display-modes" id="display-modes"></a>

Entity Actions extensions can be displayed in a variety of formats.

### Sidebar Context Menu <a href="#sidebar-context-menu" id="sidebar-context-menu"></a>

The sidebar context mode provides a second-level context menu that flies out from the content tree. Backoffice users
will typically find default items such as sorting, moving, deleting, and publishing workflow actions here.

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

To register an entity action, extension authors will need to declare the entity action in the manifest file, and then
extend the `UmbEntityActionBase` class to program the action's behavior.

### Declare the Entity Action

{% code title="entity-action/manifest.ts" lineNumbers="true" %}
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
		repositoryAlias: 'My.Repository',
	},
};

extensionRegistry.register(manifest);
```
{% endcode %}

### The Entity Action Class <a href="#the-entity-action-class" id="the-entity-action-class"></a>

Umbraco provides a few generic actions that can be used across silos, such as copy, move, trash, etc. Umbraco may
include additional generic actions in the future.

Entity Action extension authors will need to supply a class to the extension definition using the `api` property in the
manifest file. This class will be instantiated as part of the action and will be passed a reference to the entity that
invoked it.

The entity action class will provide one of the following methods:
* `getHref` - returns a url that will be used for navigation
* `execute` - programs custom imperative behaviors that can work with various contexts and service apis

If both methods are provided in the entity action class, the `getHref` method will be preferred.

When the action is completed, an event on the host element will be dispatched to notify any surrounding elements.

Example of providing an `getHref` method:

```typescript
import { UmbEntityActionBase } from '@umbraco-cms/backoffice/entity-action';
import { UmbControllerHostElement } from '@umbraco-cms/backoffice/controller-api';
import type { MyRepository } from './my-repository';

export class MyEntityAction extends UmbEntityActionBase<MyRepository> {
	constructor(host: UmbControllerHostElement, repositoryAlias: string, unique: string) {
		super(host, repositoryAlias, unique);
	}

	async getHref() {
		return 'my-link/path-to-something';
	}
}
```

Example of providing an `execute` method:

```typescript
import { UmbEntityActionBase } from '@umbraco-cms/backoffice/entity-action';
import { UmbControllerHostElement } from '@umbraco-cms/backoffice/controller-api';
import type { MyRepository } from './my-repository';

export class MyEntityAction extends UmbEntityActionBase<MyRepository> {
	constructor(host: UmbControllerHostElement, repositoryAlias: string, unique: string) {
		super(host, repositoryAlias, unique);
	}

	async execute() {
		await this.repository.myAction(this.unique);
	}
}
```

If additional contexts are needed, they can be consumed from the host element via the `constructor` method.

```typescript
import { UmbEntityActionBase } from '@umbraco-cms/backoffice/entity-action';
import { UmbContextConsumerController } from '@umbraco-cms/controller';
import { UMB_MODAL_SERVICE_CONTEXT } from '@umbraco-cms/modal';
import { MyRepository } from './my-repository';

export class MyEntityAction extends UmbEntityActionBase<MyRepository> {
	constructor(host: UmbControllerHostElement, repositoryAlias: string, unique: string) {
		super(host, repositoryAlias, unique);

		new UmbContextConsumerController(this.host, UMB_MODAL_SERVICE_CONTEXT, (instance) => {
			this.#modalService = instance;
		});
	}
  ...
}
```

## User Permission Codes <a href="#user-permission-codes" id="user-permission-codes"></a>

Entity Action extension authors can define custom user permission codes to control access to their actions, in addition
to the standard Umbraco user permission codes. Custom permission codes need to be unique and should not clash with
existing permission codes.

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

Extension authors who have created a package with a custom entity action, are encouraged to update this document by
submitting a pull request via a PR to the [documentation repository](https://github.com/umbraco/UmbracoDocs). This will allow other developers to discover 
and avoid using the same permission letter.

| Custom Backoffice letter | Verb                           |
|--------------------------|--------------------------------|
| ⌘                        | *Placeholder*                  |

## Extension Point Types <a href="#user-permissions" id="user-permissions"></a>

Umbraco provides two extension points for user permissions: entity user permissions and granular user permissions.

### Entity User Permissions

Entity user permissions are assigned to a document, media, member, etc., and are registered using the 
`entityUserPermission` type in the extension's manifest.

#### Sample Manifest

```json
{
    type: "entityUserPermission",
    alias: "Umb.UserPermission.Document.Rollback",
    name: "Document Rollback User Permission",
    meta: {
      entityType: "document",
      verbs: ["Umb.Document.Rollback"],
      labelKey: "actions_rollback",
      descriptionKey: "actionDescriptions_rollback",
      group: "administration",
    },
  },
```

#### Management Interface

<figure><img src="../../../.gitbook/assets/entity-user-permissions-ui.png" alt=""><figcaption><p><strong>Entity User Permissions UI</strong></p></figcaption></figure>

### Granular User Permission

Granular user permissions are assigned to a $type server schemaType and are also registered in the extension's manifest 
using the `userGranularPermission` type.

It is possible to provide a custom element to build the needed UX for that type of permission: ????

#### Sample Manifest

```typescript
{
    type: "userGranularPermission",
    alias: "Umb.UserGranularPermission.Document",
    name: "Document Granular User Permission",
    element: "element.js",
    meta: {
        schemaType: "DocumentPermissionPresentationModel",
      label: "Documents",
      description: "Assign permissions to specific documents"
    }
}
```

#### Management Interface

<figure><img src="../../../.gitbook/assets/granular-user-permissions-ui.png" alt=""><figcaption><p><strong>Granular User Permission UI</strong></p></figcaption></figure>

