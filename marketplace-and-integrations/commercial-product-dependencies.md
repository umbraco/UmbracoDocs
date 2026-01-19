---
description: Describes the Umbraco commercial products, their dependencies and relations.
---

# Commercial Products, Relations, and Dependencies

The following diagram shows the Umbraco commercial products, their dependencies, and the relations between them. Depending on your setup, you may need one or more of the additional packages shown here when working with them.

```mermaid
graph LR
    CMS["Umbraco.CMS"]
    
    CMS --> Forms["Umbraco.Forms"]
    CMS --> Licensing["Umbraco.Licensing"]
    CMS --> Deploy["Umbraco.Deploy"]
    CMS --> Workflow["Umbraco.Workflow"]
    CMS --> Commerce["Umbraco.Commerce"]
    
    Forms --> FormsDeploy["Umbraco.Forms.Deploy"]
    Deploy --> DeployControls["Umbraco.Deploy.Controls"]
    
    Engage["Umbraco.Engage"]
    Engage --> EngageForms["Umbraco.Engage.Forms"]
    Engage --> UIBuilder["Umbraco.UI.Builder"]
    
    CMS --> Engage
    EngageForms --> Engage
    
    Licensing --> UIBuilder
    
    Commerce --> CommerceDeploy["Umbraco.Commerce.Deploy"]
    Commerce --> CommerceCheckout["Umbraco.Commerce.Checkout"]
    Commerce --> CommercePaymentProviders["Umbraco.Commerce.Payment.Providers"]
    Commerce --> CommerceShippingProviders["Umbraco.Commerce.Shipping.Providers"]
    Commerce --> CommerceTaxProviders["Umbraco.Commerce.Tax.Providers"]
    
    CommercePaymentProviders --> Stripe["Stripe"]
    CommercePaymentProviders --> QuickPay["QuickPay"]
    CommercePaymentProviders --> Mollie["Mollie"]
    CommercePaymentProviders --> Opayo["Opayo"]
    CommercePaymentProviders --> Klarna["Klarna"]
    CommercePaymentProviders --> Worldpay["Worldpay"]
    CommercePaymentProviders --> PayPal["PayPal"]
    CommercePaymentProviders --> Buckaroo["Buckaroo"]
    
    CommerceShippingProviders --> DHL["DHL"]
    CommerceShippingProviders --> Shipmonodo["Shipmonodo"]
    CommerceShippingProviders --> EasyPost["EasyPost"]
    
    CommerceTaxProviders --> TaxJar["TaxJar"]
    
    EngageCommerce["Umbraco.Engage.Commerce"]
    EngageCommerce --> CommercePaymentProviders
```

Explanatory notes:

* `Umbraco.Licensing` supports the older licensing mechanism for Umbraco's products, including Forms and Deploy, when used on Umbraco Cloud.
* `Umbraco.Licenses` is the newer component supporting subscription licensing, used for Forms, Workflow, Commerce, and Deploy version 12 and above when used on-premise.
