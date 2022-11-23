---
meta.Title: "Umbraco Plumber Localization"
description: "Localization settings for Umbraco Plumber"
versionFrom: 8.0.0
versionTo: 10.0.0
---

# Email Templates

All email templates are fully localized where translations exist. You can edit the email templates in the Backoffice or in your IDE. By default, Umbraco Plumber's email templates are available in the default language.

## Creating an Email Template

If you wish to have one or more email templates for different languages, you will need to place all the email templates into the `~/Views/Partials/WorkflowEmails/` folder.

To add templates for other languages:

1. Go to the `~/Views/Partials/WorkflowEmails/` folder.
2. Copy the required template and paste it into the same folder.
3. Append the culture code to the file name prefixed with an underscore.

For example:

- **Default approval request template:** `~/Views/Partials/WorkflowEmails/ApprovalRequest.cshtml`
- **Danish approval request template:** `~/Views/Partials/WorkflowEmails/ApprovalRequest_da-DK.cshtml`

## Sample Email Template

Below is an example of the `ApprovalRequest.cshtml` email template from the `~/Views/Partials/WorkflowEmails/` folder:

```csharp
@model Umbraco.Workflow.Core.Models.Email.HtmlEmailModel

// Refer to the documentation for Email templates for a full rundown on the available fields
// or (better option), edit the template in Visual Studio where Intellisense will save you

<!DOCTYPE html>

<html>
<head>
    <!-- will be used as the email subject line -->
    <title>Workflow: Approval request</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
</head>
<body>
    <div>
        <h1>Hello @Model.To.Name,</h1>
        <p>Please review the following page for @Model.Type.ToLower() approval:</p>
        <ul>
            <li>
                <a href="@Model.CurrentTask.BackofficeUrl">@Model.CurrentTask.Node.Name</a>
                @if (!string.IsNullOrEmpty(Model.CurrentTask.OfflineApprovalUrl))
                {
                    <span><a href="@Model.CurrentTask.OfflineApprovalUrl">Offline approval</a> is permitted for this change (no login required).</span>
                }
            </li>
        </ul>
    </div>
</body>
</html>
```
