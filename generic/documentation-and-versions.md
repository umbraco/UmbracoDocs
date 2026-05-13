---
description: >-
  The Umbraco Documentation is versioned based on major versions of the Umbraco
  CMS. Learn more about how that works in this article.
---

# Versioning Strategy

The Umbraco Documentation covers multiple versions across different Umbraco products. This article explains how the documentation is versioned and how to use it effectively.

The major version of Umbraco CMS is used to version the documentation for the following Umbraco products:

* The Umbraco CMS
* Umbraco Commerce
* Umbraco Deploy
* Umbraco Engage
* Umbraco Forms
* Umbraco UI Builder
* Umbraco Workflow

Documentation for Umbraco Cloud, Umbraco Heartcore, and Umbraco Compose does not follow CMS versioning, as these are all Software as a Service (SaaS) products.

## Major vs Minor Versions

The Umbraco Documentation covers all supported versions of the Umbraco CMS and its official add-on products. For each supported major version of Umbraco CMS, a corresponding version of the documentation exists for both the CMS and the add-on products.

Each documentation version reflects the latest minor release within the current major version.

When a Release Candidate (RC) for a new major version of an Umbraco product is released, a new documentation version will be available. Once the major version is officially released, its documentation becomes the default version on the documentation site.

## Long Term Support (LTS) and End of Life (EOL)

The Umbraco Documentation follows the [LTS and EOL strategies outlined for the Umbraco CMS](https://umbraco.com/products/knowledge-center/long-term-support-and-end-of-life/).

Documentation for each major version remains available until that version reaches End of Life. After EOL:

* Documentation for standard releases is unpublished after 1 month.
* Documentation for LTS versions is unpublished after 3 months.

Unpublished documentation versions remain accessible in the [GitHub](https://github.com/umbraco/UmbracoDocs/tree/umbraco-eol-versions) repository.

{% hint style="info" %}
We reserve the right to change the strategy for EOL versions. This is due to the fact that we want to thoroughly test the process before making a decision.
{% endhint %}

## Contributing to a Specific Version

The Umbraco Documentation is synchronized with the open-source [UmbracoDocs](https://github.com/umbraco/UmbracoDocs) repository on GitHub. Read the [Contribution documentation](https://docs.umbraco.com/contributing) to learn more about contributions and how to get started.

The `main` branch of the `UmbracoDocs` repository contains all active documentation versions for all Umbraco products. A dedicated directory exists for each published major version of Umbraco CMS, containing the relevant documentation for that version and its associated products.

{% hint style="info" %}
Documentation for Umbraco 8 and earlier versions is maintained in the  `legacy-docs` branch. These legacy versions are published separately on [Our Umbraco website](https://our.umbraco.com/documentation).
{% endhint %}
