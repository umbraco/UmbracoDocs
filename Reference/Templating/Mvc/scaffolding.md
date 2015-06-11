#Scaffolding

_Scaffold common Umbraco items like Surface Controllers, Custom Controllers and views from the Visual Studio Console, by installing 
the UmbracoCms.Scaffolding nuget package_

##Installing
In your Visual Studio solution, install from nuget, by entering the following in the Package Manager Console:

	Install-Package UmbracoCms.Scaffolding


##Using
Scaffolding an item with the scaffolder, enter the command `Scaffold TemplateName Name Parameters` into  the Package Manager Console. The Scaffolder comes with a number of build-in templates:

- SurfaceController
- CustomController
- View
- PartialView
- MacroPartial


##SurfaceController
Generates a complete SurfaceController, Model and View with a scaffolded form based on the view. Pass in the Name and model properties.
This Scaffolder checks for an existing model class in project, if not found it will build a model using the properties, which should be passed as 
a comma-seperated string like so:

	Scaffold SurfaceController Name Id,Name,Description,PublishingDate

This will generate 3 files in the project:

- */Models/Name.cs* with the Id,Name,Description,PublishingDate propeties
- */Controllers/SurfaceControllers/NameSurfaceController.cs"
- */Views/NameSurface/Name.cshtml*


##CustomController
Generates a Controller which intercepts requests to documents with a specific Content Type.

	Scaffold CustomController ContentTypeName

Generates a single class, which inheris from `RenderMvcController`, and contains 2 sample methods, one for handling all requests to documents of this type, and one for only handling requests to documents of this type with a specific template

- */Controllers/CustomControllers/ContentTypeNameController.cs


##View
Generates a .cshtml view in /Views, inherits from UmbracoTemplatePage and contains a couple of code samples, can optionally have a layout set as a parameter, otherwise Layout is set to null.

	Scaffold View NameOfView Layout


##PartialView
Generates a .cshtml partial view in /Views/Partials, inherits from `UmbracoViewPage<Model>` and contains a couple of code samples. The Model is an optional paramater, if not set, Model is set to `IPublishedContent`

	Scaffold PartialView NameOfView Model


##MacroPartial
Generates a .cshtml view in /Views/MacroPartials, inherits from `PartialViewMacroPage` and contains references for Model, Parameters and Umbraco helper library.

	Scaffold MacroPartial Name


##Force Scaffolding
For all scaffolders, it is possible to override existing files, by adding `-force` as a paramater, like this

	Scaffold View Textpage -force

##Modify templates
If you for some reason want to edit or add scaffolders, these are located in the /CodeTemplates/Scaffolders project in your solution. Each template has a folder matching the template name. Each template consists of a .ps1 powershell script and a .t4 template file which generates the files. 	