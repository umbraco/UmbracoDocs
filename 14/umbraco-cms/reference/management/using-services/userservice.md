---
description: This will show you how to perform various User management using the Umbraco service layer.
---

# User Service

Learn how to use the User Service to manage the users on your Umbraco project.

## Assigning a User to a User Group

To assign a User to a User Group, we need both the `IUserService` and `IUserGroupService`. As with all Umbraco services, these are obtained using dependency injection.

1. Start by defining an interface for our implementation:

{% code title="ISampleUserHandler.cs" %}
```csharp
namespace UmbracoDocs.Samples;

public interface ISampleUserHandler
{
    Task<bool> AssignUserToAdminGroup(string email, Guid performingUserKey);
}
```
{% endcode %}

2. Next we implement the interface. This implementation holds the dependency to the Umbraco services:

{% code title="SampleUserHandler.cs" %}
```csharp
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Core.Models.Membership;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Core.Services.OperationStatus;

namespace UmbracoDocs.Samples;

public class SampleUserHandler : ISampleUserHandler
{
    private readonly IUserService _userService;
    private readonly IUserGroupService _userGroupService;

    public SampleUserHandler(IUserService userService, IUserGroupService userGroupService)
    {
        _userService = userService;
        _userGroupService = userGroupService;
    }

    public async Task<bool> AssignUserToAdminGroup(string email, Guid performingUserKey)
    {
        IUser? user = _userService.GetByEmail(email);
        if (user is null)
        {
            return false;
        }

        Attempt<UserGroupOperationStatus> result = await _userGroupService.AddUsersToUserGroupAsync(
            new UsersToUserGroupManipulationModel(Constants.Security.AdminGroupKey, [user.Key]),
            performingUserKey
        );

        return result.Success;
    }
}
```
{% endcode %}

3. Register the implementation in a Composer:

{% code title="SampleUserHandlerComposer.cs" %}
```csharp
using Umbraco.Cms.Core.Composing;

namespace UmbracoDocs.Samples;

public class SampleUserHandlerComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
        => builder.Services.AddSingleton<ISampleUserHandler, SampleUserHandler>();
}
```
{% endcode %}

4. Lastly, we need to put our implementation to use. This could be done in a Management API controller:

{% code title="SampleUserController.cs" %}
```csharp
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Api.Management.Controllers;
using Umbraco.Cms.Api.Management.Routing;
using Umbraco.Cms.Core.Security;

namespace UmbracoDocs.Samples;

[ApiExplorerSettings(GroupName = "Sample user handler")]
[VersionedApiBackOfficeRoute("sample/user-handler")]
public class SampleUserController : ManagementApiControllerBase
{
    private readonly ISampleUserHandler _sampleUserHandler;
    private readonly IBackOfficeSecurityAccessor _backOfficeSecurityAccessor;

    public SampleUserController(
        ISampleUserHandler sampleUserHandler,
        IBackOfficeSecurityAccessor backOfficeSecurityAccessor)
    {
        _sampleUserHandler = sampleUserHandler;
        _backOfficeSecurityAccessor = backOfficeSecurityAccessor;
    }

    [HttpPut]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<IActionResult> AssignUserToAdminGroup(string email)
        => await _sampleUserHandler.AssignUserToAdminGroup(email, CurrentUserKey(_backOfficeSecurityAccessor))
            ? Ok()
            : BadRequest();
}
```
{% endcode %}
