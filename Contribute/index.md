# Contribute to Umbraco

This guide will cover the following sections:
 - [Ways of contributing](#ways-of-contributing)
 - [Markdown syntax](#markdown-syntax)
 - [Contribution badge](#contribution-badge)
 - [Documentation & Pull Request teams](#documentation-and-pull-request-teams)

 ## Ways of contributing
This guide will cover how to contribute to the Umbraco Documentation, if you are interested in contributing to the Umbraco CMS you can find out how in their [contribution guidelines](https://github.com/umbraco/Umbraco-CMS/blob/dev-v7/.github/CONTRIBUTING.md).

There are two ways to contribute to the Umbraco Documentation:
- [Creating an issue](#creating-an-issue)
- [Creating a pull request](#creating-a-pull-request)

### Creating an issue
The Umbraco Documentation uses [Github issues]((https://github.com/umbraco/UmbracoDocs/issues)) to manage issues with the documentation.
You are very welcome to create an issue if you feel some documentation is missing or wrong, the issue board is also used for discussions about possible improvements or ways to deal with something in the documentation. You can also find a button in the top right corner of every page in the documentation itself that looks like this:
![Our issue button](images/report-issue.png)

#### Issue labels
The issue repository has several labels, these are not something you can add yourself but they may be added to your issue and other issues. Here is a quick overview of the commonly used labels and what they mean:

- `discuss` - this label is added to issues that are not a tangible problem or very large, an issue with the discuss label is something everyone is encouraged to give their opinion on!
- `missing documentation` - for issues about missing information, if you see this and wish to make a pull request on it please write that in a comment
- `incorrect documentation` - for documentation that is wrong, this can be due to many things, often it is outdated
- `up-for-grabs` - any issue with an up-for-grabs label is something noone is actively working on and is open for anyone wishing to contribute
- `Dependant On Release` - this label is for documentation pull requests that are made in advance of a new Umbraco release, will be merged in once the changes have been released
- `need-OUR-update` - this label is used for PR's awaiting some new functionality being added to the Our Umbraco website
- `Umbraco Cloud`, `Umbraco Forms`, etc - if the issue is specific to something other than Umbraco CMS it will get the relevant Umbraco product label

### Creating a pull request
A pull request is simply a way of submitting changes to something that can then be reviewed. We have this flow to ensure that all of the changes in the documentation is formatted correctly, has updated information and is written well. There are two ways to create a pull request, you can either edit a file directly on Github and your changes will then be submitted as a pull request, or you can create a fork of the Github repository, make changes and then make a pull request to sync your fork with the main repository.

#### Creating a PR directly in Github
Github has some great functionality that allows you to submit a PR directly from our [repository](https://github.com/umbraco/UmbracoDocs/), and there is also a button on every single documentation article at the top that links you directly to Github in order to edit that specific file:
![Our edit button](images/edit-this-page.png)

This is very helpful to fix typos and adding small things, but if you are working on a larger update that includes pictures and editing several files in one pull request then it is not a good way to work, then you should create a fork.

#### Creating a PR through a fork
There is a lot of great guides on how to set up a fork and work with forks, so below there will be a quick guide on how to do it, if you wish for some more general information, Github has a [guide here!](https://help.github.com/articles/fork-a-repo/)

**Step 1: Creating a fork**
A fork of the Umbraco Documentation repository means that you get a copy of the whole repository on your own Github profile, you can create a fork by simply clicking a button:
![Creating a fork](images/fork-repository.png)

Once the fork has been created you will have your own copy of the documentation, if you clone your fork down you can make changes to a lot of things and then push all the changes up to your fork, finally you can submit a pull request where you try to sync your copy with the "real" repository:
![Fork of documentation](images/example-of-fork.png)

Sometimes - like in the example above - you may end up forking and then not working on the documentation for a while, then once you start you are some commits behind, so before making changes and making a pull request you should do a rebase, for this you set the main repository as an upstream to sync from, fetch the updates and update your own fork to ensure you are in sync:

```
git remote add upstream https://github.com/umbraco/UmbracoDocs/
git fetch upstream
git rebase upstream/master
```
If you do this locally and then push it to your fork you will have a synced up fork to start working with!


#### Labels for PRs
- `Dependant On Release` - this label is for documentation pull requests that are made in advance of a new Umbraco release, will be merged in once the changes have been released
- `need-OUR-update` - this label is used for PR's awaiting some new functionality being added to the Our Umbraco website
- `D-Team` - this label is usually used when the PR is about something with Umbraco Core that the documentation team is not familiar with, it requires a review from the Umbraco development team
- `Umbraco Cloud`, `Umbraco Forms`, etc - if the issue is specific to something other than Umbraco CMS it will get the relevant Umbraco product label

 ## Markdown syntax

 ## Contribution badge

 ## Documentation and Pull Request teams

