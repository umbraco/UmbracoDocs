---
description: >-
  Version-specific documentation for upgrading to new major versions of Umbraco
  Commerce.
---

# Version Specific Upgrade Notes

This page covers specific upgrade documentation for migrating to new major versions of Umbraco Commerce.

{% hint style="info" %}
If you are upgrading to a new minor or patch version, you can find information about the breaking changes in the [Release Notes](../release-notes.md) article.
{% endhint %}

## Version Specific Upgrade Notes History

#### 19.0.0

Umbraco Commerce 19 requires Umbraco CMS 19 and .NET 11. Upgrade the CMS first, then update every `Umbraco.Commerce.*` package to version 19.

**Payment callback URLs**

* The legacy payment route `/umbraco/commerce/payment/{action}/...` has been removed. Payments are now served only by the Payment API at `/umbraco/commerce/payment/api/v1/{action}/...`.
* Version 18 already generated the new URLs for new payments, so checkouts in progress are not affected.
* Update any webhook or return URL you entered by hand in a payment gateway dashboard. For example, change `/umbraco/commerce/payment/callback/stripe-checkout/{payment_method_id}/` to `/umbraco/commerce/payment/api/v1/callback/stripe-checkout/{payment_method_id}`.
* Before upgrading, search your version 18 logs for `The legacy payments API is obsolete`. Matches show gateways still calling the old route.
* `UmbracoCommerceRequestBufferingMiddleware` is no longer registered. If your site calls `UseMiddleware<UmbracoCommerceRequestBufferingMiddleware>()`, remove the call.

**Examine replaced by Umbraco Search**

Umbraco CMS 19 replaces Examine with Umbraco Search. Umbraco Commerce follows this change:

* `UmbracoLuceneStoreFinder` has been removed. Use `UmbracoNavigationStoreFinder`. `WithUmbracoNodeStoreFinders()` keeps the same order.
* `UmbracoCommerceExamineHelper` has been removed. Use `UmbracoCommerceSearchHelper`.
* The `UmbracoProductAdapter` constructor takes `UmbracoCommerceSearchHelper` instead of `IExamineManager`. Update any custom product adapter that inherits from it.
* The `Umbraco.Commerce.Cms.Examine` namespace has been removed.
* Backoffice product search is now full-text across all fields. SKU matches are exact and case-insensitive.

**Management API**

* The version 1 and version 2 `PUT orders/{id}/refund-payment` endpoints have been removed. Use version 3.
* Version 3 of the refund endpoint now requires `refundReason`. A request without it returns `400 Bad Request`.
* The keys of `customProperties` on customers are returned exactly as stored. The same applies to `properties` on orders, carts, order lines, products and gift cards. They are no longer converted to camel case.
* The customer endpoints no longer return `isRegistered`, `isUmbracoMember` or `properties`. Use `customProperties` and `memberKey`.
* The Storefront API is not affected by the property key change.

**Storefront API deprecations**

The following endpoints still work but are deprecated and will be removed in version 21:

* Version 1 of the payment method and shipping method endpoints. Use version 2.
* `country/{id}/paymentmethods` and `country/{id}/shippingmethods`, including the region variants. Use `checkout/{orderId}/paymentmethods` and `checkout/{orderId}/shippingmethods`.
* `country/{id}/currencies`. Use `currencies?filter=allowedInCountry:{idOrAlias}`.

**Removed obsolete code**

Members marked obsolete for removal in version 19 or earlier have been removed. The changes most likely to affect custom code are:

* The `[PaymentProvider(alias, name, description)]` and `[AdvancedFilter(alias, name, description)]` constructors have been removed. Use the constructor that takes only the alias. Set labels and descriptions through [Localization](../key-concepts/payment-providers.md#localization).
* `Name` has been renamed to `Label` on payment provider, advanced filter, metadata and setting definitions.
* The `IUmbracoBuilder` pipeline shortcuts, such as `builder.WithCalculateOrderPipeline()`, have been removed. Use `builder.WithUmbracoCommerceBuilder().WithCalculateOrderPipeline()` instead.
* The `ContentUdi` property of `ProductVariantItem` has been removed. Use `ContentKey`.
* `CountryRegionTaxRate` has been removed. Use `CountryRegionTaxClass`.
* The constructors that take an `IRoundingService` have been removed from the calculators, `PaymentService` and the order pipeline tasks.
* The misspelled `SqlServerDbUpUprgadeEngineFactory` class has been removed. Use `SqlServerDbUpUpgradeEngineFactory`.

**Backoffice extensions**

* The `uc-*` property editors now dispatch a `change` event (`UmbChangeEvent`) instead of `property-value-change`. Update any markup that listens for the old event.

#### 17.0.0

*   The default property aliases for Customer Comments and Internal Notes have changed: `comments` is now `customerNotes`, and `notes` is now `internalNotes`. After upgrading from v13, existing data still lives in the database under the old aliases, so these fields appear empty in the v17 backoffice. To restore visibility without a database migration, remap the fields back to the original aliases in your composer using `OrderPropertyConfig`:

    ```csharp
    builder.WithOrderPropertyConfigs()
        .UpdateDefault(cfg => cfg
            .For(x => x.Notes.CustomerNotes).MapFrom("comments")
            .For(x => x.Notes.InternalNotes).MapFrom("notes"));
    ```

    Or scope to a single store with `.Update("yourStoreAlias", cfg => …)` instead of `UpdateDefault`. This remap covers both reads (backoffice display) and writes (saving edits).

## Legacy version specific upgrade notes

You can find the version-specific upgrade notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/tree/umbraco-eol-versions).
