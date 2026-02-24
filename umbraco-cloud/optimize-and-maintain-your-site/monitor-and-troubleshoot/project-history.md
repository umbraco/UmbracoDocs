---
description: >-
  On the Project History page, you can view a chronological overview of
  high-level activities for your cloud project.
---

# Project History

The Project History page shows details about the following changes to your project:

* Deployments and CI/CD flow deployments.
* Synchronizing (pulling) and reintegrating (pushing) changes between environments.
* Adding or removing environments.
* Project plan changes.
* Transitions between shared and dedicated resources.
* Database restores.
* Product upgrades (manual and automatic).

This is to provide you with better oversight and control over your project.

<figure><img src="../../.gitbook/assets/project-history-overview.png" alt="Project History overview"><figcaption><p>Project History page</p></figcaption></figure>

For each activity you can see the following information:

* The type of activity
* Information about the activity
* Who the activity was started by
* When the activity was started
* When the activity ended
* The status of the activity (Completed, In Progress, or Failed)

You can copy the activity ID to your clipboard using the clipboard icon on each entry. This is useful when contacting support.

## Viewing Activity Details

To get a detailed view of an activity, click the button on the right side of the entry.

For deployments, CI/CD flow deployments, synchronize/reintegrate operations, and upgrades, clicking **See more** opens a detail page with logs, timestamps, and error information.

<figure><img src="../../.gitbook/assets/project-history-deployment-details.png" alt="Deployment details"><figcaption><p>Deployment details</p></figcaption></figure>

For upgrades, clicking **See more** redirects to an Upgrade Details page where you can see details about how the upgrade went.

<figure><img src="../../.gitbook/assets/project-history-upgrade-details.png" alt="Upgrade details"><figcaption><p>Upgrade details</p></figcaption></figure>

For other activities such as adding or removing environments, plan changes, moving to dedicated or shared resources, and database restores, clicking **See activity** opens a dialog showing the stages and tasks involved in the process.

<figure><img src="../../.gitbook/assets/project-history-activity-dialog.png" alt="Activity dialog"><figcaption><p>Activity details dialog</p></figcaption></figure>
