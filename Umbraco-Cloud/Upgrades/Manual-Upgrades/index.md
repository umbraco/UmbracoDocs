---
versionFrom: 7.0.0
---

# Upgrade your Umbraco Cloud projects manually

In this article, you can read about how to manually upgrade your Umbraco Cloud project. It's very similar to how you would upgrade any other Umbraco project, but including a few extra and **very important** steps.

Umbraco Cloud project uses Umbraco Forms and Umbraco Deploy, which means there are also some dependencies you need to consider when upgrading your Umbraco Cloud project manually.

## Why and when would you do a manual upgrade

By default, all Umbraco Cloud projects are automatically upgraded when we release new patches (e.g. 7.8.**1**) to the Umbraco CMS as well as Umbraco Forms and Umbraco Deploy. When we release a new *minor* version (e.g 7.**8**) the upgrade is applied to the Umbraco Cloud engine, and **not to the individual projects** - the same goes for the release of new *major* versions (e.g. **8**.0). For these minor and major versions, there will be an option on your Umbraco Cloud Development environment to apply the upgrade. The Umbraco Cloud engine will take care of the entire process, and you only need to make sure everything works after the upgrade has been applied.

We always recommend using the automatic and *semi-automatic* upgrade options provided to you as part of your Umbraco Cloud project. With that said, it's also possible to upgrade your Umbraco Cloud project manually - this can be done with both patches and minor and major versions.

A reason for doing a manual upgrade of your Cloud project, could be if you want to test out new features and functionality on your local machine before they are applied to your Cloud environments.

## Product dependencies

When you are manually upgrading an Umbraco Cloud project it's important that you take into account the dependencies that exist between the products on Umbraco Cloud. To continue reaping the full benefits of Umbraco Cloud make sure to check for dependencies when you upgrade to a new minor or major version of Umbraco CMS.

## Upgrade order

When you are manually upgrading your Umbraco Cloud project and you need to upgrade two or more products, this is the order you need to follow:

1. Umbraco CMS
2. Umbraco Forms
3. Umbraco Deploy / Courier

[Learn more about the product dependencies on Umbraco Cloud](../Product-Dependencies)

## Video Tutorial

<iframe width="800" height="450" src="https://www.youtube.com/embed/yuHUxI_rplE?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

You can find the full playlist here: [Manually upgrade your Umbraco Cloud project](https://www.youtube.com/playlist?list=PLG_nqaT-rbpx1lzrdSIqPyJrpRf_z4DS9)

## [How to upgrade Umbraco CMS manually](Manual-CMS-upgrade.md)

Make sure to follow the steps carefully when upgrading your Umbraco Cloud project to the newest version of Umbraco CMS.

## [How to upgrade Umbraco Forms manually](https://our.umbraco.com/documentation/Add-ons/UmbracoForms/Installation/ManualUpgrade)

There are no Umbraco Cloud related files to be aware of when upgrading Umbraco Forms. Therefore you can follow the general Umbraco Forms upgrade notes. Be sure to take a look at the [version-specific upgrade notes](https://our.umbraco.com/documentation/Add-ons/UmbracoForms/Installation/Version-Specific), as there might be extra steps you need to take depending on the version you are upgrading from and to.

## [How to upgrade Umbraco Courier / Deploy manually](Manual-Deploy-and-Courier-Upgrade)
