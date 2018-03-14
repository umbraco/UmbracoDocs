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

If you wish to use use the user service in a class that inherits from one of the Umbraco base classes - eg. `SurfaceController`, `UmbracoApiController` or `UmbracoAuthorizedApiController` - you can access the user service through a local `Services` property:

	IUserService us = Services.UserService;
	
In Razor views, you can access the UserService through the `ApplicationContext` property:

	IUserService us = ApplicationContext.Services.UserService

If neither a `Services` property or a `ApplicationContext` is available, you can also reference the `ApplicationContext` class directly:

	IUserService us = ApplicationContext.Current.Services.UserService

## Samples

* [**Create a new user**](./Create-a-new-user.md)<br />Quick sample showing how to create a new backoffice user; including setting a password, assigning the user to a user group (from Umbraco 7.7 and up), and setting the name of the user.

* [**Get a reference to a user**](./Get-a-reference-to-a-user.md)<br />See the different ways to lookup a backoffice user.

* [**Update user information**](./Update-user-information.md)<br />See how you can update user information such as names and avatars.
