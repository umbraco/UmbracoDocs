---
description: >-
  How Umbraco Automate runs automations across multiple nodes, and what that
  means for your custom triggers and actions.
---

# Load Balancing

Umbraco Automate supports load-balanced environments out of the box. The engine decides which node runs an automation. Your custom triggers and actions do not need their own server-role checks.

## What Each Node Does

Every node captures trigger events and writes them to a database outbox table. Which node consumes that work depends on the execution mode.

| Concern                               | Every node | Scheduling publisher only |
| ------------------------------------- | :--------: | :-----------------------: |
| Trigger handlers capture events       |     Yes    |                           |
| Trigger events written to the outbox  |     Yes    |                           |
| Managing automations in the backoffice|     Yes    |                           |
| Scheduled (CRON) trigger evaluation   |            |            Yes            |
| Outbox consumption and step execution |  See below |         See below         |

## Execution Modes

The `Execution:Mode` setting controls which nodes consume outbox messages and run automation steps.

{% code title="appsettings.json" %}
```json
{
  "Umbraco": {
    "Automate": {
      "Execution": {
        "Mode": "SchedulerOnly"
      }
    }
  }
}
```
{% endcode %}

| Mode            | Behavior                                                                                                                                           |
| --------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| `SchedulerOnly` | The default. Only a `Single` server or the elected `SchedulingPublisher` consumes the outbox and runs steps. Other nodes capture and queue events. |
| `Distributed`   | Every node competes for outbox messages and runs steps. Use this mode to spread automation load across the cluster.                                 |

In both modes, a message is claimed by one node at a time. The outbox uses optimistic concurrency on a claim column, so two nodes never run the same message in parallel.

## Scheduled Triggers Fire Once

Scheduled triggers are evaluated by a recurring background job. That job runs only on a `Single` server or the elected `SchedulingPublisher`, and only in the main application domain. This applies in both execution modes.

A CRON automation therefore fires once per due time across the whole cluster. You do not need to add a publisher check to a custom scheduled trigger.

## Write Actions That Can Run Twice

Exactly-once claiming is not the same as exactly-once execution. A claim goes stale when the node holding it stops responding, and the message is then retried. The retry can land on a different node.

Write actions so that a repeat run is safe. This matters most for actions that create content or call an external system.

- Look up the target by a stable external key before creating it.
- Send a unique request key to external APIs that support one, so a repeated call is ignored.
- Treat a partially completed run as a state your action can recover from.

{% hint style="info" %}
Retries also happen when an action throws. See [Actions](../concepts/actions.md) for step timeouts and retry behavior.
{% endhint %}

## Server Role Election

Automate relies on the Umbraco server role to pick the scheduling publisher. If Umbraco cannot determine its application URL, the server registration job does not run, and every node stays on the `Unknown` role.

In the default `SchedulerOnly` mode, no node is eligible in that state. Trigger events are written to the outbox and stay pending, and scheduled triggers never fire.

To resolve this, set one of the following in `appsettings.json`:

| Setting                                              | Use when                                                        |
| ---------------------------------------------------- | --------------------------------------------------------------- |
| `Umbraco:CMS:WebRouting:UmbracoApplicationUrl`       | You know the public URL of the site.                            |
| `Umbraco:CMS:WebRouting:ApplicationUrlDetection`     | You want Umbraco to detect the URL from the first request.      |
| `Umbraco:CMS:Global:DisableElectionForSingleServer`  | The site runs on a single instance.                             |

{% code title="appsettings.json" %}
```json
{
  "Umbraco": {
    "CMS": {
      "WebRouting": {
        "UmbracoApplicationUrl": "https://www.example.com"
      }
    }
  }
}
```
{% endcode %}

The **Automation Execution Eligibility** health check reports whether the current node is eligible to process automation work. Find it in the **Umbraco Automate** group under **Settings** > **Health Checks**. The check returns an error when work is already queued and this node cannot consume it.

For more information on server roles, see the [Umbraco in Load Balanced Environments](https://docs.umbraco.com/umbraco-cms/run-in-production/infrastructure-and-ops/server-setup/load-balancing) article in the Umbraco CMS documentation.

## Choosing a Mode

Stay on `SchedulerOnly` unless automation throughput is a measured bottleneck. It keeps execution on one node, which makes runs easier to trace in logs.

Move to `Distributed` when a single node cannot keep up with the volume of automation work. All nodes must point to the same Automate database.

## Next Steps

{% content-ref url="first-automation.md" %}
[first-automation.md](first-automation.md)
{% endcontent-ref %}
