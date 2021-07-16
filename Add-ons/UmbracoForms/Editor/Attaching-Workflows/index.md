---
versionFrom: 7.0.0
versionTo: 9.0.0
---

# Attaching Workflows

In this article, you can learn how to add extra functionality to your Form by attaching **workflows**.

Workflows are a way of defining actions after your Form is submitted like sending an email or creating a content node.

By default, when a Form is submitted the record data is stored in the database. This can be configured in the [Store records](../Creating-a-Form/Form-Settings/index.md#settings-options) of the Forms settings.

## Adding a Workflow

At the bottom of your Form, you can see which workflow is already attached to the Form, as well as an option to configure the workflows.

![Button](images/configure-workflows.png)

Clicking **Configure workflow** will give you the option to configure existing workflows, as well as setup new ones.

![Workflow add](images/WorkflowsPage.png)

### Choose a Workflow

A new workflow can be of different types and Umbraco Forms ships with a few default ones. You can find an overview of the types in the [Workflow types](Workflow-Types) article.

![Workflow add modal](images/WorkflowsAddModel.png)

### Update Type-specific Settings

Once the Workflow Type has been selected, you will need to configure the workflow. There are various settings depending on the type that has been selected.

To use data from the submitted Form in your workflow, head over to the [Magic Strings](../../Developer/Magic-Strings) article and learn more about how that's done.

Fill in the settings and hit **Submit**. The workflow is added to your Form and it will be shown at the bottom of the page.

---

Prev: [Setting-up Conditional Logic on Fields](../Creating-a-Form/Conditional-Logic/index.md) &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; Next: [Workflow Types](../Attaching-Workflows/Workflow-Types/index.md)
