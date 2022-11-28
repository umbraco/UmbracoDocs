# UserService

The UserService acts as a "gateway" to Umbraco data for operations which are related to Users.

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

* [**Create a new user**](create-a-new-user.md)\
  Quick sample showing how to create a new backoffice user; including setting a password, assigning the user to a user group, and setting the name of the user.
