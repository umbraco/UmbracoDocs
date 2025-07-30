---
description: Example of how to use a MemberService Notification
---

# MemberService Notifications

The MemberService implements IMemberService and provides access to operations involving IMember.

## Usage

```csharp
using Microsoft.Extensions.Logging;
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Notifications;

namespace MySite;

public class MemberNotificationHandler : INotificationHandler<MemberSavedNotification>
{
    private readonly ILogger<MemberNotificationHandler> _logger;

    public MemberNotificationHandler(ILogger<MemberNotificationHandler> logger)
    {
        _logger = logger;
    }
    
    public void Handle(MemberSavedNotification notification)
    {
        foreach (var member in notification.SavedEntities)
        {
            // Write to the logs every time a member is saved.
            _logger.LogInformation("Member {member} has been saved and notification published!", member.Name);
        }
    }
}
```

<details>

<summary>What happened to <code>raiseEvent</code>method parameters?</summary>

RaiseEvent method service parameters have been removed from v9 and to name some reasons why:

- Because it's entirely inconsistent, not all services have this as method parameters and maintaining that consistency is impossible especially if 3rd party libraries support events/notifications.
- It's hacky. There's no good way to suppress events/notifications this way at a higher (scoped) level.
- There's also hard-coded logic to ignore these parameters sometimes which makes it even more inconsistent.
- There are events below services at the repository level that cannot be controlled by this flag.

**What do we use instead?**

We can suppress notifications at the scope level which makes things consistent and will work for all services that use a Scope. Also, there's no required maintenance to make sure that new service methods will also work.

**How to use scopes**:

- Create an explicit scope and call scope.Notifications.Suppress().
- The result of Suppress() is IDisposable, so until it is disposed, notifications will not be added to the queue.

[Example](https://github.com/umbraco/Umbraco-CMS/blob/b69afe81f3f6fcd37480b3b0295a62af44ede245/tests/Umbraco.Tests.Integration/Umbraco.Infrastructure/Scoping/SupressNotificationsTests.cs#L35):

```csharp
using (IScope scope = ScopeProvider.CreateScope(autoComplete: true))
using (IDisposable _ = scope.Notifications.Suppress())
{
    // TODO: Calls to service methods here will not have notifications
}
```

Child scope will inherit the parent Scope's notification object which means if a parent scope has notifications suppressed, then so does the child scope. You cannot call Suppress() more than once for the same outer scope instance else an exception will be thrown. This ensures that you cannot un-suppress notifications at a child level for an outer scope. It also ensures that suppressing events is an explicit thing to do.

**Why would one want to suppress events?**

The main reason for ever doing this would be performance for bulk operations. The callers hould be aware that suppressing events will lead to an inconsistent content cache state (if notifications are suppressed for content or media services). This is because notifications are used by NuCache to populate the cmsContentNu table and populate the content caches. They are also used to populate the Examine indexes.

So if you did suppress events, it will require you to rebuild the NuCache and examine data manually.

</details>
