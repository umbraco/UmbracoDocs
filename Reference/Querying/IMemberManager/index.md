---
versionFrom: 9.0.0
meta.Title: "Umbraco IMemberManager"
meta.Description: "Using the IMemberManager1"
state: complete
verified-against: rc-003
update-links: true
---

# IMemberManager

`IMemberManager` is an user manager interface for accessing member data in the form of `MemberIdentityUser` and converting it to `IPublishedContent`. `IMemberManager` has a variety of methods that are useful in views and controllers. For the list of methods, see the [IMemberManager Interface API Documentation](https://apidocs.umbraco.com/v9/csharp/api/Umbraco.Cms.Core.Security.IMemberManager.html#methods).

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

## Examples

### Finding members

`IMemberManager` has multiple ways to find members.

#### FindByIdAsync(string)

Finds a member by their ID 

```C#
@{
	var memberById = await _memberManager.FindByIdAsync("1234");
	// Do stuff with the member, for instance checking if email is confirmed
	var emailConfirmed = memberById.EmailConfirmed;
}
```


#### FindByEmailAsync(string)

Finds a member by their email.

```C#
@{
	var memberById = await _memberManager.FindByEmailAsync("test@member.com");
	// Do stuff with the member, for instance checking if email is confirmed
	var emailConfirmed = memberById.EmailConfirmed;
}
```

#### FindByNameAsync(string)

Finds a member by their login name.

```C#
@{
	var memberById = await _memberManager.FindByNameAsync("TestLoginName");
	// Do stuff with the member, for instance checking if email is confirmed
	var emailConfirmed = memberById.EmailConfirmed;
}
```


### AsPublishedMember(MemberIdentityUser)

By default `IMemberManager` returns members as `MemberIdentityUser`. This method allows you to convert a `MemberIndentityUser` into `IPublishedContent`:

```C#
@{
	MemberIdentityUser memberById = await _memberManager.FindByEmailAsync("test@member.com");
	IPublishedContent memberAsContent = _memberManager.AsPublishedMember(memberById);
}
```


### GetCurrentMemberAsync()

Returns the currently logged in member if there is one, else returns null value.

```C#
@{
	var currentMember = await _memberManager.GetCurrentMemberAsync();
}

@if (currentMember is not null)
{
	<p>A member is logged in, member username: @currentMember.UserName</p>
}
else
{
	<p>No member is logged in.</p>
}
```

### IsLoggedIn()

Checks if a member is logged in.

```C#
@if (_memberManager.IsLoggedIn())
{
	<p>A member is logged in</p>
}
else
{
	<p>No member is logged in.</p>
}
```

### IsMemberAuthorizedAsync(IEnumerable<String>, IEnumerable<String>, IEnumerable<Int32>)

Checks if the current member is authorized for content protected by types, groups or specific members. For instance you can use this method to check if the current logged in member is authorized for pages only available to the VIP member group like so: 

```C#
@{
	var memberIsAuthorized = await _memberManager.IsMemberAuthorizedAsync(allowGroups: new []{"VIP"});
}
```

### IsProtectedAsync()

Returns a `Task<bool>` specifying if the page with a given [Umbraco path](../IPublishedContent/Properties/index.md#Path) has public access restrictions set.

```csharp
<ul>
	@foreach (var child in Model.Children)
	{
		@if (await _memberManager.IsProtectedAsync(child.Path))
		{
			<li>@child.Name - Members only!</li>
		}
		else
		{
			<li>@child.Name - Access to everyone!</li>
		}
	}
</ul>
```

### MemberHasAccessAsync(string)

Returns a `Task<bool>` specifying if the currently logged in member has access to the page given its [Umbraco path](../IPublishedContent/Properties/index.md#Path).

```csharp
<ul>
	@foreach (var child in Model.Children)
	{
		// Only display the page if the current member has access to it.
		@if (await _memberManager.MemberHasAccessAsync(child.Path))
		{
			<li>@child.Name</li>
		}
	}
</ul>
```