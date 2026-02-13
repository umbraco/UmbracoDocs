# Headless/AJAX Forms

Umbraco Forms provides an API for client-side rendering and submission of forms. This will be useful when you want to handle forms in a headless style scenario.

## Enabling the API

The Forms API is disabled by default. To enable it, set the `Umbraco:Forms:Options:EnableFormsApi` configuration key to `true`.

For example:

```json
  "Umbraco": {
    "Forms": {
      "Options": {
        "EnableFormsApi": true
      }
    }
  }
```

## API Definition

The API supports two endpoints, one for rendering a form and one for submitting it.

{% openapi src="../.gitbook/assets/umbraco_forms_swagger.json" path="/umbraco/forms/delivery/api/v1/definitions/{id}" method="get" %}
[umbraco_forms_swagger.json](../.gitbook/assets/umbraco_forms_swagger.json)
{% endopenapi %}

{% openapi src="../.gitbook/assets/umbraco_forms_swagger.json" path="/umbraco/forms/delivery/api/v1/entries/{id}" method="post" %}
[umbraco_forms_swagger.json](../.gitbook/assets/umbraco_forms_swagger.json)
{% endopenapi %}

As well as this documentation, the definition of the API can also be reviewed via the Swagger UI.

This is available alongside the Umbraco 12 Content Delivery Api at: `/umbraco/swagger/index.html`. Select "Umbraco Forms API" from the "Select a definition" list to view the methods available.

![Swagger UI](../.gitbook/assets/swagger-ui.png)

The Open API specification is available from: `/umbraco/swagger/forms/swagger.json`

### Requesting a Form Definition

To request the definition of a form, the following request can be made:

```none
GET /umbraco/forms/delivery/api/v1/definitions/{id}?contentId={contentId}&culture={culture}&additionalData[{key}]={value}&additionalData[key2]={value2}
```

The GET request requires the Guid identifying the form.

An optional `contentId` parameter can be provided, which can either be the integer or GUID identifier for the current page. If provided, the content item identified will be used for Forms features requiring information from the page the form is hosted on. This includes the parsing of ["magic string" placeholders](magic-strings.md).

A `culture` parameter can also be provided, expected as an ISO code identifying a language used in the Umbraco installation (for example, `en-US`). This will be used to ensure the correct translation for dictionary keys is used. It will also retrieve page content from the appropriate language variant. If the parameter is not provided in the request, the default Umbraco language will be used.

Finally, an `additionalData` parameter can be provided as a dictionary. This information will be made available when rendering the form allowing it to be used as a source for ["magic string" replacements](magic-strings.md).

If the requested form is not found, a 404 status code will be returned.

A successful request will return a 200 status code. An example response is as follows. It will differ depending on the pages, fields and other settings available for the form.

