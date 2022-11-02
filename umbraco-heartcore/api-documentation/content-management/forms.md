# Content Management API for Umbraco Forms

**BASE URL**: `https://api.umbraco.io`

**API version**: 2.1

:::note
The availability of Umbraco Forms depend on the plan. See the [Pricing & Features](https://umbraco.com/umbraco-heartcore-pricing/) for an overview of which plans includes Forms.
:::

## Table of Contents

- [Common Headers](#common-headers)
- [Authentication](#authentication)
- [Errors](#errors)
- [Fields types](#field-types)
- [Get forms](#get-forms)
- [Get by id](#get-by-id)
- [Submit entry](#submit-entry)

## Common Headers

```http
Api-Version: 2.1
Umb-Project-Alias: {project-alias}
```

## Authentication

Auth is required for this API meaning that you must supply a Bearer Token via an Authorization header or an API Key via an Authorization or Api-Key header.

## Errors

If an error occurs you will receive a HTTP status code along with an API error code and an error message in the response body.

| Status Code | Error Code          | Message                                              |
| ----------- | ------------------- | ---------------------------------------------------- |
| 400         | BadRequest          | Body cannot be empty.                                |
| 401         | Unauthorized        | Authorization has been denied for this request.      |
| 403         | Forbidden           | You are not authorized to access the given resource. |
| 404         | NotFound            | Form with id '{id}' could not be found.              |
| 422         | ValidationFailed    | Validation error.                                    |
| 500         | InternalServerError | Internal server error.                               |

**JSON example**:

```json
{
  "error": {
    "code": "Unauthorized",
    "message": "Authorization has been denied for this request."
  }
}
```

## Field types

The field types gets mapped to a more machine friendly name

| Name                  | Alias               | Value                                                                    |
| --------------------- | ------------------- | ------------------------------------------------------------------------ |
| Checkbox              | checkbox            | string("on") / boolean                                                   |
| Date                  | date                | date ([ISO8601](https://www.iso.org/iso-8601-date-and-time-format.html)) |
| Data Consent          | dataConsent         | string("on") / boolean                                                   |
| Dropdown              | dropdown            | string                                                                   |
| Hidden                | hidden              | string                                                                   |
| Long Answer           | textarea            | string                                                                   |
| Multiple Choice       | checkboxList        | string                                                                   |
| Password              | password            | string                                                                   |
| Recaptcha2            | recaptcha2          | string(reCaptcha response)                                               |
| Short Answer          | text                | string                                                                   |
| Single Choice         | radio               | string                                                                   |
| Title And Description | titleAndDescription | readonly                                                                 |

## Get forms

Gets all forms.

**URL**: `/forms`

**Method**: `GET`

**Permissions required** : Access to Forms section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
{
  "_links": {
    "self": {
      "href": "/api/forms"
    },
    "forms": {
      "href": "/api/forms/2edaf583-cf66-4d57-930c-f0772c3d1c52"
    }
  },
  "_embedded": {
    "forms": [
      {
        "_id": "2edaf583-cf66-4d57-930c-f0772c3d1c52",
        "indicator": "*",
        "name": "Contact",
        "nextLabel": "Next",
        "previousLabel": "Previous",
        "submitLabel": "Submit",
        "disableDefaultStylesheet": false,
        "fieldIndicationType": "MARK_MANDATORY_FIELDS",
        "hideFieldValidation": false,
        "messageOnSubmit": "Thank you",
        "showValidationSummary": false,
        "pages": [
          {
            "fieldsets": [
              {
                "columns": [
                  {
                    "width": 12,
                    "fields": [
                      {
                        "caption": "Name",
                        "alias": "name",
                        "required": true,
                        "requiredErrorMessage": "Please provide a value for Name",
                        "settings": {
                          "placeholder": "John Smith",
                          "defaultValue": ""
                        },
                        "type": "text"
                      },
                      {
                        "caption": "Email",
                        "alias": "email",
                        "required": true,
                        "requiredErrorMessage": "Please provide a value for Email",
                        "settings": {
                          "placeholder": "johnsmith@example.org",
                          "defaultValue": "",
                          "pattern": "[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+.[a-zA-Z0-9-.]+",
                          "patternInvalidErrorMessage": "Please enter a valid email address"
                        },
                        "type": "text"
                      },
                      {
                        "caption": "Message",
                        "alias": "message",
                        "required": false,
                        "requiredErrorMessage": "Please provide a value for Message",
                        "settings": {
                          "defaultValue": "",
                          "placeholder": ""
                        },
                        "type": "textarea"
                      },
                      {
                        "caption": "Consent for storing submitted data",
                        "alias": "dataConsent",
                        "required": true,
                        "requiredErrorMessage": "Consent is required to store and process the data in this form.",
                        "settings": {
                          "acceptCopy": "Yes, I give permission to store and process my data"
                        },
                        "type": "dataConsent"
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
            "href": "/api/forms/2edaf583-cf66-4d57-930c-f0772c3d1c52"
          }
        }
      }
    ]
  }
}
```

## Get by ID

Get a specific form by its ID.

**URL**: `/forms/{id}`

**Method**: `GET`

**Permissions required** : Access to Forms section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
{
  "_id": "2edaf583-cf66-4d57-930c-f0772c3d1c52",
  "indicator": "*",
  "name": "Contact",
  "nextLabel": "Next",
  "previousLabel": "Previous",
  "submitLabel": "Submit",
  "disableDefaultStylesheet": false,
  "fieldIndicationType": "MARK_MANDATORY_FIELDS",
  "hideFieldValidation": false,
  "messageOnSubmit": "Thank you",
  "showValidationSummary": false,
  "pages": [
    {
      "fieldsets": [
        {
          "columns": [
            {
              "width": 12,
              "fields": [
                {
                  "caption": "Name",
                  "alias": "name",
                  "required": true,
                  "requiredErrorMessage": "Please provide a value for Name",
                  "settings": {
                    "placeholder": "John Smith",
                    "defaultValue": ""
                  },
                  "type": "text"
                },
                {
                  "caption": "Email",
                  "alias": "email",
                  "required": true,
                  "requiredErrorMessage": "Please provide a value for Email",
                  "settings": {
                    "placeholder": "johnsmith@example.org",
                    "defaultValue": "",
                    "pattern": "[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+.[a-zA-Z0-9-.]+",
                    "patternInvalidErrorMessage": "Please enter a valid email address"
                  },
                  "type": "text"
                },
                {
                  "caption": "Message",
                  "alias": "message",
                  "required": false,
                  "requiredErrorMessage": "Please provide a value for Message",
                  "settings": {
                    "defaultValue": "",
                    "placeholder": ""
                  },
                  "type": "textarea"
                },
                {
                  "caption": "Consent for storing submitted data",
                  "alias": "dataConsent",
                  "required": true,
                  "requiredErrorMessage": "Consent is required to store and process the data in this form.",
                  "settings": {
                    "acceptCopy": "Yes, I give permission to store and process my data"
                  },
                  "type": "dataConsent"
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
      "href": "/api/forms/2edaf583-cf66-4d57-930c-f0772c3d1c52"
    }
  }
}
```

## Submit entry

Submit form entries for a specific Form - this is what you would use when a form is submitted from your presentation layer.

**URL**: `/forms/{id}/entries`

**Method**: `POST`

**Permissions required** : Access to Forms section of the Umbraco Backoffice

### Request

The JSON property names are the form field alias

```json
{
  "name": "Jonh Smith",
  "email": "johnsmith@example.org",
  "dataConsent": "on"
}
```

### Success Response

**Code**: 202
