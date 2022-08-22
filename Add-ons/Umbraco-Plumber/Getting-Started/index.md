---
meta.Title: "Get started working with Umbraco Plumber"
meta.Description: "Here you can find information about getting started with Umbraco Plumber"
versionFrom: 9.0.0
versionTo: 10.0.0
---

# Umbraco Plumber

In this article, you can read about [Umbraco Plumber](https://umbraco.com/products/umbraco-cloud/) and how to get started.

## Umbraco Plumber Overview

Umbraco Plumber allows creation of multi-stage approval workflows. A workflow process comprises multiple steps (no limit aside from practicality), with multiple users assigned to the group responsible for providing approval at each step.

A user can be a member of multiple groups in the same workflow. To initiate an approval workflow, a user updates content, saves their changes, then selects 'Request approval' from the editor button drawer.

After entering a comment describing the nature of the changes, and submitting the request, members of the approving group are notified via email, and have a task pushed into their workflow dashboard. When initiating a workflow, the user can choose to add a document attachment - eg an email approving or requesting the change be made.

Tasks can be approved (or cancelled or rejected) from the dashboard or from the content node button drawer.

The workflow dashboard updates to reflect the state of each task, providing an overview of a user's submissions and tasks.

Rejecting a task returns the workflow to the original author, who can update the content and resubmit. The resubmitted content does not restart the workflow, but returns to the stage at which it was rejected.
