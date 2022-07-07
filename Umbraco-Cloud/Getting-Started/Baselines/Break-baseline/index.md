---
versionFrom: 8.0.0
versionTo: 10.0.0
---

# Break Reference between Baseline and Child Project

Umbraco Cloud Portal offers a powerful baseline-child relationship between projects. A Baseline Child project is very similar to a Fork (forked repository) on GitHub where we create a clone of an existing project while maintaining a connection between the two projects.

If at some point, you want to break this connection between the baseline and one of its child projects it is possible to do so with admin privileges.

:::warning
Kindly be aware that this action cannot be undone.
:::

![Baseline child project](images/Baseline-child-project.png)

From this page, you can break the connection of all the Child Projects this Baseline project has.

To break reference between a baseline and child project:

1. Click on the ![Disconnect](images/disconnect-icon.png) icon.
2. A window with the consequences of the action is displayed.
3. Read and understand the consequences mentioned and check all three boxes, if you want to disconnect.
4. Click **Disconnect**.

    ![Break Baseline and child project](images/Break-baseline.gif)
