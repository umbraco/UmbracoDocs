---
description: >-
  Learn how to manually upgrade your Umbraco Cloud project to the latest version
  of the Umbraco projects.
---

# Upgrade your projects manually

In some cases, you might need to upgrade your Umbraco Cloud project manually. It's similar to how you would upgrade any other Umbraco project but includes a few extra and **important** steps.

Umbraco Cloud project uses Umbraco Forms and Umbraco Deploy. This means there are some dependencies you need to consider when upgrading your Umbraco Cloud project manually.

## Why and when would you do a manual upgrade?

By default, all Umbraco Cloud projects are automatically upgraded when we release new patches (like 8.8.**1**) to the Umbraco CMS. This also goes for Umbraco Forms and Umbraco Deploy.

When a new _minor_ version (like 8.**8**) is released, the upgrade is applied to the Umbraco Cloud engine, and **not to the individual projects**. The same goes for the release of new major versions (like **10**.0).

For minor and major versions, there will be an option on your left-most mainline environment to apply the upgrade. The Umbraco Cloud engine will take care of the entire process, and you only need to ensure everything works when upgrade is complete.

It is recommended to use the automatic and _semi-automatic_ upgrade options provided to you as part of your Umbraco Cloud project. It's also possible to upgrade your Umbraco Cloud project manually. This can be done with both patches and minor and major versions.

Manually upgrading your Cloud project allows you to test out new features and functionality on your local machine before applying them to your Cloud environments.

## Product dependencies

When manually upgrading a Umbraco Cloud project, it is important to consider the dependencies that exist between the  products on Umbraco Cloud. To fully benefit from Umbraco Cloud, be sure to check for these dependencies before upgrading to a new minor or major version of Umbraco CMS.

## Upgrade order

When you are manually upgrading your Umbraco Cloud project and need to upgrade two or more products, follow this order:

1. Umbraco CMS
2. Umbraco Forms
3. Umbraco Deploy

[Learn more about the product dependencies on Umbraco Cloud](../product-dependencies.md)

## [How to upgrade Umbraco CMS manually](manual-cms-upgrade.md)

Make sure to follow the steps carefully when upgrading your Umbraco Cloud project to the newest version of Umbraco CMS.

## [How to upgrade Umbraco Forms manually](https://docs.umbraco.com/umbraco-forms/installation/manualupgrade)

There are no Umbraco Cloud-related files to be aware of when upgrading Umbraco Forms. Therefore you can follow the general Umbraco Forms upgrade notes. When upgrading Umbraco Forms, be sure to also consult the [version specific upgrade notes](https://docs.umbraco.com/umbraco-forms/installation/version-specific) to learn about potential breaking changes and common pitfalls.

## [How to upgrade Umbraco Deploy manually](manual-upgrade-deploy.md)
