---
description: >-
  Use Baselines to quickly create new Umbraco Cloud projects using pre-made
  schema and setup.
---

# Baselines

A Baseline project is similar to a fork (forked repository) on GitHub. A clone of an existing project is created while maintaining a connection between the two projects. The connection exists between the Live environment of the **Baseline project** and the left-most mainline environment of the **Child project**.

Any project can act as a Baseline project.

The idea is that you have a project containing all your standard Umbraco packages and components. Some default Document Types that you want to use as a baseline for future projects are also configured. When you've made changes to your Baseline project, you can push them out to all the Child projects with a click of a button.

![Baseline workflow](../../.gitbook/assets/baseline-workflow.gif)

## Create a Child Project

To create a Child project from a Baseline, follow these steps:

1. Log in to the [Umbraco Cloud Portal](https://www.s1.umbraco.io/projects).
2. Click the **Create Project** button.
3. Click **Select Baseline project**.

<figure><img src="../../.gitbook/assets/create-baseline-project.png" alt="Select Baseline Project"><figcaption>Select Baseline Project</figcaption></figure>

4. Use the dropdown to choose an existing project to use as the baseline.

<figure><img src="../../.gitbook/assets/select-baseline-project.png" alt="Choose an existing project that will become a base for your new project"><figcaption>Choose an existing project that will become a base for your new project </figcaption></figure>

5. Click **Confirm**.
6. Choose a **Plan** for the project.
7. Enter the **Project Name**.
8. **Choose an Owner** from the drop-down list.
9. Fill in the required **Technical Contact** information.
10. Click **Continue**.
11. Review the **Summary** of the information provided.
12. Select **I have read and agree to the terms and conditions and the Data Processing Agreement**.
13. Click **Create Project**.

{% hint style="info" %}

The Child project creation time depends on the size of the Baseline project.

{% endhint %}

### Restore content from the Baseline project

When you've created the Child project, you can restore content from the Baseline project:

1. Go to the newly created project.
2. Click **Backoffice**.
3. Go to the **Content** section.
4. Click **...** next to the **Content** tree.
5. Select **Environment Restore**.
6. Ensure **Baseline** is selected in the dropdown as the source environment.
7. Click **Restore from Baseline**.

If you do not see the content, reload the content tree once the restore is complete.

## Related articles

{% content-ref url="../../optimize-and-maintain-your-site/monitor-and-troubleshoot/resolve-issues-quickly-and-efficiently/baseline-merge-conflicts/upgrading-child-projects.md" %}
[Pushing upgrades to a Child Project](../../optimize-and-maintain-your-site/monitor-and-troubleshoot/resolve-issues-quickly-and-efficiently/baseline-merge-conflicts/upgrading-child-projects.md)
{% endcontent-ref %}

{% content-ref url="../../optimize-and-maintain-your-site/monitor-and-troubleshoot/resolve-issues-quickly-and-efficiently/baseline-merge-conflicts/configuration-files.md" %}
[Configuration files](../../optimize-and-maintain-your-site/monitor-and-troubleshoot/resolve-issues-quickly-and-efficiently/baseline-merge-conflicts/configuration-files.md)
{% endcontent-ref %}

{% content-ref url="../../optimize-and-maintain-your-site/monitor-and-troubleshoot/resolve-issues-quickly-and-efficiently/baseline-merge-conflicts/" %}
[Baseline Merge Conflicts](../../optimize-and-maintain-your-site/monitor-and-troubleshoot/resolve-issues-quickly-and-efficiently/baseline-merge-conflicts/)
{% endcontent-ref %}

{% content-ref url="../../optimize-and-maintain-your-site/monitor-and-troubleshoot/resolve-issues-quickly-and-efficiently/baseline-merge-conflicts/break-baseline.md" %}
[Break the baseline reference](../../optimize-and-maintain-your-site/monitor-and-troubleshoot/resolve-issues-quickly-and-efficiently/baseline-merge-conflicts/break-baseline.md)
{% endcontent-ref %}
