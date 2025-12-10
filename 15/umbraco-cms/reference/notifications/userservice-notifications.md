---
description: Example of how to use a UserService Notification
---

# UserService Notifications

The UserService implements `IUserService` and provides access to operations involving `IUser`.

The following example illustrates how to cancel the password reset feature for a given set of users.

## Usage

```csharp
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Notifications;

namespace MySite;

public class UserPasswordResettingNotificationHandler : INotificationHandler<UserPasswordResettingNotification>
{
    public void Handle(UserPasswordResettingNotification notification)
    {
        if (notification.User.Name?.Contains("Eddie") ?? false)
        {
           notification.CancelOperation(new EventMessage("fail", "Can't reset password for users with name containing 'Eddie'"));
        }
    }
}
```
