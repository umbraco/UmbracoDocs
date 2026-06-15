---
description: Learn how to manage child projects connected to your Baseline, including pushing updates and disconnecting children.
---

# Manage Baseline Children

Use the **Manage child projects** page to push updates from your Baseline to connected child projects, monitor each child's update status, and break the connection when needed.

The page is available on any project used as a baseline. Access it in multiple ways:

1. Go to the Baseline project in the Umbraco Cloud portal.
2. Navigate to the **Manage child projects** page.
   * Click the **Baseline** label at the bottom of the left-side menu.
   * Alternatively, go to **Management** > **Baselines**.

<figure><img src="../../.gitbook/assets/manage-child-projects.png" alt="The Baselines management page showing connected Child projects"><figcaption><p>Navigation showing how to navigate to the <strong>Manage child projects</strong> page.</p></figcaption></figure>

## Page overview

The page shows a list of projects that are based on the baseline.

<figure><img src="../../.gitbook/assets/baseline-manage-child-project.png" alt="Baselines - Manage child projects page"><figcaption><p>The Manage child projects page lists child projects connected to the baseline.</p></figcaption></figure>

Each child project shows the **Last update (UTC)**. A child that has not been updated within the last 5 baseline updates shows a generic message.

<figure><img src="../../.gitbook/assets/baselines-no-updates-back-five.png" alt="Baselines - Child was not updated in the last 5 updates"><figcaption><p>A child project that has not been updated within the last 5 baseline updates shows a generic message.</p></figcaption></figure>

### Pushing changes from baseline to children

You can push changes coming from the baseline out to the children.

Use the checkboxes to select which child projects you want to update. Click **Update selected** to push changes from the baseline to the child projects.

Pushing changes from the baseline creates an entry in **Project history**. Each targeted child project also gets its own entry.

### Actions, sorting and filters

Click a column header to sort the list by `Project name` or `Last update (UTC)`.

The **Filter children** input field filters the list by project name.

Use the **Select outdated** button in the action bar to select all children where component versions are behind the baseline. Then click **Update selected** to push changes.

### Outdated components

A child project can show an indicator for components that are behind the baseline. Tracked components include Umbraco CMS, Deploy, Forms, Umbraco ID, `Umbraco.Cloud.Cms`, and more.

<figure><img src="../../.gitbook/assets/baselines-components-behind.gif" alt="Baselines - Show components on child project that are behind the baseline"><figcaption><p>Child projects showing components that are behind the baseline.</p></figcaption></figure>

## Break Reference between Baseline and Child Project

To remove the connection between a Baseline and a Child project, you need admin privileges. Once disconnected, the Child project becomes a standalone project and will no longer receive updates from the Baseline.

{% hint style="warning" %}
Breaking the connection cannot be undone.
{% endhint %}

1. Navigate to the **Manage child projects** page
2. Click the disconnect icon next to the Child project you want to disconnect.

![Disconnect icon](../../.gitbook/assets/baseline-child-list-item-disconnect.png)

   A confirmation window appears, showing the consequences of disconnecting.
3. Enter the Child project name you wish to disconnect.
4. Click **Disconnect**.

   ![Break Baseline and child project](../../.gitbook/assets/break-reference.png)

## Related articles

{% content-ref url="../../optimize-and-maintain-your-site/monitor-and-troubleshoot/resolve-issues-quickly-and-efficiently/baseline-merge-conflicts/upgrading-child-projects.md" %}
[Pushing Upgrades to a Child Project](../../optimize-and-maintain-your-site/monitor-and-troubleshoot/resolve-issues-quickly-and-efficiently/baseline-merge-conflicts/upgrading-child-projects.md)
{% endcontent-ref %}

{% content-ref url="../../optimize-and-maintain-your-site/monitor-and-troubleshoot/resolve-issues-quickly-and-efficiently/baseline-merge-conflicts/configuration-files.md" %}
[Configuration files](../../optimize-and-maintain-your-site/monitor-and-troubleshoot/resolve-issues-quickly-and-efficiently/baseline-merge-conflicts/configuration-files.md)
{% endcontent-ref %}

{% content-ref url="../../optimize-and-maintain-your-site/monitor-and-troubleshoot/resolve-issues-quickly-and-efficiently/baseline-merge-conflicts/" %}
[Baseline Merge Conflicts](../../optimize-and-maintain-your-site/monitor-and-troubleshoot/resolve-issues-quickly-and-efficiently/baseline-merge-conflicts/)
{% endcontent-ref %}
