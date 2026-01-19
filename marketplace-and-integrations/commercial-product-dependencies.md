---
description: Describes the Umbraco commercial products, their dependencies and relations.
---

# Commercial Products, Relations, and Dependencies

The following diagram shows the Umbraco commercial products, their dependencies, and the relations between them. Depending on your setup, you may need one or more of the additional packages shown here when working with them.

```mermaid
graph RL
    subgraph Core
        CMS["Umbraco.CMS"]
        Licenses["Umbraco.Licenses"]
        Licenses --> CMS
    end

    subgraph "Commercial Products"
        Deploy["Umbraco.Deploy"]
        Forms["Umbraco.Forms"]
        Engage["Umbraco.Engage"]
        Commerce["Umbraco.Commerce"]
        Workflow["Umbraco.Workflow"]
        UIBuilder["Umbraco.UIBuilder"]
    end

    Deploy --> Licenses
    Forms --> Licenses
    Engage --> Licenses
    Workflow --> Licenses
    UIBuilder --> Licenses
    Commerce --> Licenses

    subgraph "Integration Packages"
        FormsDeploy["Umbraco.Forms.Deploy"]
        EngageDeploy["Umbraco.Engage.Deploy"]
        EngageForms["Umbraco.Engage.Forms"]
        EngageCommerce["Umbraco.Engage.Commerce"]
        CommerceDeploy["Umbraco.Commerce.Deploy"]
    end

    FormsDeploy --> Forms
    FormsDeploy --> Deploy
    EngageDeploy --> Engage
    EngageDeploy --> Deploy
    EngageForms --> Engage
    EngageForms --> Forms
    EngageCommerce --> Engage
    EngageCommerce --> Commerce
    CommerceDeploy --> Commerce

    subgraph "Commerce Extensions"
        CommerceCheckout["Umbraco.Commerce.Checkout"]
        CommercePaymentProviders["Umbraco.Commerce.Payment.Providers"]
        CommerceShippingProviders["Umbraco.Commerce.Shipping.Providers"]
        CommerceTaxProviders["Umbraco.Commerce.Tax.Providers"]
    end

    CommerceCheckout --> Commerce
    CommercePaymentProviders --> Commerce
    CommerceShippingProviders --> Commerce
    CommerceTaxProviders --> Commerce

    subgraph "Payment Providers"
        Stripe & QuickPay & Mollie & Opayo & Klarna & Worldpay & PayPal & Buckaroo
    end
    Stripe & QuickPay & Mollie & Opayo --> CommercePaymentProviders
    Klarna & Worldpay & PayPal & Buckaroo --> CommercePaymentProviders

    subgraph "Shipping Providers"
        DHL & Shipmondo & EasyPost
    end
    DHL & Shipmondo & EasyPost --> CommerceShippingProviders

    subgraph "Tax Providers"
        TaxJar --> CommerceTaxProviders
    end
```

Explanatory notes:

* `Umbraco.Licensing` supports the older licensing mechanism for Umbraco's products, including Forms and Deploy, when used on Umbraco Cloud.
* `Umbraco.Licenses` is the newer component supporting subscription licensing, used for Forms, Workflow, Commerce, and Deploy version 12 and above when used on-premise.
