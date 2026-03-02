---
description: >-
  Use Baselines to quickly create new Umbraco Cloud projects using pre-made
  schema and setup.
---

# Baselines

A Baseline Child project is similar to a Fork (forked repository) on GitHub. A clone of an existing project is created while maintaining a connection between the two projects. The connection exists between the Live environment of the **Baseline project** and the left-most mainline environment of the **Child project**.

Any project can act as a Baseline project.

The idea is that you have a project containing all your standard Umbraco packages and components. Some default Document Types that you want to use as a baseline for future projects are also configured. When you've made changes to your Baseline project, you can push them out to all the Child projects with a click of a button.

![Baseline workflow](../../.gitbook/assets/baseline-workflow.gif)

## Video Tutorial

{% embed url="https://www.youtube.com/embed/Ci1Hm-bH98Y" %}
Learn how to work with Baselines.
{% endembed %}

## Create a Child Project

To create a child project, follow the steps outlined below:

1. Log in to the [Umbraco Cloud Portal](https://www.s1.umbraco.io/projects).
2. Click the **Create Project** button.
3. Select **Umbraco Baseline**.
4. Use the dropdown to choose the project to be used as the baseline.

{% hint style="info" %}
Any Umbraco Cloud project can be used as a Baseline project
{% endhint %}

1. Choose a **Plan** for the project.&#x20;
2. Enter the **Project Name** under **Project Information**.
3. **Choose an Owner** from the drop-down list.
4. Fill in the required information for **Technical Contact.**
5. Click **Continue**.
6. Review the entered information and **agree to the terms and conditions and the Data Processing Agreement**.
7. Click **Create Project**.

{% hint style="info" %}
Depending on the size of the project chosen as a Baseline project, it can take a while before the Child project is ready.
{% endhint %}

### Restore content from the Baseline project

When you've created the Child project, you can choose to restore content from your Baseline project:

1. Go to the **Content** section.
2. Right-click the top of the **Content** tree in the Umbraco backoffice.
3. Choose **Environment Restore**.
4. Ensure that **Baseline** is selected as the source to restore from.&#x20;
5. Click **Restore from Baseline**

If you do not see the content, **reload** the content tree once the restore is complete.

## [Merge Conflicts](../../optimize-and-maintain-your-site/monitor-and-troubleshoot/resolve-issues-quickly-and-efficiently/baseline-merge-conflicts/)

As with any Git repository-based development, it is not uncommon to have merge conflicts as the repositories begin to differ. Read this article for more on the merge strategy we use and how to approach resolving these conflicts.

## [Pushing upgrades to a Child Project](../../optimize-and-maintain-your-site/monitor-and-troubleshoot/resolve-issues-quickly-and-efficiently/baseline-merge-conflicts/upgrading-child-projects.md)

In this article, you'll find a guide on how to upgrade your Child project with changes from your Baseline project.

## [Handling configuration files](../../optimize-and-maintain-your-site/monitor-and-troubleshoot/resolve-issues-quickly-and-efficiently/baseline-merge-conflicts/configuration-files.md)

When you are working with Baseline Child projects, you might sometimes want to have an individual configuration for each project. This can be handled using config transforms.

## [Break the reference between the baseline and the child project](../../optimize-and-maintain-your-site/monitor-and-troubleshoot/resolve-issues-quickly-and-efficiently/baseline-merge-conflicts/break-baseline.md)

Learn how to break the connection between the baseline and one of its child projects.
