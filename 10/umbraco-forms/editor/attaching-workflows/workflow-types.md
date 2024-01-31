# Workflow Types

There are multiple built-in workflow types that can be used to extend the functionality of your Form.

* [Change Record State](workflow-types.md#change-record-state)
* [Post as XML](workflow-types.md#post-as-xml)
* [Save as an XML file](workflow-types.md#save-as-an-xml-file)
* [Save as Umbraco Content Node](workflow-types.md#save-as-umbraco-content-node)
* [Send Email](workflow-types.md#send-email)
* [Send Email with Template (Razor)](workflow-types.md#send-email-with-template-razor)
* [Send Form to URL](workflow-types.md#send-form-to-url)
* [Send XSLT Transformed Email](workflow-types.md#send-xslt-transformed-email)
* [Slack](workflow-types.md#slack)

## Video Tutorial

{% embed url="https://www.youtube.com/watch?ab_channel=UmbracoLearningBase&v=L9k0yDbV6qo" %}
Workflow Types in Umbraco Forms
{% endembed %}

## **Change Record State**

![Change Record state](<images/change-record-state (1).png>)

Used to automatically **Approve Record** or **Delete Record** once it is submitted. Configure words that you want to match and select whether these words should trigger an approval or deletion of the record.

## **Post as XML**

![Post as XML](<images/post-as-xml (1).png>)

Used to post the Form as an XML to a specified URL. The following configuration can be set:

* Workflow Name
* URL (required)
* Method
* XsltFile - used to transform the XML
* Headers - map the needed files
* User
* Password

## **Save as an XML file**

![Save as XML](<images/save-as-an-xml-file (1).png>)

Saves the result of the Form as an XML file by using XSLT. The following configuration can be set:

* Workflow Name
* Path (required) - where to save the XML file
* File extension (required)
* XsltFile - used to transform the XML

The path needs to point to a folder, not a file name. The files are then stored locally, and relative paths are resolved to the content root.

{% hint style="info" %}
When storing the files within the `wwwroot` or `App_Plugins` folders, the files will be publicly available by default.
{% endhint %}

## **Save as Umbraco Content Node**

![Save as content node](<images/save-as-content-node (1).png>)

Saves a submitted Form as a new content node. You need to choose a Document type and match the fields in the Form with the properties on the selected Document Type.

You can also choose to set a static value to fill in the properties:

![Save as content node](<images/create-new-node (1).png>)

In the example above, a Document Type called **Blogpost** is selected for creating the new Content node.

The value from the **Name** field will be added as the **Node Name** property in the new Content node. The value from the **Email** field will be used as the **Content** property.

The following configuration can be set:

* Workflow Name
* Publish - choose whether to publish the node on submission
* Where to save - choose a section in the content tree where this new node should be added

## **Send Email**

![Send email](<images/send-email (1).png>)

Sends the result of the Form to the specified email address. The following configuration can be set:

* Workflow Name
* Message (required)
* Attachment - specify whether file uploads should be attached to the email
* Recipient Email (required)
* CC Email
* BCC Email
* Sender Email
* Reply To Email
* Subject of the email (required)

If the _Sender Email_ field is not populated, the address used will be read from CMS configuration.

The [Content Settings](https://docs.umbraco.com/umbraco-cms/v/10.latest-lts/reference/configuration/contentsettings) value configured at `Umbraco:CMS:Content:Notifications:Email` will be used if provided.

```json
    "Umbraco": {
         "CMS": {
            "Content": {
                "Notifications": {
                    "Email": "person@umbraco.dk"
                }
            }
        }
    }
```

If that is not set, the [Global Settings](https://docs.umbraco.com/umbraco-cms/v/10.latest-lts/reference/configuration/globalsettings) value configured at `Umbraco:CMS:Global:Smtp` will be used.

```json
    "Umbraco": {
         "CMS": {
            "Global": {
                "Smtp": {
                    "From": "person@umbraco.dk"
                }
            }
        }
    }
```

The fallback behavior also applies to the other email workflows.

## **Send Email with Template (Razor)**

![Send email with template](<images/send-email-razor (1).png>)

Uses a template to send the results of the Form to a specified email address.

You can create your own custom Razor templates to be used to send out emails upon Forms submission. Read more about how to create these templates in the [Email Templates](../../developer/email-templates.md) article.

The following configuration can be set:

* Workflow Name
* Email Template (required) - specify which template you want to use
* Header text - formatted text that will be rendered above the form entry details
* Footer text - formatted text that will be rendered below the form entry details
* Attachments - specify whether file uploads should be attached to the email
* Recipient Email (required)
* CC Email
* BCC Email
* SenderEmail
* Reply To Email
* Subject of the email (required)

## **Send Form to URL**

![Send to URL](<images/send-to-URL (1).png>)

Sends the Form to a URL either as a HTTP POST or GET. The following configuration can be set:

* Workflow Name
* URL (required)
* Method (required) - POST, GET, PUT or DELETE
* Standard Fields - optionally include and map standard form information such as name and page URL
* Fields - map the needed fields
* User
* Password

When mapping fields, if any are selected, only those chosen will be sent in the request to the configured URL. If no fields are mapped, all will be sent.

The receiving endpoint extracts form fields and values using GET for querystrings and POST for form collections.

As an illustrative example, the following code can be used to write the posted form information to a text file:

```csharp
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System.IO;

namespace RequestSaver.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class SaveRequestController : ControllerBase
    {
        private const string _filePath = "c:\\temp\\request-save.txt";

        private readonly ILogger<SaveRequestController> _logger;

        public SaveRequestController(ILogger<SaveRequestController> logger)
        {
            _logger = logger;
        }

        [HttpPost]
        public string Save()
        {
            using (StreamWriter outputFile = new StreamWriter(_filePath))
            {
                foreach (var key in Request.Form.Keys)
                {
                    outputFile.WriteLine($"{key}: {(Request.Form[key])}");
                }
            }

            return "Done";
        }
    }
}
```

## **Send XSLT Transformed Email**

![Send XSLT Email](<images/xslt-email (1).png>)

Sends the result of the Form to an email address with full control over the email contents by providing an xslt file. The following configuration can be set:

* Workflow Name
* XSLT File - specify which file should be used to transform the content
* Recipient Email (required)
* CC Email
* BCC Email
* SenderEmail
* Reply To Email
* Subject of the email (required)

## **Slack**

![Send to Slack](<images/email-slack (1).png>)

Allows to post the Form data to a specific channel on Slack. The following configuration can be set:

* Workflow Name
* Webhook URL (required)
