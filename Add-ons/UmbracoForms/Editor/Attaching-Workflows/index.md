# Attaching workflows

In this article you can learn how to add extra functionality to your form by attaching **workflows**.

Workflows are a way of defining what happens when a form is submitted. This could be sending an email, or creating a content node.

Submitting a form will by default result in the record data being stored in the database. This can be configured in the Forms settings: [Store records](../Creating-a-form/Form-Settings/#store-records-version-7).

## Adding a workflow

At the bottom of each of your forms, you can see which workflows are already attached to the form, as well as an option to configure the workflows.

![Button](images/configure-workflows.png)

Clicking **Configure workflow** will give you the option to configure existing workflows, as well as setup new ones.

![Workflow add](images/WorkflowsPage.png)

### Select the type

A new workflow can be of different types, and Umbraco Forms ships with a few default ones. You can find an overview of the types in the [Workflow types](Workflow-Types) article.

![Workflow add modal](images/WorkflowsAddModel.png)

### Fill in type specific settings

Once the type has been selected you will need to configure the workflow. There are various settings depending on the type that has been selected.

To be able to use data from the submitted form in your workflow, head over to the [Magic Strings](../../Developer/Magic-Strings) article and learn more about how that's done.

Fill in the settings and hit *Submit*. The workflow will now have been added to your form, and it will be shown at the bottom of the page.
