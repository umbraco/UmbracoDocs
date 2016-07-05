#Attaching workflows
Submitting a form will result in the record data being stored in the database, if you wish to attach extra functionality to your form you can do so by assigning 1 or multiple workflows (like sending an email).

##Adding a workflow

###Navigate to the workflow section at the bottom of your form
Select the *configure workflow* option in the bottom right corner.

![Button](workflowbutton.png)

From this point a right side overlay will open.

###Select the *Add workflow* button or modify a default workflow


![Workflow add](WorkflowsPage.png)

Another overlay will open, allowing you to choose a specific workflow.

###Select the type

A new workflow can be of different types (an overview can be found [below](#Overviewofthedefaultworkflowtypes)). So first select the type

![Workflow add modal](WorkflowsAddModal.png)


###Fill in type specific settings
Once the type has been selected you should see some additional settings (these depend on the type)

![Workflow type settings](WorkflowsPageAddTypeSettings.png)

Fill in the settings and hit *Submit*

![Workflow add](WorkflowsPageAddSubmit.png)

###Overview
At the bottom of your form you should now get an overview of the attached workflows.

![Workflows overview](WorkflowOverview.png)



##Overview of the default workflow types
There are a couple of default workflow types that can be used to extend the functionality of your form, here is an overview:
###Change Record State
Changes the state of the record being processed when it matches a word.  
###Post as XML
Posts the form as xml to a url
###Save as an XML file
Saves the result of the form as an XML file by using XSLT
###Save as Umbraco Content Node
Saves the form values as an Umbraco content node using a specific document type
###Send email
Send the result of the form to an email address
###Send form to URL
Sends the form to a url, either as a HTTP POST or GET
###Send xslt transformed email
Send the result of the form to an email address (full control over the email contents by supplying an xslt file)
###Slack
Posts the form data to a specific channel on Slack
