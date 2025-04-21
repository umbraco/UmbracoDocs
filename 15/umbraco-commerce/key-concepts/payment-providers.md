---
description: Accepting payments via Payment Providers in Umbraco Commerce.
---

# Payment Providers

Payment Providers are how Umbraco Commerce is able to accept multiple different methods of payment on a Site. Their job is to provide a standard interface between third-party payment gateways and Umbraco Commerce itself. This is done in order to allow the passing of information between the two platforms.

How the integrations work is often different for each payment gateway. The Umbraco Commerce Payment Providers add a flexible interface that should be able to work with most payment gateways.

## Example Payment Provider

An example of a bare-bones Payment Provider would look something like this:

```csharp
[PaymentProvider("my-payment-provider-alias")]
public class MyPaymentProvider :  AsyncPaymentProviderBase<MyPaymentProviderSettings>
{
    public MyPaymentProvider(UmbracoCommerceContext umbracoCommerce)
        : base(umbracoCommerce)
    { }

    ...
}

public class MyPaymentProviderSettings
{
    [PaymentProviderSetting(SortOrder = 100)]
    public string ContinueUrl { get; set; }

    ...
}

```

All Payment Providers inherit from a base class `AsyncPaymentProviderBase<TSettings>`. `TSettings` is the type of a Plain Old Class Object (POCO) model class representing the Payment Provider's settings. The class must be decorated with `PaymentProviderAttribute` which defines the Payment Providers `alias`.

The settings class consists of a series of properties, each decorated with a `PaymentProviderSettingAttribute`. These will all be used to dynamically build an editor interface for the given settings in the backoffice.

