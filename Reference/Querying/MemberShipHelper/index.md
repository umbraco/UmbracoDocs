---
versionFrom: 8.0.0
versionTo: 8.18.0
meta.RedirectLink: "/umbraco-cms/reference/querying/imembermanager"
---

:::warning
The topic covered in this article is only relevant to you if you are using Umbraco 8 or below.

If you are using Umbraco 9 or above, see the [IMemberManager](../IMemberManager/index.md) article.
:::

# Membershiphelper

_`MembershipHelper` is a helper class for accessing member data in the form of `IPublishedContent`.
`MembershipHelper` has a variety of helper methods that are useful when working in your views, controllers and webforms classes._

[For a more detailed list, visit the API documentation.](https://our.umbraco.com/apidocs/v8/csharp/api/Umbraco.Web.Security.MembershipHelper.html#methods)

## How to reference MembershipHelper?

There are different ways on how to reference MembershipHelper.

### Views

When working in templating, this helper will automatically be there for you to use as `@Members` which means you conveniently in your templates can access member data:

```csharp
@Members.IsLoggedIn();
@Members.GetCurrentMemberProfileModel();
```

### Members Property

If you wish to use the `MembershipHelper` in a class that inherits from one of the Umbraco base classes (eg. `SurfaceController`, `UmbracoApiController` or `UmbracoAuthorizedApiController`), you can access the membership helper through a local `Members` property:

```csharp
MembershipHelper membershipHelper = Members;
```

### Dependency Injection

In other cases, you may be able to use Dependency Injection. For instance if you have registered your own class in Umbraco's dependency injection, you can specify the `MembershipHelper` interface in your constructor:

```csharp
public class MyClass
{

    private MembershipHelper _membershipHelper;
    
    public MyClass(MembershipHelper membershipHelper)
    {
        _membershipHelper = membershipHelper;
    }

}
```

### Factory

If neither a Members property or Controller Injection is available, you can also reference the `MembershipHelper` by using the Factory in the static `Current` class.

```csharp
public class MyClass
{
    private MembershipHelper _membershipHelper;
    
    public MyClass()
    {
        _membershipHelper = Umbraco.Core.Composing.Current.Factory.GetInstance<MembershipHelper>();
    }
}
```

## ProfileModel and IPublishedContent

When looking up Members, member data is returned as `IPublishedContent`, which is the same format used for Content and Media, so referencing member properties should
be the exact same api as with those.

When looking at the currently logged in Member, you will get a `ProfileModel` back, which contains the same data, by with additional methods and properties available
which are specific to members.

### .GetByEmail(string email)

Looks for a member with a given email, if found, returns a member profile as `IPublishedContent`

### .GetById(int memberId)

Looks for a member with a given node ID, if found, returns a member profile as `IPublishedContent`

### .GetByProviderKey(object key)

Looks for a member with a given provider key, if found, returns a member profile as `IPublishedContent`. Provider key is the key that
the membership provider allocates for the member as its primary key.
Umbraco's default membership provider assigns a guid, alternative providers such as active directive likely uses another format.

### .GetByUsername(string username)

Looks for a member with a given username, if found, returns a member profile as `IPublishedContent`

### .GetCurrentLoginStatus()

Gets the current members login status as a `LoginStatusModel`

### .GetCurrentMember()

Get the currently logged in member as `IPublishedContent`

### .GetCurrentMemberProfileModel()

Gets the current member profile as a `ProfileModel`

### .GetCurrentMemberId()

Gets the currently logged in member id, -1 if they are not logged in.

### .IsLoggedIn()

Returns a boolean to state whether there is a member currently logged in.

### .Login(string username, string password)

Attempts to log in a member with the given username and password

### .IsMemberAuthorized(params)

Determines if a member is authorized, based on memberType, associated roles, and member ID.

### .IsUmbracoMembershipProviderActive()

Detects if the default Umbraco membership provider is in use.

### .RegisterMember(RegisterModel model)

Registers a new member

### .UpdateMemberProfile(ProfileModel model)

Updates a current member profile
