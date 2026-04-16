---
description: Learn how to break the connection between a Baseline project and one of its Child projects.
---

# Break Reference between Baseline and Child Project

To remove the connection between a Baseline and a Child project, you need admin privileges. Once disconnected, the Child project becomes a standalone project and will no longer receive updates from the Baseline.

{% hint style="warning" %}
Breaking the connection cannot be undone.
{% endhint %}

1. Go to the Baseline project in the Umbraco Cloud portal.
2. Click the **Baseline** label at the bottom of the left-side menu.
   * Alternatively, go to **Management** > **Baselines**.

   ![The Baselines management page showing connected Child projects](../../../../.gitbook/assets/manage-child-projects.png)
3. Click the ![Disconnect icon](../../../../.gitbook/assets/disconnect-icon.png) next to the Child project you want to disconnect.

   A confirmation window appears, showing the consequences of disconnecting.
4. Enter the Child project name you wish to disconnect.
5. Click **Disconnect**.

   ![Break Baseline and child project](../../../../.gitbook/assets/break-reference.png)
