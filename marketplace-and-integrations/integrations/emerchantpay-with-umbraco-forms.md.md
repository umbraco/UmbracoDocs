---
description: >-
  Details an integration available for emerchantpay with Umbraco Forms, built and maintained by Umbraco HQ.
---

# emerchantpay with Umbraco Forms Integration

This integration provides a custom workflow for handling online payments using a hosted payment page provided by emerchantpay.

Install from NuGet via:
https://www.nuget.org/packages/Umbraco.Forms.Integrations.Commerce.emerchantpay

Source code is at:
https://github.com/umbraco/Umbraco.Forms.Integrations/tree/main/src/Umbraco.Forms.Integrations.Commerce.emerchantpay

Available on the Umbraco Marketplace at:
https://marketplace.umbraco.com/package/umbraco.forms.integrations.commerce.emerchantpay

## Prerequisites

Required minimum versions of Umbraco CMS:
- CMS: 10.1.0
- Forms: 10.1.0

## How To Use

To get started with _emerchantpay_ a merchant would need to be on-boarded in order to get a merchant ID and obtain the keys
required by the integration.

To begin the onboarding process an obtain the merchant account, you would need to fill out [this](https://www.emerchantpay.com/contact-us?utm_source__c=umbraco_referral&utm_medium__c=technical_blog&utm_campaign__c=Umbraco) form.
Afterwards, a member of the _emerchantpay_ team will reach out to you.

### Customer journey map
A merchant getting started with emerchantpay and Umbraco will need to make sure that they have an emerchantpay merchant account enabled and then cover these steps:

* Package Installation
* Site Settings
* Workflow Setup

### Authentication

All requests to emerchantpay API are authenticated by providing the merchant's username and password.

If the configuration is incomplete, the user will receive an error message.

### Configuration

The emerchantpay API endpoints accept and return XML data. When the form is submitted, two batches of payload data are exchanged: one for handling consumer information and the second one for creating the payment.

A consumer has the following available properties that can be mapped against form fields:
* Email
* FirstName
* LastName
* Address1
* Address2
* ZipCode
* City
* State
* Country
* Phone

The below configuration - consisting of authentication settings, merchant specific details and customizable payment fields - is required. Some configuration items
are stored as an array of strings or a dictionary, and parsed using a specific service.

```json
{
  "Umbraco": {
    "Forms": {
      "Integrations": {
        "Commerce": {
          "Emerchantpay": {
            "Settings": {
              "GatewayBaseUrl": "https://staging.gate.emerchantpay.net/",
              "WpfUrl": "https://staging.wpf.emerchantpay.net/wpf/",
              "Username": "[your_merchant_username]",
              "Password": "[your_merchant_password]",
              "UmbracoBaseUrl": "[your_website_url]",
              "Supplier": "Umbraco",
              "Usage": "Payment Gateway using Umbraco Forms",
              "Currencies": {
                "USD": "US Dollar",
                "EUR": "Euro",
                "GBP": "British Pound",
                "DKK": "Danish Krone"
              },
              "TransactionTypes": [ "authorize", "sale" ],
              "MappingFields": [ "Email", "FirstName", "LastName" ]
            }
          }
        }
      }
    }
  }
}
```

### Working with the Umbraco Forms - emerchantpay integration

To use it you will need to attach the _emerchantpay Gateway_ to a form and map the _Amount_, _Currency_, _Number of Items_, _Record Status_, _Record Payment Unique ID_ and _Consumer Details_ with matching form fields, then configure the event handlers
for payment successfully processed, failed or cancelled.

When a form is submitted on the website, the workflow will execute and based on it's settings, two data payloads will be sent to emerchantpay for creating or retrieving the details of a consumer, and for creating a payment.
The response for the second request will provide the URL for the hosted payment page, and the user will the redirected there.

On completing the payment the emerchantpay API will return the user to the page provided in matching event handler of the workflow.
