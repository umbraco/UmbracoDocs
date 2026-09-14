---
description: >-
  Create custom triggers, actions, and connection types in C# to extend Umbraco
  Automate with your own functionality.
---

# Overview

Umbraco Automate can be extended in C#. Add new triggers, actions, and connection types as part of your project or distribute them as NuGet packages.

## Available Extension Points

Choose the extension point that matches the behavior you want to add.

| Extension Point                                                       | Use Case                                                                                  |
| ---------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| [Create a Custom Trigger](custom-trigger.md)                          | React to a domain event or external signal that is not covered by the built-in triggers.  |
| [Create a Custom Action](custom-action.md)                            | Add a new unit of work that automations can use as a step.                                |
| [Create a Custom Connection Type](custom-connection-type.md)          | Add a new credential type for an external service.                                        |
| [Schedule and Webhook Triggers](schedule-and-webhook-triggers.md)     | Fire a trigger on a cron schedule, from an inbound webhook, or from a non-Umbraco event.  |
| [Control What Runs](controlling-execution.md)                         | Gate trigger dispatch, stop automation-triggered cycles, or wrap every action's execution. |
| [Additional Action Behavior](action-behavior.md)                      | Give an action a dynamic output schema, an audit trail entry, or export-time redaction.   |

## How Discovery Works

Triggers, actions, and connection types are auto-discovered at startup using Umbraco's type loader. Apply the relevant attribute (`[Trigger]`, `[Action]`, or `[ConnectionType]`) and inherit from the right base class. No manual registration is needed.

Some extension points need explicit registration instead of attribute discovery — webhook authenticators, trigger dispatch authorizers, and action middleware. See the relevant article above for the registration call each one needs.

## See Also

* [Triggers](../concepts/triggers.md)
* [Actions](../concepts/actions.md)
* [Connections](../concepts/connections.md)
