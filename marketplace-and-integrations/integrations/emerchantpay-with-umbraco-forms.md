---
description: >-
  Details an integration available for emerchantpay with Umbraco Forms, built
  and maintained by Umbraco HQ.
---

# emerchantpay With Umbraco Forms

This integration provides a custom workflow for handling online payments using a hosted payment page provided by emerchantpay.

## Package Links

* [NuGet install](https://www.nuget.org/packages/Umbraco.Forms.Integrations.Commerce.emerchantpay)
* [Source code](https://github.com/umbraco/Umbraco.Forms.Integrations/tree/main-v10/src/Umbraco.Forms.Integrations.Commerce.EMerchantPay)
* [Umbraco marketplace listing](https://marketplace.umbraco.com/package/umbraco.forms.integrations.commerce.emerchantpay)

## Minimum version requirements

### Umbraco CMS

To ensure compatibility, check the **Dependencies** tab on NuGet for the required Umbraco CMS version. For example, see [Umbraco.Forms.Integrations.Commerce.emerchantpay](https://www.nuget.org/packages/Umbraco.Forms.Integrations.Commerce.emerchantpay#dependencies-body-tab).

## How To Use

To get started with _emerchantpay_ a merchant needs to be onboarded. This will allow you to get a merchant ID and obtain the keys required by the integration.

To begin the onboarding process and obtain the merchant account, you need to fill out [this](https://www.emerchantpay.com/contact-us/?utm_source__c=umbraco_referral&utm_medium__c=technical_blog&utm_campaign__c=Umbraco) form.

Afterwards, a member of the _emerchantpay_ team will reach out to you.

### Authentication

All requests to emerchantpay API are authenticated by providing the merchant's username and password.

If the configuration is incomplete, the user will receive an error message.

### Configuration

The below configuration is required. It consists of authentication settings, merchant specific details and customizable payment fields. Some configuration items are stored as an array of strings or a dictionary, and parsed using a specific service.

{% tabs %}
{% tab title="Versions 9 and above" %}
{% code title="appsettings.json" %}
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
{% endcode %}
{% endtab %}

{% tab title="Version 8" %}
{% code title="web.config" %}
```xml
<appSettings>
...
  <add key="Umbraco.Forms.Integrations.Commerce.eMerchantPay.GatewayBaseurl" value="https://staging.gate.emerchantpay.net/"/>
  <add key="Umbraco.Forms.Integrations.Commerce.eMerchantPay.WpfUrl" value="https://staging.wpf.emerchantpay.net/wpf"/>
  <add key="Umbraco.Forms.Integrations.Commerce.eMerchantPay.Username" value="[your_merchant_username]"/>
  <add key="Umbraco.Forms.Integrations.Commerce.eMerchantPay.Password" value="[your_merchant_password]"/>
  <add key="Umbraco.Forms.Integrations.Commerce.eMerchantPay.UmbracoBaseUrl" value="[your_website_url]"/>
  <add key="Umbraco.Forms.Integrations.Commerce.eMerchantPay.Supplier" value="Umbraco"/>
  <add key="Umbraco.Forms.Integrations.Commerce.eMerchantPay.Usage" value="Payment Gateway using Umbraco Forms"/>
  <add key="Umbraco.Forms.Integrations.Commerce.eMerchantPay.Currencies" value="USD,US Dollar;EUR,Euro;GBP,British Pound;DKK,Danish Krone"/>
  <add key="Umbraco.Forms.Integrations.Commerce.eMerchantPay.TransactionTypes" value="authorize;sale"/>
  <add key="Umbraco.Forms.Integrations.Commerce.eMerchantPay.MappingFields" value="Email;FirstName;LastName"/>
...
</appSettings>
```
{% endcode %}
{% endtab %}
{% endtabs %}

### Working with the integration

Follow the steps below to start using the integration.

1. Attach the _emerchantpay Gateway_ workflow to a form.
2. Map the following values with matching form fields:
   * _Amount_&#x20;
   * _Currency_
   * _Number of Items_
   * _Record Status_
   * _Record Payment Unique ID_
   * _Consumer Details_
3. Configure the event handlers for payment successfully processed, failed, or canceled.

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

The response for the second request will provide the URL for the hosted payment page, and the user will be redirected there.

On completing the payment the emerchantpay API will return the user to the page provided in the matching event handler of the workflow.
