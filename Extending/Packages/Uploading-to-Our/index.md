---
versionFrom: 7.0.0
---

# Upload your Package to Our

This document shows you how to upload your package to Our and share it with the world.

To get started you first need to have an account on Our, if you don't head over to the site and [register](https://our.umbraco.com/member/Signup)

:::note
You must earn some karma to upload a package from us before you can add your first package.
:::

## Creating your package

So before you can upload your package, you first have to create your package. If you need help with this then check out THESE AWESOME DOCUMENTS.


## Uploading the package to Our

To get started head over to your [profile page][Profile Package Page]. You'll see on this page if you can upload packages or not.

- Create the package
- Install it in an Umbraco instance
- Go to Packages
- Top right, Created app
- 'Create package'
	- Package Properties
		- * URL: The pubic URL to advertise the package. This is usually a source code link, such as GitHub
		- * Version: The version number of your package, if this is the first release of your package keep this at 1.0.0
		- Icon URL: The public image URL of an icon to show in the Our package area. If you leave this blank.... ?
		- Umbraco version: This defaults to the current version of Umbraco. If you leave this blank.... ?
		- * Author: Your name
		- * Author URL: A public URL to advertise yourself. This is usually a Twitter/GitHub URL.
		- Contributors: A simple text based list of anyone that helped with the package
		- License: The type of license associated with the package. Usually MIT, GNU or Apache
		- License URL: The URL to find out more about the license
		- Package readme: A place to sell your package. What is it and why should people download it? Support MD?!??!?!?!
	- Package Content
		- This is anything that you have created within the Umbraco CMS to do with the package. Content pages, data types etc
	- Package Files
		- These are the actual files needed
		- Path to files: multi-path selector from within the site root
		- Package option view: If this is selected then it will display after the user has installed the package. Nuget?!
	- Package Actions
		- These are custom actions that are used to create events and other configuration manipulation during install
- Click 'Create' in the bottom right
- Then 'Download'
	
	
- Click Add Package
	- Title: The name of your package (called name when packaging up in Umbraco?)
	- Current version: The version of your package. This will display on the front end in the button (regardless of file name)
	- Package Category: The category this package should be put into. **Maybe these need some explanation!**
	- Package Description: What your package does. Be clear and to the point about what your package does. Provide simple examples of how to use your package.
	- License name: As input in Umbraco
	- License URL: As input in Umbraco
	**Resources**
	- Package URL: **Not sure what this is!**
	- Demonstration URL: If you have a video, blog, audio description of how your package works in more depth, this is the place to advertise it. **How does this differ from the package URL?**
	- Source code URL: A link to the source code of the package
	- NuGet package URL: A link to the NuGet listing of your package if available
	- Bug tracking URL: If you want people to submit bugs in a specific place, pop the link in here.
	**Analytics and tracking**
	- Google Analytics code: Enter your GA code here to receive custom events. E.G. UA-11111111-1 **I think this should go into more detail**
	**Collaboration**
	- This package is open for collaboration: **No idea what this does!**
	**Package status**	
	- This package is retired: Tick this box if you are no longer actively maintaining the package.
	- Retired message: A quick message to explain why you are not maintaining the package. This will be shown to your Our package listing

** click next **

- Files upload
	- Select your file
	- Select the type: **Not sure what any of these are apart from Package**
	- Select Umbraco Version: Only check the versions of Umbraco that you have tested the package against. Uploading a package that is not compatible will have a negative impact on your package if it doesn't work!
	- Select the .NET Framework version: Typically the framework you developed against. If your package doesn't have any code files then select the earliest framework.
	
** click next **

- Images
	- Images really show off your package and let people know what it can do without downloading it
	- Upload up to XXXX images?
	- Make one current?
	
** click next **

- Tick that box and make it live!


	
[Profile Package Page]: https://our.umbraco.com/member/profile/packages/
[Package Manifest Help]: https://our.umbraco.com/documentation/extending/property-editors/package-manifest


-----

Notes

Bit confused why you have to give the details in Umbraco when packaging as well as in Our.

Why would you want to upload a package and instantly mark it as retired?
Messy responsive layout (hint text wrapping, description editor width)

Uploading files, current package files table could hide / show message until a file is uploaded
JS validation on the form would help!
Save file / next confusion
Why do you have to make something current? (what happens if you don't!)

After making it live, bit of an anti climax. Quite nerving for a first time package publisher to have your stuff live. Fanfares!!!

Re-ordering of images after uploading

After making live, changes are made without saving on final page. I would expect them to hold until you make it live.

Either force people to upload documentation or just hide this tab if there's nothing

Is it right you can vote on compatability of your own packages?