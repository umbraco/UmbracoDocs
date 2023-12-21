---
description: >-
  The Umbraco Documentation is versioned based on major versions of the Umbraco
  CMS. Learn more about how that works in this article.
---

# Versioning Strategy

The Umbraco Documentation covers multiple versions of multiple different products. This article explains how we version the documentation as well as how to use it when reading the documentation.

The major version of Umbraco CMS is currently used for versioning the documentation for the following Umbraco products:

* The Umbraco CMS
* Umbraco Forms
* Umbraco Deploy
* Umbraco Workflow

The documentation for Umbraco Cloud and Umbraco Heartcore is not following the CMS versioning as these are both Software as a Service (SaaS) projects.

## Major vs minor versions

The Umbraco Documentation covers all supported versions of the Umbraco CMS as well as the official Umbraco add-ons. For each supported **major** version of Umbraco CMS, a version of the documentation for CMS and the add-ons exists.

The documentation for each Umbraco product will always document the latest **minor** version of the current **major** version.

When an RC for a new **major** version of an Umbraco product is released, a new version of that documentation will be available. When the major version is released, the documentation for it will be the new **default version of the Umbraco Documentation**.

## Long Term Support (LTS) and End of Life (EOL)

The Umbraco Documentation follows the [LTS and EOL strategies outlined for the Umbraco CMS](https://umbraco.com/products/knowledge-center/long-term-support-and-end-of-life/).

This means that the Umbraco Documentation will cover each major version of the Umbraco product until they are EOL. After a major version is EOL the documentation for that version will be unpublished after 1 month extended to 3 months for LTS versions.

Unpublished versions of the Umbraco Documentation will continue to be available from GitHub.

{% hint style="info" %}
We reserve the right to change the strategy for EOL versions. This is due to the fact that we want to thoroughly test the process before making a decision.
{% endhint %}

## Contributing to a specific version

The Umbraco Documentation is synchronized with a GitHub repository, [UmbracoDocs](https://github.com/umbraco/UmbracoDocs), which is open source. Read the [Contribution documentation](contribute/getting-started.md) to learn more about contributions and how to get started.

The `main` branch on the repository holds all versions of the documentation for all Umbraco products, including Cloud and Heartcore. A directory exists for each published **major** version of Umbraco CMS, under which you can find the corresponding documentation for each Umbraco product.

{% hint style="info" %}
Documentation for Umbraco 8 and earlier versions are gathered in a single branch, `legacy-docs`. These versions are live on a different site: [Our](https://our.umbraco.com/documentation).
{% endhint %}