```json
{
    "disableDefaultStylesheet": false,
    "fieldIndicationType": "MarkMandatoryFields",
    "hideFieldValidation": false,
    "id": "34ef4a19-efa7-40c1-b8b6-2fd7257f2ed3",
    "indicator": "*",
    "messageOnSubmit": "Thanks for submitting the form",
    "name": "Simple Comment Form",
    "nextLabel": "Next",
    "pages": [
        {
            "caption": "Your comment",
            "fieldsets": [
                {
                    "caption": "",
                    "columns": [
                        {
                            "caption": "",
                            "width": 12,
                            "fields": [
                                {
                                    "alias": "name",
                                    "caption": "Name",
                                    "condition": {
                                        "actionType": "Show",
                                        "logicType": "All",
                                        "rules": []
                                    },
                                    "helpText": "[#message] from [#pageName]",
                                    "id": "25185934-9a61-491c-9610-83dfe774662c",
                                    "pattern": "",
                                    "patternInvalidErrorMessage": "Please provide a valid value for Name",
                                    "placeholder": "",
                                    "preValues": [],
                                    "required": true,
                                    "requiredErrorMessage": "Please provide a value for Name",
                                    "settings": {
                                        "defaultValue": "",
                                        "placeholder": "Please enter your name.",
                                        "showLabel": "",
                                        "maximumLength": "",
                                        "fieldType": "",
                                        "autocompleteAttribute": ""
                                    },
                                    "type": {
                                        "id": "3f92e01b-29e2-4a30-bf33-9df5580ed52c",
                                        "name": "Short answer"
                                    }
                                },
                                {
                                    "alias": "email",
                                    "caption": "Email",
                                    "condition": {
                                        "actionType": "Show",
                                        "logicType": "All",
                                        "rules": []
                                    },
                                    "helpText": "",
                                    "id": "816fdf3b-a796-4677-a317-943a54bf9d55",
                                    "pattern": "^[_a-z0-9-]+(\\.[_a-z0-9-]+)*@[a-z0-9-]+(\\.[a-z0-9-]+)*(\\.[a-z]{2,4})$",
                                    "patternInvalidErrorMessage": "Please provide a valid value for Email",
                                    "placeholder": "",
                                    "preValues": [],
                                    "required": true,
                                    "requiredErrorMessage": "Please provide a value for Email",
                                    "settings": {
                                        "defaultValue": "",
                                        "placeholder": "",
                                        "showLabel": "",
                                        "maximumLength": "",
                                        "fieldType": "email",
                                        "autocompleteAttribute": ""
                                    },
                                    "type": {
                                        "id": "3f92e01b-29e2-4a30-bf33-9df5580ed52c",
                                        "name": "Short answer"
                                    }
                                },
                                {
                                    "alias": "comment",
                                    "caption": "Comment",
                                    "condition": {
                                        "actionType": "Show",
                                        "logicType": "All",
                                        "rules": []
                                    },
                                    "helpText": "",
                                    "id": "9d723100-ec34-412f-aaa5-516634d7c833",
                                    "pattern": "",
                                    "patternInvalidErrorMessage": "Please provide a valid value for Comment",
                                    "placeholder": "",
                                    "preValues": [],
                                    "required": false,
                                    "requiredErrorMessage": "Please provide a value for Comment",
                                    "settings": {
                                        "defaultValue": "",
                                        "placeholder": "",
                                        "showLabel": "",
                                        "autocompleteAttribute": "",
                                        "numberOfRows": "2",
                                        "maximumLength": ""
                                    },
                                    "type": {
                                        "id": "023f09ac-1445-4bcb-b8fa-ab49f33bd046",
                                        "name": "Long answer"
                                    }
                                },
                                {
                                    "alias": "country",
                                    "caption": "Country",
                                    "condition": {
                                        "actionType": "Show",
                                        "logicType": "All",
                                        "rules": []
                                    },
                                    "helpText": "",
                                    "id": "30ff8f37-28d4-47df-f281-422b36c62e73",
                                    "pattern": "",
                                    "patternInvalidErrorMessage": "Please provide a valid value for Country",
                                    "placeholder": "",
                                    "preValues": [
                                        {
                                            "caption": "France",
                                            "value": "fr"
                                        },
                                        {
                                            "caption": "Italy",
                                            "value": "it"
                                        },
                                        {
                                            "caption": "Span",
                                            "value": "es"
                                        },
                                        {
                                            "caption": "United Kingdom",
                                            "value": "gb"
                                        }
                                    ],
                                    "required": false,
                                    "requiredErrorMessage": "Please provide a value for Country",
                                    "settings": {
                                        "defaultValue": "",
                                        "allowMultipleSelections": "",
                                        "showLabel": "",
                                        "autocompleteAttribute": "",
                                        "selectPrompt": "Please select"
                                    },
                                    "type": {
                                        "id": "0dd29d42-a6a5-11de-a2f2-222256d89593",
                                        "name": "Dropdown"
                                    }
                                },
                                {
                                    "alias": "favouriteColour",
                                    "caption": "Favourite Colour",
                                    "condition": {
                                        "actionType": "Show",
                                        "logicType": "All",
                                        "rules": []
                                    },
                                    "helpText": "",
                                    "id": "a6e2e27f-097d-476a-edb9-4aa79449ab5c",
                                    "pattern": "",
                                    "patternInvalidErrorMessage": "Please provide a valid value for Favourite Colour",
                                    "placeholder": "",
                                    "preValues": [
                                        {
                                            "caption": "Red",
                                            "value": "red"
                                        },
                                        {
                                            "caption": "Green",
                                            "value": "green"
                                        },
                                        {
                                            "caption": "Yellow",
                                            "value": "yello"
                                        }
                                    ],
                                    "required": false,
                                    "requiredErrorMessage": "Please provide a value for Favourite Colour",
                                    "settings": {
                                        "defaultValue": "",
                                        "showLabel": ""
                                    },
                                    "type": {
                                        "id": "fab43f20-a6bf-11de-a28f-9b5755d89593",
                                        "name": "Multiple choice"
                                    }
                                },
                                {
                                    "alias": "dataConsent",
                                    "caption": "Data consent",
                                    "condition": {
                                        "actionType": "Show",
                                        "logicType": "All",
                                        "rules": []
                                    },
                                    "helpText": "Please indicate if it's OK to store your data.",
                                    "id": "9f25acaf-4ac4-4105-9afe-eb0bb0c03b31",
                                    "pattern": "",
                                    "patternInvalidErrorMessage": "Please provide a valid value for Data consent",
                                    "placeholder": "",
                                    "preValues": [],
                                    "required": true,
                                    "requiredErrorMessage": "Please confirm your data consent",
                                    "settings": {
                                        "acceptCopy": "Yes, I give permission to store and process my data.",
                                        "showLabel": ""
                                    },
                                    "type": {
                                        "id": "a72c9df9-3847-47cf-afb8-b86773fd12cd",
                                        "name": "Data Consent"
                                    }
                                },
                                {
                                    "alias": "tickToAddMoreInfo",
                                    "caption": "Tick to add more info",
                                    "condition": {
                                        "actionType": "Show",
                                        "logicType": "All",
                                        "rules": []
                                    },
                                    "helpText": "",
                                    "id": "6ce0cf78-5102-47c1-85c6-9530d9e9c6a6",
                                    "pattern": "",
                                    "patternInvalidErrorMessage": "Please provide a valid value for Tick to add more info",
                                    "placeholder": "",
                                    "preValues": [],
                                    "required": false,
                                    "requiredErrorMessage": "Please provide a value for Tick to add more info",
                                    "settings": {
                                        "defaultValue": ""
                                    },
                                    "type": {
                                        "id": "d5c0c390-ae9a-11de-a69e-666455d89593",
                                        "name": "Checkbox"
                                    }
                                },
                                {
                                    "alias": "moreInfo",
                                    "caption": "More info",
                                    "condition": {
                                        "actionType": "Show",
                                        "logicType": "All",
                                        "rules": [
                                            {
                                                "field": "6ce0cf78-5102-47c1-85c6-9530d9e9c6a6",
                                                "operator": "Is",
                                                "value": "on"
                                            }
                                        ]
                                    },
                                    "helpText": "",
                                    "id": "5b4100ed-cc5e-4113-943c-ee5a8f4e448d",
                                    "pattern": "",
                                    "patternInvalidErrorMessage": "Please provide a valid value for More info",
                                    "placeholder": "",
                                    "preValues": [],
                                    "required": false,
                                    "requiredErrorMessage": "Please provide a value for More info",
                                    "settings": {
                                        "defaultValue": "",
                                        "placeholder": "",
                                        "showLabel": "",
                                        "maximumLength": "",
                                        "fieldType": "",
                                        "autocompleteAttribute": ""
                                    },
                                    "type": {
                                        "id": "3f92e01b-29e2-4a30-bf33-9df5580ed52c",
                                        "name": "Short answer"
                                    }
                                }
                            ],
                            "width": 0
                        }
                    ],
                    "id": "d677b96f-488d-4052-b00d-fb852b35e9c5"
                }
            ]
        }
    ],
    "previousLabel": "Previous",
    "showValidationSummary": false,
    "submitLabel": "Submit"
}
```

