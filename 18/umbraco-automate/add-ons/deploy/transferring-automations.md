---
description: >-
  Transfer automations, workspaces, workspace groups, and connections between
  environments using Umbraco Deploy.
---

# Transferring Automations

Install the Deploy add-on on both the source and target environments. You can then transfer automations, workspaces, workspace groups, and connection definitions using the standard Umbraco Deploy tooling.

## What Transfers

| Entity | Transfers? | Notes |
| ------ | ---------- | ----- |
| **Workspace Group** | Yes | Folders that hold workspaces. |
| **Workspace** | Yes | Includes the user group references, but not individual member assignments. An unresolved user group is dropped with a warning. The service account doesn't transfer, because it is specific to each environment. A new workspace arrives without one, so set it on the target. See [Manage Workspaces](../../backoffice/workspaces.md). |
| **Automation** | Yes | The published version of the automation, with all triggers, actions, and bindings. |
| **Connection** | Yes (definition only) | The connection record is created on the target environment. Encrypted credential values are skipped by default — re-authenticate or fill them in on the target. OAuth authentications never transfer. |
| **Run history** | No | Run records are environment-specific and never transfer. |

## How Connections Are Handled

Steps in an automation reference connections by ID. During Deploy export, IDs are swapped to aliases. During import, aliases are resolved back to IDs in the target environment. This means:

* If the connection exists in the target environment with the same alias, the import succeeds.
* If the connection is missing, the import fails with a clear error rather than waiting until runtime.
* Sensitive values (anything prefixed with `ENC:`) are not transferred by default. You re-authenticate or re-enter the credential on the target.
* OAuth authentications, such as the Slack account a connection signed in with, never transfer. When a transfer updates an existing connection, the target keeps its own authentication. A connection that a transfer creates arrives unauthenticated. Authenticate it on each environment. See [Authenticate an OAuth Connection](../../backoffice/connections.md#authenticate-an-oauth-connection).

See [Installation](installation.md) for the configuration that controls this behaviour.

## Validation

When an automation is transferred, the Deploy connector validates that every connection type referenced by the automation is registered in the target environment. If a required add-on package is not installed on the target, the import fails with a message that names the missing package.

## Upgrading to Version 18.1.0

{% hint style="info" %}
Umbraco.Deploy.Automate 18.1.0 requires Umbraco Deploy 18.2.0 or later.
{% endhint %}

From version 18.1.0, the workspace service account is no longer exported. In earlier versions, the exported service account made workspace checksums differ between environments. Automation and folder transfers then failed with a schema mismatch.

1. Upgrade Umbraco Deploy to 18.2.0 or later and the Deploy add-on to 18.1.0 or later on every environment. A target on an older version can still fail automation and folder transfers with a schema mismatch.
2. Export the schema, then commit the rewritten workspace `.uda` files. The files change once.
3. Export again any export packages made before the upgrade that contain automations or folders.

## See Also

* [Connections](../../concepts/connections.md)
* [Versioning](../../concepts/versioning.md)
