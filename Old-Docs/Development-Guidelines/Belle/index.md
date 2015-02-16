#Project "Belle"

_"Belle" is the codename for the next version of the Umbraco backoffice UI._

After 10 years as an open source project, the UI has barely changed. There has been tweaks here and there, but overall
the experience of using Umbraco, has stayed the same.

Project Belle intends to overhaul the entire UI with a simpler visual theme, and at the same time, replacing most of the internal code.



###Getting belle up and running

Currently there are 2 ways, either get it from nightly.umbraco.org and run it as a normal umbraco installation, or build it from source.

####From nightly
To download from nightly, download a zip of the latest build here: 

http://nightly.umbraco.org/umbraco%20belle/

Files named UmbracoCms.4.11.0.build.*.zip are the complete website package

Unzip the files to disk and use either IIS or IIS express to run the site.


####From source
At the moment, we host the belle source at a seperate repository here: 

https://bitbucket.org/UmbracoHQ/umbracocms-belleui

To get the source, open cmd.exe in a directory and enter:

	hg clone https://bitbucket.org/UmbracoHQ/umbracocms-belleui

This will download the source and you can open it in visual studio and run it from there.



