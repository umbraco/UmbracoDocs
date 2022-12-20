# Contribute to Documentation

The Umbraco Documentation is presented here on [GitBook](https://docs.umbraco.com), however it is also a [GitHub repository](https://github.com/umbraco/UmbracoDocs) and is as open source as the [Umbraco CMS](https://github.com/umbraco/Umbraco-CMS).

You can contribute to the documentation if something is missing or outdated. All you need to do it is a GitHub account and a fork of the UmbracoDocs GitHub repository.

In this section you can learn about the different ways to contribute. You can also find guidelines for writing good documentation.

## How to get started

There are many ways in which you can contribute to the Umbraco Documentation. The approach you choose to take, depends on what you want to achieve with your contribution.

* Request a quick / minor change to an article by submitting a [Pull Request](pull-request.md#option-1-creating-a-pr-directly-on-github)
* Submit a more extensive update / change by [forking the Documentation repository](pull-request.md#options-2-creating-a-pr-through-a-fork)
* Raise a question, start a discussion or report an issue on the [Issue Tracker](issues.md)
* Help improve readability of the documentation by verifying articles against our [Style Guide](style-guide.md#test-the-docs-yourself).

## [Style guide](style-guide.md)

We have a few guidelines to follow when writing documentation and we have some tools you can use for it.

## [Format, naming conventions and files](markdown-conventions.md)

The Umbraco Documentation is written using the MarkDown markup language. We have put together [an article where you can learn more about MarkDown](markdown-conventions.md).

## [File structure](structure.md)

Learn how we structure and name files in the Umbraco documentation.

## Multi version documentation

Whenever a new version of an Umbraco product is released, the previous way of doing things may change. This means that there needs to be mutliple version of our documentation.

We do this by having a Git branch for each of the major versions of Umbraco CMS.

{% hint style="info" %}
We are currently testing how best to handle the versions in terms of all products including Cloud, Heartcore, Forms and Deploy.

For now all documentation will follow the Umbraco CMS major versions. We will add warnings and notes whenever the versions to not match.
{% endhint %}

Learn more about how we handle the multiple version of our documentation in the [documenting multiple versions and products](../documentation-and-versions.md) article.

## Labels

On both Issues and Pull Requests we use labels to categorize the requests and submissions.

Here's a quick explanation of the labels groups (colors) we use:

* **Category** (e.g. `category/missing-documentation`, `category/umbraco-cloud`, `category/pending-release`)
* **Community** (e.g. `community/pr`, `help wanted`)
* **State** (e.g. `state/hq-discussion`)
* **Status** (e.g. `status/awaiting-feedback`, `status/idea`)
* **Type** (e.g. `type/bug`)

Labels will be added to your Pull Request or Issue once it has been reviewed.

## Contribution badge

If your Pull Request to any Umbraco repository gets merged, you will receive a Contributor badge on your profile on [Our Umbraco](https://our.umbraco.com):

![Contributor badge on Our](images/c-trib-badge.png)
