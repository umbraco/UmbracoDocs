# Table of contents

* [Umbraco Commerce Documentation](README.md)
* [Release Notes](release-notes/README.md)

## Commerce Products

* [Commerce Packages](https://docs.umbraco.com/umbraco-commerce-packages)
* [Commerce Payment Providers](https://docs.umbraco.com/umbraco-commerce-payment-providers)
* [Commerce Shipping Providers](https://docs.umbraco.com/umbraco-commerce-shipping-providers)

## Getting Started

* [Requirements](getting-started/requirements.md)
* [Installation](getting-started/install.md)
* [Licensing](getting-started/the-licensing-model.md)
* [Configuration](getting-started/umbraco-configuration.md)
* [User Interface](getting-started/user-interface.md)

## Upgrading

* [Upgrading Umbraco Commerce](upgrading/upgrade.md)
* [Version Specific Upgrade Notes](upgrading/version-specific-upgrades.md)
* [Migrate from Vendr to Umbraco Commerce](upgrading/migrate-from-vendr-to-umbraco-commerce/README.md)
  * [Migrate Umbraco Commerce Checkout](upgrading/migrate-from-vendr-to-umbraco-commerce/migrate-umbraco-commerce-checkout.md)
  * [Migrate custom Payment Providers](upgrading/migrate-from-vendr-to-umbraco-commerce/migrate-custom-payment-providers.md)

## Tutorials

* [Build a Store in Umbraco using Umbraco Commerce](tutorials/build-a-store/README.md)
  * [Installation](tutorials/build-a-store/installation.md)
  * [Creating a Store](tutorials/build-a-store/create-store.md)
    * [Configuring your Store](tutorials/build-a-store/configure-store.md)
  * [Creating your first Product](tutorials/build-a-store/create-product.md)
  * [Implementing a Shopping Cart](tutorials/build-a-store/cart.md)
    * [Using the Umbraco.Commerce.Cart Drop-in Shopping Cart](https://docs.umbraco.com/umbraco-commerce-packages/cart/cart)
    * [Creating a Custom Shopping Cart](tutorials/build-a-store/custom-cart.md)
  * [Implementing a Checkout Flow](tutorials/build-a-store/checkout.md)
    * [Using the Umbraco.Commerce.Checkout Drop-in Checkout Flow](https://docs.umbraco.com/umbraco-commerce-packages/checkout/checkout)
    * [Creating a Custom Checkout Flow](tutorials/build-a-store/custom-checkout.md)
  * [Configuring Store Access Permissions](tutorials/build-a-store/permissions.md)

## How-To Guides

* [Overview](how-to-guides/overview.md)
* [Configure SQLite support](how-to-guides/configure-sqlite-support.md)
* [Use an Alternative Database for Umbraco Commerce Tables](how-to-guides/use-an-alternative-database-for-umbraco-commerce-tables.md)
* [Customizing Templates](how-to-guides/customizing-templates.md)
* [Configuring Cart Cleanup](how-to-guides/configuring-cart-cleanup.md)
* [Configuring Abandoned Carts Notification](how-to-guides/configuring-abandoned-cart-notification.md)
* [Limit Order Line Quantity](how-to-guides/limit-orderline-quantity.md)
* [Implementing Product Bundles](how-to-guides/product-bundles.md)
* [Implementing Member Based Pricing](how-to-guides/member-based-pricing.md)
* [Implementing Dynamically Priced Products](how-to-guides/dynamically-priced-products.md)
* [Implementing Personalized Products](how-to-guides/personalized-products.md)
* [Implementing a Currency Switcher](how-to-guides/currency-switching.md)
* [Building a Members Portal](how-to-guides/member-portal.md)
* [Order Number Customization](how-to-guides/order-number-customization.md)
* [Sending Payment Links to Customers](how-to-guides/payment-links.md)
* [Create an Order via Code](how-to-guides/create-order-via-code.md)
* [Show Discounted Prices on Product Pages](how-to-guides/show-discounted-prices.md)

## Key Concepts

* [Get to know the main features](key-concepts/overview.md)
* [Base Currency](key-concepts/base-currency.md)
* [Calculators](key-concepts/calculators.md)
* [Currency Exchange Rate Service Provider](key-concepts/currency-exchange-rate-service-providers.md)
* [Dependency Injection](key-concepts/dependency-injection.md)
* [Discount Rules / Rewards](key-concepts/discount-rules-and-rewards.md)
* [Events](key-concepts/events/README.md)
  * [List of validation events](key-concepts/events/list-of-validation-events.md)
  * [List of notification events](key-concepts/events/list-of-notification-events.md)
* [Fluent API](key-concepts/fluent-api.md)
* [Order Calculation State](key-concepts/order-calculation-state.md)
* [Payment Forms](key-concepts/payment-forms.md)
* [Payment Providers](key-concepts/payment-providers.md)
* [Pipelines](key-concepts/pipelines.md)
* [Price/Amount Adjustments](key-concepts/price-amount-adjustments.md)
* [Price Freezing](key-concepts/price-freezing.md)
* [Product Adapters](key-concepts/product-adapters.md)
* [Product Bundles](key-concepts/product-bundles.md)
* [Product Variants](key-concepts/product-variants/README.md)
  * [Complex Variants](key-concepts/product-variants/complex-variants.md)
* [Properties](key-concepts/properties.md)
* [ReadOnly and Writable Entities](key-concepts/readonly-and-writable-entities.md)
* [Sales Tax Providers](key-concepts/sales-tax-providers.md)
* [Search Specifications](key-concepts/search-specifications.md)
* [Settings Objects](key-concepts/settings-objects.md)
* [Shipping Package Factories](key-concepts/shipping-package-factories.md)
* [Shipping Providers](key-concepts/shipping-providers.md)
* [Shipping Range/Rate Providers](key-concepts/shipping-range-and-rate-providers.md)
* [Tax Sources](key-concepts/tax-sources.md)
* [UI Extensions](key-concepts/ui-extensions/README.md)
  * [Analytics Widgets](key-concepts/ui-extensions/analytics-widgets.md)
  * [Entity Quick Actions](key-concepts/ui-extensions/entity-quick-actions.md)
  * [Order Line Actions](key-concepts/ui-extensions/order-line-actions.md)
  * [Order Properties](key-concepts/ui-extensions/order-properties.md)
  * [Order Collection Properties](key-concepts/ui-extensions/order-collection-properties.md)
  * [Order Line Properties](key-concepts/ui-extensions/order-line-properties.md)
  * [Store Menu Items](key-concepts/ui-extensions/store-menu-items.md)
* [Umbraco Properties](key-concepts/umbraco-properties.md)
* [Unit of Work](key-concepts/unit-of-work.md)
* [Umbraco Commerce Builder](key-concepts/umbraco-commerce-builder.md)
* [Webhooks](key-concepts/webhooks.md)

## Reference

* [Stores](reference/stores/README.md)
* [Shipping](reference/shipping/README.md)
  * [Fixed Rate Shipping](reference/shipping/fixed-rate-shipping.md)
  * [Dynamic Rate Shipping](reference/shipping/dynamic-rate-shipping.md)
  * [Realtime Rate Shipping](reference/shipping/realtime-rate-shipping.md)
* [Taxes](reference/taxes/README.md)
  * [Fixed Tax Rates](reference/taxes/fixed-tax-rates.md)
  * [Calculated Tax Rates](reference/taxes/calculated-tax-rates.md)
* [Storefront API](reference/storefront-api/README.md)
  * [Endpoints](reference/storefront-api/endpoints/README.md)
    * [Order](reference/storefront-api/endpoints/order.md)
    * [Checkout](reference/storefront-api/endpoints/checkout.md)
    * [Product](reference/storefront-api/endpoints/product.md)
    * [Customer](reference/storefront-api/endpoints/customer.md)
    * [Store](reference/storefront-api/endpoints/store.md)
    * [Currency](reference/storefront-api/endpoints/currency.md)
    * [Country](reference/storefront-api/endpoints/country.md)
    * [Payment method](reference/storefront-api/endpoints/payment-method.md)
    * [Shipping method](reference/storefront-api/endpoints/shipping-method.md)
    * [Content](reference/storefront-api/endpoints/content.md)
* [Management API](reference/management-api/README.md)
* [Go behind the scenes](reference/go-behind-the-scenes.md)
* [Telemetry](reference/telemetry.md)
