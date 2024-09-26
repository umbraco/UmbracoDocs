---
description: >-
  Whether you've found a broken link or want to add a new article to the Umbraco
  documentation, this article will guide you on your way.
---

# How to contribute

The Umbraco Documentation is presented here on [GitBook](https://docs.umbraco.com), however, it is also a [GitHub repository](https://github.com/umbraco/UmbracoDocs) and is as open source as the [Umbraco CMS](https://github.com/umbraco/Umbraco-CMS).

You can contribute to the documentation if something is missing or outdated. **You will need a GitHub account and a fork of the UmbracoDocs GitHub repository**.

## How to get started

There are many ways in which you can contribute to the Umbraco Documentation. The approach you choose to take depends on what you want to achieve with your contribution.

* Request a quick/minor change to an article by submitting a [Pull Request](pull-request.md#option-1-creating-a-pr-directly-on-github)
* Submit a more extensive update/change by [forking the Documentation repository](pull-request.md#options-2-creating-a-pr-through-a-fork)
* Raise a question, start a discussion, or report an issue on the [Issue Tracker](issues.md)
* Help improve the readability of the documentation by verifying articles against our [Style Guide](../style-guide/#test-the-docs-yourself).

## [Style guide](../style-guide/)

We have a few guidelines to follow when writing documentation and we have some tools you can use for it.

## [Format, naming conventions, and files](../style-guide/markdown-conventions.md)

The Umbraco Documentation is written using the MarkDown markup language. We have put together [an article where you can learn more about MarkDown](../style-guide/markdown-conventions.md).

## [File structure](../style-guide/structure.md)

Learn how we structure and name files in the Umbraco documentation.

## Writing documentation locally

We recommend using a text editor like Visual Studio Code for making changes to the documentation on your local machine. We do not recommend using an Integrated Development Environment (IDE) like Visual Studio, for making changes to the documentation on your local machine. This is because the IDE may create files in the project which are not needed for the document changes to be implemented.

## Multi-version documentation

Whenever a new version of an Umbraco product is released, the previous way of doing things may change. This means that there need to be multiple versions of our documentation.

We do this by keeping documentation for each version in separate folders.

<figure><img src="../../../.gitbook/assets/repository-folder-structure.png" alt=""><figcaption><p>And overview of the file structure in the UmbracoDocs GitHub repository.</p></figcaption></figure>

In the screenshot above, two versions are available: 10 and 11. Within each of these folders is the documentation for all the versioned products: Umbraco Forms, Umbraco Deploy, Umbraco Workflow, and Umbraco CMS.

Umbraco Cloud and Umbraco Heartcore are not following the same versioning, which is why they are separate from this structure.

Learn more about how we handle the multiple version of our documentation in the [documenting multiple versions and products](https://docs.umbraco.com/welcome/documentation-and-versions) article.

## Labels

On both Issues and Pull Requests we use labels to categorize the requests and submissions.

Here's a quick explanation of the labels (colors) we use:

* **Category** (e.g. `category/missing-documentation`, `category/umbraco-cloud`, `category/pending-release`)
* **Community** (e.g. `community/pr`, `help wanted`)
* **State** (e.g. `state/hq-discussion`)
* **Status** (e.g. `status/awaiting-feedback`, `status/idea`)
* **Type** (e.g. `type/bug`)

Labels will be added to your Pull Request or Issue once it has been reviewed.

## Contribution badge

If your Pull Request to any Umbraco repository gets merged, you will receive a Contributor badge on your profile on [Our Umbraco](https://our.umbraco.com):

![Contributor badge on Our](../images/c-trib-badge.png)
