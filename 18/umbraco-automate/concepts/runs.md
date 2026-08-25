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
| **Steps**          | For each step: status, input, output, error, duration, retry count.            |
| **Version**        | Which published version of the automation was used.                            |

A run's status is **Rejected**, not **Failed**, when it ends because a human declined a [Request Approval](../backoffice/approvals.md) step and nothing else went wrong. It is a terminal status, but not an error — the automation ran exactly as designed.

## Run Detail View

Open a run from the **Runs** view on the automation. The run detail page replays the automation on the canvas with each step coloured by status. Click a step to view the resolved settings and output for that run.

## Versioning and Runs

A run always completes on the version of the automation that was live when the run started. Publishing a new version does not affect runs that are already in progress.

## Retention

Run data is retained according to the `AuditLogRetentionDays` setting. See [Configuration](../getting-started/configuration.md) for details.

## See Also

* [Reviewing Runs](../backoffice/runs.md)
* [Versioning](versioning.md)
