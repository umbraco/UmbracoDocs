---
versionFrom: 7.0.0
versionTo: 9.0.0
---

# Attaching Workflows

In this article, you can learn how to add extra functionality to your Form by attaching **workflows**.

Workflows are a way of defining actions after your Form is submitted like sending an email or creating a content node.

## Default Workflow

By default, when a Form is submitted the record data is stored in the database. This can be configured in the [Store records](../Creating-a-Form/Form-Settings/index.md#settings-options) of the Forms settings.

The behaviour to display a message to the user that submitted the form, or to redirect to another page, can be configured by clicking on the built-in first workflow step, labelled **Submit message/Go to page**.

![Submit message/Go to page](MessageOnSubmit.png)

If a value is selected for **Go to page** it will be used to issue a redirect to that page once the form has been submitted.

If no value is selected, the message provided in **Message on submit** will be displayed to the user on the same page, instead of the form fields.  From version 8.8 onwards, this is implemented via a redirect to the current page, ensuring that the form can't be accidentally resubmitted.

### Customizing The Redirect

Whether displaying a message or redirecting, a developer can customize the page viewed after the form is submitted on the basis of presence of `TempData` variables.

One variable with a key of `UmbracoFormSubmitted` has a value containing the Guid identifier for the submitted form.

A second variable containt the Guid identifier of the record created from the form submission. You can find this using the `Forms_Current_Record_id` key.

In order to redirect to an external URL rather than a selected page on the Umbraco website, you will need to use a [custom workflow](../../Developer/Extending/Adding-a-Workflowtype.md). Within this workflow you can set the required redirect URL on the `HttpContext.Items` dictionary using the key `FormsRedirectAfterFormSubmitUrl` (defined in the constant `Umbraco.Forms.Core.Constants.ItemKeys.RedirectAfterFormSubmitUrl`).  This feature is available from versions 8.13 and 10.1.

For example, using an injected instance of `IHttpContextAccessor`:

```c#
_httpContextAccessor.HttpContext.Items[Constants.ItemKeys.RedirectAfterFormSubmitUrl] = "https://www.umbraco.com";
```

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

## Workflow Processing

When a form is submitted, any workflows associated with the "submit" stage of the form will run sequentially in the configured order. The record is stored after these workflows are completed, and as such they can make changes to the information recorded.

Similarly, approval of a form entry, whether automatic or manual, will trigger the execution of the workflows associated with the "approve" stage.

If a workflow encounters an unexpected error, it will silently fail from the perspective of the user submitting the form, recording the exception and other details of the failed operation to the log.

From Umbraco Forms versions 8.13.0 and 10.1, an audit trail has been made available. In the list of entries for a form, a summary is presented that shows how many workflows were executed, and how many were successful:

![Workflow execution summary](images/workflow-summary.png)

For each entry, in the backoffice a table can be viewed that shows each of the workflows and the success, or otherwise, of the operation.

![Workflow execution summary](images/workflow-audit.png)

---

Prev: [Setting-up Conditional Logic on Fields](../Creating-a-Form/Conditional-Logic/index.md) &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; Next: [Workflow Types](../Attaching-Workflows/Workflow-Types/index.md)
