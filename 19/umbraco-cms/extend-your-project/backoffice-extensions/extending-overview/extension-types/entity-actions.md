---
description: >-
  Entity Actions give developers the ability to add custom actions to a fly-out
  menu.
---

# Entity Actions

{% hint style="info" %}
**Entity Actions** was previously known as **Tree Actions.**
{% endhint %}

Entity Actions is an extension type that provides a fly-out context menu for secondary or additional functionality to an entity (document, media, etc...).

Developers can define and associate custom actions for entities in a [tree extension](tree/), workspace, or collection view. Access to these actions can be controlled via user permissions. The Users section of the backoffice allows Administrators to control which actions a user has permissions to access.

## Display Modes <a href="#display-modes" id="display-modes"></a>

Entity Actions extensions can be displayed in a variety of formats.

### Sidebar Context Menu <a href="#sidebar-context-menu" id="sidebar-context-menu"></a>

The sidebar context mode provides a second-level context menu that flies out from the content tree. Backoffice users will typically find default items such as sorting, moving, deleting, and publishing workflow actions here.

![graphic representation of the sidebar context menu](../../../../.gitbook/assets/entity-action-sidebar-context.svg)

### Workspace Entity Menu <a href="#workspace-entity-action-menu" id="workspace-entity-action-menu"></a>

The workspace entity mode provides a drop-down menu that flies out from the upper decking of a workspace.

![Workspace Entity Action Menu](../../../../.gitbook/assets/entity-action-workspace-menu.svg)

### Collection Menu <a href="#collection-menu" id="collection-menu"></a>

The collection mode provides a drop-down menu that appears above a collection view.

![Collection](../../../../.gitbook/assets/entity-action-collection-menu.svg)

### Picker Menu <a href="#picker-menu" id="picker-menu"></a>

The picker mode provides a menu in a sidebar modal.

![Pickers](../../../../.gitbook/assets/entity-action-picker-context-menu.svg)

## Registering an Entity Action <a href="#registering-an-entity-action" id="registering-an-entity-action"></a>

To register an entity action, developers declare the entity action in the manifest file, and then extend the `UmbEntityActionBase` class to program the action's behavior.

### Declare the Entity Action

{% code title="entity-action/manifest.ts" %}
```typescript
import { umbExtensionsRegistry } from '@umbraco-cms/backoffice/extension-registry';

const manifest = {
    type: 'entityAction',
    kind: 'default',
    alias: 'My.EntityAction',
    name: 'My Entity Action',
    weight: 10,
    api: () => import('./my-entity-action.js'),
    forEntityTypes: ['my-entity'],
    meta: {
        icon: 'icon-add',
        label: 'My Entity Action',
    },
};

umbExtensionsRegistry.register(manifest);
```
{% endcode %}

## The Entity Action Class <a href="#the-entity-action-class" id="the-entity-action-class"></a>

Umbraco provides a few generic actions that can be used across silos, such as copy, move, trash, etc. Umbraco may include additional generic actions in the future.

Entity Action extensions will need to supply a class to the extension definition using the `api` property in the manifest file. This class will be instantiated as part of the action and will be passed a reference to the entity that invoked it.

The entity action class will provide one of the following methods:

* `getHref` - returns a URL that will be used for navigation
* `execute` - programs custom imperative behaviors that can work with contexts and service APIs

If both methods are provided in the entity action class, the `getHref` method will be preferred.

When the action is completed, an event on the host element will be dispatched to notify any surrounding elements.

### The `getHref()` Method <a href="#get-href-method" id="get-href-method"></a>

Entity action extensions are provided by the `this.args` property, via the `UmbEntityActionBase` superclass. The `this.args` contains a property, `unique` that allows developers to identity which element the user selected.

The `getHref()` method must return a string value, and the result will be rendered into the DOM as an anchor/link.

{% code title="entity-action/my-entity-action.ts" %}
```typescript
import { UmbEntityActionBase } from '@umbraco-cms/backoffice/entity-action';

export class MyEntityAction extends UmbEntityActionBase<never> {
	override async getHref() {
		return `my-link/path-to-something/${this.args.unique}`;
	}
}

export { MyEntityAction as api };
```
{% endcode %}

### The `execute()` Method <a href="#execute-method" id="execute-method"></a>

The `execute()` method is flexible and allows developers to perform nearly any task on an entity. Developers can perform network requests with the [Umbraco HTTP Client](../../foundation/fetching-data/http-client.md), or access a repository. The following example gets an item from the API in the [Creating a backoffice API](../../../tutorials/creating-a-backoffice-api/README.md) tutorial.