Labels and descriptions for providers and their settings are controlled through [Localization](#localization) entries.

## Payment Provider Responsibilities

There are two main responsibilities of a Payment Provider, and those are:

* **Payment Capture** - Capturing the initial Order payment and finalizing the Order.
* **Payment Management** - Managing a payment post Order finalization, such as being able to Capture authorized payments or Refunding captured payments.

### Payment Capture

The Payment Capture workflow can be the hardest part of a Payment Provider. This is due to the fact that no two payment gateways are alike. Therefore it can be difficult to figure out how best to implement the gateway into the provider format.

Generally, there are three methods within a Payment Provider that you may need to implement, and each one has a specific responsibility.

* **GenerateFormAsync** - The `GenerateFormAsync` method generates an HTML form that will redirect the customer to the given payment gateway payment form. In this method you may need to communicate with the payment gateway to initialize a payment, letting the payment gateway know how much to capture. This often results in some kind of code or redirect URL being returned which will need to be embedded into the generated form. The form appears on a checkout **Review** page before payment, featuring a **Continue to Payment** button to submit the form and redirect to the gateway.
* **ProcessCallbackAsync** - The `ProcessCallbackAsync` method handles the response coming back from the payment gateway and processing whether the payment was successful or not. This can occur _synchronously_, if the payment gateway sends information back during the confirmation page redirect. It can also occur _asynchronously_ if the payment gateway sends the information back via an out-of-band webhook request.
* **GetOrderReferenceAsync** - The `GetOrderReferenceAsync` method extracts an order reference number from a request when a payment gateway uses an asynchronous webhook to finalize an order.  This method is specifically used where the payment gateway uses a global webhook URL strategy for all notifications rather than a notification URL per transaction. Where a webhook URL can be passed per transaction, then Umbraco Commerce provides a unique callback URL that identifies the order reference as part of the URL parameters. When using the per transaction URL provided, implementing this method becomes unnecessary.

_\* denotes a required method implementation_.

What follows is a generalized diagram in order to help in visualizing when each of these methods is called within a regular checkout flow.

![Payment Provider Capture Workflow](../media/payment\_provider\_capture\_flow.png)

### Payment Management

In addition to the initial payment capture flow, Payment Providers can also be set up to manage the payment post-checkout. This could be Capturing Authorized transactions or Refunding Captured transactions.

These features are optional and not required for Payment Provider developers to implement. They allow store owners to manage payments directly in the backoffice rather than through the payment gateway's portal when performing these types of actions.

The implementable management methods are:

* **FetchPaymentStatusAsync** - The `FetchPaymentStatusAsync` method communicates with the 3rd party payment gateway in order to fetch the current status of the given transaction.
* **CapturePaymentAsync** - The `CapturePaymentAsync` method communicates with the 3rd party payment gateway to capture a previously authorized payment associated with the given transaction.
* **CancelPaymentAsync** - The `CancelPaymentAsync` method communicates with the 3rd party payment gateway to cancel a previously authorized payment associated with the given transaction.
* **RefundPaymentAsync** - The `RefundPaymentAsync` method communicates with the 3rd party payment gateway to refund a previously captured payment associated with the given transaction. The implementation of this method typically sends a refund request to the 3rd party payment gateway, then either returns a non-null `Umbraco.Commerce.Core.PaymentProviders.ApiResult`—allowing Umbraco Commerce to update the payment details—or throws an exception to indicate that the refund action should be ignored. This method supports both full and partial refunds.

For each implemented method above, developers should also implement a corresponding boolean property returning a `true` value. This is to let Umbraco Commerce know that the given feature is supported by the Payment Provider.

* **CanFetchPaymentStatus**
* **CanCapturePayments**
* **CanCancelPayments**
* **CanRefundPayments**
* **CanPartiallyRefundPayments** (*available from version 15.3.0*)

## Payment Provider Meta Data

For all implemented methods of a Payment Provider, all method return types support the returning of additional Meta Data. This is to allow Payment Providers to capture and store relevant information. This information will aid the provider in doing its job, or for storing useful reference information to display for the retailer.

Any returned Meta Data from a Payment Provider method will be stored against the Order in its [Properties](properties.md) collection. Should you need to retrieve these values from other areas of the Payment Provider, you can use the passed-in Orders Properties collection.

{% hint style="info" %}
As Meta Data is stored in Orders Properties collections, it is recommended to prefix your Meta Data keys with the Payment Providers alias. This is done to prevent possible conflicts.
{% endhint %}

### Meta Data Definitions

The Meta Data that is returned from the Payment Provider is useful for the retailer. The Payment Provider can also be used to display Meta Data in the backoffice. This is done by exposing a `TransactionMetaDataDefinitions` property consisting of a list of `TransactionMetaDataDefinition` values, each with a unique `alias.

```csharp
public override IEnumerable<TransactionMetaDataDefinition> TransactionMetaDataDefinitions => new[]{
    new TransactionMetaDataDefinition("stripeSessionId"),
    new TransactionMetaDataDefinition("stripePaymentIntentId"),
    new TransactionMetaDataDefinition("stripeChargeId"),
    new TransactionMetaDataDefinition("stripeCardCountry")
};
```

![Transaction Meta Data](../media/transaction\_meta\_data\_dialog.png)

Labels and descriptions for meta data fields are controlled through [Localization](#localization) entries.

## Localization

When displaying your provider in the backoffice UI, it is neceserray to provide localizable labels. This is controlled by Umbraco's [UI Localization](https://docs.umbraco.com/umbraco-cms/extending/language-files/ui-localization) feature.

Umbraco Commerce will automatically look for the following entries:

| Key |  Description |
| --- | --- | 
| `ucPaymentProviders_{providerAlias}Label` | A main label for the provider |
| `ucPaymentProviders_{providerAlias}Description` | A description of the provider |
| `ucPaymentProviders_{providerAlias}Settings{settingAlias}Label` | A label for a provider setting |
| `ucPaymentProviders_{providerAlias}Settings{settingAlias}Description` | A description of a provider setting |
| `ucPaymentProviders_{providerAlias}MetaData{metaDataAlias}Label` | A label for a provider transaction metadata item |
| `ucPaymentProviders_{providerAlias}MetaData{metaDataAlias}Description` | A description of a provider transaction metadata item |

Here `{providerAlias}` is the alias of the provider, `{settingAlias}` is the alias of a setting, and `{metaDataAlias}` is the alias of a transaction meta data item.