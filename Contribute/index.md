---
versionFrom: 7.0.0
meta.Title: "Contribute to Umbraco CMS"
meta.Description: "Explanation of how you can contribute to Umbraco, what the process is like and what things to keep in mind when contributing."
---
# Contribute to the Umbraco Documentation

The Umbraco Documentation is presented here on Our Umbraco, but is in fact also a GitHub repository and it is just as open source as the Umbraco CMS.

You can contribute to the documentation whenever you feel something is missing or out of date, and all you need to do it, is an account on GitHub.

In this section you can learn much more about the various ways of contributing.

## How to get started

There are more than one way that you can contribute to the Umbraco Documentation. Which approach to take, depends on what you want to achieve with your contribution.

* Request a quick / minor change to an article by submitting a [Pull Request](Pull-Requests/#option-1-creating-a-pr-directly-on-github)
* Submit a more extensive update / change by [forking the Documentation repository](Pull-Requests/#options-2-creating-a-pr-through-a-fork)
* Raise a question, start a discussion or report an issue on the [Issue Tracker](Issues/)

## [Style guide](Style-Guide/index.md)

We have a few rules to follow when writing documentation, don't worry they are quite easy to follow and we have some tools you can use to make it even easier.

## [Format, naming conventions and files](Markdown-Conventions)

The Umbraco Documentation is written using the MarkDown markup language. We've put together an article where you can learn more about MarkDown. You will also find an overview of the folder and file structure we use.

## Multi version documentation

Whenever a new version of Umbraco is released new features might introduced and the "old way" of doing one thing, might have changed. This means that there will have to be several articles about the same thing, but with different information.

Therefor we've introduced **versioned documentation**, which includes 2 different mechanisms:

1. The [YAML meta data describing](adding-metadata.md) `versionFrom` and `versionTo`.
2. The possibility [to add multiple files about the same topic](file-naming-conventions.md)

## [Adding meta data](adding-metadata.md)

You can add meta data to any article in the Umbraco Documentation. This includes `meta title` and `meta description` as well as information on the versioning of the article.

## Labels

On both Issues and Pull Requests we use labels to categories the various requests and submissions.  

Here's a quick explanation of the labels groups (colors) we use:

- **Category** (e.g. `category/missing-documentation`, `category/umbraco-cloud`, `category/pending-release`)
- **Community** (e.g. `community/pr`, `help wanted`)
- **State** (e.g. `state/hq-discussion`)
- **Status** (e.g. `status/awaiting-feedback`, `status/idea`)
- **Type** (e.g. `type/bug`) 

Labels will be added to your Pull Request or Issue once it has been reviewed.

## Documentation Curators

All the work of adding labels, going through issues and PR's and managing the Documentation repository is done by the Umbraco Documentation Curators team. If you wish to know more about who they are and how they work there is some information about them here: https://our.umbraco.com/community/the-documentation-curators/

## Contribution badge

If you make a pull request to any Umbraco repository that gets merged in you will get a Contributor badge on your member profile on [Our](https://our.umbraco.com):

![Contributor badge on our](images/c-trib-badge.png)

The Documentation Curators will search for your profile when merging a PR in and add the badge. 
If it is forgotten just make a comment on the closed PR and we will do it as soon as possible!
