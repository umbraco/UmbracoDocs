#Defining and attaching prevaluesources
Prevalue sources can be hooked to fields that use a list fieldtype (radiobuttonlist, checkboxlist, dropdownlist). Making it possible to retrieve a list of items from a certain source.

##Setting up a prevalue sources
Prevalue sources can be managed in the corresponding part of the Contour section

![Prevalue source tree](prevaluesourcetree.png)

###Create new prevalue source

Right click the prevalue source tree and select create, you should get a new page where you'll need to provide a name for the new prevalue source

![Create dialog](create.png)

###Choose type
First you'll need to select the type of prevalue source you'll want to use, an overview of the different default types can be found [below](##Overviewofthedefaultprevaluesourcetypes)

![Choose type](choosetype.png)

###Fill in settings
Depending on the type you'll need to provide some additional settings

![Type settings](typesettings.png)

In this example I am using the 'get values from textfile' type and providing a .txt file that contains

	example value 1
	example value 2
	example value 3
	example value 4
	example value 5

###Save the prevalue source
Once the settings are populated save the prevalue source by hitting the save icon in the toolbar

![Save](save.png)

###Watch preview of the values
If the settings are succesfully validated and they return results you should get an overview of the values.

![Preview](preview.png)

##Attaching a prevalue source to a field
Now move to the form where you want to use the prevalue source add or edit a field and go to the additional settings (the fieldtype has to support prevalues so checkboxlist, radiobuttonlist, dropdownlist). When there is at least 1 prevalue source you should now see a new option called prevalue source where we can choose 1 of the available prevalue sources.

![Prevalue source](FieldPrevalueSource.png)

Choose the correct type (so the name of the prevalue source), you should now see a render of the field in the designer using the values coming from the attached source

![Preview](fieldpreview.png)



##Overview of the default prevalue source types
There are a couple of default prevalue source types that can be used, here is an overview:

###Get values from textfile
Upload textfile that contains the prevalues (seperated by linebreak)

###SQL Database
Connects to a OLEDB compatible Database Table and constructs a prevalue source from it, which is editable from the forms UI


###Umbraco data type Prevalues
Connects to an Umbraco data type and uses its prevalue collection


###Umbraco Documents
Uses nodes from a specific source as prevalues
