#ApplicationTreeService

**Applies to Umbraco 7.x and newer**

The ApplicationTreeService is used to control/query the storage for tree registrations in the ~/Config/trees.config file.

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
The ApplicationTreeService is available through the `ApplicationContext`, but the if you are using a `SurfaceController` or the `UmbracoUserControl` then the ApplicationTreeService is available through a local `Services` property.

	Services.ApplicationTreeService

Getting the service through the `ApplicationContext`:

	ApplicationContext.Current.Services.ApplicationTreeService

##Methods

###.MakeNew(bool initialize, byte sortOrder, string applicationAlias, string alias, string title, string iconClosed, string iconOpened, string type)
Persists a new `Umbraco.Core.Models.ApplicationTree` object

###.SaveTree(ApplicationTree tree)
Saves a `Umbraco.Core.Models.ApplicationTree` object

###.DeleteTree(ApplicationTree tree)
Deletes a `Umbraco.Core.Models.ApplicationTree` object 

###.GetByAlias(string treeAlias)
Gets a `Umbraco.Core.Models.ApplicationTree` object by alias

###.GetAll()
Gets all registered `Umbraco.Core.Models.ApplicationTree` objects

###.GetApplicationTrees(string applicationAlias)
Gets all `Umbraco.Core.Models.ApplicationTree` objects for the specified section

###.GetApplicationTrees(string applicationAlias, bool onlyInitialized)
Gets all `Umbraco.Core.Models.ApplicationTree` objects for the specified section that are marked to be initialized