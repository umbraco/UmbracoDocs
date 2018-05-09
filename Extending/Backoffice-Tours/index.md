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

Below is a explanation of each of the properties on the object

### name 

This is the name that is displayed in the help drawer for the tour.

![Tour name highlighted](images/tourname.png)

### alias 

This is the unique alias of your tour. This is used to track the progress a user has made during taking a tour. The information of the tour progress is stored in the TourData column of the UmbracoUsers table in the database.

### group 

The group property is used to group related tours in the help drawer under a common subject (eg. Getting started). 

![Tour group highlighted](images/tourgroup.png)

### groupOrder 

This is used to control the order of the groups in the help drawer. This must be a integer value.

### allowDisable 

A boolean value that indicates if the "Don't show this tour again" should be shown on the tour steps. If the user clicks this link the tour will not be shown in the help drawer anymore.

### culture (introduced in v7.11)

You can set a culture (eg. nl-NL) and this tour will only be shown for users that have set this culture on their profile. If ommitted or left empty the tour will be shown to all users.

### sections
This is an array of section aliases that user needs to be able to access. If the user doesn't have access to all the sections the tour will not be shown in the help drawer. Eg. if the tour requires to content,media and settings and the logged in user only has access to content and media, the tour will not be shown for this user.

### steps

This is array of step JSON objects that user needs to take to complete the tour.









