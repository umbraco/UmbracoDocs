---
meta.Title: "Umbraco Plumber Dashboards and buttons"
meta.Description: "Information about Dashboards and buttons with Umbraco Plumber"
versionFrom: 8.0.0
versionTo: 10.0.0
---

# Dashboards and Buttons

Umbraco Plumber adds two Dashboards to the Umbraco installation:

- **User dashboard:** added in the content section, this view displays all submissions and pending tasks for the current user
- **Admin dashboard:** the default view in the Workflow section, displaying a chart of recent workflow activity, and any relevant messaging related to upgrades

Umbraco Plumber replaces the default Umbraco button set in the editor drawer. When a workflow is active on the current node, the button is singular, linking to the workflow content app. When no workflow is active, the button state is determined by the current user's permissions.

Umbraco Plumber overrides Umbraco's user/group publishing permissions. Provided the user has permission to update the node, they will be able to intiate a workflow process on that node. Umbraco Plumber essentially shifts Umbraco from a centrally administered publishing model (ie controlled by a site administrator) to a distributed model, where editors publish content based on their responsibilities assigned through inclusion in workflows.

In cases where the content is already in a workflow, a notification is displayed at the top of the editor (depending on settings, content edits may also be disabled). For nodes where the workflow has been disabled, the default Umbraco options are displayed.
