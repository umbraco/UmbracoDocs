---
description: >-
  Move automations, workspaces, workspace groups, and connections between
  environments using Umbraco Deploy.
---

# Transferring Automations

Install the Deploy add-on on both the source and target environments. You can then move automations, workspaces, workspace groups, and connection definitions using the standard Umbraco Deploy tooling.

Umbraco Deploy handles the entities in two ways:

* **Automations** and **workspace groups** (folders) transfer like content. Use **Add to Transfer Queue**, **Tree restore**, and **Partial restore**.
* **Workspaces** and **connections** deploy with the schema. Saving one writes its `.uda` file to `umbraco/Deploy/Revision`. Commit the file and deploy it with the rest of your schema.

## What Moves

| Entity | How it moves | Notes |
| ------ | ------------ | ----- |
| **Workspace** | With the schema | Includes the user group references, but not individual member assignments. An unresolved user group is dropped with a warning. The service account doesn't move, because it is specific to each environment. See [Manage Workspaces](../../backoffice/workspaces.md). |
| **Connection** | With the schema (definition only) | Encrypted credential values are skipped by default. Re-authenticate or fill them in on the target. OAuth authentications never move. |
| **Workspace Group** | Transfer | Folders that hold automations inside a workspace. |
| **Automation** | Transfer | Includes all triggers, actions, and bindings. A new automation arrives as a draft, so publish it on the target. An update keeps the target's publish status. |
| **Run history** | Never | Run records are environment-specific. |

Deploy the schema before you transfer automations. A transfer fails with "Ensure the workspace is deployed before the automation" when the workspace isn't on the target yet.

## Transfer and Restore Actions

The actions are on the Automations tree in the **Automation** section:

| Where | Actions |
| ----- | ------- |
| The **Automations** header (**...** menu) | **Add to Transfer Queue**, **Tree restore**, **Partial restore** |
| A workspace group (folder) | **Add to Transfer Queue**, **Partial restore** |
| An automation | **Add to Transfer Queue**, **Partial restore** |

Workspaces and connections have no transfer or restore actions.

When you transfer an automation whose folder isn't on the target, the folder and its parent folders transfer with it.

**Partial restore** from the **Automations** header shows your workspaces. Open a workspace and pick a folder or an automation, not the workspace itself.

## How Connections Are Handled

Steps in an automation reference connections by ID. During Deploy export, IDs are swapped to aliases. During import, aliases are resolved back to IDs in the target environment. As a result:

* If the connection exists in the target environment with the same alias, the import succeeds.
* If the connection is missing, the import fails with a clear error rather than waiting until runtime.
* Sensitive values (anything prefixed with `ENC:`) are not transferred by default. You re-authenticate or re-enter the credential on the target.
* OAuth authentications, such as the Slack account a connection signed in with, never transfer. When a deploy updates an existing connection, the target keeps its own authentication. A connection that a deploy creates arrives unauthenticated. Authenticate it on each environment. See [Authenticate an OAuth Connection](../../backoffice/connections.md#authenticate-an-oauth-connection).

See [Installation](installation.md) for the configuration that controls this behaviour.

## Validation

When an automation is transferred, the Deploy connector validates that every connection type referenced by the automation is registered in the target environment. If a required add-on package is not installed on the target, the import fails with a message that names the missing package.

## Upgrading from Version 18

In version 18, all four entity types were written as `.uda` files and could also be transferred. Version 19 splits them, so existing sites need a one-time cleanup.

1. Before you upgrade, make sure automations and folders match across your environments.
2. Upgrade Umbraco Deploy, Umbraco Automate, and the Deploy add-on on every environment.
3. Delete the automation and folder `.uda` files from `umbraco/Deploy/Revision`. These files are named `umbraco-automate-automation__<id>.uda` and `umbraco-automate-workspace-group__<id>.uda`. Keep the `umbraco-automate-workspace__<id>.uda` and `umbraco-automate-connection__<id>.uda` files.
4. Export the schema, then commit the rewritten workspace and connection files.
5. From then on, move automations and folders with **Add to Transfer Queue**, **Tree restore**, or **Partial restore**.

{% hint style="warning" %}
Don't delete files with a pattern such as `umbraco-automate-workspace*`. That pattern also matches the workspace files, which must stay.
{% endhint %}

After the upgrade:

* Until you export the schema, the **UDA file versions** health check lists the workspace and connection files written by Deploy 18.
* Remove any workspace or connection still in the transfer queue from version 18. Those items no longer transfer.
* Export packages made before the upgrade that contain automations or folders can warn that the workspace checksum doesn't match. Export them again.

## See Also

* [Connections](../../concepts/connections.md)
* [Versioning](../../concepts/versioning.md)
