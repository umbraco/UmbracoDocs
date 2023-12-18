# Release Notes

In this section, we have summarized the changes to Umbraco Commerce released in each version. Each version is presented with a link to the [Umbraco Commerce issue tracker](https://github.com/umbraco/Umbraco.Commerce.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version, check the breaking changes in the [Version Specific Upgrade Notes](getting-started/installation/version-specific-upgrades.md) article.
{% endhint %}

We've listed here all the changes going back to the launch of Umbraco Commerce in 2023. For details of releases for **Vendr**, refer to the [Change log file on Github](changelog-archive/Vendr-core.md).

## Release History

In this section, you can find the release notes for each version of Umbraco Commerce. For each major version, you can find the details about each release.

<details>

<summary>Version 12</summary>

#### [12.1.2](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.1.2) (October 18th 2023)

* Fixed UI spelling mistakes as documented in issue [#427](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/427).
* Fixed issue where adding a product with a uniqueness property, and then adding the same product without a uniqueness property would replace the initial orderline, rather than adding a new one [#438](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/438)
* Fixed localization issue where `-1` in querystrings would get incorrectly formatted. Root ids are now formatted with an invarient culture.

#### [12.1.1](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.1.1) (September 13th 2023)

* Fixed issue with Storefront API causing value converter error due to multiple value converts for the same property editor being found. Storefront API value converters are now no longer discoverable. They are instead registered only when `AddStorefrontApi` is called on the `IUmbracoCommerceBuilder` instance [#429](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/429)

#### [12.1.0](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.1.0) (August 30th 2023)

* All items listed under 12.1.0-rc1.
* Updated `Umbraco.Commerce` package to have dependency on `Umbraco.Commerce.Cms.Web.Api.Storefront` so that an explicit dependency isn't needed.
* Allow overriding of `SameSite`/`Path` for Umbraco Commerce cookies.
* Updated product adapter to resolve product details correctly from child node variants.

#### [12.1.0-rc1](https://github.com/umbraco/Umbraco.Commerce.Issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.1.0) (August 15th 2023)

* Added headless Storefont API.
* Added templating functionality to payment provider settings to allow dynamic value resolution. For example the template `{Order.OrderNumber}` would inject the order number into the given setting value.
* Added `IProductSnapshotWithImage` interface to allow product snapshots to expose a product image.
* Updated default order number template from `CART-{0}` to `ORDER-{0}`.
* Updated product adapter to resolve product details correctly from child node variants.

#### [12.0.0](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.0.0) (July 5th 2023)

* [Initial product launch](https://umbraco.com/blog/umbraco-commerce-release/).

</details>

<details>

<summary>Version 10</summary>

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

</details>
