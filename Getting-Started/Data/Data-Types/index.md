#Data-Types
*A Data Type defines the type of input for a property. So when adding a property (on Document Types, Media Types and Members) when selecting the Type you are selecting a Data Type. There are a number of of preconfigured Data Types available in Umbraco and more can be added in the Developer section.*

##What is a data type?
A Data Type can be something very simple (textstring, number, true/false,...) or more complex (multi node tree picker, image cropper, Grid Layout).

The Data type references a Property Editor and if the Property Editor has settings these are configured on the Data Type. This means you can have multiple Data Types referencing the same Property Editor.

An example of this could be to have two dropdown Data Types both referencing the same dropdown Property Editor. One configured to show a list of cities, the other a list of countries.

##Creating a new Data-Type
To create a new Data Type go to the Developer section and click the menu icon to the right of __Data-Types__ and select __Create__. Name the Data Type, we'll call it "Dropdown Cities".

![Dropdown List](images/Data-Types-Create.jpg)

* __Property Editor:__ This is where you pick the Property Editor that our *Dropdown Cities* Data Type will be referencing. Pick the __Dropdown List__ and now you will see the cofiguration options that are available for a Data Type referencing the Dropdown List Property Editor.

* __Property Editor Alias__
The alias of the Property Editor being used.

* __Add prevalue:__ Here you can add prevalues to this Data Type by entering the value you want into the input field and pressing the __add__ button. For the "Dropdown Cities" list this could be:
    * London
    * Paris
    * Berlin

When you're happy with the list press Save and it is now possible to select this Data Type for a property on Document Types, Media Types and Members. This will then create a dropdown list for the editor to choose from and save the choice as a string.

##Customizing Data-Types
To customize an existing Data Type go to the __Developer__ section, expand the __Data-Types__ node and select the Data Type you want to edit.

Aside from the Data Types That are available out of the box there are some additional Property Editors to choose from such as the __Slider__ and __Macro Container__.

##More information
* [List of available Data types](../../../Reference/Data-Types/)
* [Property Editors](../../../Reference/Property-Editors/)

##Related Services
* [DataTypeService](../../../Reference/Management/Services/DataTypeService.md)

##Umbraco.tv
* [Data Types](http://umbraco.tv/videos/umbraco-v7/implementor/fundamentals/document-types/data-types/)
* [Customizing Data Types](http://umbraco.tv/videos/umbraco-v7/implementor/fundamentals/document-types/customizing-data-types/)
