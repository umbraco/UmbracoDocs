---
versionFrom: 8.0.0
---

# UserService

The UserService acts as a "gateway" to Umbraco data for operations which are related to Users.

[Browse the API documentation for IUserService](https://our.umbraco.com/apidocs/v8/csharp/api/Umbraco.Core.Services.IUserService.html).

 * **Namespace:** `Umbraco.Core.Services`
 * **Assembly:** `Umbraco.Core.dll`

All samples listed in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following using statements:

```csharp
using Umbraco.Core;
using Umbraco.Core.Models;
using Umbraco.Core.Services;
```

## Getting the service

### Services property

If you wish to use the UserService in a class that inherits from one of the Umbraco base classes (eg. `SurfaceController`, `UmbracoApiController` or `UmbracoAuthorizedApiController`), you can access the service through a local `Services` property:

```csharp
IUserService userService = Services.UserService;
```

### Dependency Injection

In other cases, you may be able to use Dependency Injection. For instance if you have registered your own class in Umbraco's dependency injection, you can specify the `IUserService` interface in your constructor:

```csharp
public class MyClass
{

    private IUserService _userService;
    
    public MyClass(IUserService userService)
    {
        _userService = userService;
    }

}
```

### Static accessor

If neither a `Services` property or Dependency Injection is available, you can also reference the static `Current` class directly:

```csharp
IUserService userService = Umbraco.Core.Composing.Current.Services.UserService;
```


## Samples

* [**Create a new user**](Create-a-new-user.md)<br />Quick sample showing how to create a new backoffice user; including setting a password, assigning the user to a user group (from Umbraco 7.7 and up), and setting the name of the user.

* [**Get a reference to a user**](Get-a-reference-to-a-user.md)<br />See the different ways to lookup a backoffice user.

* [**Update user information**](Update-user-information.md)<br />See how you can update user information such as names and avatars.