It's possible to define either a message displayed when a form is submitted, or a redirect to another website page.

With the former, the output will be as above, and as shown in this extract:

```json
{
    ...
    "messageOnSubmit": "Thanks for submitting the form",
    ...
}
```

When a redirect is configured, details of the content ID and a route will be included, as follows:

```json
{
    ...
    "gotoPageOnSubmit": "eab72f13-b22e-46d5-b270-9c196e49a53b",
    "gotoPageOnSubmitRoute": {
        "path": "/contact-us/thanks/",
        "startItem": {
            "id": "ca4249ed-2b23-4337-b522-63cabe5587d1",
            "path": "home"
        }
    },
    ...
}
```

### Submitting a Form Entry

To submit a form entry, the following request can be made:

```none
POST /umbraco/forms/delivery/api/v1/entries/{id}
```

The POST request requires the Guid identifying the form.

It also requires a `Content-Type` header of `application/json` and accepts a body as per this example:

```json
{
    "values": {
        "name": "Fred",
        "email": "fred@test.com",
        "comment": "Test",
        "country": "it",
        "favouriteColours": ["red", "green"],
        "dataConsent": "on"
    },
    "contentId": "ca4249ed-2b23-4337-b522-63cabe5587d1",
    "culture": "en-US",
    "additionalData": {
        "foo": "bar",
        "baz": "buzz",
    }
}
```

