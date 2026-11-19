---
description: >-
  Workspaces group automations and scope which connections and users have
  access.
---

# Workspaces

A workspace is a container that groups related automations. Workspaces are the access boundary for automations and connections.

## What a Workspace Controls

| Setting                 | Description                                                                                                                                                                                                 |
| ----------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **User groups**         | The Umbraco user groups whose members can view, edit, and run the automations in the workspace.                                                                                                             |
| **Allowed connections** | The connections that the automations in the workspace can use.                                                                                                                                              |
| **Service account**     | The Umbraco API user that the automations run as. A regular backoffice user can't be the service account. The account's section access, start node, and (where applicable) per-resource membership determine which triggers and actions the workspace can use. |

## Why Use Workspaces

Workspaces let you separate concerns:

* A **Marketing** workspace might own Slack and email automations and be edited by the marketing team.
* An **Operations** workspace might own scheduled maintenance jobs and be edited by developers only.

Each workspace has its own list of connections, so credentials for one workspace are not visible to automations in another workspace.

## Default Workspace

A default workspace is created when Umbraco Automate is first installed. You can use the default workspace for small sites or create additional workspaces as your needs grow.

## Workspace Groups

Workspaces can be organized into workspace groups, which are folders in the tree that hold workspaces. Workspace groups are organizational only; they do not affect permissions.

## Service-Account Permissions

The workspace service account is the security boundary for what its automations can see and do. Every built-in and add-on step type declares the Umbraco backoffice section it needs (for example, **content**, **media**, **commerce**). Some also enforce node- or resource-level access at runtime:

| Layer                                                                       | What it gates                                                                   | Effect on the workspace                                                                                                                                                                           |
| --------------------------------------------------------------------------- | ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Section access**                                                          | Whether the step type may be used at all.                                       | The catalogue picker hides triggers and actions the account cannot use. Publish validation rejects automations that reference them. Dispatch silently skips events that arrive after a downgrade. |
| **Start node / Browse permission** (content, media and Library triggers and actions) | Whether the event refers to a node the account can read.                        | A workspace scoped to `/marketing/` does not receive `Content Published` events for `/finance/` and cannot publish content outside its start node at runtime.                                     |
| **Granular permission** (content and Library actions)                         | Whether the account has the specific verb (Create, Publish, Update, Move, and for Library elements Read and Unpublish) on the target node. | The **Publish Content** action requires the Publish letter on the target node — the action fails with an authentication error if the account only has Browse. **Create Content** needs Create on the parent, and **Move Content** needs Move and access to the destination. The Library actions check the same way on the element, or on the folder for **Create Element**. |
| **Per-resource membership** (Commerce stores)                               | Whether the account is allowed in the trigger or action's target store.         | Workspaces scoped to Store A do not receive events for Store B and cannot capture payments on Store B's orders. Admins bypass the per-store list, matching the Commerce backoffice.               |

Creating or moving an item at the content, media or Library root needs root access. That applies even when the account can reach nodes inside its start node.

### Publishing Shared Properties

On content that varies by culture, Umbraco only publishes shared properties when one of the user's groups has **Allow editing shared content** turned on. Shared properties are the properties that don't vary by culture. The rule also applies to the service account when **Publish Content** names one or more cultures.

Without the permission, the step still succeeds and the named cultures are published. The shared properties keep their last published values. **Publish Content** writes a warning to its **Logs** tab that names those properties. Turn on **Allow editing shared content** on one of the service account's user groups to publish them. Automate doesn't change the account's groups for you. For more information, see [User Group Parameters](https://docs.umbraco.com/umbraco-cms/manage-and-publish-content/users-and-members/users#user-group-parameters) in the Umbraco CMS documentation.

Changing the service account on a published workspace can take its automations offline. Events that previously dispatched now silently skip. Actions that need permissions the new account doesn't have fail with an authentication error in the run log. Treat the account the same way you would treat the role of a backoffice user.

## See Also

* [Managing Workspaces](../backoffice/workspaces.md)
* [Connections](connections.md)
