---
versionFrom: 9.0.0
---

# IMemberManager

`IMemberManager` is an user manager interface for accessing member data in the form of `IPublishedContent`. `IMemberManager` has a variety of methods that are useful in views, controllers, and webforms classes. For the list of methods, see the [IMemberManager Interface API Documentation](https://apidocs.umbraco.com/v9/csharp/api/Umbraco.Cms.Core.Security.IMemberManager.html#methods).

## How to reference IMemberManager

There are different ways to reference MembershipHelper:

### Views

While working with templates, the methods are available when you inject `@IMemberManager` to access member data:

```csharp
@inject IMemberManager _memberManager;

_memberManager.IsLoggedIn()
```

### Dependency Injection

If you wish to use the `IMemberManager` in a class that inherits from one of the Umbraco base classes (eg. `SurfaceController`, `UmbracoApiController`, or `UmbracoAuthorizedApiController`),  you can use Dependency Injection. For instance, if you have registered your own class in Umbraco's dependency injection, you can specify the `IMemberManager` interface in your constructor:

```csharp

 public class MemberAuthenticationSurfaceController : SurfaceController
    {
        private readonly IMemberManager _memberManager;
       
        public MemberAuthenticationSurfaceController(IMemberManager memberManager)
        {
            _memberManager = memberManager;
        }
    }
```

## Methods

### AsPublishedMember(MemberIdentityUser)

Returns the identity user instance used for the member.

### GetCurrentMemberAsync()

Returns the currently logged in member if there is one, else returns null value.

### IsLoggedIn()

Checks if a member is logged in.

### IsMemberAuthorizedAsync(IEnumerable<String>, IEnumerable<String>, IEnumerable<Int32>)

Checks if the current member is authorized based on the parameters provided.

### IsProtectedAsync()

Checks if a document object is protected by the "Protect Pages" functionality in Umbraco.

### MemberHasAccessAsync(IEnumerable<String>)

Checks if the current user has access to the path.

### MemberHasAccessAsync(String)

Checks if the current user has access to a document.
