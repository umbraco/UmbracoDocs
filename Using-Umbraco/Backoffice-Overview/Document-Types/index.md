#Document Types#
_A Document Type is a way to structure the data of your website. A Document Type consists of Properties, and a Document Type also defines which Templates can render its data._
##Creating Document Types##
Document Types are created in the 'Settings' section of the Backoffice by rightclicking on the node 
Document Types and choosing 'Create' in the context menu:

![creating a Document Type in the Settings section](images/documenttype-create.gif?raw=true)

A new Document Type has 4 configuration tabs:

![Document Type configuation tabs](images/documenttype-configuration-tabs.gif?raw=true)

###Info###
The Info tab is where you set the Name and Alias of your Document Type. Under this tab you also define which Templates 
can render the data this Document Type holds. Also the display options are set under the Info tab, like the Icon with 
which it is shown in the Content Tree or its Thumbnail and Description when a user creates a new Document Type in the Content Tree.
###Structure###
The Structure tab is where you control the hierarchy of your site. Structure allows you to determine which 
Document Types can be nested as children to the one you are creating.
###Generic properties###
This tab holds the properties that are created on the Document Type or that are inherited from a Master Document Type. Inherited Properties can not be edited.
###Tabs###
Document Types organize Properties on the screen by using Tabs so the first thing you will want to do when creating a Document Type is create one or more tabs
##Properties##
A Document Type can be compared in a certain way with a Data Table in a database. The Document Type Properties are then analogous to the fields of a database. For instance, a 'Customer' Document Type can hold a 'Firstname' Property, a 'Lastname' and an age Property.
Like the fields in a database, you have to define what kind of data a Property will hold. This is done by choosing a Data Type for the Property. The 'Firstname' Property would then hold a 'Text' Data Type while the 'Age' Property could hold a 'Number' Data Type.