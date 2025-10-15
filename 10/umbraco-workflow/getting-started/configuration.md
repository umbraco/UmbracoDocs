---
description: >-
  Get an overview of various options for customizing the configuration of your
  Umbraco Workflow installation.
---

# Configuration

With Umbraco Workflow, it is possible to customize the functionality with different configuration values.

## Editing configuration values

All configuration for Umbraco Workflow is held in the `appSettings.json` file found at the root of your Umbraco website. If the configuration has been customized to use another source, then the same keys and values discussed in this article can be applied there.

The convention for Umbraco configuration is to have package-based options stored as a child structure. The child structure is added below the Umbraco element and as a sibling of the CMS. Workflow configuration follows this pattern, i.e.:

```json
{
  ...
  "Umbraco": {
    "CMS": {
        ...
    },
    "Workflow": {
        ...
    }
  }
}
```

All Workflow configuration is optional and will a fallback to defaults, if not set. The following structure represents the full set of configuration options along with the default values:

```json
{
  "Workflow": {
    "ReminderNotificationPeriod": Timespan.FromHours(8),
    "EnableTestLicense": false,
    "EmailTemplatePath": "~/Views/Partials/WorkflowEmails",
    "SettingsCustomization": {...}
  }
```

### Workflow Configuration

#### ReminderNotificationPeriod

A `TimeSpan` representing the period between checking for, and sending, reminder notifications for overdue workflows. This setting is used in conjunction with `ReminderDelay` to determine if a workflow is overdue.

#### EnableTestLicense

A `bool` value used to enable or disable the test license. When true, and running Umbraco in development mode, all licensed features are available on local domains.

#### EmailTemplatePath

A `string` value representing the path to the email notification templates.

#### Colors

An instance of `ColorSettings` allowing customization of colors used in email notifications. Allows setting alternate values for red, orange, and green use to highlight workflow status in emails.

## SettingsCustomization

All Workflow settings can be customized in the `appSettings.json` file. Settings can be read-only or hidden entirely in the backoffice. Optionally you can set the values here.

The `SettingsCustomization` object has two child properties:

* `General`
* `ContentReviews`

Both are dictionaries of `SettingsCustomizationDetail` objects. The value is set to the following structure that contains three settings:

```json
{
  …
  "MySettingKey": {
    "IsHidden": false,
    "IsReadOnly": false,
    "Value": 42
  }
  …
}
```

* `IsHidden` - When true, the corresponding property is not displayed in the backoffice UI
* `IsReadOnly` - When true, the corresponding property is displayed in the backoffice UI but is not editable
* `Value` - Sets the value for the corresponding property. This value takes priority over existing values set via the backoffice

All available `SettingsCustomization` options are illustrated below along with their respective values:

```json
{
  "Workflow": {
    …
    "SettingsCustomization": {
      "General": {
        "FlowType": 0|1|2 matching the FlowType enum values,
        "ApprovalThreshold": 0|1|2 matching the ApprovalThreshold enum values,
        "ConfigureApprovalThreshold": bool,
        "RejectionResetsApprovals": bool,
        "LockIfActive": bool,
        "MandatoryComments": bool,
        "AllowAttachments": bool,
        "AllowScheduling": bool,
        "RequireUnpublish": bool,
        "ExtendPermissions": bool,
        "SendNotifications": bool,
        "Email": string,
        "ReminderDelay": int,
        "EditUrl": string,
        "SiteUrl": string,
        "NewNodeApprovalFlow": *,
        "DocumentTypeApprovalFlow": *,
        "ExcludeNodes": *,
      },
      "ContentReviews": {
        "EnableContentReviews": bool,
        "ReviewPeriod": int,
        "ReminderThreshold": int,
        "SendNotifications": bool,
        "PublishIsReview": bool
      }
    }
  }
}
```

{% hint style="info" %}
These are complex types and are not recommended to have values set from Configuration. Instead, these values can be set from the backoffice to hidden or read-only to prevent further changes.
{% endhint %}

### General

#### FlowType (int)

Sets the workflow type to one of Explicit (0), Implicit (1), or Exclude (2):

| Value         | Name     | Description                                                                                                                                 |
| ------------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| 0 (_default_) | Explicit | Requires all steps be approved, including steps where the original change author is a group member.                                         |
| 1             | Implicit | Auto-approves steps where the author is a member of the approving group.                                                                    |
| 2             | Exclude  | Behaves similarly to Explicit, but excludes the original author from any notifications (that is the author can not approve their own work). |

#### ApprovalThreshold (int, requires a license)

Sets the default approval threshold to one of One (0), Most (1), or All (2):

