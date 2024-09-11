---
description: "Using the IMemberManager"
---

# IMemberManager

`IMemberManager` has a variety of methods that are useful for managing members in controllers and views. In this article, we'll have a look at how some of these can be used.

{% hint style="info" %}
For the full list of methods, see the [IMemberManager Interface API Documentation](https://apidocs.umbraco.com/v14/csharp/api/Umbraco.Cms.Core.Security.IMemberManager.html#methods).
{% endhint %}

## How to reference IMemberManager

There are different ways to reference `IMemberManager`:

### Dependency Injection

The recommended way is to create a [Controller](../../implementation/controllers.md) or Service and inject `IMemberManager` in the constructor:

{% code title="MemberAuthenticationController.cs" %}
```csharp
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Core.Security;

namespace UmbracoDocs.Samples;

public class MemberAuthenticationController : Controller
{
    private readonly IMemberManager _memberManager;

    public MemberAuthenticationController(IMemberManager memberManager)
        => _memberManager = memberManager;
}
```
{% endcode %}

### Views

Alternatively, `IMemberManager` can be injected directly into a template:

{% code title="MemberAuthenticationView.cshtml" %}
```cshtml
@using Umbraco.Cms.Core.Security;
@inject IMemberManager _memberManager;
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage

@if (_memberManager.IsLoggedIn())
{
    @* Do something when a member is logged in *@
}
```
{% endcode %}

{% hint style="info" %}
It is advisable to implement Controllers to manage this kind of view logic.
{% endhint %}

## Examples

### Finding members

`IMemberManager` has multiple ways to find members.

#### FindByIdAsync(string)

Finds a member by their ID

```csharp
var member = await _memberManager.FindByIdAsync("1234");
// Do stuff with the member, for instance checking if email is confirmed
var emailConfirmed = member is not null && member.EmailConfirmed;
```

If we want to find a member by `Udi` or `Guid` we need to inject `IIdKeyMap` service:

#### Find member by `Udi`

```csharp
var memberUdiAttempt = _idKeyMap.GetIdForUdi(memberUdi);
if (memberUdiAttempt.Success)
{
    var memberId = memberUdiAttempt.Result;
    var member = await _memberManager.FindByIdAsync(memberId.ToString());
}
```

#### Find member by `Guid`

```csharp
var memberKeyAttempt = _idKeyMap.GetIdForKey(memberKey, UmbracoObjectTypes.Member);
if (memberKeyAttempt.Success)
{
    var memberId = memberKeyAttempt.Result;
    var member = await _memberManager.FindByIdAsync(memberId.ToString());
}
```

#### FindByEmailAsync(string)

Finds a member by their email.

```csharp
var member = await _memberManager.FindByEmailAsync("test@member.com");
// Do stuff with the member, for instance checking if email is confirmed
var emailConfirmed = member is not null && member.EmailConfirmed;
```

#### FindByNameAsync(string)

Finds a member by their login name.

```csharp
var member = await _memberManager.FindByNameAsync("TestLoginName");
// Do stuff with the member, for instance checking if email is confirmed
var emailConfirmed = member is not null && member.EmailConfirmed;
```

### AsPublishedMember(MemberIdentityUser)

The `IMemberManager` methods returns members as `MemberIdentityUser`.

Since Members Types are defined like Content Types in Umbraco, members can hold any number of properties. To access these properties, it can be beneficial to convert the member into an `IPublishedContent` instance.

This is done using `AsPublishedMember(MemberIdentityUser)`::

```csharp
MemberIdentityUser? member = await _memberManager.FindByEmailAsync("test@member.com");
if (member is not null)
{
    IPublishedContent? memberAsContent = _memberManager.AsPublishedMember(member);
    // Access member content properties
}
```

### GetCurrentMemberAsync()

Returns the currently logged in member if there is one, else returns null value.

```csharp
var currentMember = await _memberManager.GetCurrentMemberAsync();
var currentMemberName = currentMember?.Name;
```

### GetUserIdAsync()

Returns the ID of a member.

```csharp
public async Task<string> GetMemberId(MemberIdentityUser member)
    => await _memberManager.GetUserIdAsync(member);
```

### IsLoggedIn()

Checks if the current request contains a logged-in member.

```csharp
public async Task<string> GetMemberId(MemberIdentityUser member)
    => await _memberManager.GetUserIdAsync(member);
```

### IsMemberAuthorizedAsync(IEnumerable memberTypes, IEnumerable memberGroups, IEnumerable memberIds)

Checks if the current member is authorized as specific member types, member groups or concrete members.

For instance, you can use this method to verify if the current logged in member is part of a specific group:

```csharp
var memberIsVIP = await _memberManager.IsMemberAuthorizedAsync(allowGroups: new []{"VIP"});
```

### IsProtectedAsync()

Returns a `Task<bool>` specifying if the content with a given [Umbraco path](ipublishedcontent/properties.md#path) has public access restrictions set.

```csharp
public async Task<string> GetContentName(IPublishedContent content)
    => await _memberManager.IsProtectedAsync(content.Path)
        ? $"{content.Name} - Members only!"
        : $"{content.Name} - Access for everyone!";
```

### MemberHasAccessAsync(string)

Returns a `Task<bool>` specifying if the currently logged in member has access to the content given its [Umbraco path](ipublishedcontent/properties.md#path).

```csharp
public async Task<string> GetContentName(IPublishedContent content)
    => await _memberManager.MemberHasAccessAsync(content.Path)
        ? content.Name
        : "Members only";
```

### ValidateCredentialsAsync(string username, string password)

Validates that specific member credentials are correct (without performing a log-in).

```csharp
public async Task<bool> IsValidCredentials(string userName, string password)
    => await _memberManager.ValidateCredentialsAsync(userName, password);
```
