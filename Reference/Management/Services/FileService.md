#FileService

**Applies to Umbraco 6.x and newer**

The FileService acts as a "gateway" to Umbraco data for operations which are related to Scripts, Stylesheets and Templates.

 * **Namespace:** `Umbraco.Core.Services` 
 * **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following usings:
	
	using Umbraco.Core;
	using Umbraco.Core.Models;
	using Umbraco.Core.Services;

**Please note that this page will be updated with samples and additional information about the methods listed below**

##Getting the service
The FileService is available through the `ApplicationContext`, but the if you are using a `SurfaceController` or the `UmbracoUserControl` then the FileService is available through a local `Services` property.

	Services.FileService

Getting the service through the `ApplicationContext`:

	ApplicationContext.Current.Services.FileService

##Methods

###.GetTemplate(string alias)

Gets a single `ITemplateObject` object.

###.DeleteTemplate(string alias, int userId = 0)

Delete a single `ITemplateObject` object.

###.Save(ITemplate template)

Saves a single `Template` object.
