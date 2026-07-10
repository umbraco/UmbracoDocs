---
description: >-
  Reference for the triggers contributed by the Umbraco.Workflow.Automate
  add-on.
---

# Triggers

The Workflow add-on contributes the following triggers.

## Workflow Lifecycle Triggers

| Display Name          | Alias                          |
| ---------------------- | ------------------------------- |
| Workflow Started       | `umbracoWorkflow.started`       |
| Workflow Completed     | `umbracoWorkflow.completed`     |
| Workflow Approved      | `umbracoWorkflow.approved`      |
| Workflow Rejected      | `umbracoWorkflow.rejected`      |
| Workflow Cancelled     | `umbracoWorkflow.cancelled`     |
| Workflow Resubmitted   | `umbracoWorkflow.resubmitted`   |

## Task Triggers

| Display Name  | Alias                        |
| -------------- | ----------------------------- |
| Task Assigned  | `umbracoWorkflow.taskAssigned` |

## Email Triggers

| Display Name          | Alias                              |
| ---------------------- | ------------------------------------ |
| Workflow Email Sent     | `umbracoWorkflow.emailSent`          |
| Reminder Emails Sent    | `umbracoWorkflow.reminderEmailsSent` |

## Content Review Triggers

| Display Name              | Alias                                    |
| --------------------------- | ------------------------------------------ |
| Content Review Completed   | `umbracoWorkflow.contentReviewCompleted`   |

{% hint style="info" %}
Each Workflow trigger emits details about the workflow instance, task, or content review it fired on. Fields include the node ID, entity key, workflow type and status, author, and comment. Inspect a real run in the **Runs** view to see the exact field names, then use the binding picker to reference them in downstream steps.
{% endhint %}
