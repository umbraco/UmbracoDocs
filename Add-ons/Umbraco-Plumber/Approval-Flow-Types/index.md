---
meta.Title: "Umbraco Plumber Approval Flow Types"
meta.Description: "Umbraco Plumber's Approval Flow Types"
versionFrom: 8.0.0
versionTo: 10.0.0
---

# Approval Flow Types

Approval Flows come in three types: explicit, inherited, and document-type.

A given content node may have all three approval flow types applied but only one will be applied as per the following order of priority:

- **Explicit:** set directly on a content node via the context menu. This type will take priority over all others.
- **Document-type:** set in the Settings section. This approval flow will apply to all content of the selected Document Type, unless the node has an explicit flow set. Requires license.
- **Inherited:** if a node has no explicit approval flow, nor a flow applied to its Document Type, Umbraco Plumber will traverse the content tree until it finds a node with an explicit flow, and will use this flow for the current change.

Current responsibilites for groups can be reviewed on the user group view for explicit and Document Type approval flows only.

Document Type approval flows can also include conditional groups i.e., only include Group B in the workflow when the meta-description property has changed.
