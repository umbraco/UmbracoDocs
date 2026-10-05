---
description: >-
  How Umbraco Automate runs automations across multiple nodes and what that
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

## Restarting a Node

When a node starts, it marks runs that were interrupted mid-step as **Failed**. See [Runs Interrupted by a Restart](../concepts/runs.md#runs-interrupted-by-a-restart). Every node runs this check except nodes in the `Subscriber` role. That includes nodes still in the `Unknown` role before server role election.

The check leaves alone any run whose step another node is executing. A node holds a lock on each run while it executes a step, and renews it until the step finishes. If the check finds a held lock, it waits up to `WorkflowLock:LeaseDuration` for locks left by a stopped process to expire. Automations on that node start running once the check completes.

Keep the following in mind:

* Keep node clocks in sync, for example with Network Time Protocol (NTP). Each node compares lock expiry times with its own clock. A clock that is ahead by more than `LeaseDuration` minus `RenewalInterval` (about 20 seconds by default) treats live locks as expired.
* Keep `WorkflowLock:RenewalInterval` well below `WorkflowLock:LeaseDuration`.
* A run holds no lock while it waits to be picked up, sits between steps, or waits to retry a step. Restarting another node at that moment can still mark the run as **Failed**. Restart nodes one at a time, when the site is quiet.
* In `Distributed` mode, another node can pick up a step from a node that stopped once its lock expires. That step then runs again, so write actions that can run twice (see above).

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

## Share the Data Protection Keys

After an OAuth sign-in, such as for a Slack connection, Automate protects the result with ASP.NET Core Data Protection. The node that completes the sign-in and the node that saves the connection can differ. All nodes must share the same Data Protection key ring, as Umbraco CMS already requires for load-balanced sites. Otherwise, saving a connection after signing in can fail.

## Choosing a Mode

Stay on `SchedulerOnly` unless automation throughput is a measured bottleneck. It keeps execution on one node, which makes runs easier to trace in logs.

Move to `Distributed` when a single node cannot keep up with the volume of automation work. All nodes must point to the same Automate database.

## See Also

* [Configuration](../getting-started/configuration.md) for the full `Execution` settings block.
* [Transfer Automations](../add-ons/deploy/transferring-automations.md) for moving automations between environments with the Deploy add-on.
