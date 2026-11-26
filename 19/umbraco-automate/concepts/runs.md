---
description: >-
  A run is a single execution of an automation. Every run is recorded with
  per-step inputs, outputs, errors, and timing.
---

# Runs

A run is a single execution of an automation. Every run is captured for audit and debugging.

## What a Run Records

Each run records enough data to trace what happened from trigger to final outcome.

| Field              | Description                                                                    |
| ------------------ | ------------------------------------------------------------------------------ |
| **Status**         | Pending, Running, Completed, Failed, Suspended, Cancelled, or Rejected.        |
| **Initiator**      | Who or what started the run — a user, an event handler, a webhook, a schedule. |
| **Trigger output** | The data emitted by the trigger.                                               |
| **Steps**          | For each step: status, input, output, log entries, error, duration, retry count, and the exit the step took. |
| **Version**        | Which published version of the automation was used.                            |

A run's status is **Rejected**, not **Failed**, when it ends because a human declined a [Request Approval](../backoffice/approvals.md) step and nothing else went wrong. It is a terminal status, but not an error — the automation ran exactly as designed.

## Run Detail View

Open a run from the **Runs** view on the automation. The run detail view lists the trigger and each step that ran. Expand a step to see its input, output, and log entries for that run. See [Reviewing Runs](../backoffice/runs.md).

### Exit Taken

A step that branches records the exit it took. Branching steps are actions that declare outcomes, **If**, **Switch**, and **Request Approval**. See [Control Flow](control-flow.md#other-steps-that-branch).

* On the run's **Canvas** view, the line each step took is highlighted. Other named lines from that step are dimmed. An **Any result** line is highlighted too, because it always runs.
* On the run's **Details** view, expand the step. The **Details** tab shows **Exit taken** with the label of the exit.

A step inside a loop can take a different exit on each iteration. The canvas highlights every exit the step took.

Steps that don't branch and steps that failed have no exit taken. Neither do runs recorded before Umbraco Automate 18.6.0, because the exit wasn't saved then.

## Versioning and Runs

A run always completes on the version of the automation that was live when the run started. Publishing a new version does not affect runs that are already in progress.

## Runs Interrupted by a Restart

If Umbraco stops while a step is running, Automate marks the run as **Failed** when that node starts again. It also stops the run's workflow, so the interrupted step is not run a second time on restart. A step that calls an external service, sends an email, or uses AI credits is therefore not repeated.

If the site stopped abruptly, automations can take up to `WorkflowLock:LeaseDuration` (30 seconds by default) to start running again. Automate first checks whether any other node is still running. A clean shutdown lets the site start straight away.

Runs that were waiting when the site stopped are not affected. For example, a run waiting on a **Delay** or a [Request Approval](../backoffice/approvals.md) step continues as normal. The same applies when an approval was decided shortly before the site stopped. The run continues down the path that was chosen.

To run the automation again, use **Replay** on the failed run. See [Reviewing Runs](../backoffice/runs.md).

In a load-balanced setup, Automate leaves every run in progress alone while another node is still running. See [Restarting a Node](../run-in-production/load-balancing.md#restarting-a-node).

## Retention

Automate deletes runs older than `RunCleanup:RetentionDays` (90 by default). It also keeps at most `RunCleanup:MaxRunsPerAutomation` runs per automation (1,000 by default). See [Run Cleanup](../getting-started/configuration.md#run-cleanup).

## See Also

* [Reviewing Runs](../backoffice/runs.md)
* [Versioning](versioning.md)
