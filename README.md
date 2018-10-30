# Umbraco Documentation project
 [![made-with-Markdown](https://img.shields.io/badge/Made%20with-Markdown-1f425f.svg)](http://commonmark.org)
 
# Reading & using the docs
This is the documentation project for Umbraco. The scope of this project is to provide overviews of concepts, tutorials, example code, and links to API reference.

# What's in the documentation

## Getting started
[Getting started (available here)](Getting-Started/) is an introduction to Umbraco containing explanations of basic concepts and short tutorials.

## Implementation
[Implementation (available here)](Implementation/) is an overview of Umbracos structure and pipeline.

## Developers Reference
[Reference (available here)](Reference/index.md) is a collection of API references specifically for developers working with and extending Umbraco.

## Extending
[Extending (available here)](Extending/) is documentation on customizing and extending the back office.

## Tutorials
[Tutorials (available here)](Tutorials/) is a collection of the more extensive tutorials used in the documentation.

# Markdown conventions
Keep custom HTML to a minimum. All script and style markup are cleaned by default.
For reference, the [Markdown syntax guide](https://daringfireball.net/projects/markdown/syntax) is available.

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

	https://yahoo.com/something

	or

	[yahoo something](https://yahoo.com/something)


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

# Annotating a document

To add version information and extra keywords, [every document can be annotated using YAML](Contribute/adding-metadata.md). 

# Multi version documentation
Every new version of Umbraco introduces new features. This means that every document might not work for your possibly older version.

Therefore we introduced 2 different mechanisms.
1. the [YAML metadata describing](Contribute/adding-metadata.md) `versionFrom` and `versionTo`.
2. the possibility [to add multiple files about the same topic](Contribute/file-naming-conventions.md)

# Contributing [![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/umbraco/UmbracoDocs/issues) [![GitHub contributors](https://img.shields.io/github/contributors/umbraco/UmbracoDocs.svg)](https://GitHub.com/umbraco/UmbracoDocsgraphs/contributors/)
We :heart: valuable contributions from everyone who are willing to help. It does not matter to us, if it's something trivial like, correcting spelling mistakes or raising an issue or writing a tutorial! Every little help counts and it helps make Umbraco easier to use for everyone.
Otherwise, [bug reports](https://github.com/umbraco/UmbracoDocs/issues/), [bug fixes](https://github.com/umbraco/UmbracoDocs/pulls) and any feedback on Umbraco is always appreciated.
Look at the [Contributor Guidelines](CONTRIBUTING.md) to learn how you can get involved and help with the Umbraco Documentation.
## License [![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](./LICENSE)
This library is released under the [MIT License](license)
