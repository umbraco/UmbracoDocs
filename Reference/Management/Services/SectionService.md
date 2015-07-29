#SectionService

**Applies to Umbraco 7.x and newer**

The SectionService is used to control/query the storage for section registrations in the ~/Config/applications.config file.

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
The SectionService is available through the `ApplicationContext`, but the if you are using a `SurfaceController` or the `UmbracoUserControl` then the SectionService is available through a local `Services` property.

	Services.SectionService

Getting the service through the `ApplicationContext`:

	ApplicationContext.Current.Services.SectionService

##Methods

###.GetSections()
Gets all `Umbraco.Core.Models.Section` objects

###.GetAllowedSections(int userId)
Gets all `Umbraco.Core.Models.Section` objects that the user with the specified ID is allowed to access

###.GetByAlias(string appAlias)
Gets the `Umbraco.Core.Models.Section` object by its alias

###.MakeNew(string name, string alias, string icon)
Persists a new `Umbraco.Core.Models.Section` object

###.MakeNew(string name, string alias, string icon, int sortOrder)
Persists a new `Umbraco.Core.Models.Section` object

###.DeleteSection(Section section)
Deletes the specified `Umbraco.Core.Models.Section` object