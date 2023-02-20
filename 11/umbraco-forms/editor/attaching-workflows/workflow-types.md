---
description: >-
  This article will give you an overview of the Workflow Types available in
  Umbraco Forms.
---

# Workflow Types

There are several built-in Workflow Types that can be used to extend the functionality of your form. Do you want to post the submitted form as XML, send the data as an email, or send a notification through another messaging system? These are just a few of the options you can choose when working with Umbraco Forms.

## Video Tutorial

{% embed url="https://www.youtube.com/watch?ab_channel=UmbracoLearningBase&v=L9k0yDbV6qo" %}
Workflow Types in Umbraco Forms
{% endembed %}

## **Change Record State**

![Change Record state](../../../../10/umbraco-forms/editor/attaching-workflows/images/change-record-state.png)

Used to automatically **Approve Record** or **Delete Record** once it is submitted. Configure words that you want to match and select whether these words should trigger an approval or deletion of the record.

## **Post as XML**

![Post as XML](../../../../10/umbraco-forms/editor/attaching-workflows/images/post-as-xml.png)

Used to post the Form as an XML to a specified URL. The following configuration can be set:

* Workflow Name
* URL (required)
* Method
* XsltFile - used to transform the XML
* Headers - map the needed files
* User
* Password

## **Save as an XML file**

![Save as XML](../../../../10/umbraco-forms/editor/attaching-workflows/images/save-as-an-xml-file.png)

Saves the result of the Form as an XML file by using XSLT. The following configuration can be set:

* Workflow Name
* Path (required) - where to save the XML file
* File extension (required)
* XsltFile - used to transform the XML

## **Save as Umbraco Content Node**

![Save as content node](../../../../10/umbraco-forms/editor/attaching-workflows/images/save-as-content-node.png)

Saves a submitted Form as a new content node. You need to choose a Document type and match the fields in the Form with the properties on the selected Document Type.

You can also choose to set a static value to fill in the properties:

![Save as content node](../../../../10/umbraco-forms/editor/attaching-workflows/images/create-new-node.png)

In the example above, a Document Type called **Blogpost** is selected for creating the new Content node.

The value from the **Name** field will be added as the **Node Name** property in the new Content node and the value from the **Email** field will be used as the **Content** property.

The following configuration can be set:

* Workflow Name
* Publish - choose whether to publish the node on submission
* Where to save - choose a section in the content tree where this new node should be added

## **Send Email**

![Send email](../../../../10/umbraco-forms/editor/attaching-workflows/images/send-email.png)

Sends the result of the Form to the specified email address. The following configuration can be set:

* Workflow Name
* Message (required)
* Attachment - specify whether file uploads should be attached to the email
* Recipient Email (required)
* CC Email
* BCC Email
* SenderEmail - also configurable in `appsettings.json` under `Umbraco:CMS:Global:Smtp`. For more information, see the [Global Settings](https://docs.umbraco.com/umbraco-cms/reference/configuration/globalsettings) article.

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

* Reply To Email
* Subject of the email (required)

## **Send Email with Template (Razor)**

![Send email with template](../../../../10/umbraco-forms/editor/attaching-workflows/images/send-email-razor.png)

Uses a template to send the results of the Form to a specified email address.

You can create your own custom Razor templates to be used to send out emails upon Forms submission. Read more about how to create these templates in the [Email Templates](../../developer/email-templates.md) article.

The following configuration can be set:

* Workflow Name
* Email Template (required) - specify which template you want to use
* Attachment - specify whether file uploads should be attached to the email
* Recipient Email (required)
* CC Email
* BCC Email
* SenderEmail - also configurable in `appsettings.json` under `Umbraco:CMS:Global:Smtp`. For more information, see the [Global Settings](https://docs.umbraco.com/umbraco-cms/reference/configuration/globalsettings) article.

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

* Reply To Email
* Subject of the email (required)

## **Send Form to URL**

![Send to URL](../../../../10/umbraco-forms/editor/attaching-workflows/images/send-to-URL.png)

Sends the Form to a URL either as a HTTP POST or GET. The following configuration can be set:

* Workflow Name
* URL (required)
* Method (required) - POST, GET, PUT or DELETE
* Standard Fields - optionally include and map standard form information such as name and page URL
* Fields - map the needed fields
* User
* Password

When mapping fields, if any are selected, only those chosen will be sent in the request to the configured URL. If no fields are mapped, all will be sent.

The receiving endpoint will be able to extract the form fields and values from the querystring or form collection when the method used is set to GET or POST respectively.

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

![Send XSLT Email](../../../../10/umbraco-forms/editor/attaching-workflows/images/xslt-email.png)

Sends the result of the Form to an email address with full control over the email contents by providing an xslt file. The following configuration can be set:

* Workflow Name
* XSLT File - specify which file should be used to transform the content
* Recipient Email (required)
* CC Email
* BCC Email
* SenderEmail - also configurable in `appsettings.json` under `Umbraco:CMS:Global:Smtp`. For more information, see the [Global Settings](https://docs.umbraco.com/umbraco-cms/reference/configuration/globalsettings) article.

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

* Reply To Email
* Subject of the email (required)

## **Slack**

![Send to Slack](../../../../10/umbraco-forms/editor/attaching-workflows/images/email-slack.png)

Allows to post the Form data to a specific channel on Slack. The following configuration can be set:

* Workflow Name
* Webhook URL (required)
