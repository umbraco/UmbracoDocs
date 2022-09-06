---
meta.Title: "Umbraco Plumber Approval Flow Types"
meta.Description: "Umbraco Plumber's Approval Flow Types"
versionFrom: 8.0.0
versionTo: 10.0.0
---

# Approval Flow Types

Approval Flows are available in three types: Content approval flow, Inherited approval flow, and Document-type approval flow.

A given content node may have all three approval flow types applied but only one will be applied as per the following order of priority:

- **Content approval flow:** set directly on a content node via the **Configuration** section in the **Workflow** tab . This type will take priority over all others.
- **Inherited approval flow:** if a node has no Content approval flow set, nor a flow applied to its Document Type, Umbraco Plumber will traverse the content tree until it finds a node with a Content approval flow and will use this flow for the current change.
- **Document-type approval flow:** set in the **Settings** section. This approval flow will apply to all content nodes of the selected Document Type, unless the node has a Content approval flow set. This feature requires a license.

![Approval Flow Types](images/approval-flow-types.png)

Current responsibilites for Approval Groups can be reviewed in the **Roles** tab of the **Approval Groups** section for **Node-based approvals** and **Document-type approvals** only. For more information see the [Roles](../Approval-Groups/index.md#roles) section in the [Approval Groups](../Approval-Groups/index.md) article.

![Approval Groups Roles](images/approval-groups-roles.png)

Document Type approval flows can also include conditional stages i.e., only include **Translators** in the workflow when the **Description** property has changed. For more information on settings conditions in Document Type approval flows, see the [Document Type approval flows](../Workflow-Settings/index.md#document-type-approval-flows) section in the [Workflow Settings](../Workflow-Settings/index.md) article.
