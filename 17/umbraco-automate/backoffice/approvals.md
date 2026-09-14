---
description: >-
  Add approval steps to an automation and act on pending approvals in the
  backoffice.
---

# Use Approvals

The **Request Approval** action pauses an automation and waits for a user to approve or reject before the run continues. Use it to add a human checkpoint to an automation — for example, before publishing AI-generated content.

## How It Works

1. The automation reaches a **Request Approval** step.
2. The run is suspended and an approval entry is created with the configured prompt.
3. A user with access to the workspace opens the approval and chooses **Approve** or **Reject**.
4. The step finishes and the run follows whichever branch matches the decision.

A rejection is not an error. The **Request Approval** node has two outgoing handles on the canvas — **Approved** and **Rejected**. Send each outcome down a different path, the same way you would with an **If** node. See [Control Flow](../concepts/control-flow.md).

If a run finishes on the Rejected path, its status is **Rejected**, a separate status from **Failed**. Nothing went wrong — a person said no.

## Using the Decision in Later Steps

The step's output is available to any step that runs after it:

| Field                 | Description                                                     |
| --------------------- | ----------------------------------------------------------------- |
| `approved`            | `true` or `false`. Use this to branch, for example `${ steps.approval.approved }`. |
| `outcome`             | The decision as text: `Approved` or `Rejected`.                 |
| `comment`             | The optional note the approver left.                            |
| `approvedByUserKey`   | The user key of whoever made the decision.                      |
| `decisionUtc`         | The date and time the decision was made.                        |

See [Bindings](../concepts/bindings.md) for the full binding syntax.

## Request Approval Settings

| Setting             | Description                                                                                                  |
| ------------------- | ------------------------------------------------------------------------------------------------------------ |
| **Prompt**          | The message shown to approvers explaining what needs approval. Supports [bindings](../concepts/bindings.md). |
| **Timeout (hours)** | Optional. If set, the step auto-rejects when no decision is made within this many hours.                     |

## Approver Permissions

A user can act on an approval if they are a member of a user group that the workspace allows access to. See [Manage Workspaces](workspaces.md).

## Finding Pending Approvals

The **Approvals** dashboard in the Automate section lists every approval awaiting a decision across the workspaces you can access. Click an approval to open the decision dialog.

## See Also

* [Build an Automation](building-an-automation.md)
* [Manage Workspaces](workspaces.md)
* [Control Flow](../concepts/control-flow.md)
* [Bindings](../concepts/bindings.md)
