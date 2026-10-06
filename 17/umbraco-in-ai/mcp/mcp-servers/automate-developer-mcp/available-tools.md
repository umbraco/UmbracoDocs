---
description: List of tools that are enabled in the Automate Developer MCP
---

# Available Tools

This document lists all available tools grouped according to the categories defined in the **Umbraco Automate Management API**. Every endpoint in the Automate Management API is covered by at least one tool, so no endpoints are excluded.

The names shown in parentheses, for example, `(automations)` or `(runs)` refer to the **Tool Collection names**, which are used for configuration via environment variables: `UMBRACO_INCLUDE_TOOL_COLLECTIONS` or `UMBRACO_EXCLUDE_TOOL_COLLECTIONS`.

This server also chains to the [Umbraco CMS Developer MCP](../cms-developer-mcp/README.md), whose tools are proxied with a `cms--` prefix (for example, `cms--get-document-by-id`). See [Configuration Options](configuration.md#cms-mcp-server-chaining) for details. Those chained tools are documented on the [CMS Available Tools](../cms-developer-mcp/available-tools.md) page and are not repeated here.

{% hint style="info" %}
Some features need a later Umbraco Automate 17.x release. See [Umbraco Automate Version Support](README.md#umbraco-automate-version-support) for how the tools behave on older releases.
{% endhint %}

## Table of Contents

- [Approvals (`approvals`)](#approvals-approvals)
- [Automations (`automations`)](#automations-automations)
- [Catalogue (`catalogue`)](#catalogue-catalogue)
- [Connections (`connections`)](#connections-connections)
- [Metrics (`metrics`)](#metrics-metrics)
- [Runs (`runs`)](#runs-runs)
- [Umbraco Server (`umbraco-server`)](#umbraco-server-umbraco-server)
- [Version History (`version-history`)](#version-history-version-history)
- [Workspaces (`workspaces`)](#workspaces-workspaces)

## Approvals (`approvals`)

- `decide-approval-step` — Approve or reject a run step that is waiting for approval
- `list-pending-approvals` — List the run steps that are waiting for an approval decision

## Automations (`automations`)

- `add-automation-step` — Add a step to an automation without sending the full definition
- `connect-automation-steps` — Connect the output of one step to another step, optionally for a specific outcome
- `create-automation` — Create an empty draft automation in a workspace
- `delete-automation` — Delete an automation, including its run history
- `disconnect-automation-steps` — Remove the connections between two steps without deleting the steps
- `export-automation` — Export an automation as a portable definition
- `get-automation` — Get the full definition of an automation, including its trigger, steps, and connections
- `get-automation-ancestors` — List the workspace groups above an automation
- `get-automation-group` — Get a single workspace group
- `get-automation-webhook-url` — Get the inbound webhook URL of an automation with a webhook trigger
- `import-automation` — Create an automation in a workspace from an exported definition
- `import-automation-into-existing` — Overwrite an existing automation with an exported definition
- `list-automation-runs` — List the runs of an automation, newest first
- `list-automations` — List automations, optionally filtered by name, workspace, or group
- `publish-automation` — Publish an automation so its trigger starts firing
- `re-enable-automation` — Re-enable an automation that Umbraco disabled after repeated failures
- `remove-automation-step` — Remove a step and its connections from an automation
- `set-automation-trigger` — Set or remove the trigger that starts an automation
- `trigger-automation` — Start a run of a published automation immediately
- `unpublish-automation` — Unpublish an automation so its trigger stops firing
- `update-automation` — Rename an automation, edit its description, or move it to another group
- `update-automation-step` — Update the configuration of a single step
- `validate-automation-import` — Validate an exported definition against a workspace without saving

## Catalogue (`catalogue`)

- `list-catalogue-actions` — List the action steps that can be added to an automation
- `list-catalogue-connection-types` — List the connection types, such as HTTP, SMTP, or Slack, and their settings
- `list-catalogue-control-flows` — List the control flow steps, such as conditions and loops
- `list-catalogue-notification-channels` — List the notification channels, such as email, Slack, or Teams
- `list-catalogue-step-types` — List every step type in one list, optionally filtered by type
- `list-catalogue-triggers` — List the triggers that can start an automation
- `list-catalogue-webhook-authenticators` — List the authenticators that can secure a webhook trigger
- `resolve-step-type-output-schema` — Get the output schema of a step whose output depends on its settings

## Connections (`connections`)

- `create-connection` — Create a connection with the credentials and settings for a third-party service
- `delete-connection` — Delete a connection
- `get-connection` — Get a single connection, with credential settings redacted
- `list-connections` — List connections, without their settings
- `test-connection` — Test whether a saved connection can reach its service
- `update-connection` — Replace the alias, name, type, and settings of a connection

{% hint style="warning" %}
`get-connection` redacts settings whose names look like credentials, such as secrets, passwords, tokens, and API keys. The redaction is based on setting names only, so treat connection settings as sensitive.

Credentials passed to `create-connection` or `update-connection` are sent through your AI tool as part of the conversation.
{% endhint %}

## Metrics (`metrics`)

- `get-metrics` — Get overall run totals, a breakdown by status, and the success rate
- `get-metrics-by-automation` — Get the number of runs, successes, and failures for each automation

## Runs (`runs`)

- `get-run-by-id` — Get the full detail of a run, including the status of each step
- `list-runs` — List runs across all automations, newest first
- `replay-run` — Run a finished run again from the start, as a new run
- `resume-run` — Resume a suspended run from where it paused
- `suspend-run` — Pause a pending or running run
- `terminate-run` — Stop a pending, running, or suspended run permanently

## Umbraco Server (`umbraco-server`)

- `get-server-info` — Get Umbraco server information, including the version

## Version History (`version-history`)

- `compare-version-history` — Compare two versions of an entity, field by field
- `get-version-history-entry` — Get a single past version of an entity
- `list-version-history` — List the versions of an entity, newest first
- `list-version-history-supported-types` — List the entity types that have version history
- `rollback-version-history` — Roll an entity back to a past version

## Workspaces (`workspaces`)

- `create-workspace` — Create a workspace
- `create-workspace-group` — Create a group inside a workspace, optionally nested in another group
- `delete-workspace` — Delete a workspace and its groups
- `delete-workspace-group` — Delete a group in a workspace
- `get-workspace` — Get a single workspace, including its user groups and allowed connections
- `get-workspace-group` — Get a single group in a workspace
- `list-workspace-groups` — List one level of groups in a workspace
- `list-workspaces` — List workspaces, optionally filtered by name or alias
- `update-workspace` — Update the alias, name, service account, user groups, and allowed connections of a workspace
- `update-workspace-group` — Rename a group or move it under another parent group
