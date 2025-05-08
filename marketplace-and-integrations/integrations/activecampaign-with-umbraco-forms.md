---
description: >-
  Details an integration available for ActiveCampaign with Umbraco Forms, built
  and maintained by Umbraco HQ.
---

# ActiveCampaign with Umbraco Forms

This integration provides a custom workflow, allowing form entries to be mapped to an ActiveCampaign contact record. The record can be used to create a new contact or to associate a contact with an existing Customer Relationship Management (CRM) account.

## Package Links

* [NuGet install](https://www.nuget.org/packages/Umbraco.Forms.Integrations.Crm.ActiveCampaign)
* [Source code](https://github.com/umbraco/Umbraco.Forms.Integrations/tree/main-v10/src/Umbraco.Forms.Integrations.Crm.ActiveCampaign)
* [Umbraco marketplace listing](https://marketplace.umbraco.com/package/umbraco.forms.integrations.crm.activecampaign)

## Minimum version requirements

To ensure compatibility, check the **Dependencies** tab on NuGet for the required Umbraco CMS version. For example, see [Umbraco.Forms.Integrations.Crm.ActiveCampaign](https://www.nuget.org/packages/Umbraco.Forms.Integrations.Crm.ActiveCampaign/#dependencies-body-tab).

## Authentication

All requests to the ActiveCampaign API are authenticated by providing an API key. The API key is included as an HTTP header called _Api-Token_.

If the configuration is incomplete, the user will receive an error message.

## Configuration

An ActiveCampaign contact has four main properties: email, first name, last name, and phone.

To connect to your ActiveCampaign account, the following configuration is required:

{% code title="appsettings.json" %}
```json
"Umbraco": {
  "Forms": {
    "Integrations": {
        "Crm": {
          "ActiveCampaign": {
            "Settings": {
              "BaseUrl": "https://[YOUR_ACCOUNT_NAME].api-us1.com",
              "ApiKey": "[YOUR_API_KEY]",
              "ContactFields": [
                {
                  "name": "email",
                  "displayName": "Email",
                  "required": true
                },
                {
                  "name": "firstName",
                  "displayName": "First Name",
                  "required": false
                },
                {
                  "name": "lastName",
                  "displayName": "Last Name",
                  "required": false
                },
                {
                  "name": "phone",
                  "displayName": "Phone",
                  "required": true
                }
            ]
          }
        }
      }
    }
  }
}
```
{% endcode %}

The email property is mandatory by default through ActiveCampaign API rules. The required rule can be extended to the other properties, by explicitly specifying that in the `required` property of each `ContactFields` node.

## Working with the integration

To use it, follow these steps:

1. Attach the _ActiveCampaign Contacts Workflow_ to a form.
2. Configure the mappings between the contact properties and the form fields.
3. Select an account if you want to associate the contacts, and/or map any contact custom fields.

When a form is submitted on the website, the workflow will execute. Based on the provided email it will create or update an ActiveCampaign account. If custom fields mappings have been provided, the contact payload will contain custom fields values.

If an account has been provided in the workflow setup, then an association with the account will be created.