{% hint style="info" %}
The [Fetching Data](../../foundation/fetching-data/) article provides an overview of the methods for fetching data from Umbraco, including `tryExecute()` requests.
{% endhint %}

{% code title="entity-action/my-fetch-entity-action.ts" %}
```typescript
import { UmbEntityActionBase } from '@umbraco-cms/backoffice/entity-action';
import { umbHttpClient } from '@umbraco-cms/backoffice/http-client';
import { tryExecute } from '@umbraco-cms/backoffice/resources';

export class MyFetchEntityAction extends UmbEntityActionBase<never> {
	override async execute() {
		const { data, error } = await tryExecute(
			this,
			umbHttpClient.get({
				url: `/umbraco/management/api/v1/my/item/${this.args.unique}`,
			}),
		);

		if (error) {
			throw error;
		}

		if (data) {
			console.log(data); // Do something with the data
		}
	}
}

export { MyFetchEntityAction as api };
```
{% endcode %}

### Overriding the `UmbEntityActionBase` Constructor <a href="#umbentityaction-constructor" id="umbentityaction-constructor"></a>

If additional contexts are needed, they can be consumed from the host element via the `constructor` method.

{% code title="entity-action/my-custom-modal-entity-action.ts" %}
```typescript
import { MY_CUSTOM_MODAL_TOKEN } from './my-custom-modal-token.js';
import { UmbEntityActionBase } from '@umbraco-cms/backoffice/entity-action';
import { UMB_MODAL_MANAGER_CONTEXT } from '@umbraco-cms/backoffice/modal';
import type { UmbControllerHostElement } from '@umbraco-cms/backoffice/controller-api';
import type { UmbEntityActionArgs } from '@umbraco-cms/backoffice/entity-action';

export class MyCustomModalEntityAction extends UmbEntityActionBase<never> {
	#modalManager?: typeof UMB_MODAL_MANAGER_CONTEXT.TYPE;

	constructor(host: UmbControllerHostElement, args: UmbEntityActionArgs<never>) {
		super(host, args);

		this.consumeContext(UMB_MODAL_MANAGER_CONTEXT, (modalContext) => {
			this.#modalManager = modalContext;
		});
	}

	override async execute() {
		const modal = this.#modalManager?.open(this, MY_CUSTOM_MODAL_TOKEN, {});

		if (!modal) {
			console.error('No modal manager found!');
			return;
		}

		await modal.onSubmit();

		console.log(modal.value); // Do something with the submitted data.
	}
}

export { MyCustomModalEntityAction as api };
```
{% endcode %}

## Grouping Entity Actions <a href="#grouping-entity-actions" id="grouping-entity-actions"></a>

Umbraco splits entity action menus into groups of related actions, with a separator line between the groups. For example, the actions that create something sit together, and so do the actions that move, sort, or delete it.

A group is an extension of the type `entityActionGroup`. An entity action joins a group through its `group` property, which holds the alias of the group.

Property actions and workspace action menu items follow the same rules with their own group types:

| Actions                     | Group extension type           |
| --------------------------- | ------------------------------ |
| Entity actions              | `entityActionGroup`            |
| Property actions            | `propertyActionGroup`          |
| Workspace action menu items | `workspaceActionMenuItemGroup` |

### Built-in Entity Action Groups <a href="#built-in-entity-action-groups" id="built-in-entity-action-groups"></a>

Umbraco registers the following entity action groups. Import the constants from `@umbraco-cms/backoffice/entity-action`.

| Constant                                | Alias                                 | Weight |
| --------------------------------------- | ------------------------------------- | ------ |
| `UMB_ENTITY_ACTION_GROUP_CREATE`        | `Umb.EntityActionGroup.Create`        | 1200   |
| `UMB_ENTITY_ACTION_GROUP_STRUCTURE`     | `Umb.EntityActionGroup.Structure`     | 800    |
| `UMB_ENTITY_ACTION_GROUP_PUBLISHING`    | `Umb.EntityActionGroup.Publishing`    | 600    |
| `UMB_ENTITY_ACTION_GROUP_ROUTING`       | `Umb.EntityActionGroup.Routing`       | 400    |
| `UMB_ENTITY_ACTION_GROUP_NOTIFICATIONS` | `Umb.EntityActionGroup.Notifications` | 100    |
| `UMB_ENTITY_ACTION_GROUP_IMPORT_EXPORT` | `Umb.EntityActionGroup.ImportExport`  | 50     |

### Adding an Action to a Built-in Group

Set `group` to one of the constants to place your action next to the related core actions. Inside the group, the `weight` of the action only orders it among the other actions in that group.

The following action joins the Import and export group on Document Types. Its weight of 400 places it after the core Export and Import actions, which have a weight of 500.

