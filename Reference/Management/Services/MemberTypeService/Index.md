# MemberTypeService

**Applies to Umbraco 7.1 and 6.2 and newer**

The MemberTypeService acts as a "gateway" to Umbraco data for operations which are related to MemberTypes.

[Browse the API documentation for MemberTypeService](https://our.umbraco.com/apidocs/csharp/api/Umbraco.Core.Services.MemberTypeService.html).

 * **Namespace:** `Umbraco.Core.Services` 
 * **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following using statements:
	
	using Umbraco.Core;
	using Umbraco.Core.Models;
	using Umbraco.Core.Services;

## Getting the service
The MemberTypeService is available through the `ApplicationContext`, but the if you are using a `SurfaceController` or the `UmbracoUserControl` then the MemberTypeService is available through a local `Services` property.

	Services.MemberTypeService

Getting the service through the `ApplicationContext`:

	ApplicationContext.Current.Services.MemberTypeService

## Methods

### .Delete(IMemberType memberType);
Deletes a `MemberType`

### .Get(string alias)
Returns a `MemberType` with a given alias

### .GetAll(int[] ids);
Returns a collection of `MemberType` with the given ids

### .Save(IMemberType memberType)
Saves a `MemberType`
