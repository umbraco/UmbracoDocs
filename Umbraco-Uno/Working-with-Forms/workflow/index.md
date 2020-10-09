---
versionFrom: 8.0.0
---

# What is a workflow

A workflow, in this case, is the flow that happens from you press the submit form button on the frontend until it ends in your email (or wherever you assigned it to arrive)

The most common workflow is to have the user press the submit button, then a thank you message pops up, and then the email is sent to a designated mail inbox. However, you could choose to have it sent to, for example, slack if you wanted. In this guide, you will learn to set-up a basic workflow for your forms.

## How do you set up a workflow

In this part we will set-up a workflow that uses a templte for how the email will look in your inbox. and make it send to your email in box.
We will be working with a form that contains the following:

* A Name field using a short answer
* An Email field using a short answer
* A Question using a long answer

1. In the Forms section of the backoffice.
2. Here select the form you want to add a workflow to.
3. In the buttom of the page you will find a section containing a check mark saying ***on submit***
4. Click ***Configure Workflow***
5. The pop op window will contain the workflow that currently excist
6. Select the one that says *Sending template email to* 

### Filling in the workflow

In this section we will make the workflow send to your email of choice.

1. Workflow Name - give the workflow the name you want
2. Active - make sure this is checked because it enables/disables the workflow.
3. Include Sensitive Data - Set this depending if you want sensitive data or not.
4. Email - set this to the email where you want the replies to the form sent to.
5. Sender Email - 