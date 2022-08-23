---
meta.Title: "Umbraco Plumber Notifications and Reminders"
meta.Description: "Information on Umbraco Plumber Notifications and Reminders"
versionFrom: 8.0.0
versionTo: 10.0.0
---

# Notifications and Reminders

Umbraco Plumber uses a more mature and versatile notifications engine, allowing deep configuration of email notifications for all workflow activities.

From the settings view in the Workflow backoffice section, the notifications dashboard provides access to the following:

- **Send notifications:** if your users are active in the backoffice, email notifications might not be required. Turn them off here.
- **Reminder delay:** set a delay in days for sending reminder emails for outstanding workflow processes. Set to 0 to disable.
- **Workflow email:** set a sender address for notification emails. MANDATORY
- **Site URL:** the URL for the public website (including schema - http[s]). MANDATORY
- **Edit site URL:** the URL for the editing environment (including schema - http[s]). MANDATORY
- **Email templates:** configure which users receive emails for which workflow actions, and modify the templates for those emails

## Notifications

Notification emails use HTML templates, rendering information from the `HtmlEmailModel` type, which lives in the `Plumber.Core.Models.Email` namespace. While it's entirely possible to modify the email templates from the backoffice, it's recommended to make changes via your IDE of choice, to enjoy the helping hand that is Intellisense.

The `HtmlEmailModel` looks like this:

- {WorkflowType} WorkflowType: an enum value, either 1 or 2, for Publish and Unpublish respectively
- {DateTime?} ScheduledDate: if a scheduled date exists for the workflow, it is found here
- {IHtmlString} Summary: a pre-generated representation of the current workflow state (the same data as found in the pre-v1.6.0 email content)
- {WorkflowTaskViewModel} CurrentTask: the view model data for the current workflow task. Comes with a whole lot of useful data, best explored via Intellisense
- {WorkflowInstanceViewModel} Instance: the view model data for the current workflow. Also best explored via Intellisense

Base fields from `HtmlEmailBase`:

- {string} SiteUrl: the public URL for your site
- {string} NodeName: the name of the node from the current workflow
- {string} Type: the UI-friendly workflow type. Includes the scheduled date if one exists
- {EmailType} EmailType: an enum value representing the current email type, which relates directly to the workflow task type
- {EmailUserModel} To: the model defining who receives the email
  - {string} Email: the email address (or group address if the group email is set)
  - {string} Name: the user's name
  - {string} Language: the user's language
  - {int} Id: the user's ID (or group ID when sending to a group email address)
  - {bool} IsGroupEmail: are we sending to a generic group email address?

Umbraco Plumber provides settings for determining who receives emails at which stages of a workflow. While these are set to default values on install, it's advised that these are updated to better suit your install. Emails can be sent to:

- All: all participants in all workflow stages (previous and current)
- Group: all members of the group assigned to the current task
- Author: the user who initiated the workflow
- Admin: the admin user

By default, all emails are set to send to Group, but this isn't always the ideal - cancelled workflows would be best sent to the Author only, likewise with rejected. All would likely be most useful for notifying of completed workflows, but even this may be excessive. As said above, the best configuration will depend on your site, but most likely won't be the defaults.

## Reminders

v1.6.0 introduces a reminder email system, to prompt editors to complete pending workflows. Reminders are sent using Umbraco's internal task scheduler, every 24 hours after an initial delay. For example, setting the reminder delay value to 2 will allow pending workflows to sit for 2 days before sending reminder emails every 24 hours to all members of the group assigned to the pending workflow task.

The emails use a similar model to the notification emails, also inheriting from `HtmlEmailBase`. In addition to the inherited fields, `HtmlReminderEmailModel` includes:

- {IList<WorkflowTaskViewModel>}: OverdueTasks: a list containing all the overdue tasks assigned to the current user
- {int} TaskCount: the count of overdue tasks assigned to he current user