The `values` collection consists of a set of name/value pairs, where the name is the alias of a form field. The value is the value of the submitted field, which can either be a string, or an array of strings. In this way we support fields that accept multiple values, such as checkbox lists.

The `contentId` and `culture` parameters are optional. If provided they will be used to customize the response for the current page and language respectively.

Similarly the `additionalData` dictionary is optional. This data is associated with the created record and made available within workflows.

In the case of a validation error, a 422 "Unprocessable Entity" status code will be returned, along with a response similar to the following:

```json
{
    "errors": {
        "name": [
            "Please provide a value for Name"
        ]
    },
    "extensions": {},
    "status": 422,
    "title": "One or more validation errors occurred."
}
```

A successful response will return a 202 "Accepted" status code.

It will contain an object detailing the post-submission configured the form, for example:

```json
{
    "gotoPageOnSubmit": "3cce2545-e3ac-44ec-bf55-a52cc5965db3",
    "gotoPageOnSubmitRoute": {
        "path": "/about-us/",
        "startItem": {
            "id": "ca4249ed-2b23-4337-b522-63cabe5587d1",
            "path": "home"
        }
    },
    "messageOnSubmit": "Thanks for your entry",
    "messageOnSubmitIsHtml": false
}
```

#### File Uploads

The file upload field type is supported via the API for the rendering and submission of forms.

When retrieving a form definition, some additional detail is provided for fields of this type to allow for the appropriate rendering of the form interface:

```json
    ...
    "fields": [
        {
            "alias": "uploadAPicture",
            ...
            "fileUploadOptions": {
                "allowAllUploadExtensions": false,
                "allowedUploadExtensions": [
                    "png",
                    "jpg",
                    "gif"
                ],
                "allowMultipleFileUploads": false
            },
        }
    ]
    ...
```

When submitting a form, the value should be a JSON structure that provides a collection. Each item in the collection should contain the file name and the file contents as a base64 encoded data URL.

```json
{
    "values": {
        "uploadAPicture": [
            {
                "fileName": "mypic.jpg",
                "fileContents": "data:image/png;base64,iVBORw..."
            }
        ]
    },
}
```

## Securing the API

### Antiforgery Protection

When posting forms in the traditional way, via a full page post back, an anti-forgery token is generated and validated. This provides protection against Cross-Site Request Forgery (CSRF) attacks.

