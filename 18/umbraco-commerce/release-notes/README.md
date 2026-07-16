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

#### 18.0.2 (15th Jul 2026)

* Fixed cart conversion "Reached Checkout" and "Purchased" totals drifting for past periods (#835).
* Fixed the product picker in the discount rule editor losing store context.
* Tolerate legacy member group names in discount rule settings (#839).
* Raise `CartAbandonedNotification` from the abandoned cart pipeline (#805).
* Guard against a null content node in `StockPropertyValueConverter` (#848).
* Fixed a crash in the variant picker when a variant has no price (#829).
* Fixed a `NULL dateTimeUtc` error in the transaction activity migration (#831).
* Preserve the original stack trace when `PollyExecutionStrategyBase` rethrows (#815).
* Fixed `DateTime` settings deserialization failing on space-separated values.
* Reset (rather than cancel) the transaction when a customer abandons checkout (#789).
* Fixed order transaction, export authorization, and top-buyers analytics bugs.
* Use the CMS scope in `StoreTelemetryRepository` to avoid querying CMS tables against the Commerce database.

#### 18.0.1 (08th Jul 2026)

* Fixed a false-positive "transaction amount changed" exception in `BeginPaymentFormAsync`.
* Fixed a `NullReferenceException` when using dynamic shipping with no product measurements or no store location.
* Fixed a `NullReferenceException` when a dynamic shipping rate range provider alias is unresolvable.

#### 18.0.0 (23rd Jun 2026)

* Final release for Umbraco v18. See 18.0.0-rc1 below for the breaking changes introduced in this major.

#### 18.0.0-rc1 (05th Jun 2026)

* Initial release candidate for Umbraco v18. 
  - 3 startup notification handlers are now async (INotificationAsyncHandler); sync Handle removed — override HandleAsync instead.
  - 7 public Swagger handler classes removed (CMS v18 dropped Swashbuckle); OpenAPI output is unchanged, customizations move to the Microsoft transformer APIs.
  - Obsolete Udi-based VariantEditorLayoutItem constructors removed.
