---
meta.Title: "Umbraco Plumber Offline approval"
meta.Description: "Umbraco Plumber's Offline approval"
versionFrom: 8.0.0
versionTo: 10.0.0
---

# Offline Approval

Groups can optional be given permission to action workflow tasks without logging in to Umbraco. This feature requires a paid license.

By setting the Offline Approval checkbox to true on the edit group view, all email notifications sent to members of the group will include a personalized link to a preview page.

The preview page exposes the current saved page, with the options to approve or reject the change. It is not possible to edit the content from the offline approval view.

This feature is intended for use in situations where the approval group membership is a single user who would not otherwise be using Umbraco - for example, a manager may want to approve media releases before publishing, but does not othewise need access to Umbraco.

Offline approval does require a user exist in the backoffice, and be assigned to a workflow group - just like any other workflow participant - but they need not know how to use Umbraco, or even know their login credentials.
