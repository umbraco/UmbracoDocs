---
meta.Title: "Umbraco Plumber Content App"
meta.Description: "Information about using Content app with Umbraco Plumber"
versionFrom: 8.0.0
versionTo: 10.0.0
---

# Workflow Content App

Umbraco Plumber adds a [Content App](../../../Extending/Content-Apps/index.md) to all content nodes in the **Content** section where the workflow is enabled. The Workflow content app includes three sub-sections: Active workflow, Configuration, and History.

![Workflow content app](images/content-app.png)

## Active Workflow

The Active workflow sub-section provides an interface for managing workflows for the current content node. When you have to initiate a workflow on the current node, the**Active workflow** sub-section requires information such as:

- Change Description.
- [Optional] Scheduled date to publish the changes requested in the node.

![Active workflow initiate request](images/Active-workflow-initiate-request.png)

When the current node is pending workflow approval, the **Active workflow** sub-section displays detailed information such as:

- Approve, reject, or cancel pending workflow tasks.
- View change description and track differences across pending and completed workflows.
- View the group responsible for approving the pending workflow.
- View pending language variant(s) workflow.
- View the workflow activity (eg pending approval/task approvals/rejects) for the current workflow process.

![Active Workflow sub-section](images/Active_Workflow_detailed_info.png)

You can access Active Workflows from two places - Content section and the Workflow section (depending on your user permission). Workflow Administrators (those users with access to the Workflow section) can action workflows assigned to a different group. In the **Workflow History**, these are noted as being performed by the admin.

In multi-lingual sites, variant content can be submitted in one of these workflows:

- Only the current variant.
- All variants for publishing in a single workflow process using the workflow applied to the default variant.
- Each variant into a separate workflow.

For example, you can have the German version of your content approved by groups of German speakers and the English version by English speakers group.

## Configuration

The Configuration sub-section provides an interface for configuring the content approval flow for the current node and displays any inherited or document-type approval flows applied to the current content node.

![Configuration sub-section](images/Configuration-sub-section.png)

### Content Approval Flow

You can add different groups for different stages of content approval flow. Content Approval flow groups can be reordered via drag and drop. You can also apply the approval flow either for publish and unpublish workflow or only publish workflow.

![Content approval flow](images/content-approval-flow.gif)

### Approval Flow Types

There are three types of Approval Flow: Explicit, Inherited, and Document-type.

A given content node may have all three approval flow types applied but only one will be applied as per the following order of priority:

- **Explicit approval flow**: Set directly on a content node via the context menu. This type will take priority over all others.
- **Inherited approval flow**: If a node has no explicit approval flow, nor a flow applied to its document-type, Umbraco Plumber will traverse the content tree until it finds a node with an explicit flow and will use this flow for the current change.
- **Document-type approval flow**: Set in the Workflow **Settings** section. This approval flow will apply to all content of the selected document type, unless the node has an explicit flow set. This flow type requires a license.

Current responsibilites for Groups can be reviewed on the user group view for Explicit and Document-type approval flows only. For more information on User Group view, see the [Approval Groups](../Approval-Groups/index.md) article.

Document type approval flows can also include conditional groups i.e., only include Group B in the workflow when the meta-description property has changed.

![Approval flows](images/approval-flow-types.png)

:::note
Configuration cannot be modified when a content node is in a workflow process.
:::

## History

The History sub-section provides a chronological audit trail of workflow activity for the current node. It displays a table containing the Page name with the Language variant, Type of Publish, workflow requested by, date the workflow was requested on, comment, and status of the workflow.

![History sub-section](images/History-sub-section.png)

You can also **Filter** the records based on Requested by, Created date, Completed date, Page Language, Workflow Type, and Workflow Status. Additionally, you can adjust the total number of records displayed on a page.

The **Detail** button at the end of the record displays an overlay with content similar to the Active workflow sub-section.

![Details overlay](images/Details-overlay.png)
