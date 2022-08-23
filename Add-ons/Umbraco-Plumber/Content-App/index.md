---
meta.Title: "Umbraco Plumber Content App"
meta.Description: "Information about using Content app with Umbraco Plumber"
versionFrom: 8.0.0
versionTo: 10.0.0
---

# Content App

Umbraco Plumber adds a content app to all nodes where workflow is enabled. The Workflow content app includes three sub-sections: Active workflow, Configuration and History

## Active workflow

The Active workflow sub-section provides the interface for managing workflows for the current content node - from this view, content can be submitted for workflow approval and pending workflow tasks can be rejected, cancelled or approved.

In multi-lingual sites, variant content can be submitted into one of three different workflows. Either submmit only the current variant, submit all variants for publishing in a single workflow process using the workflow applied to the default variant, or submit each variant into a separate workflow - eg, have the German version of your content approved by groups of German speakers, and the English version by English speakers.

When the current node is pending workflow approval, the Active workflow sub-section displays more detailed information - the requesting user, their comments, the pending variant(s), and any workflow activity (eg task approvals/rejects) for the current workflow process.

Users must provide a comment before actioning a task.

Workflow administrators (those users with access to the Workflow section) can action workflows assigned to a different group. In the workflow history, these are noted as being performed by admin.

## Configuration

The Configuration sub-section provides the interface for configuring (surprise!) the approval flow for the current node, and displays any inherited or content-type approvals applied to the current node. Adding an approval flow is as easy as selecting groups from the dropdown, and clicking Add group.

Approval flow groups can be reordered via drag and drop.

Configuration can not be modified when a content node is in a workflow process.

## History

The History sub-section provides a chronological audit trail of workflow activity for the current node. The Detail button in the right-most column launches an overlay with similar content to that displayed on the Active workflow sub-section.
