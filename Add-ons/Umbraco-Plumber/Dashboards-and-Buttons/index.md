---
meta.Title: "Umbraco Plumber Dashboards and buttons"
meta.Description: "Information about Workflow Dashboard and buttons with Umbraco Plumber"
versionFrom: 8.0.0
versionTo: 10.0.0
---

# Dashboards and Buttons

Umbraco Plumber has it's own default Dashboards. By default, when you install Umbraco Plumber, you receive two Dashboards. Additionally, Umbraco Plumber replaces the default Umbraco button set in the editor drawer.

## Dashboards

Umbraco Plumber adds two Dashboards to your Umbraco project:

- **User Dashboard** - This Workflow Dashboard is added in the **Content** section. It displays the current user's submissions and tasks requiring approval from the user.

  ![Workflow Dashboard in the Content Section](images/WorkflowDashboard_ContentSection.png)

- **Admin Dashboard** - This Workflow Dashboard is the default view in the **Workflow** section. It displays a chart of recent workflow activity and any relevant messages related to upgrades. You can also set number of days to view the workflow activity chart for the specified days range.

  ![Workflow Dashboard in the Workflow Section](images/WorkflowDashboard_WorkflowSection.png)

## Buttons

When a workflow is active on the current node, the **Publish** button is replaced, linking to the workflow content app.

![Disabled content edits](images/Buttons.png)

When no workflow is active, the button state is determined by the current user's permissions.

Umbraco Plumber overrides Umbraco's user/group publishing permissions. If the user has permission to update the node, they will be able to intiate a workflow process on that node. Umbraco Plumber shifts Umbraco from a centrally administered publishing model (i.e. controlled by a site administrator) to a distributed model, where editors publish content based on their responsibilities assigned during the workflows.

In cases, where the content is already in a workflow, a notification is displayed at the top of the editor. Depending on the Workflow **Settings**, you can enable/disable  editing access on a content node in a workflow.

![Disabled content edits](images/blocked_content.png)

For nodes where the workflow has been disabled, the default Umbraco options are displayed.

![Default Button](images/Default_Buttons.png)
