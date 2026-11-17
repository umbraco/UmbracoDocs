---
description: >-
  Learn the core concepts that make up Umbraco Automate — workspaces,
  automations, triggers, actions, connections, bindings, and runs.
---

# Core Concepts

Umbraco Automate is built around a small set of concepts. Understanding them helps you build automations confidently and read run history when something goes wrong.

## Concept Map

| Concept                         | Description                                                                               |
| ------------------------------- | ----------------------------------------------------------------------------------------- |
| [Workspace](workspaces.md)      | A container that groups automations and controls which connections and users have access. |
| [Automation](automations.md)    | A user-defined workflow — a trigger plus a sequence of steps.                             |
| [Trigger](triggers.md)          | The event that starts an automation.                                                      |
| [Action](actions.md)            | A reusable unit of work that runs as a step in an automation.                             |
| [Connection](connections.md)    | A named, reusable credential set for an external service.                                 |
| [Binding](bindings.md)          | A `${ ... }` placeholder that passes data between steps.                                  |
| [Control Flow](control-flow.md) | Branching and looping primitives such as If, Switch, While, and ForEach.                  |
| [Run](runs.md)                  | A single execution of an automation, with per-step audit data.                            |
| [Versioning](versioning.md)     | Draft and published versions of an automation, with rollback.                             |
