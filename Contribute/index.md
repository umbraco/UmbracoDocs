---
meta.Title: "Contribute to Umbraco CMS"
meta.Description: "An explanation of how you can contribute to the Umbraco Documentation, what the process is and what things to keep in mind when contributing."
---
# Contribute to the Umbraco Documentation

The Umbraco Documentation is presented here on [Our Umbraco](https://our.umbraco.com/documentation), however it is also a [GitHub repository](https://github.com/umbraco/UmbracoDocs) and is as open source as the [Umbraco CMS](https://github.com/umbraco/Umbraco-CMS)!

You can contribute to the documentation whenever you feel something is missing or out of date, and all you need to do it, is an account on GitHub.

In this section you can learn more about the various ways of contributing.

## How to get started

There are many ways in which you can contribute to the Umbraco Documentation. The approach you choose to take, depends on what you want to achieve with your contribution.

* Request a quick / minor change to an article by submitting a [Pull Request](Pull-Requests/#option-1-creating-a-pr-directly-on-github)
* Submit a more extensive update / change by [forking the Documentation repository](Pull-Requests/#options-2-creating-a-pr-through-a-fork)
* Raise a question, start a discussion or report an issue on the [Issue Tracker](Issues/)

## [Style guide](Style-Guide/index.md)

We have a few rules to follow when writing documentation and we have some tools you can use to help.

## [Format, naming conventions and files](Markdown-Conventions)

The Umbraco Documentation is written using the MarkDown markup language. We've put together an article where you can learn more about MarkDown [here](https://our.umbraco.com/Documentation/Contribute/Markdown-Conventions). You will also find an overview of the folder and file structure we use.

## Multi version documentation

Whenever a new version of Umbraco is released new features might introduced and the "old way" of doing one thing, might have changed. This means that there will have to be several articles about the same thing, but with different variations of information.

Therefore we've introduced **versioned documentation**, which includes 2 different mechanisms:

1. The [YAML meta data](Adding-Metadata/index.md) describing `versionFrom` and `versionTo`.
2. The possibility to [add multiple files about the same topic](File-Naming-Conventions/index.md)

## [Adding meta data](Adding-Metadata/index.md)

You can add meta data to any article in the Umbraco Documentation. This includes `meta title` and `meta description` as well as information on the versioning of the article.

## Labels

On both Issues and Pull Requests we use labels to categories the various requests and submissions.

Here's a quick explanation of the labels groups (colors) we use:

* **Category** (e.g. `category/missing-documentation`, `category/umbraco-cloud`, `category/pending-release`)
* **Community** (e.g. `community/pr`, `help wanted`)
* **State** (e.g. `state/hq-discussion`)
* **Status** (e.g. `status/awaiting-feedback`, `status/idea`)
* **Type** (e.g. `type/bug`)

Labels will be added to your Pull Request or Issue once it has been reviewed.

## Documentation Curators

All the work of adding labels, going through Issues & Pull Requests and managing the Documentation repository is done by the Umbraco Documentation Curators team. If you wish to know more about who they are and how they work there is more information about them here: https://our.umbraco.com/get-involved/the-documentation-curators/

## Contribution badge

If you make a Pull Request to any Umbraco repository that gets merged, you will receive a Contributor badge on your member profile on [Our Umbraco](https://our.umbraco.com):

![Contributor badge on Our](images/c-trib-badge.png)

The Documentation Curators team will search for your profile when merging your Pull Request and add the badge.
If after some time you have not received your Contributor badge, write a comment with the url to your profile on the closed/merged Pull Request and we will look into it as soon as possible!
