# Working with Umbraco Cloud and Node.js cli

One of the features built into Umbraco Cloud is the ability to work locally with your Umbraco site - without having a Windows machine with a local web server installed on it. This enables e.g. people on OS X or a Linux based OS to be using their favorite editor to modify code in their Umbraco Cloud site. The functionality requires that your machine has the following three tools installed:

* Git - In order to clone a site and push changes
* Node.js (minimum version: 2.15) + npm installed in a command line of choice
* A code editor like Atom, Sublime or Visual Studio Code

To use Node.js and npm you need to download the latest build either from [https://nodejs.org/en/download/](https://nodejs.org/en/download/) or your OS' repository. It is important to let the installer register itself to your PATH, so that the commands are available via your command line tool. 

The module you want to install is called **uaas-cli**, aka *Umbraco Cloud Command line interface.*

Run the following in your CLI to install the module for global use: 

`npm install -g uaas-cli`

Use Git to clone the Umbraco Cloud site. Once you have it locally, open your CLI and simply type the following inside the website's cloned directory:

`uaas watch`

This will start the module and you'll be asked to type in your credentials. A local server will boot up if authenticated, which serves as a BrowserSync proxy to your Umbraco Cloud site. The server is set to run on port 3000 and should open in your default browser automatically.

![](images/cli-example.png)

Now it's time to open your favourite code editor. The idea is that you are now able to change all front-end files locally. By default the module is watching the `/css`, `/Views`, `/scripts` and `/images` folders. Any changes in these folders will be synced between your local- and Umbraco Cloud site. A change to any of the files will also auto refresh your browser so you can see the change immediately.

## Configuration

If you'd like the module to watch other files/folders, simply change the `uaas.json` file located in `/App_Data`.

	{
		"files": [
			"css/**/*.css",
			"scripts/**/*.js",
			"Views/**/*.*",
			"images/**/*.*"
		],
		"useHttps": false,
		"username": "youremail@domain.com"
	}

## Content Changes

Changing content needs to be done through the development environment. Whenever you change some content on your development environment, your local instance will be notified and the changes will be synced. 

This flow enables you to do rapid front-end changes and displaying them directly against the content on the Umbraco Cloud site.
