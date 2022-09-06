---
meta.Title: "Umbraco Plumber Notifications and Reminders"
meta.Description: "Information on Umbraco Plumber Notifications and Reminders"
versionFrom: 8.0.0
versionTo: 10.0.0
---

# Notifications and Reminders

Umbraco Plumber uses Notifications to allow you to configure email notifications for all workflow activities for the backoffice.

From the **Settings** view in the **Workflow** section, the **Notifications** tab provides access to the following:

- **Send notifications:** If you wish to send email notifications to approval groups, you can enable it here. If your users are active in the backoffice, email notifications might not be required.
- **Workflow email:** Provide a sender address for email notifications. This is a mandatory field.
- **Reminder delay (days):** Set a delay in days for sending reminder emails for outstanding workflow processes. Set to 0 to disable reminder emails.
- **Edit site URL:** The URL for the editing environment (including schema - http[s]). This is a mandatory field.
- **Site URL:** The URL for the public website (including schema - http[s]). This is a mandatory field.
- **Email templates:** Configure which users receive emails for which workflow actions and modify the templates for those emails. You can send an email to:
  
  ![Notifications tab in the Workflow Section](images/Notifications_tab.png)

## Notifications

Notification emails use HTML templates which render information from the `HtmlEmailModel` type which lives in the `Plumber.Core.Models.Email` namespace. While it is possible to modify the email templates from the backoffice, it is recommended to make changes via an IDE of your choice.

The `HtmlEmailModel` contains the following fields:

| Fields        | Data Type                 | Description                                                                                                    |
|---------------|---------------------------|----------------------------------------------------------------------------------------------------------------|
| WorkflowType  | WorkflowType              | An enum value containing either 1 or 2 for Publish and Unpublish respectively.                                 |
| ScheduledDate | DateTime                  | If a scheduled date exists for the workflow, it is found here.                                                 |
| Summary       | IHtmlString               | A pre-generated representation of the current workflow state.                                                  |
| CurrentTask   | WorkflowTaskViewModel     | The view model data for the current workflow task. Contains lot of useful data, best explored via Intellisense.|
| Instance      | WorkflowInstanceViewModel | The view model data for the current workflow. Best explored via Intellisense.                                  |

The `HtmlEmailBase` contains the following fields:

| Fields       | Data Type      | Description                                                                                         |
|--------------|----------------|-----------------------------------------------------------------------------------------------------|
| SiteUrl      | string         | The public URL of your site.                                                                        |
| NodeName     | string         | The name of the node from the current workflow.                                                     |
| Type         | string         | The workflow type including the scheduled date (if exists).                                         |
| EmailType    | EmailType      | An enum value representing the current email type which relates directly to the workflow task type. |
| To           | EmailUserModel | The model defining the receiver of the email.                                                       |
| Email        | string         | The user's email address or group address (if a group email is being sent).                         |
| Name         | Name           | The user's name.                                                                                    |
| Language     | string         | The user's language.                                                                                |
| Id           | int            | The user's ID or group ID (when sending to a group email address).                                  |
| IsGroupEmail | bool           | Is the email being sent to a generic group email address?                                           |

Umbraco Plumber provides **Settings** for determining who receives emails at which stages of a workflow. While these are set to default values during installation, it's recommended to update your Notifications Settings to better suit your installation needs. Emails can be sent to:

- **All**: All the participants in all workflow stages (previous and current).
- **Admin**: The admin user.
- **Author**: The user who initiated the workflow.
- **Group**: All members of the group assigned to the current task.

:::note
Duplicate users are removed from email notifications.
:::

By default, all emails are sent to the **Group**. This might not always be an ideal situation. For example: cancelled workflows would be best sent to the **Author** only, likewise with rejected.

It might be useful to notify **All** the participants of completed workflows but even this may be excessive. Depending on your website, you can adjust the best configuration.

## Config, Group, and Tasks Notifications

Currently, Notifications are raised by the Config, Group, and Tasks services. You can also subscribe to the `DocumentPublish` and `DocumentUnpublish` processes.

You cannot cancel Notifications and serve to provide an entry point for writing custom notification layers like Slack.

### ConfigService

The ConfigService is responsible for managing workflow configuration for nodes and content types. This service raises notifications whenever a node or content type configuration is updated.

## GroupService

The GroupService is responsible for managing approval groups. This service raises notifications whenever an approval group is created, updated, or deleted.

## TasksService

The TasksService is responsible for all operations involving workflow tasks. This service raises notifications whenever a task is created or updated.

## DocumentPublishProcess and DocumentUnpublishProcess

These processes are the core of the workflow and manage instance/task creation and workflow progression. These processes raise notifications whenever a workflow instance is created or updated.

### Notification Subscription

You can subscribe to notifications by adding a handler in a Component:

```csharp
public class ContentEventsComponent : IComponent
{
  public void Initialize()
  {
    GroupService.Updated += GroupService_Updated;
  }

  private void GroupService_Updated(object sender, GroupEventArgs e) {
    // do stuff whenever a group is updated
  }
}
```

where for all services, `e` will provide the object being created, updated, or deleted.

## Reminders

Umbraco Plumber uses a reminder email system to prompt editors to complete the pending workflows. Reminders are sent using Umbraco's internal task scheduler, every 24 hours after an initial delay. For example, setting the **Reminder delay (days)** value to 2 in the Workflow **Settings** section will allow pending workflows to sit for 2 days. After which reminder emails will be sent every 24 hours to all members of the group assigned to the pending workflow task.

The emails use a similar model to the notification emails, also inheriting from `HtmlEmailBase`. In addition to the inherited fields, `HtmlReminderEmailModel` includes:

| Fields       | Data Type                     | Description                                                           |
|--------------|-------------------------------|-----------------------------------------------------------------------|
| OverdueTasks | IList<WorkflowTaskViewModel>  | A list containing all the overdue tasks assigned to the current user. |
| TaskCount    | int                           | The count of overdue tasks assigned to the current user.              |
