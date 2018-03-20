# Upgrade your Umbraco Cloud projects manually

In this article you can read about how to manually upgrade your Umbraco Cloud project. It's very similar to how you would upgrade any other Umbraco project, just including a few extra and **very important** steps. 

Umbraco Cloud project uses Umbraco Forms and Umbraco Deploy, which means there are also some dependencies you need to consider, when upgrading your Umbraco Cloud project manually.

## Why and when would you do a manual upgrade

By default all Umbraco Cloud projects are automatically upgraded when we release new patches (e.g. 7.8.**1**) to the Umbraco CMS as well as Umbraco Forms and Umbraco Deploy. When we release a new *minor* version (e.g 7.**8**) the upgrade is applied to the Umbraco Cloud engine, and **not to the individual projects** - the same goes for the release of new *major* versions (e.g. **8**.0). For these minor and major versions there will be an option on your Umbraco Cloud Development environment to apply the upgrade - the Umbraco Cloud engine will take care of the entire process, and you only need to make sure everything works after the upgrade has been applied.

We always recommend using the automatic and *semi-automatic* upgrade options provided to you as part of your Umbraco Cloud project. With that said, it's also possible to upgrade your Umbraco Cloud project manually - this can be done with both patches and minor and major versions. 

Common reasons for doing manual upgrades on Umbraco Cloud

* You've opted out of the automatic upgrades, and now you want to upgrade your project
* You want to test the newest minor or major version locally before deploying to the Cloud environments

## Product dependencies

When you are manually upgrading an Umbraco Cloud project it's important that you take into account the dependencies that exist between the products on Umbraco Cloud. To continue reaping the full benefits of Umbraco Cloud make sure to check for dependencies when you upgrade to a new minor or major version of Umbraco CMS.

[Learn more about the product dependencies on Umbraco Cloud](../Product-Dependencies)

## [How to upgrade Umbraco CMS manually](Manual-CMS-upgrade.md)

## How to upgrade Umbraco Forms manually

## How to upgrade Umbraco Courier / Umbraco Deploy manually