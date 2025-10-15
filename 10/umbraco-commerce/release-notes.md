---
description: >-
  Get an overview of the things changed and fixed in each version of Umbraco Commerce.
---

# Release Notes

In this section, we have summarized the changes to Umbraco Commerce released in each version. Each version is presented with a link to the [Commerce issue tracker](https://github.com/umbraco/Umbraco.Commerce.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version, check the breaking changes in the [Version Specific Upgrade Notes](./upgrading/version-specific-upgrades.md) article.
{% endhint %}

## Release History

This section contains the release notes for Umbraco Commerce 10 including all changes for this version.

#### [10.0.13](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.0.13) (July 11th 2024)

* Fixed issue with stock synchronizer prematurely looking up a store [#536](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/536).

#### [10.0.12](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.0.12) (July 3rd 2024)

* Added pessimistic locking to the payment provider callback endpoint to prevent concurrency issues if the endpoint is called too many times at once [#533](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/533).
* Fixed percentage discounts not taking the stores rounding method into account during calculation [#506](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/506).
* Fixed issue where order lines with a zero value would cause a concurrency exception due to the fact their prices aren't frozen but the order recalculation process was attempting to refreeze them.
* Updated Order properties to trim whitespace around values to prevent unexpected behavior [#528](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/528).

#### [10.0.11](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.0.11) (April 23rd 2024)

* Fixed error in `SearchOrder` when searching with date ranges [#496](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/496).

#### [10.0.10](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.0.10) (April 8th 2024)

* Fixed properties set in the background from an entity action lost when resaving the entity from the UI after the action (wasn't fully fixed in 10.0.9) [#472](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/472).
* Added support for localhost sub domains in dev license [#493](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/493).
* Added a `WithUmbracoBuilder` extension for `IUmbracoCommerceBuilder` to allow access to the Umbraco configuration within an Umbraco Commerce registration.

#### [10.0.9](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.0.9) (March 27th 2024)

* Fixed properties set in the background from an entity action lost when resaving the entity from the UI after the action [#472](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/472).
* Fixed unable to override cart editor view like you can the order editor view [#474](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/474).

#### [10.0.8](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.0.8) (March 3rd 2024)

* Fixed issue with date range order searches not working correctly [#468](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/468).

#### 10.0.7 (February 15th 2024)

* Fixed error in SafeLazy not taking null into account and so causing errors when an entity cache entry is evicted [#466](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/466).
* Incremented `Newtonsoft.Json` version dependency to 13.0.1 as 13.0.0 doesn't exist on NuGet anymore [#451](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/451).

#### 10.0.6 (February 6th 2024)

* Added licensing fallback to use any previously validated license within the last 7 days
* Updated `Umbraco.Licenses` version dependency to the latest
* Made `WithUmbracoCommerceBuilder` extension public to allow accessing the `IUmbracoCommerceBuilder` instance outside of the `AddUmbracoCommerce` call

#### [10.0.5](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.0.5) (December 13th 2023)

* Fixed Cross-site scripting (XSS) issue in email/print templates.

#### [10.0.4](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.0.4) (November 1st 2023)

* Use Microsoft.Data.SqlClient for migrations to support Azure connection strings [#443](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/443).
* Move system config files to `system.{}.config.json` to allow overriding as per the docs [#448](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/448).
* Updated order/cart editor config to allow `template` option for custom property rendering [#446](https://github.com/umbraco/Umbraco.Commerce.Issues/discussions/446).

#### [10.0.3](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.0.3) (October 18th 2023)

* Fixed UI spelling mistakes as documented in issue [#427](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/427).
* Fixed issue where adding a product with a uniqueness property, and then adding the same product without a uniqueness property would replace the initial orderline, rather than adding a new one [#438](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/438)
* Fixed localization issue where `-1` in querystrings would get incorrectly formatted. Root ids are now formatted with an invarient culture.

#### [10.0.2](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.0.2) (September 13th 2023)

* Allow overriding of `SameSite`/`Path` for Umbraco Commerce cookies.
* Updated `productSource` resolution to check for both `IPublishedContent` and `IEnumerable<IPublishedContent>` as it depends on the picker used and what its return type is.

#### [10.0.1](https://github.com/umbraco/Umbraco.Commerce.Issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.0.1) (August 15th 2023)

* Updated default order number template from `CART-{0}` to `ORDER-{0}`.
* Updated product adapter to resolve product details correctly from child node variants.

#### [10.0.0](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.0.0) (July 5th 2023)

* [Initial product launch](https://umbraco.com/blog/umbraco-commerce-release/).

## Legacy release notes

You can find the release notes for **Vendr** in the [Change log file on GitHub](../../13/umbraco-commerce/changelog-archive/Vendr-core.md).
