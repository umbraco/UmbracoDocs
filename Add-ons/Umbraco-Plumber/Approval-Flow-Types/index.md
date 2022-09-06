---
meta.Title: "Umbraco Plumber Approval Flow Types"
meta.Description: "Umbraco Plumber's Approval Flow Types"
versionFrom: 8.0.0
versionTo: 10.0.0
---

# Approval Flow Types

Approval Flows are available in three types: explicit, inherited, and document-type.

A given content node may have all three approval flow types applied but only one will be applied as per the following order of priority:

- **Explicit:** set directly on a content node via the **Content** section. This type will take priority over all others.
- **Document-type:** set in the **Settings** section. This approval flow will apply to all content of the selected Document Type, unless the node has an explicit flow set. This feature requires a license.
- **Inherited:** if a node has no explicit approval flow, nor a flow applied to its Document Type, Umbraco Plumber will traverse the content tree until it finds a node with an explicit flow and will use this flow for the current change.

Current responsibilites for Groups can be reviewed on the User group view for **Node-based approvals** and **Document-type approvals** only.

Document Type approval flows can also include conditional stages i.e., only include **Translators** in the workflow when the **Description** property has changed.
