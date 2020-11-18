---
versionFrom: 8.0.0
---

# Workflows

A workflow is what you use to define what should happen when a form on your website is submitted. This could be sending an email with the information from the form or it could be setting up a notification in a tool like Slack.

The most common workflow is to present a "Thank you" message when a form is submitted, and then also send the email to a designated mail inbox.

In your Umbraco Uno website a workflow has already been set up for you, and you only need to choose which email you want to notify, when a form has been submitted.

In this article you will learn how to start using the default workflow, and you will also find information on how to set up your own custom workflows.

Please be aware that you will need to fill out the Contact form email field, in the **General** settings page found under **Settings** in the Content section.

:::tip
This requires you to have set up a form. If you don't have a form set-up yet, you can learn how to do that in the [Setting up a form](../Setting-up-a-form/index.md) section.
:::

## Finding the workflows

In this part, we will learn how to enter the configuration menu for workflows. We will be working with a form that contains the following:

* A Name field using a short answer
* An Email field using a short answer
* A Question using a long answer

This is how you get into the configuration of your workflow:

1. Navigate to the Forms section of the backoffice.
2. Here, select the form you want to add a workflow to.
3. At the bottom of the page, you will find a section containing a checkmark saying ***on submit***.
4. Click ***Configure workflow***.
5. The pop op window will contain the workflow that currently exists.

### Editing the existing workflow

If you choose an ***empty form*** when setting up a new form, it will come with a working workflow. You will have to make a slight update to it before it functions optimally.
This can be done in the configuration menu for workflows.

1. Click the box ***Send template email to***.
2. In the field called ***Sender email***, you should add something like Noreply@something.something.
3. It is recommended to choose ***Igloo template***.
4. Hit submit and then hit submit in the next menu as well.

Now the workflow will be working optimally if you followed the steps to point.

### Creating a custom workflow

In this section, you will learn how to make a custom workflow that sends an email to your inbox of choice. 

1. First, give the workflow the name you want it to have in the ***Workflow Name*** field.
2. Put a checkmark in the ***Active**** so that the workflow is active.
3. The ***Include Sensitive Data*** will be left unchecked unless your form contains sensitive data.
4. Ensure that the ***Email*** is set to the email which should receive replies from forms.
5. Next up is the ***Sender Email***. Here you can add something like Noreply@something.com.
6. If you want to reply directly to the customer from the forms reply, you can add {email} to the ***ReplyToEmail*** this will fetch the email from the field called email in the form.
7. Next, you have the option to choose the subject of the email.
8. In the next field, you can pick a template. It is recommended to use ***Igloo-template.cshtml***.
9. Finally, leave ***Attachments*** unchecked, unless you have an upload-field in the form, and want to receive the uploaded files through the workflow.

![this is the workflow settings](images/Workflow3.png)

:::note
The above is for setting up a workflow from scratch. This will be needed if you choose any of the two forms templates coming with the basic install of Umbraco Uno.
:::
