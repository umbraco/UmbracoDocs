# Workspace View

Umbraco Workflow adds a [Workspace View](https://docs.umbraco.com/umbraco-cms/customizing/extending-overview/extension-types/workspaces/workspace-views) to all content nodes in the **Content** section where a workflow is enabled. The Workflow workspace view includes two sub-sections:

* [Configuration](workflow-workspace-view.md#configuration)
* [History](workflow-workspace-view.md#history)

## Configuration

The Configuration sub-section provides an interface for configuring the content approval flow for the current node. It also displays any Inherited or Document type approval flows applied to the current content node.

In multi-lingual sites, each variant can have its own approval flow. By default, new variants inherit the configuration set on the default language.

For example, German variants can be approved by the German speakers group, while English variants are approved by the English speakers group.

![Configuration sub-section](../.gitbook/assets/Configuration-sub-section-v14.png)

### Content Approval Flow

You can add different groups for different stages of content approval flow. Content Approval flow groups can be reordered via drag and drop. You can also apply the approval flow either for publish and unpublish workflows or only publish workflow.

![Content approval flow](../.gitbook/assets/content-approval-flow-v14.png)

#### Approval Flow Types

Approval Flows are available in three types: Content approval flow, Inherited approval flow, and Document type approval flow.

A given content node may have all three approval flow types applied but only one will be applied as per the following order of priority:

| Flow Type                       | Description                                                                                                                                                                                  | Priority  |
| ------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------- |
| **Content approval flow**       | Set directly on a content node via the **Configuration** section in the **Workflow** tab.                                                                                                    | Highest   |
| **Document type approval flow** | Set in the **Settings** section. Applies to all content nodes of the selected Document Type unless overridden by a Content approval flow set directly on the node. Requires a license.       | Secondary |
| **Inherited approval flow**     | Used when a content node has no Content approval flow set, nor a flow applied to its Document Type. Umbraco Workflow will traverse the content tree upwards to find a Content approval flow. | Lowest    |

![Approval Flow Types](../.gitbook/assets/content-approval-flow-v14.png)

Review the current Permissions for Approval Groups in the **Approval Groups** section for **Node-based approvals** and **Document type approvals** only. For more information see the [Roles](../workflow-section/approval-groups.md#roles) section in the [Approval Groups](../workflow-section/approval-groups.md) article.

![Approval Groups Roles](../.gitbook/assets/approval-groups-roles-v14.png)

Document type approval flows may contain conditional stages, such as including **Translators** in the workflow only when the **Description** property has changed. For more information on settings conditions in Document type approval flows, see the [Document type approval flows](https://github.com/umbraco/UmbracoDocs/blob/main/17/umbraco-workflow/workflow-section/workflow-settings.md#document-type-approval-flows) section in the [Workflow Settings](https://github.com/umbraco/UmbracoDocs/blob/main/17/umbraco-workflow/workflow-section/workflow-settings.md) article.

Configuration cannot be modified when a content node is in a workflow process.

#### Content reviews

Content reviews is a tool that allows content editors to keep their content up-to-date. For more information, see the [Content reviews](../workflow-section/content-reviews.md) section.

![Content reviews](../.gitbook/assets/Content-reviews-v14.png)

## History

The History sub-section provides a chronological audit trail of workflow activity for the current node. It displays a table containing the following information:

* Type of Publish
* Who the workflow is requested by
* The date the workflow was requested
* Comments

![History sub-section](../.gitbook/assets/History-sub-section-v14.png)

You can also **Filter** the records based on the information listed above. Additionally, you can adjust the total number of records displayed on a page.

The **Detail** button at the end of the record displays an overlay with content similar to the Workflow Detail dialog.

![Details overlay](../.gitbook/assets/Workflow-Content-app-Details-overlay-v14.png)
