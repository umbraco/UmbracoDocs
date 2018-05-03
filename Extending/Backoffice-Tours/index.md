# Backoffice tours

Backoffice tours are managed in a JSON format and stored in files on disk. The filenames should end with the .json extension.

## Tour file locations

The tour functionality will load information from multiple locations.

### Core tours and custom tours

The tour file that ships with Umbraco are stored in /Config/BackofficeTours. This is also the recommended place for storing your own tour files.

### Plugin tours

If you want to include a tour with your custom plugin you can store the tour file in /App_Plugins/<YourPlugin>/backoffice/tours. It is recommend that you place the tour files here when you are creating a plugin.

## The JSON format

A tour file contains an array of tour JSON objects. So it's possible to have multiple, (un)related tours in one file.

	[
		{
			//tour object
		},
		{
			//tour object
		}
	]

## The tour object

A tour JSON object looks like this.

	{
		"name": "My Awesome tour",
		"alias": "myUniqueAlias",
		"group": "Get things done!!!",
		"groupOrder": 1,
		"allowDisable": true,
		"culture" : "en-US",
		"requiredSections": ["content","media"],
		"steps": []
	}

### name
