# Umbraco Documentation project

# Reading & using the docs
This is the documentation project for Umbraco. The scope of this project is to provide overviews of concepts, tutorials, example code, and links to API reference.
We welcome valuable contributions from anyone willing to help. No matter if it is correcting spelling mistakes, raising an issue or writing a tutorial, everything counts and helps make Umbraco easier to use for everyone.

For details on how to contribute, see further down this page.

#What's in the documentation

## Getting started
[Getting started (available here)](Getting-Started/) is an introduction to Umbraco containing explanations of basic concepts and short tutorials.

## Implementation
[Implementation (available here)](Implementation/) is an overview of Umbracos structure and pipeline.

## Developers Reference
[Reference (available here)](Reference/index.md) is a collection of API references specifically for developers working with and extending Umbraco.

## Extending
[Extending (available here)](Extending/) is documentation on customizing and extending the backoffice.

## Tutorials
[Tutorials (available here)](Tutorials/) is a collection of the more extensive tutorials used in the documentation.

# Contributing to the guides
To contribute to either the documentation or stubs, you can fork & clone our repository, make your edits, and simply push back to GitHub and send us a pull request. All items that get pulled into the main repository will automatically get pushed to [our.umbraco.org/documentation](http://our.umbraco.org/documentation).

#### Getting started with Git and GitHub
 * [Setting up Git for Windows and connecting to GitHub](http://windows.github.com)
 * [Forking a GitHub repository](https://help.github.com/articles/fork-a-repo/)
 * [The simple guide to GIT](http://rogerdudler.github.io/git-guide/)

## Repository organisation
All active work done on the documentation is currently being done on the `master` branch.

### Contributing documentation
All documents are written in Markdown, using a simple structure and stored as .md files.
These are then pulled to [our.umbraco.org/documentation](http://our.umbraco.org/documentation) for easy browsing.

First fork and clone the repository so that you have your own working copy. Then create a new branch on your local copy to make your changes. Once you are happy with your edits, use GitHub to issue a "pull request", which means your edits will be reviewed, and once accepted, merged into the main repository.

**Note:** It's a good idea to pull in upstream changes, merge and commit to your own fork before submitting a pull request. Instructions on how to set up a remote repo and pull from upstream can be found on this [page](https://help.github.com/articles/fork-a-repo).

Everything in the main repository will make it onto the [our.umbraco.org/documentation](http://our.umbraco.org/documentation) site, which is why we have chosen a pull request workflow to keep everything simple and straightforward.

## Planning & discussions

Use [Github issues](https://github.com/umbraco/UmbracoDocs/issues) for reporting and discussing issues.

# Markdown conventions
Keep custom HTML to a minimum. All script and style markup are cleaned by default.
For reference, the [Markdown syntax guide](http://daringfireball.net/projects/markdown/syntax) is available.

## Images
Images are stored and linked relatively to .md pages, and should by convention always be in an
`images` folder. So to add an image to `/documentation/reference/partials/renderviewpage.md` you link it like so:

	![My Image Alt Text](images/img.jpg)

And store the image as `/documentation/reference/partials/images/img.jpg`

Images can have a maximum width of **800px**. Please always try to use
the most efficient compression, `gif`, `png` or `jpg`. No `bmp`, `tiff` or `swf` (Flash), please.

NB: In order to get images to display correctly on GitHub, all image URLs must end with ``.

## External links
Include either the complete URL, or link using Markdown:

	http://yahoo.com/something

	or

	[yahoo something](http://yahoo.com/something)


## Internal links
If you need to link between pages, always link relatively, and include the .md extension.

	[Umbraco.Helpers](Umbraco.Helpers.md)

	or

	[Umbraco.Helpers](../../Reference/Umbraco.Helpers.md)

## Formatting code
Indent your sample with a single tab, which will cause it to be rendered as `<pre><code>` tags.
For inline code, wrap in ` (backtick) chars.

Use # for the headline, ## for sub headers and ### for parameters (on code reference pages)

For optional parameters wrap in _ (underscore) - end result: `###_optionalParameter_`

## Structure
For the documentation project, each individual topic is contained in its own folder.
Each folder must have an `index.md` file which links to the individual sub-pages, if images
are used, these must be in `images` folders next to the .md file referencing them relatively.

* topic
	* images
		* images.jpg
	* Subtopic
		* images
		* index.md
	* index.md
	* otherpage.md
