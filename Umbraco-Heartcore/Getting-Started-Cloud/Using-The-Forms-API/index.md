---
versionFrom: 8.0.0
---

# Using the Forms API

In this article you can learn more about how to use the Forms API for retrieving form definitions and submitting form entries.

We recommend that you have a look at the [Forms API reference documentation](../../API-Documentation/Content-Management/forms) along side this article if you haven't already seen it. The API reference has useful content around field types and possible errors.

Using the Forms API requires the use of a Bearer Token or an API-Key. A bearer token makes sense when working server side or in some kind of middleware whereas on the client side an API-Key might be a better fit.
When using an API-Key on the client side we recommend that you create a "Forms-only" usergroup, so you do not expose any Content Management capabilities on the client side where not intentional.

:::note
The availability of Umbraco Forms depends on the plan. See the [Pricing & Features](https://umbraco.com/umbraco-heartcore-pricing/) for an overview of which plans includes Forms.
:::

## Usage

In the Forms section of the Umbraco backoffice you will find the Forms Builder, which allows you to create forms by adding Fields, Placeholder texts, Validation and Conditions.

The purpose of this article is not to describe the Forms functionality itself, but to show how to use the APIs which are available for Umbraco Heartcore projects. 

If you want to learn the basics of 'Creating a form' before going further we recommend that you start with the [Umbraco Forms documentation section](../../../Add-ons/UmbracoForms/Editor/Creating-a-Form/).

Before you continue with the rest of this article we recommend that you have at least one Form available that can be used for examples below. Here we will use a form with a Name field, an Email field and the Data Consent field, which is standard for all new Forms.

## Retrieving a Form

### Retrieving a Form using the REST API

The API for Forms lives under the Content Management API, so a Bearer token or an API-Key is required to call all the Forms related endpoints.

For this example we will call `https://api.umbraco.io/forms` which lists all available forms. From here you can find a specific form to retrieve in order to get the definition for that form. This is useful when you want to expose a specific form in a specific part of your presentation layer.

Getting a specific form is done by issuing a GET request to
`https://api.umbraco.io/forms/{id:guid}`

Required headers include `umb-project-alias` and `Api-Key` or a Bearer Token via an Authorization header.

The JSON output for one specific form would look something like this:

```json
{
    "_id": "0134604b-f583-4ebc-a3b6-c26ce0f1a11b",
    "indicator": "*",
    "name": "Contact Us",
    "nextLabel": "Next",
    "previousLabel": "Previous",
    "submitLabel": "Submit",
    "disableDefaultStylesheet": false,
    "fieldIndicationType": "MARK_MANDATORY_FIELDS",
    "hideFieldValidation": false,
    "invalidErrorMessage": "Please provide a valid value for {0}",
    "messageOnSubmit": "0",
    "requiredErrorMessage": "Please provide a value for {0}",
    "showValidationSummary": false,
    "pages": [
        {
            "caption": "Contact details",
            "fieldsets": [
                {
                    "columns": [
                        {
                            "width": 12,
                            "fields": [
                                {
                                    "caption": "Name",
                                    "alias": "name",
                                    "containsSensitiveData": false,
                                    "required": true,
                                    "requiredErrorMessage": "Please enter your name",
                                    "settings": {
                                        "defaultValue": "",
                                        "placeholder": "Full name",
                                        "patternInvalidErrorMessage": "Please provide a valid value for Name"
                                    },
                                    "preValues": [],
                                    "type": "text"
                                },
                                {
                                    "caption": "Email",
                                    "alias": "email",
                                    "containsSensitiveData": false,
                                    "required": true,
                                    "requiredErrorMessage": "Please enter a valid email",
                                    "settings": {
                                        "placeholder": "Your email address",
                                        "defaultValue": "",
                                        "pattern": "[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+.[a-zA-Z0-9-.]+",
                                        "patternInvalidErrorMessage": "Please provide a valid value for Email"
                                    },
                                    "preValues": [],
                                    "type": "text"
                                },
                                {
                                    "caption": "Consent for storing submitted data",
                                    "alias": "dataConsent",
                                    "containsSensitiveData": false,
                                    "required": true,
                                    "requiredErrorMessage": "Consent is required to store and process the data in this form.",
                                    "settings": {
                                        "acceptCopy": "Yes, I give permission to store and process my data",
                                        "patternInvalidErrorMessage": "Please provide a valid value for Consent for storing submitted data"
                                    },
                                    "type": "consent"
                                }
                            ]
                        }
                    ]
                }
            ]
        }
    ],
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/forms/0134604b-f583-4ebc-a3b6-c26ce0f1a11b"
        }
    }
}
```

Notice that the layout of properties correspond to the Forms builder in the backoffice. The various properties available for the form itself and for each of the fields is something you can use to build up the look and feel of the form in your presentation layer.

### Retrieving a Form using the .NET Core Client Library

If you are a C# developer and work with .NET you can use the [.NET Core Client Library](../../Client-libraries/Dot-Net-Core) in your own codebase to retrieve form definitions.

First step is to install it through NuGet:

```
> Install-Package Umbraco.Headless.Client.Net
```

When using the library you need the Content Management part in order to work with Forms. Create a new instance of the `ContentManagementService` and pass in the name of your Umbraco Heartcore project and either username + password of a backoffice user or an API-Key. In the example below we use an API-Key when retrieving all available form definitions:

```csharp
var managementService = new ContentManagementService("project-alias", "api-key-value");
var forms = await managementService.Forms.GetAll();
```

If you want to retrieve a specific form you can use the `GetById` method along with a GUID ID as shown below:

```csharp
var managementService = new ContentManagementService("project-alias", "api-key-value");
var contactForm = await managementService.Forms.GetById(new Guid("0134604b-f583-4ebc-a3b6-c26ce0f1a11b"));
```

### Retrieving a Form using the NodeJS Client Library

If you are a javascript developer and work with NodeJS you can use the [NodeJS Client Library](../../Client-Libraries/Node-JS) in your own codebase to retrieve form definitions.

First step is to install it through npm:

```bash
> npm install --save @umbraco/headless-client
```

First we need to import and create a new instance of the `Client`, to use the forms api you need to pass in the project alias and set an API-Key.

```typescript
import { Client } from '@umbraco/headless-client'

const client = new Client({
  projectAlias: 'project-alias'
})

client.setAPIKey('api-key-value')
```

To retrieve all forms we need to use the forms service on the management API as shown below.

```typescript
const forms = await client.management.forms.all()
```

To retrieve a single form by ID you can use the `byId` method with the form ID.

```typescript
const form = await client.management.forms.byId('0134604b-f583-4ebc-a3b6-c26ce0f1a11b')
```

## Posting a Form entry

### Posting a Form entry using the REST API

When a form is filled out we need to post the entered values to the `entries` endpoint of the Forms API.

In order to submit the entered values you send a POST request to `https://api.umbraco.io/forms/{id:guid}/entries` where the ID represents the specific form to post the entry to.

Required headers include `umb-project-alias` and `Api-Key` or a Bearer Token via an Authorization header.
The payload is a key value object with the alias of the fields and the values entered in the form.

Below is an example of the payload body when sending an entry back to the form retrieved in the previous section.

```json
{
  "name": "Jonh Smith",
  "email": "johnsmith@example.org",
  "dataConsent": "on"
}
```

Please keep in mind that the `dataConsent` property is required to have the value `on` or `true` when present on a form - anything else will result in validation error.

If you added validation on the email field to ensure that the entered value is in fact a valid email address, then this validation will also be enforced through the API. Try to send the payload above with a value that is not a valid email address to see the validation response you get back.

### Posting a Form entry using the .NET Core Client Library

Continuing on the previous .NET Core example we can also post entries to a form using the library.

Given that the form contains a Name, Email and Data Content field we can submit a form entry as follows:

```csharp
var entry = new Dictionary<string, object>
             {
                 {"name", "John Smith"},
                 {"email", "johnsmith@example.org"},
                 {"dataConsent", true}
             };

var managementService = new ContentManagementService("project-alias", "api-key-value");
await managementService.Forms.SubmitEntry(new Guid("0134604b-f583-4ebc-a3b6-c26ce0f1a11b"), entry);
```

Please note that if validation fails an exception is thrown. The validation configured for each of the fields is validated by Umbraco Forms on the server side.

### Posting a Form entry using the NodeJS Client Library

Continuing on the previous NodeJS example we can also post entries to a form using the library.

Given that the form contains a Name, Email and Data Content field we can submit a form entry as follows:

```typescript
const entry = {
  "name": "Jonh Smith",
  "email": "johnsmith@example.org",
  "dataConsent": "on"
}

await client.management.forms.submitEntry('0134604b-f583-4ebc-a3b6-c26ce0f1a11b', entry)
```

Please note that if validation fails an error is thrown. The validation configured for each of the fields is validated by Umbraco Forms on the server side.

