#Umbraco Documentation project

#Reading & using the docs
This is the documentation project for Umbraco. The scope of this project is to provide overviews of concepts, tutorials, example code, and links to API reference.
This is a work in progress at the moment, and we welcome valuable contributions from anyone willing to help. For details on how to contribute, see further down this page.

Our project consists of 2 main parts, "Stubs" and "Documentation".  Currently there are no branches for different versions of umbraco.

#What's in these guides

##Documentation
[Documentation (available here)](Documentation/index.md) is a collection of references and step-by-step guides, as well as conceptual overviews of the architecture.

##Developers Reference
[Developers (available here)](Documentation/Reference/index.md) is a collection of API references specifically for developers working with and extending Umbraco.

#Contributing to the guides
To contribute to either the documentation or stubs, you can fork & clone our repository, make your edits, and simply push back to GitHub and send us a pull request. All items that get pulled into the main repository will automatically get pushed to [our.umbraco.org/documentation](http://our.umbraco.org/documentation).

####Getting started with Git and GitHub
 * [Setting up Git for Windows and connecting to GitHub](http://windows.github.com)
 * [Forking a GitHub repository](http://help.github.com/fork-a-repo/)
 * [The simple guide to GIT](http://rogerdudler.github.com/git-guide/)


##Repository organisation
All active work done on the documentation is currently being done on the 'master' branch.

###Contributing documentation
All documents are written in Markdown, using a simple structure and stored as .md files.
These are then pulled to [our.umbraco.org/documentation](http://our.umbraco.org/documentation) for easy browsing. 

First fork and clone the repository so that you have your own working copy. Then create a new branch on your local copy to make your changes. Once you are happy with your edits, use GitHub to issue a "pull request", which means your edits will be reviewed, and once accepted, merged into the main repository. 

**Note:** It's a good idea to pull in upstream changes, merge and commit to your own fork before submitting a pull request. Instructions on how to set up a remote repo and pull from upstream can be found on this [page](https://help.github.com/articles/fork-a-repo).

Everything in the main repository will make it onto the [our.umbraco.org/documentation](http://our.umbraco.org/documentation) site, which is why we have chosen a pull request workflow to keep everything simple and straightforward.

##Planning & discussions

If you would like to get more involved in the discussions around the Umbraco Documentation project, please visit the following places:

* [Trello Board](https://trello.com/board/umbraco-4-documentation/4fdb02df8fc3ef067e809e95) - our planning board full of our backlog and work-in-progress items. Browse this board to get an idea of what needs more work, or what someone else has already started. Join the board to add concepts, ideas and tasks. Claim a task and start working on it!
* [JabbR Chatroom](http://jabbr.net/#/rooms/umbraco) - discuss things in real-time with the Umbraco community.


#Markdown conventions
Keep custom HTML to a minimum. All script and style mark-up are cleaned by default.
For reference, the [Markdown syntax guide](http://daringfireball.net/projects/markdown/syntax) is available.

##Images
Images are stored and linked relatively to .md pages, and should by convention always be in an
`images` folder. So to add an image to `/documentation/reference/partials/renderviewpage.md` you link it like so:

	![My Image Alt Text](images/img.jpg?raw=true)

And store the image as `/documentation/reference/partials/images/img.jpg`

Images can have a maximum width of **650px** and maximum height of **600px**. Please always try to use 
the most efficient compression, `gif`, `png` or `jpg`. No `bmp`, `tiff` or `swf` (Flash), please. 

NB: In order to get images to display correctly on GitHub, all image URLs must end with "?raw=true"

##External links
Include either the complete URL, or link using Markdown:
	
	http://yahoo.com/something

	or

	[yahoo something](http://yahoo.com/something)


##Internal links
If you need to link between pages, always link relatively, and include the .md extension.

	[Umbraco.Helpers](Umbraco.Helpers.md)

	or

	[Umbraco.Helpers](../../Reference/Umbraco.Helpers.md)

##Formatting code
Indent your sample with a single tab, which will cause it to be rendered as `<pre><code>` tags.
For inline code, wrap in ` (backtick) chars.

Use # for the headline, ## for sub headers and ### for parameters (on code reference pages)

For optional parameters wrap in _ (underscore) - end result: `###_optionalParameter_` 

##Structure
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

	