The same protection is available for forms submitted via AJAX techniques.

In order to generate the token and provide it in the form post, the following code can be applied to the .cshtml template:

```csharp
@using Microsoft.AspNetCore.Antiforgery

@inject IAntiforgery antiforgery

@{
    var tokenSet = antiforgery.GetAndStoreTokens(Context);
}
```

When posting the form, the header value generated can be provided, where it will be validated server-side before accepting the request.

```javascript
    let response = await fetch("/umbraco/forms/delivery/api/v1/entries/" + formId, {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
            "@tokenSet.HeaderName" : "@tokenSet.RequestToken"
        },
        body: JSON.stringify(data),
    });
```

### API Key

The antiforgery token security approach is valid when building a client-side integration with API calls made from the browser.

Providing the token isn't possible though in other headless situations such as server-to-server requests. In these situations, an alternative approach to securing the API is available.

Firstly, with server-to-server integrations you will want to disable the antiforgery token protection.

This is done by setting the `Umbraco:Forms:Security:EnableAntiForgeryTokenForFormsApi` configuration key to a value of `false`.

You should then configure an API key `Umbraco:Forms:Security:FormsApiKey`. This can be any string value, but it should be complex enough to resist being guessed by a brute force attack.

With this in place any request to the Forms API will be rejected unless the configured value is provided in an HTTP header named `Api-Key`.

## Rendering and Submitting forms with JavaScript

For an illustrative example showing how a form can be rendered, validated and submitted using the API and vanilla JavaScript, [see this gist](https://gist.github.com/AndyButland/9371175d6acf24a5307b053398f08448).

Examples demonstrating how to handle a file upload and use reCAPTCHA fields are included.

## Working with the CMS Content Delivery API

The [Content Delivery API](https://docs.umbraco.com/umbraco-cms/reference/content-delivery-api) provides headless capabilities within Umbraco by allowing you to retrieve content in JSON format.

When retrieving content that contains an Umbraco Forms form picker, the output by default will consist of the ID of the selected form:

```json
{
    "name": "Contact Us",
    "route": {
        "path": "/contact-us/",
        "startItem": {
            "id": "ca4249ed-2b23-4337-b522-63cabe5587d1",
            "path": "home"
        }
    },
    "id": "4a1f4198-e143-48ba-a0f5-1a7ef2df23aa",
    "contentType": "contactPage",
    "properties": {
        "title": "Contact Us",
        "contactForm": {
            "id": "3623b232-9296-4bf0-b16c-57801dc4f296",
            "form": null
        }
    }
}
```

With [expanded output](https://docs.umbraco.com/umbraco-cms/reference/content-delivery-api#output-expansion) for the property, the full details of the form will be available. The structure and content of the form representation will be exactly the same as that provided by the Forms API itself.

```json
{
    "name": "Contact Us",
    "route": {
        "path": "/contact-us/",
        "startItem": {
            "id": "ca4249ed-2b23-4337-b522-63cabe5587d1",
            "path": "home"
        }
    },
    "id": "4a1f4198-e143-48ba-a0f5-1a7ef2df23aa",
    "contentType": "contactPage",
    "properties": {
        "title": "Contact Us",
        "contactForm": {
            "id": "3623b232-9296-4bf0-b16c-57801dc4f296",
            "form": {
                "id": "3623b232-9296-4bf0-b16c-57801dc4f296",
                "name": "Contact Form",
                ...
                "pages": [ ... ]
            }
        }
    }
}
```

## Dynamic Form Injection

For dynamic Form injection on a page, such as in a modal dialog, there's a specific JavaScript event and API method. This allows reinitializing Umbraco Forms for the new content.

```javascript
// Execute a reinitialize on dynamic injections
const reinitializeEvent = new Event('umbracoFormsReinitialize');
document.dispatchEvent(reinitializeEvent);

// Render a specific form via the API
const injectedForm = document.getElementById('injected-umbraco-form');
window.UmbracoForms.reinitialize(injectedForm);
```
