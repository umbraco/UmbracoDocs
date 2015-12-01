#MemberGroupService

**Applies to Umbraco 7.1 and 6.2 and newer**

The MemberGroupService acts as a "gateway" to Umbraco data for operations which are related to Member groups, which are also known as Member Roles.

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
The MemberGroupService is available through the `ApplicationContext`, but the if you are using a `SurfaceController` or the `UmbracoUserControl` then the MemberGroupService is available through a local `Services` property.

	Services.MemberGroupService

Getting the service through the `ApplicationContext`:

	ApplicationContext.Current.Services.MemberGroupService

##Methods

###.Delete(IMemberGroup)
Deletes a given `MemberGroup`

###.GetAll();
Returns a `MemberGroup` collection

###.GetById(int id);
Returns a `MemberGroup` with a given Id

###.GetByName(string name);
Returns a `MemberGroup` with a given name

###.Save(IMemberGroup group)
Saves a `MemberGroup`