{% code title="entity-action/manifest.ts" %}
```typescript
import { UMB_ENTITY_ACTION_GROUP_IMPORT_EXPORT } from '@umbraco-cms/backoffice/entity-action';
import { umbExtensionsRegistry } from '@umbraco-cms/backoffice/extension-registry';

const manifest = {
    type: 'entityAction',
    kind: 'default',
    alias: 'My.EntityAction.ExportAsJson',
    name: 'My Export as JSON Entity Action',
    group: UMB_ENTITY_ACTION_GROUP_IMPORT_EXPORT,
    weight: 400,
    api: () => import('./my-export-as-json-entity-action.js'),
    forEntityTypes: ['document-type'],
    meta: {
        icon: 'icon-download-alt',
        label: 'Export as JSON',
    },
};

umbExtensionsRegistry.register(manifest);
```
{% endcode %}

### Registering Your Own Group

Register an `entityActionGroup` when none of the built-in groups fit your actions. A group manifest has the following properties:

* `type` - The group extension type, here `entityActionGroup`.
* `alias` - The alias that actions use in their `group` property.
* `name` - A readable name for the extension.
* `weight` - The position of the group in the menu.
* `meta.label` - The accessible name of the group. Use plain text or a localization key, such as `#actionGroups_publishing`.

The menu doesn't display the label. Umbraco renders each group as an element with `role="group"` and uses the label as its `aria-label`, so screen readers announce the group.

The following example registers a Reports group at weight 300, between the Routing and Notifications groups. One action joins the group.

{% code title="entity-action/manifest.ts" %}
```typescript
import { umbExtensionsRegistry } from '@umbraco-cms/backoffice/extension-registry';

const groupManifest = {
    type: 'entityActionGroup',
    alias: 'My.EntityActionGroup.Reports',
    name: 'My Reports Entity Action Group',
    weight: 300,
    meta: {
        label: 'Reports',
    },
};

const actionManifest = {
    type: 'entityAction',
    kind: 'default',
    alias: 'My.EntityAction.ContentReport',
    name: 'My Content Report Entity Action',
    group: 'My.EntityActionGroup.Reports',
    weight: 100,
    api: () => import('./my-content-report-entity-action.js'),
    forEntityTypes: ['document'],
    meta: {
        icon: 'icon-chart',
        label: 'Content report',
    },
};

umbExtensionsRegistry.registerMany([groupManifest, actionManifest]);
```
{% endcode %}

### Menu Order

Umbraco orders the visible actions in a menu by the following rules:

* Groups sort by the `weight` of the group, highest first.
* Inside a group, actions sort by their own `weight`, highest first. Equal weights sort by alias.
* Actions without a `group`, or with a `group` that matches no registered group, render last in the Other group. They sort the same way.
* A group with no visible actions doesn't render.

### Separators

Umbraco places the separator lines in a menu by the following rules:

* A separator line sits between every two groups, including the Other group.
* A menu never starts or ends with a separator.

Inside a group, an action can add an extra line above itself with `separatorBefore: true`. Core uses the property in the **Save and publish** menu of the Document workspace, which lists workspace action menu items rather than entity actions. There, Schedule publish, Publish with descendants, and Unpublish belong to the `UMB_WORKSPACE_ACTION_MENU_ITEM_GROUP_PUBLISHING` group. Unpublish sets `separatorBefore: true`, so a line separates it from the two publish actions. When a condition such as a user permission hides Unpublish, the extra line disappears with it. On the first action of a group, `separatorBefore` has no effect, as a line already sits above the group.

## User Permission Codes <a href="#user-permission-codes" id="user-permission-codes"></a>

Developers can define custom user permission codes to control access to their actions, in addition to the standard Umbraco user permission codes. Custom permission codes need to be unique and should not clash with existing permission codes.

Each permission has a set of verbs that will be checked against on both the client and server.

### Standard Umbraco Permission Letters <a href="#standard-permission-letters" id="standard-permission-letters"></a>

| Legacy backoffice letter | Verb                             |
| ------------------------ | -------------------------------- |
| C                        | Umb.Document.Create              |
| F                        | Umb.Document.Read                |
| A                        | Umb.Document.Update              |
| D                        | Umb.Document.Delete              |
| ï                        | Umb.Document.CreateBlueprint     |
| N                        | Umb.Document.Notifications       |
| U                        | Umb.Document.Publish             |
| R                        | Umb.Document.Permissions         |
| Z                        | Umb.Document.Unpublish           |
| O                        | Umb.Document.Duplicate           |
| M                        | Umb.Document.Move                |
| S                        | Umb.Document.Sort                |
| I                        | Umb.Document.CultureAndHostnames |
| P                        | Umb.Document.PublicAccess        |
| K                        | Umb.Document.Rollback            |

