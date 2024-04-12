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
