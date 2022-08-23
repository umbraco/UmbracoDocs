---
meta.Title: "Umbraco Plumber Settings"
meta.Description: "Various settings for Umbraco Plumber"
versionFrom: 8.0.0
versionTo: 10.0.0
---

# Settings

Umbraco Plumber provides out-of the-box default settings but you should modify it to best suit your site:

- **Flow type** - How should the approval flow progress? These options manage how the change author is included in the workflow:
  - **Explicit** - All steps of the workflow must be completed and all users will be notified of tasks (including the change author).
  - **Implicit** - All steps where the original change author is NOT a member of the group must be completed. Steps where the original change author is a member of the approving group will be completed automatically and noted in the workflow history as not required.
  - **Exclude** - Similar to Explicit. All steps must be completed but the original change author is not included in the notifications or shown dashboard tasks.
- **Lock active content** - How should content in a workflow be managed? Set `true` or `false` to determine whether the approval group responsible for the active workflow step can make modifications to the content.
- **Exclude nodes** - Nodes selected here are excluded from the workflow engine and will be published per the configured Umbraco user permissions. Requires a license.
- **Document-type approvals** - Configure workflows to be applied to all content of the selected document type. Refer to [Approval flow types](../Approval-Flow-Types/index.md) for more information. Requires alicense.
