# Product Upgrades

This document describes when and what product updates are rolled out on Umbraco Cloud.

## What products are auto-upgraded?

* Umbraco CMS patch updates
* Forms patch updates
* Deploy
* Internal Umbraco Cloud services (generally these updates will not affect running websites but in some cases, if they do we will notify Umbraco Cloud users via the status page)

When minor upgrades are available, you will need an additional mainline environment on your project in order to get the new version. Read the [Minor Upgrades](minor-upgrades.md) article for more details.

## When do upgrades happen?

* The status page will include all important rollout information: [**https://status.umbraco.io/**](https://status.umbraco.io/)
* We will release product updates only on **Tuesday**
* The decision to roll out an upgrade will be made no later than the **Thursday** prior and the status page will be updated accordingly
* A product upgrade will be rolled out if:
  * A fix needs to be shipped due to a critical issue in any product
  * A patch version of Umbraco Core is ready for release
  * A new version of Deploy is ready for release
  * A new version of Forms is ready for release
* Umbraco Cloud reserves the right to roll out an emergency product fix to fix a critical issue at any time

{% hint style="info" %}

Your project will not be auto-upgraded if your environments aren't running the same **minor version**. For example, when upgrading a project to a new minor version, one environment may be running 10.6.x while another runs 10.7.x.

{% endhint %}

## The auto upgrade rollout process

Before a live upgrade is rolled out on Umbraco Cloud:

* Write release notes and include special upgrade instructions and/or blog posts if necessary
* Create a new version on the issue tracker
* Take the build from AppVeyor and push to NuGet
* Update our.umbraco.com release page
* Update Umbraco Cloud’s site creation engine with the new version so that all new sites are built with the latest version
* Run the auto-upgrader on Umbraco Cloud on a subset of test sites to verify there are no issues
* Run the auto-upgrader on all Umbraco Cloud sites

## The process of auto-upgrading a Umbraco Cloud project

This describes how a Umbraco Cloud project is auto-upgraded:

* The upgrade payload will have been created for the specific product(s) being upgraded
* The payload is a set of files (such as DLLs, and other ASP.NET website files)
* The upgrader will verify that the home page of all the environments in the mainline environment is healthy, meaning they don’t return an HTTP status error. If all environments are ok, it will proceed.
* The upgrader will take a snapshot of the left-most environments home page including its HTTP status code result and its HTML contents.
* The payload is deployed to the left-most environments Git repository and committed with a tag for the product version being updated. This new Git repository commit will replace the Umbraco product assembly (DLL) files along with other product files such as files located in /umbraco, /umbraco\_client folders
* The normal Umbraco Cloud deployment process is invoked and the repository files are deployed to the website
* The upgrader will automatically ensure the web.config version and the database version are updated so that the Installer/upgrade page is not shown
* The upgrader will verify that the new HTTP status code returned from the left-most environments home page is OK and will verify that the HTML contents of the home page match that of the snapshot originally taken.
* If either of these tests fails we will be notified and Umbraco will take appropriate measures to roll back the site to its previous state
* The failed upgrade is then tracked for reporting and the customer will be notified if necessary
* When the left-most environment is upgraded successfully, the upgrader will continue this same process for the next environment in the chain.

{% hint style="info" %} Changes for patches might appear on left-most environment, even if they have already been applied to Live. The environments will not be synchronized during the upgrade process. This is because synchronization risks pushing other apparent changes from one environment to another. Those changes will need to be deployed. Once that has been done, the environments will be in sync again. {% endhint %}

## How do baseline updates work?

The upgrade process for patch and minor versions is the same for projects with child projects created off them. The difference is that we always upgrade the baseline as the first project, and afterward we upgrade the child projects. This ensures that any updates done from the baseline will also send the upgrade to the children.

## What is a breaking change?

It is important that developers understand what is considered a breaking change in Umbraco products. In most cases, an auto-upgrade will not have any breaking changes and we strive to ensure this is the case. However, in some rare cases, developers may be using Umbraco's internal code not intended for public consumption. In some releases, that code may change. It is important for developers to understand the risks of using Umbraco code that is not considered a breaking change when it is updated. This may directly affect a site that is auto-upgraded.

What is a breaking change is documented here: [https://our.umbraco.com/documentation/development-guidelines/breaking-changes](https://our.umbraco.com/documentation/development-guidelines/breaking-changes)

## Can I opt out of product auto upgrades?

No, it´s not possible to opt-out of product auto upgrades on Umbraco Cloud.

To support a site on Umbraco Cloud, all sites must run the latest versions of our products. That way, we know the sites are running in the most stable state.
