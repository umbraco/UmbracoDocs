---
description: >-
  Get an overview of the things changed and fixed in each version of Umbraco
  Commerce.
---

# Release Notes

In this section, we have summarized the changes to Umbraco Commerce released in each version. Each version is presented with a link to the [Commerce issue tracker](https://github.com/umbraco/Umbraco.Commerce.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading, they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version, check the breaking changes in the [Version Specific Upgrade Notes](../upgrading/version-specific-upgrades.md) article.
{% endhint %}

## Release History

This section contains the release notes for Umbraco Commerce 18, including all changes for this version.

#### 18.1.3 (21st Aug 2026)

* Fixed a startup crash on large stores during the customer data migration ([#883](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/883)).
* Fixed cart cleanup failing with a foreign key constraint error on large stores ([#882](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/882)).
* Fixed payment provider callback URLs trusting a spoofable `X-Original-Host` header.

#### 18.1.2 (17th Aug 2026)

* Fixed a backoffice crash when viewing an order linked to a customer by member key or another non-ID reference ([#878](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/878)).
* Fixed data corruption from a discount migration that could invalidate member-group discount rules ([#877](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/877)).
* Fixed missing database indexes causing slow order and order line deletes on large stores ([#879](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/879)).
* Fixed missing price fields in the dynamic shipping rate range editor ([#880](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/880)).

#### 18.1.0 (12th Aug 2026)

* Added customer management, including customer records, addresses, communication history, and statistics that stay in sync with orders automatically.
* Added support for editing an order after it has been finalized and authorized, including changing line quantities, adding or removing lines, and reconciling discount and gift card codes.
* Added partial capture support for payment providers, with the authorized and captured amount both shown in the transaction history.
* Fixed a database migration failure when importing customer records from legacy orders that have no first or last name (#876).

#### 18.0.5 (11th Aug 2026)

* Fixed email rendering crash when there's no active HTTP request (#872).
* Fixed cart cleanup timing out on stores with a large number of old carts (#874).

#### 18.0.4 (29th Jul 2026)

* Added logging to record why an order is moved to the error status, and when a payment is reset or redirected through a payment provider's cancel or error URL (#866).

#### 18.0.3 (27th Jul 2026)

* Fixed a second order save being triggered while frozen prices were recalculating, which could cause a concurrency error.
* Improved logging when an order calculation fails, so the underlying cause and order details are recorded.
* Fixed the cart becoming unusable when an order line's product can no longer be found (#863).
* Fixed creating a product picker Data Type failing with a "property editor not found" error.
* Fixed product attribute and preset changes requiring the Settings section instead of the Commerce section.

#### 18.0.2 (15th Jul 2026)

* Fixed cart conversion "Reached Checkout" and "Purchased" totals drifting for past periods (#835).
* Fixed the product picker in the discount rule editor losing store context.
* Tolerate legacy member group names in discount rule settings (#839).
* Raise `CartAbandonedNotification` from the abandoned cart pipeline (#805).
* Guard against a null content node in `StockPropertyValueConverter` (#848).
* Fixed a crash in the variant picker when a variant has no price (#829).
* Fixed a `NULL dateTimeUtc` error in the transaction activity migration (#831).
* Preserve the original stack trace on errors surfaced by `PollyExecutionStrategyBase` (#815).
* Fixed `DateTime` settings failing to parse space-separated values.
* Reset (rather than cancel) the transaction when a customer abandons checkout (#789).
* Fixed order transaction, export authorization, and top-buyers analytics bugs.
* Use the CMS scope in `StoreTelemetryRepository` to avoid querying CMS tables against the Commerce database.

#### 18.0.1 (08th Jul 2026)

* Fixed a false-positive "transaction amount changed" exception in `BeginPaymentFormAsync`.
* Fixed a `NullReferenceException` when using dynamic shipping with no product measurements or no store location.
* Fixed a `NullReferenceException` when a dynamic shipping rate range provider alias cannot be resolved.

#### 18.0.0 (23rd Jun 2026)

* Final release for Umbraco v18. See 18.0.0-rc1 below for the breaking changes introduced in this major.

#### 18.0.0-rc1 (05th Jun 2026)

* Initial release candidate for Umbraco v18. 
  - 3 startup notification handlers are now async (INotificationAsyncHandler); sync Handle removed — override HandleAsync instead.
  - 7 public Swagger handler classes removed (CMS v18 dropped Swashbuckle); OpenAPI output is unchanged, customizations move to the Microsoft transformer APIs.
  - Obsolete Udi-based VariantEditorLayoutItem constructors removed.
