---
description: >-
  Connections store credentials for external services and are shared by the
  actions that need them.
---

# Connections

A connection is a named, reusable credential set for an external service such as Slack, an SMTP server, or an OAuth provider. Connections separate credentials from automation definitions so that the same automation can be safely transferred between environments.

## Why Connections

Without connections, every action that talks to an external service would need its credentials configured inline. Connections solve three problems:

* **Reuse** — multiple automations can share the same connection.
* **Environment safety** — credentials are configured per environment and never travel with an exported automation.
* **Security** — credentials are encrypted at rest and masked in run logs.

## Connection Types

Each connection has a type that defines what credentials are needed and how to validate them. Built-in and add-on packages contribute connection types. For example:

* The **Slack** add-on adds a `slack` connection type that uses OAuth.
* A custom provider can add a `smtp` connection type with host, port, username, and password fields.

When an action requires a connection, the connection picker only shows connections of the matching type.

## Scope

Connections are stored globally but their use is scoped by workspace. Each workspace declares which connections its automations can use via the **Allowed Connections** field on its **Settings** tab. An action only sees connections that the workspace has allowed. See [Workspaces](workspaces.md) for the access model.

## Validation

Most connection types implement a validation step. Click **Test connection** in the connection editor to check the credentials work before saving.

## See Also

* [Manage Connections](../backoffice/connections.md)
* [Slack add-on](../add-ons/slack/)
* [Create a Custom Connection Type](../extending/custom-connection-type.md)
