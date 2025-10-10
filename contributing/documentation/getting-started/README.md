---
description: >-
  Whether you've found a broken link or want to add a new article, this guide
  will help you contribute to the Umbraco documentation.
---

# How to Contribute

The Umbraco Documentation is presented here on [GitBook](https://docs.umbraco.com). The documentation is also available as a [GitHub repository](https://github.com/umbraco/UmbracoDocs) and is open-source, just like the [Umbraco CMS](https://github.com/umbraco/Umbraco-CMS).

You can contribute to the documentation if something is missing or outdated. **A GitHub account and a fork of the UmbracoDocs GitHub repository are required**.

## How to Get Started

There are many ways in which you can contribute to the Umbraco Documentation. The approach you choose to take depends on what you want to achieve with your contribution.

* Request a quick/minor change to an article by submitting a [Pull Request](pull-request.md#option-1-creating-a-pr-directly-on-github).
* Submit a more extensive update or change by [forking the Documentation repository](pull-request.md#options-2-creating-a-pr-through-a-fork).
* Raise a question, start a discussion, or report an issue on the [Issue Tracker](issues.md).
* Help improve the readability of the documentation by verifying articles against our [Style Guide](../style-guide/#test-the-documentation-yourself).

## [Style guide](../style-guide/)

Consistency and readability are important when writing and reading documentation. When you contribute, follow the style guidelines and rules outlined in the Style Guide.

## [Markdown and formatting](../style-guide/markdown-conventions.md)

The Umbraco Documentation is written using the Markdown markup language.

## [File names and structure](../style-guide/structure.md)

Learn how we structure and name files in the Umbraco documentation.

## Writing documentation locally

Use a text editor like Visual Studio Code to make changes to the documentation locally. Although it is possible, it is not recommended to use an Integrated Development Environment (IDE) like Visual Studio for making changes to the documentation on your local machine. This is because the IDE may create files in the project that are not needed for the document changes to be implemented.

## Multi-version documentation

Whenever a new version of an Umbraco product is released, the previous way of doing things may change. This means that multiple versions of our documentation must exist.

Versioning is done via the file structure, where all versioned products are located under a folder named by the major version of Umbraco.

For example, version folders such as '10' and '11' contain documentation specific to those product versions.

<figure><img src="../../../generic/.gitbook/assets/repository-folder-structure.png" alt=""><figcaption><p>An overview of the file structure in the UmbracoDocs GitHub repository.</p></figcaption></figure>

Umbraco Cloud and Umbraco Heartcore are not documented by version, which is why they are separate from this structure.

Learn more about how versioning is managed in the [Documenting multiple versions and products ](https://docs.umbraco.com/welcome/documentation-and-versions)article.

## Labels

On both Issues and Pull Requests, labels are used to categorize the requests and submissions.

Here's a quick explanation of the labels (colors):

* **Category**&#x20;
  * &#x20;`category/missing-documentation`
  * `category/umbraco-cloud`
  * &#x20;`category/pending-release`
* **Community**
  * &#x20;`community/pr`&#x20;
  * `help wanted`
* **State**
  * `state/hq-discussion`
* **Status**&#x20;
  * `status/awaiting-feedback`
  * &#x20;`status/idea`
* **Type**&#x20;
  * `type/bug`
* **Internal Review**&#x20;
  * `review/docsteam`&#x20;
  * `review/developer`

Labels are added during the initial review of your pull request or issue.
