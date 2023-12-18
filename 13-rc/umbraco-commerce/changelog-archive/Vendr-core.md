---
title: Changelog
description: Changelog for the Core Vendr product
---

# Changelog

### v3.0.11

**Date:** 2023-03-22\
**Description:** Patch release with minor bug fixes and non-breaking enhancements

* Fixed a bug where order line quantities were being multiplied by 10 due to culture-related issues ([#405](https://github.com/vendrhub/vendr/issues/405)).
* Fixed bug Vendr tree would vanish if installed with Umbraco Workflow due to controllers having the same class name. All Vendr trees have now been prefixed with `Vendr` ([#408](https://github.com/vendrhub/vendr/issues/408)).
* Fixed bug where date-based order advanced filters used UTC time when all other front-end dates were in local time. Vendr now converts the dates to UTC before applying the filters ([#406](https://github.com/vendrhub/vendr/issues/406)).
* Changed the default product adapter to also search child variants names, not just SKUs.
* Changed the multi-variants property editor to construct an SKU from the parent node if the variant node doesn't have an SKU defined.

### v3.0.10

**Date:** 2023-02-24\
**Description:** Patch release with minor bug fixes and non-breaking enhancements

* Fixed issue where discount codes wouldn't persist changes when being updated.

### v3.0.8/9

**Date:** 2023-02-14\
**Description:** Patch release with minor bug fixes and non-breaking enhancements

* Added debug symbols to NuGet packages.
* Fixed session manager incorrectly storing the default shipping method in the default shipping country cookie value ([#404](https://github.com/vendrhub/vendr/issues/404)).

### v3.0.7

**Date:** 2023-02-07\
**Description:** Patch release with minor bug fixes and non-breaking enhancements

* Added extra logging around payment request handler failures.
* Fixed error when processing payment requests and an order number can't be found. Now returns 200 status to allow webhook notification to stop, but logs the error locally.

### v3.0.6

**Date:** 2023-01-16\
**Description:** Patch release with minor bug fixes and non-breaking enhancements

* Added an extra `CalculatePrice` extension method to `IProductSnapshot` that can accept a current order as a reference to save on processing if a current order is known to exist.
* The product Attribute value sort order is now correctly honored.
* Fixed entity controllers actions not working for users with the only `Commerce` role assigned. We misunderstood how the authorize attribute works as we assumed it enforced them as an OR operation, but it appears it enforces them as an `AND` operation and so we now have an explicit `SettingsOrCommerce` section policy.

### v3.0.5

**Date:** 2022-12-01\
**Description:** Patch release with minor bug fixes and non-breaking enhancements

* Added readme for new Umbraco marketplace.
* Changed the product adapter so that it only searches for published products.
* Fixed an issue where calls to entity services inside event handlers didn't have the most up-to-date entity because the temporary cache wasn't pushed back before the event handlers were called.
* Fixed the telemetry data service failing in Umbraco v11 due to it using an obsolete constructor that got removed in v11.
* Fixed the product adapter search not working for multi-word phrases.
* Fixed bug with price property editor erroring if there is no fraction config.

### v3.0.4

**Date:** 2022-11-08\
**Description:** Patch release with minor bug fixes and non-breaking enhancements

* Added Umbraco marketplace tag to main NuGet package.
* Check `X-Forwarded-Host` when determining the base URL for payment provider links.
* Re-cache the order state if the order changes during save events.
* Fixed error when order properties are searched when not in the correct `alias:value` format. Now ignores values not in this format.
* Fixed the tags order filter not actually taking supplied tag values into account.

### v3.0.3

**Date:** 2022-10-17\
**Description:** Patch release with minor bug fixes and non-breaking enhancements

* Fixed error screen when using dictionary input fields due to the resolution of a scoped service from a singleton ([#392](https://github.com/vendrhub/vendr/issues/392)).
* Fixed error screen when generating models builder models in Umbraco 10.3.0 RC due to changes in block editor base classes ([#393](https://github.com/vendrhub/vendr/issues/393)).

### v3.0.2

**Date:** 2022-10-11\
**Description:** Patch release with minor bug fixes and non-breaking enhancements

* Fixed issue when deleting allowed shipping method countries causing an error due to them referencing a `paymentMethodId` in their SQL statements rather than `shippingMethodId`.
* Fixed issue with NPoco `ExecuteScalar` not handling Guid conversions.
* Fixed bug in the order list not pulling back child entities correctly due to an inner join having its order by clause removed causing a miss-match of orders being fetched.
* Fixed issue where joins with an order by's would throw an exception if there wasn't an offset applied to the query. We now always apply an offset, even if one isn't necessary.
* Fixed bug where `BeginPaymentForm` would overwrite the customer reference if one was already set. It now only sets the customer reference if one isn't already present.

### v3.0.1

**Date:** 2022-09-29\
**Description:** Patch release with minor bug fixes and non-breaking enhancements

* Fixed DB migration error due to `DF__vendrOrderLine__quantity` prevent a migration step to execute when migrating from a v2 install.
* Fixed bug where Azure would automatically use `System.Data.SqlClient` when it should use `Microsoft.Data.SqlClient`
* Fixed Vendr health checks failing due to shipping method exception ([#388](https://github.com/vendrhub/vendr/issues/388)).
* Fixed `Unit of work has already been completed` error when creating all countries from the ISO country list ([#389](https://github.com/vendrhub/vendr/issues/389)).

## v3.0.0

**Date:** 2022-09-21\
**Description:** Minor release with additional features and bug fixes

* Added `IVendrBuilder` concept to encapsulate Vendr's build configuration.
* Added option SQLite support for testing purposes.
* Added ability to store Vendr data in the alternative database to Umbraco.
* Added optimistic concurrency checks to ensure an entity hasn't changed since the last save.
* Added databased indexes on all `storeId` and `orderId` columns to aid performance.
* Added async support to `BeginPaymentForm` extension.
* Added support for bundle base price adjustments.
* Added new `BundleOrderLine` and `BundledOrderLine` entities for strongly typed access to bundle-specific features.
* Added new `IsBundle` and `GetBundles` methods to make working with bundles easier.
* Added default values support to payment provider/discount settings objects.
* Changed Umbraco dependency persistence layer for our own implementation.
* Changed Unit of Work to use an `Execute` method rather than using the `Create` method in a using statement.
* Changed `AsWritable` to automatically fetch the latest entity from the database instead of copying the in-memory state.
* Fixed issue where reverting a cart would revert stock levels when this should only occur for finalized orders.
* Dropped Umbraco v8 and v9 support
* Retargeted for Umbraco v10+

### v2.4.1

**Date:** 2022-10-11\
**Description:** Patch release with minor bug fixes and non-breaking enhancements

* Fixed bug where `BeginPaymentForm` would overwrite the customer reference if one was already set. It now only sets the customer reference if one isn't already present.

## v2.4.0

**Date:** 2022-08-13\
**Description:** Minor release with additional features and bug fixes

* Added support for Cart/Order list config files to enable displaying order properties in the order list view.
* Fixed bug in property editor dialog passing the `orderId` in the `storeId` config setting.
* Fixed bug in the session manager storing the default payment method under the default country session ID.

### v2.3.4

**Date:** 2022-08-22\
**Description:** Patch release with minor bug fixes and non-breaking enhancements

* Added more null checking to the `UmbracoStockSynchronizer` as the fix in 2.3.3 didn't quite fix the issue.
* Fixed regression with `AsyncHelper` causing error/hanging when attempting to send emails.

### v2.3.3

**Date:** 2022-08-08\
**Description:** Patch release with minor bug fixes and non-breaking enhancements

* Fixed issue with `UmbracoStockSynchronizer` causing an exception if there is no previous data stored in the variants property editor.
* Fixed a bug in export logic where exporting multiple templates would actually just export the first template multiple times.
* Fixes issue with `AsyncHelper` causing `AggregateException` by switching to our newer style of `AsyncHelper` from v3.

### v2.3.2

**Date:** 2022-07-06\
**Description:** Patch release with minor bug fixes and non-breaking enhancements

* Fixed v10 regression causing indexing of products/variants in Lucene to fail.
* Fixed null error in `RaiseOrderLineChangeEvents` as original Tax Class ID can be null for new order lines.
* Fixed `XSS` issue in custom order table cell rendering. Now HTML escapes all user input before rendering.
* Fixed bug on licenses dashboard now showing the Refresh button for subscription licenses.

### v2.3.1

**Date:** 2022-06-21\
**Description:** Patch release with minor bug fixes and non-breaking enhancements

* Fixed v10 regression due to Umbraco API change where saving / publishing content would cause an error screen.
* Fixed v10 regression due to Umbraco API change where internal index would not rebuild and so Vendr store finders would not run.
* Fixed bug in Content based store finder due to incorrectly overriding base method.

## v2.3.0

**Date:** 2022-06-21\
**Description:** Minor release with Umbraco v10 support

* Added decimal place configuration to `Vendr: Price` property editor.
* Added logging to payment callback handler.
* Added validation events to payment capture, cancel and refund actions to allow validating whether those actions should occur or not ([#369](https://github.com/vendrhub/vendr/issues/369)).
* Added support for default settings in payment providers and discounts rules / rewards. Can now set default values on settings Poco and these will apply during create.
* Updated DB migrations to work with SQLite (v10 only).
* Fixed v10 compatability issues.
* Fixed order editor UI issue with bundle order lines showing the parent order line prices.
* Fixed bug with unit price discounts being capped at a bundle order lines base price.
* Fixed bug where deleting carts would restock items. Now only reverts an order if it has been finalized.
* Fixed bug where Export Templates weren't being deleted ([#373](https://github.com/vendrhub/vendr/issues/373)).

### v2.2.1

**Date:** 2022-05-23\
**Description:** Patch release with minor bug fixes and non-breaking enhancements

* Added ability to change the tax class of an order line.
* Added ability to set the number of decimal places a stock input field should accept.
* Fixed bug in stock input field formatting the number incorrectly for the current users culture ([#367](https://github.com/vendrhub/vendr/issues/367)).
* Fixed error when saving stock due to setting property value to string `"-1"` when it expects to be the decimal `-1` ([#368](https://github.com/vendrhub/vendr/issues/368)).

## v2.2.0

**Date:** 2022-05-06\
**Description:** Minor release with some breaking changes

* Added `GetCurrentOrder` method to `SessionManager` that accepts a `customerReference` to allow finding an order via `IOrderFinder`.
* `GetCurrentOrder` on `SessionManager` with no `customerReference` parameter now calls the new `GetCurrentOrder` method passing in the current logged in members ID. This shouldn't change any behaviour for the majority of stores without order finders, but if intalls do have order finders you'll now need to pass `null` to the `customerReference` parameter if you want to get the current order whilst avoiding using order finders.
* `IOrderFinder.FindOrder` now accetps an additional `storeId` parameter.
* `IOrderService.FindOrder` now accetps an additional `storeId` parameter.

### &#x20;v2.1.3

**Date:** 2022-04-28\
**Description:** Patch release with minor bug fixes and non-breaking enhancements

* Updated price calculation process to set total prices temporarily as the pipelines goes along so that any stage within the calculation process you can get the total prices at the current state.
* Updated the licensing dialog to display a warning if there is an inactive license installed which usually means the local environment has been updraded beyond the installed licenses upgrade window ([#360](https://github.com/vendrhub/vendr/issues/360)).
* Fixed order table layout issue due to too large a `colspan` attribute.
* Fixed recuring tasks having the delay / interval in the wrong order in Umbraco v9.
* Fixed conflicting routes issue in Umbraco v9.5RC due to Umbraco introducing a new AnalyticsController. Have now prefixed all Vendr controllers with `Vendr` ([#362](https://github.com/vendrhub/vendr/issues/362)).
* Fixed product related analytics reports not passing the `storeId` into the product adapter when fetching up to date product info ([#364](https://github.com/vendrhub/vendr/issues/364)).
* Fixed bug when using own order editor config view where the order editor still trys to fix notes fields. Now does a null check before attempting. ([#363](https://github.com/vendrhub/vendr/issues/363)).

### v2.1.2

**Date:** 2022-03-23\
**Description:** Patch release with minor bug fixes and non-breaking enhancements

* Added order activity log to order edit screen ([#351](https://github.com/vendrhub/vendr/issues/351)).
* We no longer maintain a cache of all Gift Cards in memory, instead, we do the same as we do with orders and just maintain active Gift Cards on a sliding expiration.
* Fixed issue when using `VariantsEditorValueConverter` in background threads due to the use of scoped services. Now no longer require effective services to be scoped.
* Fixed activity logs not recording the user ID of the user that performed the given task ([#350](https://github.com/vendrhub/vendr/issues/350)).
* Fixed error when saving product attributes due to a bug in deep-equals logic ([#354](https://github.com/vendrhub/vendr/issues/354)).

### v2.1.1

**Date:** 2022-03-07\
**Description:** Patch release with minor bug fixes and non-breaking enhancements

* Added constants for the built-in payment provider aliases.
* Added `IUmbracoProductSnapshot` interface to allow snapshots to be swapped out, but still have the default Umbraco node-based stock implementation work.
* Added `ParentOrderLineId` and `ParentBundleId` properties to order lines to be able to easily identify an order line's parent.
* Discount `UsageLimit` is set to `0` if `IsUnlimited` is set to `true`.
* Payment provider callback handler without order info now returns OK status if it can't handle the supplied order, rather than Bad Request.
* Fixed cart edit form submitting on enter for Discount/Gift Card Codes field ([#344](https://github.com/vendrhub/vendr/issues/344)).
* Fixed issue with discounts not updating correctly due to deep comparisons not working. Switched from using `DeepEqual` library to `CompareNetObject` library instead ([#347](https://github.com/vendrhub/vendr/issues/347)).

## v2.1.0

**Date:** 2022-02-14\
**Description:** Minor release with new features and some breaking changes

* Added `Carts` feature to `Commerce` section.
* Added `ProductAdapterBase` as a new base class for product adapters.
* Added `Cart` category for email, print, and export templates.
* Added `cart.editor.config.js` file support for controlling editable cart fields differently from editable order fields.
* Added `IUmbracoNodeStoreFinder` interface to allow custom ways of locating a store from an Umbraco node. Default finders and their order are `UmbracoPublishedContentStoreFinder`, `UmbracoLuceneStoreFinder` and `UmbracoContentStoreFinder`. Additional store finders can be added via the `WithUmbracoNodeStoreFinders` collection builder API available on the `IUmbracoBuilder` interface.
* Added Change Status bulk action to allow changing the order status of multiple orders at once ([#335](https://github.com/vendrhub/vendr/issues/335)).
* Added advanced search filter feature to allow searching for orders/carts in a more targeted way. This can also be extended by adding custom `AdvancedFilterBase` implementations to the DI container.
* Added Order tagging support to allow tagging orders with custom tags that can be used for filtering ([#324](https://github.com/vendrhub/vendr/issues/324)).
* Added custom `OutfieldDigitalExchangeRateService` and set as the default implementation that just acts as a proxy to the exchangerate.host API. This is to ensure that we can fix this in the future without people needing to upgrade, should that service ever stop working like the Exchange Rates API service did.
* Order editor customer information dialog now allows the countries to be edited.
* Order search now searches the customer's email too.
* Updated all places that located a store based on an Umbraco node/content item to use the new `IUmbracoNodeStoreFinder` implementations.
* Fixed bug when searching for orders that have an email address assigned (previously threw a malformed SQL error).
* Fixed bug where only admins could pick from store entity pickers ([#342](https://github.com/vendrhub/vendr/issues/342)).
* Fixed path inconsistencies on Linux due to case-sensitive file system ([#341](https://github.com/vendrhub/vendr/issues/341)).
* Fixed variant item editor not showing variant attribute summary in Umbraco v8.
* Fixed the issue with sorting not working due to the change to .NET Core.
* Fixed error when deleting bundle order lines due to items being deleted in the wrong order and thus causing an FK violation.
* Fixed styling issues in store entity picker pre-value editor UI.
* `IProductAdapter` now exposes `SearchProductSummaries`, `GetProductVariantAttributes` and `SearchProductVariantSummaries` methods for editable cart support.
* `IProductAdapter`, `IStockService`, `IProductService`, `IVendrApi` methods that accept a `productReference` / `productVariantReference` parameter now receives a `storeId` parameter as well ([#339](https://github.com/vendrhub/vendr/issues/339)).
* `IPaymentCalculator` and `IShippingCalculator` now accept a nullable `countryId` parameter.

### v2.0.6

**Date:** 2022-02-01\
**Description:** Patch release with minor bug fixes and non-breaking enhancements

* Added explicit checks for the use of CloudFlares Flexible Secure Socket Layer (SSL) feature when resolving Vendr URLs.
* Added extra null checks in exchange rate service implementations.
* Added new `ExchangeRateHostCurrencyExchangeRateService` implementation.
* The payment controller now only returns `BadRequest` status if the URL has been tampered with. All other code paths now return a `OK` status so that webhooks won't keep attempting notifications for orders/transactions that can't be handled.
* Move the shipping company name field to be in the same location as the billing company name field.
* Updated the resolution of the `order.editor.config.js` file to prefer a config on disk over a legacy entry in the database table.
* Updated the default `ICurrencyExchangeRateService` to use the free `ExchangeRateHostCurrencyExchangeRateService`.
* Updated the `ExchangeRatesApiCurrencyExchangeRateService` to require an API key as this now appears to be required.
* Fixed license domains list not displaying correctly in the Vendr settings dashboard.
* Fixed divide-by-zero issues when applying exchange rates to an order.

### v2.0.5

**Date:** 2022-01-17\
**Description:** Patch release with minor bug fixes and non-breaking enhancements

* Changed `EventBus` and `Pipeline` implementations to no use lazy dependencies as in some occasions it's possible in Umbraco that these get resolved too early before registration is complete and can end up caching a `null` value.
* Changed from using `IStartupFilter` for some core startup configurations to using `IComponent` due to issues with Umbraco Deploy firing too early.
* Fixed regression in license limitations checks for custom product adapters when using a lite license. Then namespace had changed in v2, but we didn't update the limitation check.

### v2.0.4

**Date:** 2021-12-06\
**Description:** Patch release with minor bug fixes and non-breaking enhancements

* Changed the stock synchronizer to use an internal cache rather than rely on scoped dependencies.
* Removed Matryoshka override styles as shouldn't be necessary anymore.
* Fixed variants attribute group not showing in variants editor due to core changes in how tabs work.

### v2.0.3

**Date:** 2021-10-26\
**Description:** Patch release with minor bug fixes and non-breaking enhancements

* Fixed issue with Opayo payment provider not working due to the `HttpRequestMessage` already having been read ([#4](https://github.com/vendrhub/vendr-payment-provider-opayo/issues/4)).
* Fixed issue with Order Export Template rendering everything on one line due to newline characters being escaped ([#330](https://github.com/vendrhub/vendr/issues/330)).

### v2.0.2

**Date:** 2021-10-20\
**Description:** Patch release with minor bug fixes and non-breaking enhancements

* Fixed issue with the Variants property editor creating an empty `General` tab when using tabs on the product document type.

### v2.0.1

**Date:** 2021-10-18\
**Description:** Patch release with minor bug fixes and non-breaking enhancements

* Added more null handling when accessing `ProductSnapshot` properties ([#327](https://github.com/vendrhub/vendr/issues/327)).
* Updated the Nuget build tasks to only replace the `App_Plugins\Vendr\backoffice` folder on `Clean`.
* Fixed bug in payment provider callback handler erroring for URLs where the order number isn't known.
* Fixed bug in payment provider context not populating `Request` property when converting to a strongly typed context.
* Fixed regression where deleted gift cards were showing in the gift cards list ([#326](https://github.com/vendrhub/vendr/issues/326)).
* Fixed a number of async deadlock issues.
* Fixed incorrect minimum Umbraco version in Umbraco `package.xml`.

## v2.0.0

**Date:** 2021-10-07\
**Description:** Major new release with breaking changes

* Added v9 / .NET Core support.
* Added custom rounding support ([#168](ttps://github.com/vendrhub/vendr/issues/168)).
* Payment providers are now .netstandard2.0.
* Payment provider methods are now async.
* Payment providers now take in a `PaymentProviderContext` for most methods.
* Big project restructuring.
* More details on what's changed in the [v2.0.0 release blog post](https://vendr.net/blog/vendr-2-0-0-release/).

### v1.8.6

**Date:** 2021-08-27\
**Description:** Patch release with minor bug fixes and non-breaking enhancements

* Added more null handling in exchange rate service providers.
* Updated the default order number generator to improve randomness and thus prevent collisions, especially in load-balanced environments.
* Fixed intermittent concurrency errors with `EntityCacheKeys`. Switched to a concurrent dictionary for cache key storage.
* Fixed issue with payment provider URLs forcing port 443 for non-localhost URLs.
* Updated the price property editor to allow an explicit zero value to be set ([#314](https://github.com/vendrhub/vendr/issues/314)).
* Fixed issue with analytics dashboard not allowing the viewing of todays figures ([#319](https://github.com/vendrhub/vendr/issues/319)).

### v1.8.5

**Date:** 2021-07-23\
**Description:** Patch release with minor bug fixes and non-breaking enhancements

* Fixed regression where order editor configs weren't getting resolved correctly (1.8.4 didn't actually fix this).

### v1.8.4

**Date:** 2021-07-22\
**Description:** Patch release with minor bug fixes and non-breaking enhancements

* Added refresh license button to licenses dashboard for subscription licenses.
* Removed `ILicensingService` and have a core `LicensingService` (which is now `sealed`) dependency instead.
* Fixed error where payment interactions from the order editor weren't having any effect ([#316](https://github.com/vendrhub/vendr/issues/316)).
* Fixed regression where order editor configs weren't getting resolved correctly.

### v1.8.3

**Date:** 2021-06-21\
**Description:** Patch release with minor bug fixes and non-breaking enhancements

* Added ability to define reply to the email address on email templates ([#287](https://github.com/vendrhub/vendr/issues/287)).
* Added ability to replace and remove event handlers via the Vendr API ([#256](https://github.com/vendrhub/vendr/issues/256))
* Added support for convention-based resolution of the order editor config, inline with how analytics and gift cards configs work.
* Implemented a `IPaymentService` to encapsulate the Capture, Cancel and Refund actions of a payment gateway to allow re-use outside of the Vendr UI.
* Umbraco Product Adapter now uses `IUmbracoContextFactory` instead of `IUmbracoContextAccessor` so that it can create a context if one isn't present, allowing it to run in background tasks.
* Updated cache refreshers to load their dependencies Lazily as was causing errors in some random instances.
* Updated Store editor to allow default email templates to be un-set in order to allow disabling of default emails ([#223](https://github.com/vendrhub/vendr/issues/223)).
* Updated County and Regions editor to allow Default Country, Payment Methods and Shipping Methods to be not set ([#305](https://github.com/vendrhub/vendr/issues/305)).
* Updated product attribute editor to allow camel case attribute aliases inline with all other aliases ([#269](https://github.com/vendrhub/vendr/issues/269)).
* Updated the stock input field to display the same "No store found" message if the product node has no store setting defined ([#193](https://github.com/vendrhub/vendr/issues/193)).
* Updated the stock property editor save event handlers to use `MemoryCache` to remember the state, rather than the `RequestCache` as there is no request cache when a content node is published via a schedule.
* Updated the payment controller actions to not continue with the processing if the order reference on file does not match that in the URL.
* Fixed errors in exchange rate services returning null. Now handles null values.
* Fixed an issue with analytics reports showing data in UTC and not in the local time zone ([#303](https://github.com/vendrhub/vendr/issues/303)).
* Fixed bug in top-selling product analytics chart erroring if a product's name changes at some point in the date range ([#297](https://github.com/vendrhub/vendr/issues/297)).
* Fixed a bug where the injected `vendr_variants` tab is displayed when using Matroyhska. Custom CSS has been added to ensure this remains hidden ([#304](https://github.com/vendrhub/vendr/issues/304)).
* Fixed a bug where payment provider settings weren't being translated before being passed to the payment provider within the Capture, Cancel, and Refund actions.

### v1.8.2

**Date:** 2021-05-26\
**Description:** Patch release with minor bug fixes.

* Added `esc` keyboard shortcut to close the exports dialog ([#301](https://github.com/vendrhub/vendr/issues/301)).
* No longer errors if the same discount/gift card code is applied for a second time.
* Fixed error when creating Gift Cards in backoffice due to no currency defined yet.
* Fixed bug in gift cards searches API not initializing the gift card state correctly.

### v1.8.1

**Date:** 2021-05-13\
**Description:** Patch release with minor bug fixes

* Added `Try` methods to `IStockService` and `IProductService` for all get/set stock methods.
* Made `PricePropertyValue` implement `IEnumerable<ProductPrice>` returning any price with a value.
* Fixed a bug in the shipping cost calculation not using the shipping tax rate ([#298](https://github.com/vendrhub/vendr/issues/298)).
* Removed obsolete `ProductVariantCollectionExtensions` causing naming conflicts.
* Fixed bug in variants editor save event handler not persisting initial stock levels.

## v1.8.0

**Date:** 2021-05-05\
**Description:** Minor release with new features and minor bug fixes

* Added export templates section to the Store settings area.
* Added export bulk action to Orders, Gift Cards, and Discounts list views to allow exporting.
* Updated print dialog to disable the print button whilst there are no templates selected ([#292](https://github.com/vendrhub/vendr/issues/292)).

### v1.7.3

**Date:** 2021-05-04\
**Description:** Patch release with minor bug fixes

* Updated the `ProductOrderLineAmountDiscountRewardProvider` with an `OrderLineSource` settings to allow choosing whether the matching product should be located anywhere on the order, or within the matching rule results.

### v1.7.2

**Date:** 2021-04-26\
**Description:** Patch release with minor bug fixes

* Changed it so that when setting stock levels, if the stock source can't be found it no longer throws an error. Instead, it fails silently and logs a debug message.
* Changed the entity cache wrappers to use cache accessor functions so that the cache wrappers can be reused locally.

### v1.7.1

**Date:** 2021-04-20\
**Description:** Patch release with minor bug fixes

* Fixed a bug in the new cache mechanism where changes weren't being pushed back into the global cache if an entity was accessed outside of a UoW within the same request prior to changes being made to that entity.

### v1.7.0

**Date:** 2021-04-15\
**Description:** Minor release with new features and minor bug fixes

* Added new `EntityCaches` for independent cache repositories of entities.
* Order and Price Freezer caches now auto-expire items if they are not used.
* Added a new stock caching layer to help improve performance.
* Added new Order and GiftCard search API for more flexible searching ([#110](https://github.com/vendrhub/vendr/issues/110)).
* `EntityStateCache` has now been obsoleted in favor of a new `EntityCaches` with an improved caching mechanism.
* Transactional cache has now been updated to work with the new `EntityCaches` rather than the `EntityStateCache`.
* Old Order and GiftCard search methods have been obsoleted in favor of the new search API.

## v1.6.0

**Date:** 2021-04-06\
**Description:** Minor release with new features and minor bug fixes

* Added order printing action button ([#79](https://github.com/vendrhub/vendr/issues/79)).
* Added bulk order printing feature to orders list.
* Email Templates are now located in a Templating parent folder to encompass both Email and Print templates
* Fixed hardcoded `/umbraco` URL prefixes preventing sites from running with non-standard admin path ([#290](https://github.com/vendrhub/vendr/issues/290)).

### v1.5.3

**Date:** 2021-03-24\
**Description:** Patch release with minor bug fixes

* Fixed issue where the variants property editor was not recursively transforming property values when converting from editor to DB ([#285](https://github.com/vendrhub/vendr/issues/285)).
* Fixed minor styling issues in the default email templates ([#286](https://github.com/vendrhub/vendr/issues/286)).

### v1.5.2

**Date:** 2021-03-17\
**Description:** Patch release with minor bug fixes

* Fixed error screen when fetching too many sub-entities in one SQL query. All sub-entity queries are now batched into groups of 2000 entities at a time ([#280](https://github.com/vendrhub/vendr/issues/280)).
* Fixed regression in `ZeroValuePaymentProvider` since 1.4.0 release due to it not being updated to use the `TransactionAmount` property ([#281](https://github.com/vendrhub/vendr/issues/281)).
* Added new event handlers when a content node with a variants editor is saved/copied/moved to automatically inject the related `storeId` for the variants editor into it's data structure. This is mainly to provide context to the `Vendr.Deploy` package.
* Added `Create` methods to `ProductAttribute` and `ProductAttributePreset` to allow the passing in of an ID. This is to enable them to be deployed in `Vendr.Deploy`.
* Updated the `UmbracoProductAdapter.GetProductSnapshot` introduced in 1.5.0 which accepts a `productVariantReference` to be virtual inline with the existing `GetProductSnapshot` method ([#282](https://github.com/vendrhub/vendr/issues/282)).
* Updated the product variants editor value converter to automatically lookup the related store so that a `storeId` isn't needed when using the `GetInUseProductAttributes` method.

### v1.5.1

**Date:** 2021-02-26\
**Description:** Patch release with minor bug fixes

* Fixed stock property editor erroring on newly created variants in pre-existing product nodes.
* Fixed error due to variants prop editor being moved to first group. Now moved to it's own group and that group is then hidden.
* Fixed errors when using variants prop editor with content variants.
* As block list editors don't support content variants yet, the variants editor has been updated to grey out and prevent editing on non-default language variant editors.

## v1.5.0

**Date:** 2021-02-11\
**Description:** Minor release with new multi-variants feature

* Multi-variants property editor.
* Added new Options node to stores in the Commerce section with subsections for new Product Attributes and Product Attribute Presets features.
* `AddProduct` API's now accept a new productVariantReference.
* Order Lines now expose a `ProductVariantReference` property.
* Order Lines now expose an `Attributes` property.
* Minimum Umbraco version updated to 8.10.+ due block list editor API requirement.
* Additional `IProductAdapter.GetProductSnapshot` method accepting a productVariantReference has been added.
* `IProductAdapter.GetProductReference` changed to `IProductAdapter.TryGetProductReference`.
* `IProductSnapshot` now exposes a `ProductVariantReference` property.
* `IProductSnapshot` now exposes an `Attributes` property.

### v1.4.2

**Date:** 2021-02-04\
**Description:** Patch release with minor bug fixes and enhancements

* Added confirmation dialogs to Cancel, Refund, and Capture payment actions ([#251](https://github.com/vendrhub/vendr/issues/251)).
* Added extra events to fire when adding or updating order lines via the `AddProduct` methods ([#248](https://github.com/vendrhub/vendr/issues/248)).
* Added `IOrderFinder` interface so custom order locating can be added if no order is found for a customer reference.
* Fixed bug where Member ID wasn't being auto-assigned to orders ([#263](https://github.com/vendrhub/vendr/issues/263)).
* Fixed Vendr cache refreshers not refreshing distributed caches correctly ([#250](https://github.com/vendrhub/vendr/issues/250)).
* Fixed an issue where log files are getting filled with unnecessary log messages ([#249](https://github.com/vendrhub/vendr/issues/249)).
* Fixed an issue where using a Gift Card resulted in the order erroring ([#247](https://github.com/vendrhub/vendr/issues/247)).
* Fixed issue with analytics fixed timeframes not updating ([#234](https://github.com/vendrhub/vendr/issues/234)).
* Fixed styling issue where long order status labels were getting cropped ([#230](https://github.com/vendrhub/vendr/issues/230)).
* Fixed issue where `GetOrCreateCurrentOrder` could return an order for a previous logged-in member ([#216](https://github.com/vendrhub/vendr/issues/216)).
* Fixed formatting bug in menu actions interceptor.
* Fixed bug in Store Dashboard where error order statuses were linking to the order list view with the wrong query string parameter.

### v1.4.1

**Date:** 2020-12-21\
**Description:** Patch release with minor bug fixes and enhancements

* Fixed bug with license checking erroring during Umbraco Deploy deployments ([#233](https://github.com/vendrhub/vendr/issues/233)).
* Fixed issue with order confirmation email using payment country name in place of shipping country name.
* Fixed spelling error in auto-generated error email template alias.
* Fixed regression where custom product adapter was not being allowed on a trial license.
* Updated discounts to apply percentage values differently depending on whether tax is included in prices or not (rounding issue).
* Fixed error screen when assigning an orders order status prior to finalization due to the activity logger. The activity logger now only logs activity for finalized orders.
* Updated the `Price` entity to prioritize tax rounding over base price rounding.

## v1.4.0

**Date:** 2020-12-10\
**Description:** Major breaking changes release

For more details on this release, including a recommended upgrade strategy, please see the [Vendr 1.4.0 RC blog post](https://vendr.net/blog/vendr-1-4-0-release-candidate/).

* Added price adjustments/adjusters.
* Added amount adjustments/adjusters.
* Changed licensing factory to support subscription licenses in the future.
* Discounts are now Price Adjustments and so all price "Discount" related properties have been renamed to "Adjustment" related properties.
* Because Discounts are now Price Adjustments, Discounts are now no longer calculated as their own calculation pipeline task (`CalculateOrderDiscountsTask`). Instead, there is now an adjustments calculation pipeline task that calculates all adjustments (`ApplyOrderPriceAdjustmentsTask`), of which Discounts are now a type of adjuster (`DiscountsPriceAdjuster`).
* Because price adjustments can be positive or negative, all discount adjustments are now negative in value (important if you using discounts to calculate a value).
* All order calculation pipeline tasks related to "Discounts"/"Discounted" have all been renamed to "Adjustments"/"Adjusted" task names. All previous tasks have been marked obsolete with IntelliSense to guide you to the new implementation.
* Gift Cards are now Amount Adjustments and so all "Gift Card" related properties are now found in the "Adjustment" related properties.
* Because Gift Cards are now Amount Adjustments, Gift Cards are now no longer calculated as their own calculation pipeline task (`CalculateOrderGiftCardAmountsTask`). Instead, there is now an adjustments calculation pipeline task that calculates all adjustments (`ApplyOrderAmountAdjustmentsTask`), of which Gift Cards are now a type of adjuster (`GiftCardsAmountAdjuster`).
* Gift Card / Amount Adjustment values are now found on the `TransactionAmount` property rather than the `TotalPrice` property of an order.

### v1.3.5

**Date:** 2020-12-07\
**Description:** Patch release with minor bug fixes and enhancements

* Fixed a bug in the backoffice rendering of bundled items where total columns were not lining up.
* Fixed a bug where deleting a discount fired the `DiscountedCodeAdded` validation event and prevented a discount code from being removed ([#222](https://github.com/vendrhub/vendr/issues/222)).
* Fixed bug in `UmbracoBooleanJsonConverter` not handling null values ([#224](https://github.com/vendrhub/vendr/issues/224)).
* Added extra logging to cache refreshers so these can be debugged.

### v1.3.4

**Date:** 2020-11-23\
**Description:** Patch release with minor bug fixes and enhancements

* Bulk actions are now extendable ([#218](https://github.com/vendrhub/vendr/issues/218)).
* Added validation error when redeeming a discount/gift card where the code doesn't exist.
* Added order line `bundleId` to uniqueness properties list by default to enforce all bundles being unique order lines.
* Added `HMACSHA1Hash` helper to payment provider base class.
* Fixed an issue where logged-in customers weren't assigned to newly created orders ([#213](https://github.com/vendrhub/vendr/issues/213)).
* Fixed bug in `PropertyValue` constructor not settings `IsServerSideOnly` and `IsReadOnly` to pass in values.
* Put the Vendr stores tree into the "Commerce" group so that if anyone adds a new tree to the commerce section, the store's node does not appear under a generic "Third Party" group.
* Fixed spelling mistakes in `RegisteredCustomerInfo` method name.
* Fixed bug in default Tax Class validation rule being passed the wrong ID to validate.
* Fixed bug with discount rules provider not filtering "All" rules fulfilled order lines correctly.

### v1.3.3

**Date:** 2020-10-28\
**Description:** Patch release with minor bug fixes and enhancements

* Added extra hashing method to the Payment Provider base class ([#209](https://github.com/vendrhub/vendr/issues/209)).
* Added `UnassignFromCustomer` convenience method to order.
* Stock is now replenished if an order payment status is `Cancelled` ([#196](https://github.com/vendrhub/vendr/issues/196)).
* Added distributed cache refresher for gift cards ([#212](https://github.com/vendrhub/vendr/issues/212)).
* Added validation rules to ensure entities set as "defaults" can't be deleted until a new default is set ([#201](https://github.com/vendrhub/vendr/issues/201)).
* Fixed minor alignment issues on the store actions list ([#192](https://github.com/vendrhub/vendr/issues/192)).
* Fixed `TotalPrice.TotalDiscount` not taking into account payment/shipping discounts ([#207](https://github.com/vendrhub/vendr/issues/207)).
* Fixed discount distributed cache refresher not being hooked up ([#211](https://github.com/vendrhub/vendr/issues/211)).
* Fixed typo in validation error for invalid combination of currency/country ([#205](https://github.com/vendrhub/vendr/issues/205)).
* Fixed issue where member discounts aren't recalculated when the order customer changes ([#204](https://github.com/vendrhub/vendr/issues/204)).
* Fixed conditional input break after 7.7 UI breaking change ([#203](https://github.com/vendrhub/vendr/issues/203)).
* Changed the breakpoint at which the Vendr layout reduces to mobile ([#202](https://github.com/vendrhub/vendr/issues/202)).
* Changed how percentage discounts work so that they calculate the percentage of pre-tax + tax prices rather than the pre-tax + the orders tax rate.

### v1.3.2

**Date:** 2020-10-05\
**Description:** Patch release with minor bug fixes and enhancements

* Added unique code validation rule for Gift Cards.
* Expose the NPoco database type in the DatabaseUnitOfWork.
* Fixed a bug where users would get logged out when editing discounts/gift cards due to the tree Controller checking the wrong permission ([#197](https://github.com/vendrhub/vendr/issues/197)).
* Fixed SQL date error in the Analytics section when using **British English - English** DB culture ([#198](https://github.com/vendrhub/vendr/issues/198)).
* Removed redundant code fetching members in order editor ([#185](https://github.com/vendrhub/vendr/issues/185)).

### v1.3.1

**Date:** 2020-10-05\
**Description:** Patch release with minor bug fixes and enhancements

* Added `Formatted()` extension method to `DiscountedPrice`.
* Added extra methods to order service to get Finalized, Open, and All orders for a customer.
* Added Region info to billing/shipping address details ([#180](https://github.com/vendrhub/vendr/issues/180)).
* Added Discount entity to DiscountRuleContext inline with DiscountRewardContext ([#189](https://github.com/vendrhub/vendr/issues/189))
* Added `StoreActionsRenderingNotification` and `ActivityLogEntriesRenderingNotification` events to allow extending the store dashboard.
* Added support for a `VendrLicensesDirectory` app setting to override where licenses are loaded from.
* Fixed error when deleting an order connected to a Gift Card ([#186](https://github.com/vendrhub/vendr/issues/186)).
* Fixed a spelling error in the search term model for the item picker directive.
* Fixed performance issue introduced in 1.3.0 where constantly loading an entity become significantly slower. Introduced a new `EntityStateCacheAccessor` to only use the new transactional entity state cache when necessary ([#191](https://github.com/vendrhub/vendr/issues/191)).
* Fixed migration error if installing on a site where the Vendr tables already exist, Vendr hasn't been installed yet ([#190](https://github.com/vendrhub/vendr/issues/190)).
* Removed redundant code fetching members in order editor ([#185](https://github.com/vendrhub/vendr/issues/185)).

## v1.3.0

**Date:** 2020-09-17\
**Description:** Minor release including new features and some bug fixes/breaking changes

* Added a new store summary dashboard featuring a sales summary, links to pertinent actions as well as an activity log.
* Added commerce route dashboard giving a summary of stores the current user has access to.
* Added analytics section to stores to provide basic analytics reporting on the store's performance.
* Added ability to handle Vendr subscription-based licenses.
* Added Vendr logo to Umbraco package.
* Fixed Umbraco 8.8 RC styling issues mostly around icons.
* `IEntityStateCache` is now no longer an injectable dependency, instead it is accessed via the Unit of Work.
* List view buttons now use the outline style as per the latest Umbraco.
* `IProductCalculator` now accepts a `ProductCalculatorContext`.
* `IUnitOfWork` interface now provides access to the entity state cache.
* `UnitOfWork` now accepts a `VendrUnitOfWorkTransaction`.

### v1.2.10

**Date:** 2020-09-11\
**Description:** Patch release with minor bug fixes mostly around the Umbraco 8.7 release

* Fixed a styling bug in the order details header that got missed in the previous release.

### v1.2.9

**Date:** 2020-09-11\
**Description:** Patch release with minor bug fixes mostly around the Umbraco 8.7 release

* Fixed a bug in the session manager remembering an order after it had been moved to finalized.
* Fixed bug in UI not matching the same colors used by Umbraco ([#174](https://github.com/vendrhub/vendr/issues/174)).
* Fixed bug with price + store entity pickers not working correctly in Umbraco 8.7 ([#176](https://github.com/vendrhub/vendr/issues/176)).
* Fixed a series of style changes in the recent Umbraco 8.7 release.

### v1.2.8

**Date:** 2020-08-21\
**Description:** Patch release with minor bug fixes/enhancements

* Added a new customer info panel accessible via a user icon next to the customer name to be able to display registered customer info + order history ([#129](https://github.com/vendrhub/vendr/issues/129)).
* Added helpful exception messages if you attempt to create an order but the required store default config isn't yet in place. It now tells you what needs fixing, and how to fix it ([#158](https://github.com/vendrhub/vendr/issues/158)).
* Use `umb-loader` component in Vendr list view rather than raw markup + css classes ([#161](https://github.com/vendrhub/vendr/issues/161)).
* Improved accessibility in a number of areas ([#162](https://github.com/vendrhub/vendr/issues/162)).
* Removed `umb-overlay` directive usage in favor of the `overlayService` ([#163](https://github.com/vendrhub/vendr/issues/163)).
* Expanded any self-closing directive DOM tags as this is considered bad practice for directives ([#164](https://github.com/vendrhub/vendr/issues/164)).
* Fixed a bug where creating a new order via the session manager wasn't populating a default shipping country/shipping method ([#156](https://github.com/vendrhub/vendr/issues/156)).
* Fixed bug in session manager SetDefaultCurrency and SetDefaultTaxClass where exception was thrown if `applyToCurrentOrder` is `true` ([#160](https://github.com/vendrhub/vendr/issues/160)).
* Add null checks and error logs if there is a problem calculating the order gift card amount if a gift card is deleted ([#167](https://github.com/vendrhub/vendr/issues/167)).
* Fixed long order line names flowing off-screen. They are now truncated with ... ([#147](https://github.com/vendrhub/vendr/issues/147)).
* Fixed bug in Member Group Discount Rule throwing an error screen due to DI resource not being found. Now use `IMemberService` for everything.
* Fixed rounding issue when applying a discount amount but the order line totals calculation doesn't match the price + tax of the discount exactly.

### v1.2.7

**Date:** 2020-07-29\
**Description:** Patch release with minor bug fixes/enhancements

***

* Added payment provider feature to fetch an order's payment status from the payment gateway when an order is opened in the same way Tea Commerce does.
* Updated how the stock property editor loads and persists its value so that it doesn't cause a stock update every time it's saved.
* Orders now finalize if the payment status is anything but Initialized (previously didn't finalize if the status was PendingExternalSystem).
* The pending payment status is now displayed as purple in the backoffice so that it's not the same color as the canceled status.
* Updated the store entity picker to support multiple store resolution modes so that the picker can be used outside of the content section ([#141](https://github.com/vendrhub/vendr/issues/141)).
* Fixed bug when creating US country regions from preset ([#159](https://github.com/vendrhub/vendr/issues/159)).
* Fixed issue with payment provider continue/cancel/error URLs escaping query strings ([#157](https://github.com/vendrhub/vendr/issues/157)).
* Fixed <= price discount rule not displaying correct symbol ([#155](https://github.com/vendrhub/vendr/issues/155)).

### v1.2.6

**Date:** 2020-07-02\
**Description:** Patch release with minor bug fixes/enhancements and some breaking changes

* Thawing prices now causes existing, unfinalized orders to recalculate and re-freeze prices at the current rate ([#145](https://github.com/vendrhub/vendr/issues/145)).
* Fixed error screen when applying a discount with multiple rewards for the same price target. Applied discounts now accumulate all rewards per price type ([#136](https://github.com/vendrhub/vendr/issues/136)).
* Fixed a bug in discounts where the "Block discount if previous discounts already apply" setting was not being honored ([#142](https://github.com/vendrhub/vendr/issues/142)).
* Fixed bug in discounts where Order Total based percentage discounts were not being applied ([#143](https://github.com/vendrhub/vendr/issues/143)).
* Fixed error when creating an order and adding order lines in the same UoW. This ultimately came down to the price freezing logic freezing prices too early. For new orders, prices are now frozen after the initial save ([#140](https://github.com/vendrhub/vendr/issues/140)).
* Fixed an issue in migrations where some installs seem to convert unique indexes into unique constraints and so an error is thrown when attempting to drop the index. We now check to see if a constraint exists first and then perform the appropriate task ([#116](https://github.com/vendrhub/vendr/issues/116)).
* `IShippingCalculator` methods now take in  `ShippingCalculatorContext` with a reference to the current order/order calculation should one be available ([#146](https://github.com/vendrhub/vendr/issues/146)).
* `IPaymentCalculator` methods now take in  `PaymentCalculatorContext` with a reference to the current order/order calculation should one be available ([#146](https://github.com/vendrhub/vendr/issues/146)).

### v1.2.5

**Date:** 2020-06-17\
**Description:** Patch release with minor bug fixes/enhancements

* Added license warning message to gift cards, discounts, and store settings sections.
* Fixed the issue where the sort dialog displays the wrong error message if there is an error whilst sorting ([#131](https://github.com/vendrhub/vendr/issues/131)).
* Fixed issue where Dates were incorrect due to use of DateTime.Now rather than DateTime.UtcNow ([#134](https://github.com/vendrhub/vendr/issues/134)).
* Fixed rounding issue in order calculation ([#126](https://github.com/vendrhub/vendr/issues/126)).
* Fixed issue with the entity cache storing null values which shouldn't be allowed.
* Fixed issue where setting an explicit sort order on a new entity would be ignored on save.
* Fixed regression issue from 1.2.3 where loading orders from the database was switching the order id and currency id of the order causing calculation problems.
* Fixed issue with spelling mistake in discount rules / reward configurations for `Amounts Include Tax` properties ([#135](https://github.com/vendrhub/vendr/issues/135)).
* Fixed the issue with discounts not maintaining their sort order when loading from the database ([#132](https://github.com/vendrhub/vendr/issues/132)).
* Deprecated "Master" terminology in the code base so `MasterRelation` is now `ProductSource` (This is currently deprecated so the existing `MasterRelation` will still work, but moving forward `ProductSource` will be the recommended terminology).
* Updated the payment methods and create-dialog to exclude any payment providers marked with an `[Obsolete]` attribute. Obsolete payment providers can still be used, but they won't be selectable for new payment methods.
* Removed the sort option from the Gift Cards section as gift cards aren't sortable ([#131](https://github.com/vendrhub/vendr/issues/131)).
* Made the `Order.InitializeTransaction` method public to allow people to create and finalize a transaction in code without having to go via a payment gateway.
* Store `Create` method extended to make store auto population configurable. This is needed for Vendr.Deploy.

### v1.2.4

**Date:** 2020-06-12\
**Description:** Patch release with minor bug fixes / enhancements and some minor breaking changes

* Added support for `UmbracoLicensesDirectory` app setting to define where licenses are located ([#119](https://github.com/vendrhub/vendr/issues/119)).
* Added `CanProcessOrder` method to payment providers so that payment providers can pre-check whether they would be capable of processing a given order.
* Fixed an issue where it wasn't possible to update a product's stock back to the previously entered stock level ([#127](https://github.com/vendrhub/vendr/issues/127)).
* Fixed issue where multiple operations within a single UoW were not being persisted due to stale state not getting updated correctly ([#128](https://github.com/vendrhub/vendr/issues/128)).
* Fixed issue with the `Extract` helper method throwing an exception if the given item to extract couldn't be found.
* Fixed issue where null order/order line properties would cause persistence error.
* Updated the percentage amount discounts rewards to only allow positive percentage values ([#113](https://github.com/vendrhub/vendr/issues/113)).
* Renamed the `Persistance` namespace to the correct `Persistence` spelling. This is a breaking change, but people shouldn't be using the persistence resources directly.
* Moved `ValidationError` to `Models` namespace. This is a breaking change, but people shouldn't be using the `ValidationError` model directly.
* With the introduction of the `UmbracoLicensesDirectory` app setting, if you are running on Umbraco Cloud and have a license installed, because Umbraco Cloud auto sets this setting to `~\App_Plugins\UmbracoLicenses\` you will need to move your license files from the `App_Data` folder to this new location.

### v1.2.3

**Date:** 2020-06-05\
**Description:** Patch release with minor bug fixes/enhancements

* Fixed issue with recent gift card config settings not being copied when a store is deep cloned.
* Fixed issue with the store "allowed users" not persisting due to incorrect variable name in views.
* Fixed issue where domain events that affect the saving entity model were not being persisted due to a variable reference issue and deep comparisons not working.
* Fixed the issue with the sort dialog close button not working ([#123](https://github.com/vendrhub/vendr/issues/123)).
* Fixed issue where deleted gift cards were still showing in list view ([#124](https://github.com/vendrhub/vendr/issues/124)).
* Fixed issue where stock values were being cached at the page level where they should be at the request level ([#125](https://github.com/vendrhub/vendr/issues/125)).
* Only show payment/shipping "via" in the backoffice if a payment/shipping method is known.
* Added script to NuGet packages to auto increment client dependency version.
* Order calculation now rounds prices to the currencies defined decimal places level after each calculation step in order to prevent rounding issues ([#126](https://github.com/vendrhub/vendr/issues/126)).
* Payment Provider cancel, continue, and callback URL hashes now include the actual URL, and not only the reference as part of the hash. This is to prevent tampering of the URLs.
* Session cookies are now flagged as `HttpOnly` (this can be disabled by setting an app setting `Vendr:Cookies:HttpOnly` to `false`), and when the site is accessed over HTTPS, also flagged as `Secure`. This is to protect the session cookies from being hijacked by malicious entities.
* The current finalized order is now stored in its own session cookie with a limited lifetime of 5 minutes providing enough time to display a confirmation page, but no longer persisting until a new order took its place.

### v1.2.1/2

**Date:** 2020-05-28\
**Description:** Patch release with minor bug fixes/enhancements

* Fixed bug in discount service preventing discount/gift cards from being redeemed 🤦‍♂️
* Reverted fix for ([#116](https://github.com/vendrhub/vendr/issues/116)) as it was preventing clean installs so needs investigating further 🤦‍♂️

## v1.2.0

**Date:** 2020-05-28\
**Description:** Minor version release predominantly for the Gift Cards feature with a few bug fixes too

* Added gift cards feature which includes a new sub-section in the commerce section along with the ability to create gift cards manually and additional automation for automatically creating gift cards and sending gift card emails when a gift card is purchased.
* Added `IGiftCardCodeGenerator` to allow for a custom gift card code generation strategy.
* Added Zero Value payment provider in core to allow the passing through of orders whose final value is 0 and thus no payment needs to be taken. This will be up to the implementer however to set up and select this payment method accordingly.
* Added gift card service methods to the global `IVendrApi` helper.
* Added support of dynamic lambda statements in the syntax of `{Model.Value}` in email template subject lines ([#107](https://github.com/vendrhub/vendr/issues/107)).
* Added validation to the `AddProduct` method to ensure a price for the order currency exists.
* Added `_ViewStart.cshtml` file to the Vendr views folder to reset any global layout that might have been defined ([#117](https://github.com/vendrhub/vendr/issues/117)).
* Fixed NullReference exception when adding a product to an order when missing a price ([#112](https://github.com/vendrhub/vendr/issues/112)).
* Fixed a number of migration SQL errors when upgrading using SQL Server ([#116](https://github.com/vendrhub/vendr/issues/116)).
* Fixed error with discount property rule not working correctly when a property doesn't exist ([#115](https://github.com/vendrhub/vendr/issues/115)).
* Fixed bug with discount code validation incorrectly reporting the discount code is already in use.
* Store configuration now has additional gift card configuration fields.
* Email Templates now have a category used to filter the email templates to display in "send email" dialogs.
* Updated the store create-pipeline to auto-create the default gift card email.
* Updated the store create-pipeline to assign generated emails to the relevant categories.
* Send email dialogs now have the ability to override the `To` address before sending.
* Improved the `PricePropertyValue` model's `HasValue` method to also check for null values.
* Updated the `UmbracoProductSnapshot.Prices` property to check for values for the given currency before assuming it has a value.
* `IProductAdapater` interface now has a new `IsGiftCard` property.

### v1.1.4

**Date:** 2020-05-19\
**Description:** Patch release with minor bug fixes/enhancements

* Fixed JavaScript error when refreshing the order list view after an order is deleted ([#96](https://github.com/vendrhub/vendr/issues/96)).
* Fixed formatting issue in table view selection message where `X of Y` the message was being displayed without spaces.
* Fixed error screen when deleting an order line that has discounts applied to it ([#98](https://github.com/vendrhub/vendr/issues/98)).
* Fixed order lines are limited to a max of 100 quantities ([#101](https://github.com/vendrhub/vendr/issues/101)).
* Fixed error in backoffice when displaying the transaction info dialog when some keys have an empty value ([#104](https://github.com/vendrhub/vendr/issues/104)).
* Fixed error when adding a suborder line to a bundle ([#106](https://github.com/vendrhub/vendr/issues/106)).

### v1.1.3

**Date:** 2020-05-06\
**Description:** Patch release with minor bug fixes/enhancements

* Patch release `dll` timestamp is not formatted in the correct way.
* Fixed bug in TaxClassRepository.GetIdByAlias method which had a malformed SQL statement.
* Fixed NuGet install script not working correctly in directories containing spaces.
* When saving a product node with a stock property, only sync the value back to the stock database table if the property is dirty ([#93](https://github.com/vendrhub/vendr/issues/93)).

### v1.1.2

**Date:** 2020-05-05\
**Description:** Patch release with minor bug fixes / enhancements

* Added `*.xip.io`, `*.nip.io` and `*.sslip.io` as valid test domains.
* Added strongly typed value converter for the store entity picker property editor.
* Added missing validation events for Discount code add/update/remove.
* Added validation events to all entities to validate the uniqueness of aliases/codes.
* Added `Exists` methods to all entity services to make it easier to check for the existence of an entity.
* Fixed bug in product uniqueness logic throwing an error if you add a product with no uniqueness properties after one that is already in the cart ([#88](https://github.com/vendrhub/vendr/issues/88)).
* Fixed build script formatting the patch release timestamp incorrectly.
* Fixed error when removing items from a cart and using SQL CE. This was due to a SQL statement that doesn't work on SQL CE. Now updated to work across the board ([#89](https://github.com/vendrhub/vendr/issues/89)).
* Fixed bug where discount codes declared on deleted discounts couldn't be reused ([#91](https://github.com/vendrhub/vendr/issues/91)).
* Discount aliases are now validated before saving and display a friendly error message ([#91](https://github.com/vendrhub/vendr/issues/91)).
* Changed picker property editor 'add' buttons to use a button element, rather than a link tag ([#86](https://github.com/vendrhub/vendr/issues/86)).
* Changed table view 'create' buttons to use a button element, rather than a link tag ([#87](https://github.com/vendrhub/vendr/issues/87)).
* Implemented friendlier display of validation errors ([#91](https://github.com/vendrhub/vendr/issues/91)).

### v1.1.1

**Date:** 2020-04-29\
**Description:** Patch release with minor bug fixes/enhancements

* Fixed issue with the v1.1.0 NuGet package not copying email templates to the Views folder 🤦‍♂️.

### v1.1.0

**Date:** 2020-04-29\
**Description:** Minor release with new features and some minor bug fixes/enhancements

* Added "Unlimited" checkbox to discount codes to allow them to have unlimited usage ([#50](https://github.com/vendrhub/vendr/issues/50)).
* Added basic Order/Payment Status filters to the Order list ([#63](https://github.com/vendrhub/vendr/issues/63)).
* Added escape key shortcut to close Discount rule/rewards settings editor dialog ([#60](https://github.com/vendrhub/vendr/issues/60)).
* Added feedback when copying order details to clipboard ([#22](https://github.com/vendrhub/vendr/issues/22)).
* Added a new store entity picker property editor to merge together all store entity pickers. Tax Class picker is now obsolete in favour of this new picker.
* Added email templates for the default Confirmation / Error emails.
* Fixed error when accessing transaction info for an order where the Payment Provider no longer existed. Now perform null checks on data ([#58](https://github.com/vendrhub/vendr/issues/58)).
* Fixed issue with NuGet packages not copying content files on upgrade. Added a PowerShell script to perform the copy.
* Fixed bug where customer details weren't being persisted into the dedicated fields in the database table (they are still present in the properties collection where they are referenced from 99% of the time) ([#85](https://github.com/vendrhub/vendr/issues/85)).
* Rule / Reward builders now support infinite editing when creating a rule so closing the editor via the 'close' link now goes back to the rule / reward picker. ([#81](https://github.com/vendrhub/vendr/issues/81)).
* Removed code for shipping method / payment method picker property editors in favour of the new store entity picker. These were never made public as actual property editors, as they were only used by the rule / reward builder so this won't be classed as a breaking change.

### v1.0.3

**Date:** 2020-04-24\
**Description:** Patch release with minor bug fixes/enhancements

* Added missing Product discount rule to discounts rule builder ([#76](https://github.com/vendrhub/vendr/issues/76)).
* Added basic Order Line Amount Reward that applies to all Order Lines.
* Product prices now thaw when the last product of a type is removed from the cart ([#71](https://github.com/vendrhub/vendr/issues/71)).
* Fixed error when saving a property with a null value. The property is now removed if the value is null ([#78](https://github.com/vendrhub/vendr/issues/78)).
* Changed the name of the Products Order Line Amount Reward to Order Line (with Product) Amount Reward as it's more descriptive of its purpose.

### v1.0.2

**Date:** 2020-04-15\
**Description:** Patch release with minor bug fixes/enhancements

* Added the ability to delete an order from the action menu.
* Added permission checks to all entity controller actions.
* Fixed ability to delete orders ([#49](https://github.com/vendrhub/vendr/issues/49)).
* Fixed issue with orders not finalizing if an error occurs sending emails. Email sending is now wrapped in a try-catch that logs errors to the error log instead ([#52](https://github.com/vendrhub/vendr/issues/52)).
* Fixed bug in EmailTemplateService.SendEmail where it wasn't sent to the supplied To email address unless "Send to Customer" on the email template was checked. This setting now only applies if you call the SendEmail method version that accepts an Order. The signature with the explicit `toEmailAddress` parameter will always send to the provided email address ([#54](https://github.com/vendrhub/vendr/issues/54)).
* Percentage reward inputs now only accept decimals ([#59](https://github.com/vendrhub/vendr/issues/59)).
* Fixed property discount rule, property alias field description describing the wrong thing ([#62](https://github.com/vendrhub/vendr/issues/62)).
* Changed payment status colours so Authorized is now blue and Refunded is orange so that Refunded doesn't look like an error ([#61](https://github.com/vendrhub/vendr/issues/61)).

### v1.0.1

**Date:** 2020-04-06\
**Description:** Patch release with minor fixes found post-launch

* Fixed the wrong license URL displayed in the installer.
* Fixed stock input field not allowing a stock level greater than 100 ([#44](https://github.com/vendrhub/vendr/issues/44)).
* Fixed stock input field rounding decimal stock levels on save ([#45](https://github.com/vendrhub/vendr/issues/45)).
* Updated all caches to use a `GetOrAddIfNotNull` method to ensure null entities don't end up in the internal cache.

## v1.0.0

**Date:** 2020-03-30\
**Description:** Initial Vendr release
