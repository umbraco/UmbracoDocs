---
description: The Umbraco Documentation is versioned based on major versions of the Umbraco CMS. Learn more about how that works in this article.
---

# Documentation and versions

The Umbraco Documentation covers multiple versions of multiple different products. This article explains how we version the documentation as well as how to use it when reading the documentation.

The major version of Umbraco CMS is currently used for versioning the entire Umbraco Documentation site.

{% hint style="info" %}
The versioning can be disregarded for any and all articles related to Umbraco Cloud and Umbraco Heartcore.

The documentation for Umbraco Cloud and Umbraco Heartcore currently appears with the same versioning as the Umbraco CMS. The plan is to create separate sites for each main Umbraco product; CMS, Cloud, and Heartcore.

Currently, there is no timeline for this change.
{% endhint %}

## Site-wide versioning

The Umbraco Documentation is versioned on a site-wide basis. This means that when the dropdown is used to change the version, it changes the version of the entire documentation site.

If the article you are currently viewing does not exist in the version you change to, you will be redirected to the documentation landing page.

## Major vs minor versions

The Umbraco Documentation covers all supported versions of Umbraco CMS. A version exists for each supported **major** version of Umbraco CMS.

When a Release Candidate (RC) for a new **minor** version of Umbraco CMS is released, a new version of the documentation will be available. When the minor version is released, the documentation for it will be merged into the related **major** version.

The documentation for each major version will always document the latest version of that major version of Umbraco CMS.

When an RC for a new **major** version of Umbraco CMS is released, a new version of the documentation will be available. When the major version is released, the documentation for it will be the new **default version of the Umbraco Documentation**.

## Long Term Support (LTS) and End of Life (EOL)

The Umbraco Documentation follows the [LTS and EOL strategies outlined for the Umbraco CMS](https://umbraco.com/products/knowledge-center/long-term-support-and-end-of-life/).

This means that the Umbraco Documentation will cover each major version of Umbraco CMS until it is EOL. After a major version is EOL the documentation for that version will be unpublished after 1 month extended to 3 months for LTS versions.

Unpublished versions of the Umbraco Documentation will continue to be available from GitHub.

{% hint style="info" %}
We reserve the right to change the strategy for EOL versions. This is due to the fact that we want to thoroughly test the process before making a decision.
{% endhint %}

## Contributing to a specific version

The Umbraco Documentation is synchronized with a GitHub repository, [UmbracoDocs](https://github.com/umbraco/UmbracoDocs), which is open source. Read the [Contribution documentation](../contribute/) to learn more about contributions and how to get started.

The `main` branch on the repository holds the default version of the documentation. Each version of the Umbraco Documentation has a separate branch in the repository. These will remain even though the CMS version is EOL.

{% hint style="info" %}
Documentation for Umbraco 8 and earlier versions are gathered in a single branch, `legacy-docs`. These versions are live on a different site: [Our](https://our.umbraco.com/documentation).
{% endhint %}