| Value         | Name | Description                                                                                                                                                                                                  |
| ------------- | ---- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| 0 (_default_) | One  | Pending tasks require approval from **any** member of the assigned approval group.                                                                                                                           |
| 1             | Most | <p>Pending tasks require approval from an absolute <strong>majority</strong> of group members. <br>Example: A group with 3 members requires 2 approvals and a group with 4 members requires 3 approvals.</p> |
| 2             | All  | Pending tasks require approval from **all** group members.                                                                                                                                                   |

#### ConfigureApprovalThreshold (bool, requires a license)

When true, allows configuring the approval threshold on individual workflow stages.

#### RejectionResetsApprovals (bool, requires a license)

When true, and ApprovalThreshold is Most or All, rejecting a task resets progress towards the approval threshold for the current workflow stage.

#### LockIfActive (bool)

When true, prevents editing content where the node is in an active workflow. When false, content can be edited at any stage of a workflow.

#### MandatoryComments (bool)

When true, comments are required when approving a workflow task. When false, comments are optional when approving a workflow task. Comments are always required when submitting changes for approval.

#### AllowAttachments (bool)

When true, displays an optional media picker when initiating a workflow. The selected media item can be used to provide further context or explanation of the content changes.

#### AllowScheduling (bool)

When true, displays optional controls for scheduling publish/unpublish when initiating a workflow. The scheduling uses Umbraco's existing content scheduling functionality.

#### RequireUnpublish (bool)

When true, content must be approved via a workflow when unpublishing. When false, a user with appropriate permission can unpublish content without workflow approval.

#### ExtendPermissions (bool)

When true, Workflow adds additional buttons to the editor footer (Request publish and Request unpublish, if the latter is required). When false, Workflow replaces the existing editor footer buttons.

#### SendNotifications (bool)

When true, Workflow will send email notifications in response to workflow changes. When false, no emails are sent.

#### Email (string)

The from address for email notifications.

#### ReminderDelay (int)

The number of days after which to start sending reminder emails for incomplete workflows.

#### EditUrl (string)

The URL at which editors access the BackOffice eg `https://edit.mysite.com`. Used for generating links to nodes in email notifications. Must be fully qualified and not include the `/umbraco` path.

#### SiteUrl (string)

The URL at which users access the live site eg `https://mysite.com`. Used for generating links in email notifications. Must be fully qualified.

#### NewNodeApprovalFlow (complex type)

When set, this flow is used for all new nodes on the first approval request. Subsequent workflows use the permissions set on the node (or content type, or inherited from an ancestor node). This is a complex type and ideally would not be set via configuration.

#### DocumentTypeApprovalFlow (complex type, requires a license)

Sets workflow permissions for Document Types (that is: all items of `BlogItem` type use the same workflow). The Document Type flow is used when a content node has no explicit permissions set. This is a complex type and ideally should not be set via configuration.

#### ExcludeNodes (complex type, requires a license)

Allows excluding segments of the content tree from the workflow model. This is a complex type and ideally would not be set via configuration.

### ContentReviews

#### EnableContentReviews (bool)

When true, the content review engine will monitor publication dates to determine content review requirements.

#### ReviewPeriod (int)

Sets the number of days between mandatory reviews. This is a global value that can be overridden at the node or content type level.

#### ReminderThreshold (int)

Sets the date on which to send notification emails, prior to the review date elapsing. For example, if the `ReviewPeriod` is 20 and the `ReminderThreshold` is 3, notifications will be sent in 17 days or 3 days before the review date.

#### SendNotifications (bool)

When true, Workflow will send email notifications to approval groups, with a digest of expiring and expired content.

#### PublishIsReview (bool)

When true, publishing a node is treated as a review, and will generate a new review date. When false, content must be explicitly reviewed via the review banner rendered at the top of the editor.

For example: To set the site URL, hide it in the backoffice, and set the content review period but keep the property read-only. The configuration would look like this:

```json
{
  "Workflow": {
    "SettingsCustomization": {
      "General": {
        "SiteUrl": {
          "IsHidden": true,
          "Value": "https://www.myawesomesite.com"
        }
      },
      "ContentReviews": {
        "ReviewPeriod": {
          "IsReadOnly": true,
          "Value": 42
        }
      }
    }
  }
}
```

Your Integrated Development Environment (IDE) will provide intellisense for the available settings but does not provide the valid value types. Settings are validated on startup and Umbraco will throw an exception if a known setting is provided with an invalid value.

{% hint style="info" %}
It is possible to include settings outside of those referenced by Workflow. These can be useful for providing values for use in extensions and customizations. These settings are not validated on startup so can have any value.
{% endhint %}
