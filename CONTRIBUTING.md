# Contributing Guidelines

To contribute to either the documentation or stubs, you can fork & clone our repository, make your edits, and push back to GitHub and send us a pull request. All items that get pulled into the main repository will automatically get pushed to [our.umbraco.com/documentation](https://our.umbraco.com/documentation).

## Getting started with Git and GitHub

* [Download GitHub Desktop](https://desktop.github.com)
* [Configuring GitHub Desktop](https://help.github.com/desktop/guides/)
* [Forking a GitHub repository](https://help.github.com/articles/fork-a-repo/)
* [The basic guide to Git](https://rogerdudler.github.io/git-guide/)

## Repository organisation

All active work done on the documentation is currently being done on the `main` branch.

### Keeping your UmbracoDocs fork in sync with the main repository

If you decide to clone the UmbracoDocs repository on your local machine for making larger changes that can't be done directly on GitHub then we recommend you sync with our repository before you submit your pull request. That way, you can fix any potential merge conflicts and make our lives a little bit easier.

To sync your fork with this original one, you'll have to add the upstream URL, you only have to do this once:

```xml
git remote add upstream https://github.com/umbraco/UmbracoDocs.git
```

Then when you want to get the changes from the main repository:

```xml
git fetch upstream
git rebase upstream/main
```

In this command, we're syncing with the `main` branch. You can choose another one if needed.

### Contributing documentation

All documents are written in Markdown, using a basic structure and stored as .md files.
These are then pulled to [our.umbraco.com/documentation](https://our.umbraco.com/documentation) for browsing.

First fork and clone the repository so that you have your own working copy. Then create a new branch on your local copy to make your changes. Once you are happy with your edits, use GitHub to issue a "pull request", which means your edits will be reviewed, and once accepted, merged into the main repository.

**Note:** It's a good idea to pull in upstream changes, merge and commit to your own fork before submitting a pull request. Instructions on how to set up a remote repo and pull from upstream can be found on this [page](https://help.github.com/articles/fork-a-repo).

Everything in the main repository will make it onto the [our.umbraco.com/documentation](https://our.umbraco.com/documentation) site, which is why we have chosen a pull request workflow to keep everything straightforward.

## Planning & discussions

If you want to report an issue, or you're planning a big change, use [GitHub issues](https://github.com/umbraco/UmbracoDocs/issues) for opening a discussion. If you want to do a small change, don't hesitate to do a pull request, we don't need you to create an issue first.
