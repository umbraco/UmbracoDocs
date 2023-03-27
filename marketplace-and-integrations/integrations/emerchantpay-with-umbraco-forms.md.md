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

To get started with _emerchantpay_ a merchant needs to be onboarded. This will allow you to get a merchant ID and obtain the keys required by the integration.

To begin the onboarding process an obtain the merchant account, you need to fill out [this](https://www.emerchantpay.com/contact-us?utm_source__c=umbraco_referral&utm_medium__c=technical_blog&utm_campaign__c=Umbraco) form.

Afterwards, a member of the _emerchantpay_ team will reach out to you.

### Authentication

All requests to emerchantpay API are authenticated by providing the merchant's username and password.

If the configuration is incomplete, the user will receive an error message.

### Configuration

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

To use it you will need to attach the _emerchantpay Gateway_ workflow to a form. Then map the _Amount_, _Currency_, _Number of Items_, _Record Status_, _Record Payment Unique ID_ and _Consumer Details_ with matching form fields. Finally, configure the event handlers for payment successfully processed, failed or cancelled.

A consumer has the following properties available that can be mapped against form fields:

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


When a form is submitted on the website, the workflow will execute. Two data payloads will be sent to emerchantpay. One for creating or retrieving the details of a consumer and the other for creating a payment.

The response for the second request will provide the URL for the hosted payment page, and the user will the redirected there.

On completing the payment the emerchantpay API will return the user to the page provided in matching event handler of the workflow.
