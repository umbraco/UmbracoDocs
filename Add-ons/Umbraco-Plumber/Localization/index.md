---
meta.Title: "Umbraco Plumber Localization"
meta.Description: "Localization settings for Umbraco Plumber"
versionFrom: 8.0.0
versionTo: 10.0.0
---

# Localization

All email models are fully localized (where translations exist), with the remaining template text available to edit in the backoffice or your IDE. Out of the box, Umbraco Plumber's email templates are assumed to be for the default language. To add templates for other languages, duplicate the required template and append the culture code to the file name, prefixed with an underscorce:

- Default approval request template: `~/View/Partials/WorkflowEmails/ApprovalRequest.cshtml`
- Danish approval request template: `~/Views/Partials/WorkflowEmails/ApprovalRequest_da-DK.cshtml`
