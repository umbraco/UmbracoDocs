# Approval thresholds

{% hint style="info" %}
This feature requires a license - learn more about [Workflow's licensing model](https://umbraco.com/products/umbraco-workflow)
{% endhint %}

Workflow's default behaviour requires one member of an approval group to approve a pending task to advance it through the workflow. 

The approval thresholds feature introduces configuration options to set the required number of approvals for a given workflow stage.

The threshold options are:

- **One**: Pending tasks require approval from any member of the assigned approval group. This is the default behaviour for all installations (trial and licensed).
- **Most**: Pending tasks require approcal from an absolute majority of group members. For example, a group with three members requires two approvals and a group with four members requires three approvals.
- **All**: Pending tasks require approval from all group members.

The workflow detail UI displays the following:

- The status of the current task.
- Approval status for members of the current group.
- Progress towards meeting the threshold for the current approval stage.
- Future tasks and the assigned group and its users.

![Tasklist with approval thresholds](./images/tasklist-with-approval-thresholds.png)

Approving a task as an administrator immediately satisfies the approval threshold for the task, and will advance to the next workflow stage.

When a task is rejected in a workflow stage where the approval threshold is Most or All, existing approvals can be managed via configuration:

- Existing approvals can be reset, resetting progress towards the approval threshold. In this case, all users in the approval group will be able to approve the resubmitted content.
- Existing approvals can be kept. In this case, users in the approval group who have already approved the task will not be able to approve the resubmitted content. 

## Related settings and configuration

Approval thresholds are managed via settings in the Workflow section or in the `appsettings.json` file. Node-specific thresholds are set directly on the workflow configuration in the Workflow content app.

### Settings

The settings below can be set from the Backoffice or via settings customization in the `appsettings.json` file (refer to [Settings customization](configuration.md#settingscustomization) for implementation instructions).

- **Approval threshold**: Sets the global approval threshold to One, Most or All.
- **Rejection resets approvals**: When `true`, and the approval threshold is Most or All, rejecting a task resets the previous approvals for the workflow stage.
- **Allow configuring approval threshold**: When `true`, enables setting the approval threshold for any stage of a workflow (on a content node or Document Type).

### Configuration

The approval threshold for an individual workflow stage can be set using the control below the stage name. Setting the stage threshold requires the **Allow configuring approval threshold** setting to be `true`.

![Setting approval threshold for individual workflow stages](./images/approval-flow-with-thresholds.png)
