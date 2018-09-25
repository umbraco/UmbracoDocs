# Contribute to Umbraco Documentation

This guide will cover the following sections:
 - [Ways of contributing](#ways-of-contributing)
 - [Markdown conventions](#markdown-conventions)
 - [Contribution badge](#contribution-badge)
 - [Documentation Curators](#documentation-curators)

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

**Note:** It may be helpful for you to read our [Markdown guidelines](#markdown-conventions) on how to set up Documentation articles before you start writing!

#### Creating a PR directly in Github
Github has some great functionality that allows you to submit a PR directly from our [repository](https://github.com/umbraco/UmbracoDocs/), and there is also a button on every single documentation article at the top that links you directly to Github in order to edit that specific file:
![Our edit button](images/edit-this-page.png)

This is very helpful to fix typos and adding small things, but if you are working on a larger update that includes pictures and editing several files in one pull request then it is not a good way to work, then you should create a fork.

#### Creating a PR through a fork
There is a lot of great guides on how to set up a fork and work with forks, so below there will be a quick guide on how to do it. If you wish for some more general information, Github has a [guide here](https://help.github.com/articles/fork-a-repo/).

**Step 1: Creating a fork** 

A fork of the Umbraco Documentation repository means that you get a copy of the whole repository on your own Github profile. You can create a fork by simply clicking a button:
![Creating a fork](images/fork-repository.png)

Once the fork has been created you will have your own copy of the documentation. If you clone your fork down you can make changes to a lot of things and then push all the changes up to your fork. 

When you are done and happy with the changes you've made, you can submit a pull request where you try to sync your copy with the "real" repository:
![Fork of documentation](images/example-of-fork.png)

**Step 2: Syncing your fork**

Sometimes - like in the example above - you may end up forking and then not working on the documentation for a while. Once you start you are some commits behind, so before making changes and making a pull request you should do a rebase. For this you set the main repository as an upstream to sync from, fetch the updates and update your own fork to ensure you are in sync:

```cmd
git remote add upstream https://github.com/umbraco/UmbracoDocs/
git fetch upstream
git rebase upstream/master
```

**Step 3: Creating a PR**

If you do this locally and then push it to your fork you will have a synced up fork to start working with! Once you have made some changes and you are happy with the result, you can create a pull request (you may have to rebase again and resolve merged conflicts if a lot of things has been merged in since your last sync).
![Creating a PR](images/pull-request.png)

And that is all you need to do to create a fork, sync it and make a pull request to the main repository! 


#### Labels for PRs
- `Dependant On Release` - this label is for documentation pull requests that are made in advance of a new Umbraco release, will be merged in once the changes have been released
- `need-OUR-update` - this label is used for PR's awaiting some new functionality being added to the Our Umbraco website
- `D-Team` - this label is usually used when the PR is about something with Umbraco Core that the documentation team is not familiar with, meaning it requires a review from the Umbraco development team
- `Umbraco Cloud`, `Umbraco Forms`, etc - if the issue is specific to something other than Umbraco CMS it will get the relevant Umbraco product label

## Markdown conventions
The Umbraco Documentation uses Markdown for all of the documentation - but more precisely we use the CommonMark specification, read more about the difference [here](https://commonmark.org/).

### Structure
For the documentation project, each individual topic is contained in its own folder.
Each folder must have an `index.md` file which links to the individual sub-pages, if images are used, these must be in `images` folders next to the .md file referencing them relatively.

* topic
	* images
		* images.jpg
	* Subtopic
		* images
		* index.md
	* index.md
	* otherpage.md

### Images
Images are stored and linked relatively to .md pages, and should by convention always be in an `images` folder. So to add an image to `/documentation/reference/partials/renderviewpage.md` you link it like so:

	![My Image Alt Text](images/img.jpg)

And store the image as `/documentation/reference/partials/images/img.jpg`

Images can have a maximum width of **800px**. Please always try to use the most efficient compression, `gif`, `png` or `jpg`. No `bmp`, `tiff` or `swf` (Flash).

### External links
Include either the complete URL, or link using Markdown:

	https://yahoo.com/something

	or

	[yahoo something](https://yahoo.com/something)


### Internal links
If you need to link between pages, always link relatively, and include the .md extension.

	[Umbraco.Helpers](Umbraco.Helpers.md)

	or

	[Umbraco.Helpers](../../Reference/Umbraco.Helpers.md)

### Formatting code
Indent your sample with a single tab, which will cause it to be rendered as `<pre><code>` tags.
For inline code, wrap in ` (backtick) chars.

Use # for the headline, ## for sub headers and ### for parameters (on code reference pages)

For optional parameters wrap in _ (underscore) - end result: `###_optionalParameter_`

 ## Contribution badge
If you make a pull request to any Umbraco repository that gets merged in you will get a Contributor badge on your member profile on Our:

![Contributor badge on our](images/c-trib-badge.png)

The Documentation Curators will search for your profile when merging a PR in and add the badge, but if it is forgotten just make a comment on the closed PR and we will do it as soon as possible!

 ## Documentation Curators
 All the work of adding labels, going through issues and PR's and managing the Documentation repository is done by the Umbraco Documentation Curators team. If you wish to know more about who they are and how they work there is some information about them here: https://our.umbraco.com/community/the-documentation-curators/
