---
description: >-
  Get an overview of the things changed and fixed in each version of Umbraco
  Commerce.
---

# Release Notes

In this section, we have summarized the changes to Umbraco Commerce released in each version. Each version is presented with a link to the [Commerce issue tracker](https://github.com/umbraco/Umbraco.Commerce.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version, check the breaking changes in the [Version Specific Upgrade Notes](../upgrading/version-specific-upgrades.md) article.
{% endhint %}

## Release History

This section contains the release notes for Umbraco Commerce 16 including all changes for this version.

#### [16.1.0](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Acomponent%2Fcommerce+label%3Arelease%2F16.1.0) (11th Jul 2025)

* Added store theming options to store settings.
* Added abandoned cart notifier service to send emails & webhooks when carts become abandoned.
* Fixed regression with not being able to refund a payment [#710](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/710).
* Fixed bug in Safari browsers not persisting price property updates [#713](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/713).
* Fixed bug with gift cards not persisting remaining amount [#729](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/729).

#### 16.0.0 (12th Jun 2025)

* Version 16 final release.
* Fixed bug in property editors with store config not resolving the correct store [#721](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/721).
* Fixed stock input allowing stock levels below zero [#714](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/714).
* Fixed bug in price property editor not honoring extra decimal places config [#712](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/712).
  
#### 16.0.0-rc1 (28th May 2025)

Initial release candidate for Umbraco v16. This release doesn't contain any new features; rather, it's a v16 compatibility release.

* Updated to Umbraco CMS v16.
* Upgraded all third-party dependencies.
* Removed all obsolete code flagged for removal in v16.
