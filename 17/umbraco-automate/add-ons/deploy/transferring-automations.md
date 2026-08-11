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
| **Workspace** | Yes | Includes service account reference but not member assignments. |
| **Automation** | Yes | The published version of the automation, with all triggers, actions, and bindings. |
| **Connection** | Yes (definition only) | The connection record is created on the target environment. Encrypted credential values are skipped by default — re-authenticate or fill them in on the target. |
| **Run history** | No | Run records are environment-specific and never transfer. |

## How Connections Are Handled

Steps in an automation reference connections by ID. During Deploy export, IDs are swapped to aliases. During import, aliases are resolved back to IDs in the target environment. This means:

* If the connection exists in the target environment with the same alias, the import succeeds.
* If the connection is missing, the import fails with a clear error rather than waiting until runtime.
* Sensitive values (anything prefixed with `ENC:`) are not transferred by default. You re-authenticate or re-enter the credential on the target.

See [Installation](installation.md) for the configuration that controls this behaviour.

## Validation

When an automation is transferred, the Deploy connector validates that every connection type referenced by the automation is registered in the target environment. If a required add-on package is not installed on the target, the import fails with a message that names the missing package.

## See Also

* [Connections](../../concepts/connections.md)
* [Versioning](../../concepts/versioning.md)
