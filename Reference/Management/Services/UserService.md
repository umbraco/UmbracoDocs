# UserService

**Applies to Umbraco 6.x and newer**

The UserService acts as a "gateway" to Umbraco data for operations which are related to Users.

[Browse the API documentation for UserService](https://our.umbraco.org/apidocs/csharp/api/Umbraco.Core.Services.UserService.html).

 * **Namespace:** `Umbraco.Core.Services` 
 * **Assembly:** `Umbraco.Core.dll`

All samples listed in this document will require references to the following dll:

* Umbraco.Core.dll

All samples listed in this document will require the following usings:
	
	using Umbraco.Core.Models.Membership;
	using Umbraco.Core.Services;

## Getting the service
The UserService is available through the `ApplicationContext`, but if you are using a `SurfaceController` or the `UmbracoUserControl` then the UserService is available through a local `Services` property.

	Services.UserService

Getting the service through the `ApplicationContext`:

	ApplicationContext.Current.Services.UserService

## Samples

* [**Create a new user**](./UserService/Create-a-new-user.md)<br />Quick sample showing how to create a new user; including setting a password, assigning the user to a user group (from Umbraco 7.7 and up), and setting the name of the user.
