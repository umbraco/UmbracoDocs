# Product Upgrades

This document describes when and what product updates are rolled out on Umbraco Cloud.

## What products are auto-upgraded?

* Umbraco CMS
* Forms
* Deploy
* Internal Umbraco Cloud services (generally these updates will not affect running websites but in some cases, if they do we will notify Umbraco Cloud users via the status page)

By default, automatic upgrades occur for patch and minor updates, while major updates require manual action. You can [opt out of automatic minor and/or patch upgrades](#can-i-opt-out-of-automated-upgrades).

## When do upgrades happen?

Automatic upgrades start in your project's upgrade windows. An upgrade window is a 4-hour period in the week where automatic upgrades are allowed to start. An upgrade that starts late in a window can finish after the window has closed.

* Each project starts with a default schedule. You can select the windows that suit your project from the Cloud Portal. See the [Upgrade Windows](minor-upgrades.md#upgrade-windows) section for the default schedule and how to change it.
* A product upgrade is made available for automatic upgrades when:
  * A fix needs to be shipped due to a critical issue in any product
  * A new version of Umbraco CMS is ready for release
  * A new version of Deploy is ready for release
  * A new version of Forms is ready for release
* Umbraco Cloud reserves the right to roll out a critical security fix at any time, outside of your upgrade windows. These security upgrades are announced on the status page: [**https://status.umbraco.io/**](https://status.umbraco.io/)

{% hint style="info" %}

Your project will not be auto-upgraded if your environments aren't running the same **minor version**. For example, when upgrading a project to a new minor version, one environment may be running 10.6.x while another runs 10.7.x.

{% endhint %}

## The auto upgrade rollout process

Before a live upgrade is rolled out on Umbraco Cloud:

* Release notes, special upgrade instructions and/or blog posts are published when necessary
* Update Umbraco Cloud’s site creation engine with the new version so that all new sites are built with the latest version
* Run the auto-upgrader on Umbraco Cloud on a subset of internal test sites to verify there are no issues
* Make the release available for automatic upgrades. Each project is then upgraded in one of its upgrade windows

## The process of auto-upgrading a Umbraco Cloud project

This describes how a Umbraco Cloud project is auto-upgraded:

* The upgrade starts during one of the project's upgrade windows. The window only limits when the upgrade can start, so later environments can be upgraded after the window has closed
* The upgrade payload will have been created for the specific product(s) being upgraded
* The payload is a set of files (such as DLLs, and other ASP.NET website files)
* The upgrader will verify that the home page of all the environments in the mainline environment is healthy, meaning they don’t return an HTTP status error. If all environments are ok, it will proceed.
* The upgrader will take a snapshot of the left-most environments home page including its HTTP status code result and its HTML contents.
* The payload is deployed to the left-most environments Git repository and committed with a tag for the product version being updated. This new Git repository commit will replace the Umbraco product assembly (DLL) files along with other product files such as files located in `/umbraco`, `/umbraco_client` folders
* The normal Umbraco Cloud deployment process is invoked and the repository files are deployed to the website
* The upgrader will automatically ensure the web.config version and the database version are updated so that the Installer/upgrade page is not shown
* The upgrader will verify that the new HTTP status code returned from the left-most environments home page is OK and will verify that the HTML contents of the home page match that of the snapshot originally taken.
* If either of these tests fails we will be notified and Umbraco will take appropriate measures to roll back the site to its previous state
* The failed upgrade is then tracked for reporting and the customer will be notified if necessary
* When the left-most environment is upgraded successfully, the upgrader will continue this same process for the next environment in the chain.

{% hint style="info" %} Changes for patches might appear on left-most environment, even if they have already been applied to Live. The environments will not be synchronized during the upgrade process. This is because synchronization risks pushing other apparent changes from one environment to another. Those changes will need to be deployed. Once that has been done, the environments will be in sync again. {% endhint %}

## What is a breaking change?

It is important that developers understand what is considered a breaking change in Umbraco products. In most cases, an auto-upgrade will not have any breaking changes and we strive to ensure this is the case. However, in some rare cases, developers may be using Umbraco's internal code not intended for public consumption. In some releases, that code may change. It is important for developers to understand the risks of using Umbraco code that is not considered a breaking change when it is updated. This may directly affect a site that is auto-upgraded.

What is a breaking change is documented here: [https://our.umbraco.com/documentation/development-guidelines/breaking-changes](https://our.umbraco.com/documentation/development-guidelines/breaking-changes)

## Can I opt out of automated upgrades?

Yes. You can enable or disable automatic minor and/or patch upgrades from the Cloud Portal:

1. Go to your Umbraco Cloud project.
2. Navigate to **Configuration** -> **Automatic Upgrades**.
3. Toggle **Automatic Minor Upgrades** or **Automatic Patch Upgrades** on or off.

To keep automatic upgrades but control when they start, change your [upgrade windows](minor-upgrades.md#upgrade-windows) instead.

### Minor Upgrades

New projects have automatic minor upgrades enabled by default. When disabled, you are responsible for upgrading to new minor versions manually. See the [Minor Upgrades](minor-upgrades.md) article for details.

### Patch Upgrades

By default, all Umbraco Cloud projects are automatically upgraded to new patch versions during their upgrade windows, including security patches. This ensures all sites run the most stable and secure versions of our products.

If your project requires full control over when patches are applied, you can disable automated patch upgrades.

{% hint style="danger" %}
When you disable automated patch upgrades, you are responsible for keeping your project up to date. Falling behind on patches may affect your eligibility for support and can expose your project to known security vulnerabilities.
{% endhint %}

{% hint style="warning" %}
We reserve the right to patch critical vulnerabilities, also outside of your upgrade windows and when automatic upgrades are disabled. This ensures the Umbraco Cloud platform remains stable and secure.
{% endhint %}

## Related Information

If your Cloud website uses IP filtering on the origin, ensure the correct IP addresses are allowlisted to maintain connectivity during upgrades. See [Static Outbound IP Addresses for Umbraco Cloud](../../../expand-your-projects-capabilities/external-services/static-outbound-ip-addresses.md) for more details.
