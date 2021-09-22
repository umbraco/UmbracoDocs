---
versionFrom: 9.0.0
---

# Baselines

A Baseline Child project is very similar to a Fork (forked repository) on GitHub where we create a clone of an existing project while maintaining a connection between the two projects. The connection exists between the _Live_ environment of the existing project, the **Baseline project**, and the _Development_ or Live environment - of the newly created project, the **Child project**.

Any project can act as a Baseline project.

The basic idea is that you have a project that contains all your standard Umbraco packages/components, maybe even configured with some default Document Types, which you want to use as a baseline for future projects. When you've made changes to your Baseline project you can then push these changes out to all the Child projects with a click of a button.

![Baseline workflow](images/baseline-workflow.gif)

For some more in-depth information have a look at the [High-level Overview](High-level-overview/) article.

## Creating a Child Project

To create a child project:

1. Log in to the [Umbraco Cloud Portal](https://www.s1.umbraco.io/projects).
2. Click the **Create New Project** button.
3. Select **Umbraco Cloud** from the **Create New Project** window.
4. Choose either **Starter**, **Standard** or **Professional** plan from the **Plan Selection** window.
5. In the **Project Information** window, enter the following details:
    - Enter the **Project Name**.
    - **Choose an Owner** from the drop-down list.
    - From the **Choose baseline (Optional)** drop-down list, select the Cloud project the new project should be based on.
    :::note
    Any Umbraco Cloud project can be used as a Baseline project
    :::
    - Select the **Region** from the drop-down list.
    - Select **I want to create an Umbraco 9 project**.
    - Select **I have read and agree to the terms and conditions and the Data Processing Agreement**.
6. Click **Create Project** and you will be redirected to the new project.
    - It might take several minutes for the project to spin up and before your environments are ready.

When your environments are ready, you will see a *green* light next to the environment name.

![Creating a Baseline child project](images/create-baseline-child-project-v9.gif)

:::note
Depending on the size of the project you've chosen as a Baseline project, it might take several minutes before the Child project is ready.
:::

### Restore content from the Baseline project

When you've created the Child project you can choose to restore content from your Baseline project:

* 'Right-click* the top of the Content tree in the Umbraco backoffice
* Choose *Restore*
* The *Baseline project* should already be selected as the environment to restore from
* Click **Restore from Baseline**
* Once the restore is complete, *reload* the content tree to see the content!

![Restore content from Baseline project](images/RestoreFromBaseline.gif)

## [Merge Conflicts](Baseline-Merge-Conflicts/)
As with any Git repository-based development it is not uncommon to have merge conflicts as the various repositories begin to differ. Read this article for more on the merge strategy we use and how to approach resolving these conflicts.

## [Pushing upgrades to a Child Project](Upgrading-Child-Projects/)
In this article you'll find a guide on how to upgrade your Child project with changes from your Baseline project.

## [Handling configuration files](Configuration-files/)
When you are working with Baseline Child projects you might sometimes want to have individual configuration for each project - this can be handled using config transforms.
