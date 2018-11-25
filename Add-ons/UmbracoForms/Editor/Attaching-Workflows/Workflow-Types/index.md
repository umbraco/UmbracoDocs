# Overview of the default workflow types

There are a couple of default workflow types that can be used to extend the functionality of your form. Here is an overview:

## Change Record State

![Change Record state](images/change-record-state.png)

This workflow is used to automatically **approve** or **delete** a record once it is submitted.

You simply configure some words that you want to check for, and select whether these words should trigger a deletion or an approval.

## Post as XML

![Post as XML](images/post-as-xml.png)

This workflow is used to post the form as XML to a specified URL.

Besides a name, the following configuration can be set:

* URL (required)
* Method
* XsltFile - used to transform the XML
* Headers - map the needed files
* User and password

## Save as an XML file

![Save as XML](images/save-as-an-xml-file.png)

This workflow will save the result of the form as an XML file by using XSLT.
In the configuration you can configure the following settings:

* Path - where to save the XML file (required)
* File extension (required)
* XsltFile - used to transform the XML 

## Save as Umbraco Content Node

![Save as content node](images/save-as-content-node.png)

This workflow gives you the option to save a forms submission as a new content node.

First of all, you need to choose a Document type and match the fields in the form with the properties on the selected Document Type. You can also choose to set a static value to fill in the properties.

![Save as content node](images/create-new-node.png)

In the example above, a Document Type called 'Blogpost' is selected to be used for creating the new content node. Furthermore, the value from the 'Name' field will be added as the 'Node Name' property in the new content node, and the value from the 'Email' field will be used for the 'Content' property.

Other configuration:

* Publish - choose whether to publish the node on submission
* Where to save - choose a section in the content tree where this new node should be added

## Send email

![Send email](images/send-email.png)

Send the result of the form to a specified email address.

The following settings can be configured:

* Email (required)
* SenderEmail - also configurable in `Config/umbracosettings.config`
* Subject of the email
* Message (required)
* Attachment - specify whether file uploads should be attached to the email

## Send email with template (Razor)

![Send email with template](images/send-email-razor.png)

This workflow will use a template to send the results of the form to a specified email address. 

You can create your own custom Razor templates to be used to send out emails upon forms submission. Read more about how to create these templates in the [Email Templates](../../../Developer/Email-Templates) article.

The following settings can be configured:

* Email (required)
* SenderEmail - also configurable in `Config/umbracosettings.config`
* Subject (required)
* Email Template - specify which template you want to use (required)
* Attachment - specify whether file uploads should be attached to the email

## Send form to URL

![Send to URL](images/send-to-URL.png)

This workflow sends the form to a url, either as a HTTP POST or GET.

The following settings can be configured:

* URL (required)
* Method - POST, GET, PUT or DELETE (required)
* Fields - map the needed fields
* User and password

## Send XSLT transformed email

![Send XSLT Email](images/xslt-email.png)

Send the result of the form to an email address and have full control over the email contents by supplying an xslt file.

The following settings can be configured:

* Email (required)
* SenderEmail - also configurable in `Config/umbracosettings.config`
* Subject (required)
* XSLT File - specify which file should be used to transform the content

## Slack

![Send to Slack](images/email-slack.png)

This workflow lets you post the form data to a specific channel on Slack.

The following settings can be configured:

* API Token (required)
* Channel (required)
* Username (required)
* Avatar URL (required)