### Custom Permission Letters <a href="#custom-permission-letters" id="custom-permission-letters"></a>

Developers who create packages with custom entity actions are encouraged to update this document by submitting pull requests to the [documentation repository](https://github.com/umbraco/UmbracoDocs). This will inform other developers which permission letters they should avoid defining.

| Custom Backoffice letter | Verb          |
| ------------------------ | ------------- |
| ⌘                        | _Placeholder_ |

## Entity Action Permissions <a href="#user-permissions" id="user-permissions"></a>

Umbraco provides two extension types for user permissions: **entity user permissions** and **granular user permissions.**

These two extension types are used in tandem with each other.

* `entityUserPermission`: Defines _what_ can be done and allows assigning them globally to a User Group.
* `userGranularPermission`: Defines _how_ those same verbs can be assigned to specific nodes in the User Management UI. These extension types provide an interactive interface in the backoffice to control permission assignment.

### Entity User Permissions

Entity user permissions are assigned to a document, media, member, etc., and are registered using the `entityUserPermission` type in the extension's manifest.

{% code title="entity-user-permission/manifest.ts" %}
```typescript
import { umbExtensionsRegistry } from '@umbraco-cms/backoffice/extension-registry';

const manifest = {
    type: 'entityUserPermission',
    alias: 'My.UserPermission.Document.Archive',
    name: 'My Document Archive User Permission',
    forEntityTypes: ['document'],
    meta: {
        verbs: ["My.Document.Archive"],
        label: "Archive Document",
        description: "Allow user to archive documents",
        group: "administration"
    },
};

umbExtensionsRegistry.register(manifest);
```
{% endcode %}

#### Management Interface

The `entityUserPermission` extension type will render a toggle control in the **Default permissions** pane in the Users > User Groups editor.

<figure><img src="../../../../.gitbook/assets/entity-user-permissions-ui.png" alt=""><figcaption><p><strong>Entity User Permissions UI</strong></p></figcaption></figure>

### Granular User Permission

<figure><img src="../../../../.gitbook/assets/granular-user-permissions-ui.png" alt="" width="796"><figcaption><p><strong>Default Granular User Permission UI</strong></p></figcaption></figure>

#### Management Interface

Extension developers can customize the selection and interaction style of a granular permission using the `element` property. The `element` property accepts the file location of a custom web component, and will render that component in the management interface.

The `userGranularPermission` extension type will render a document selection control in the **Granular permissions** pane in the Users > User Groups editor by default. The default selector can be replaced with a custom web component.

{% code title="user-granular-permission/manifest.ts" %}
```typescript
import { umbExtensionsRegistry } from '@umbraco-cms/backoffice/extension-registry';

const manifest = {
    type: 'userGranularPermission',
    alias: 'My.UserGranularPermission.Document',
    name: 'My Document Granular User Permission',
    element: () => import('./my-document-user-granular-permission-ui.js'),
    meta: {
        schemaType: "DocumentPermissionPresentationModel",
        label: "Documents",
        description: "Assign permissions to specific documents"
    },
};

umbExtensionsRegistry.register(manifest);
```
{% endcode %}

<figure><img src="../../../../.gitbook/assets/granular-user-permissions-ui-custom.png" alt="" width="796"><figcaption><p><strong>Custom Granular User Permission UI</strong></p></figcaption></figure>

### Enforcing Permissions

Developers can enforce permission controls on **Entity Action** extensions by defining conditions in the `conditions` array.

In the following example, the `conditions:alias` property of an `entityAction` extension is `Umb.Condition.UserPermission.Document`. This condition checks the permissions of the current user for the document.

Similarly, the `conditions:allOf` array must contain the one of the values from the `meta:verbs` array of the `entityUserPermission` extension definition.

{% code title="entity-action/manifest.ts" %}
```typescript
import { umbExtensionsRegistry } from '@umbraco-cms/backoffice/extension-registry';

const manifest = {
    type: 'entityAction',
    kind: 'default',
    alias: 'My.EntityAction.DocumentArchive',
    name: 'My Document Archive Action',
    api: () => import('./my-document-archive-entity-action.js'),
    forEntityTypes: ['document'],
    meta: {
		icon: 'icon-box',
		label: 'Archive',
	},
	conditions: [
		{
			alias: 'Umb.Condition.UserPermission.Document',
			allOf: ['My.Document.Archive'],
		},
	],
};

umbExtensionsRegistry.register(manifest);
```
{% endcode %}
