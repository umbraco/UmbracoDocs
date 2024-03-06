---
description: This is the guide for upgrading existing installations in general.
---

{% hint style="warning" %}
This page is a work in progress. It will be updated as the software evolves.
{% endhint %}

# Upgrade your project

In this article, you will find everything you need to upgrade your Umbraco CMS project.

You will find instructions on how to upgrade to a new minor or major version as well as how to run upgrades unattended.

* [Before you upgrade](./#before-you-upgrade)

## Before you upgrade

The following lists a few things to be aware of before initiating an upgrade of your Umbraco CMS project.

* Sometimes there are exceptions to general upgrade guidelines. These are listed in the [**version-specific guide**](version-specific/). Be sure to read this article before moving on.
* Check if your setup meets the [requirements](../requirements.md) for the new versions you will be upgrading your project to.
* Things may go wrong for different reasons. Be sure to **ALWAYS** keep a backup of both your site's files and the database. This way you can always return to a version that you know works.
* Before upgrading to a new major version, check if the packages you're using are compatible with the version you're upgrading to. On the package's download page, in the **Project compatibility** area, click **View details** to check version-specific compatibility.

{% hint style="info" %}
It is necessary to run the upgrade installer on each environment of your Umbraco site. This means that you need to repeat the steps below on each of your environments in order to complete the upgrade.
{% endhint %}
