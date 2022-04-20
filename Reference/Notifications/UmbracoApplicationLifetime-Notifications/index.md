---
versionFrom: 9.3.0
verified-against: 9.3.0
meta-title: Umbraco Application Lifetime Notifications
meta.Description: Represents an Umbraco application lifetime (starting, started, stopping, stopped) notification
state: complete
update-links: true
---

# UmbracoApplicationLifetime Notifications

The UmbracoApplicationLifetime class implements IUmbracoApplicationLifetimeNotification. It represents an Umbraco application lifetime such as starting, started, stopping, and stopped notifications.

## Usage

Example usage of the UmbracoApplicationLifetime notifications:

```C#
using Microsoft.Extensions.Logging;
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Notifications;

namespace MySite
{
  public class UmbracoApplicationNotificationHandler : INotificationHandler<UmbracoApplicationStartingNotification>, INotificationHandler<UmbracoApplicationStartedNotification>, INotificationHandler<UmbracoApplicationStoppingNotification>, INotificationHandler<UmbracoApplicationStoppedNotification>
    {
      private readonly ILogger _logger;

      public UmbracoApplicationNotificationHandler(ILogger<UmbracoApplicationNotificationHandler> logger) => _logger = logger;

      public void Handle(UmbracoApplicationStartingNotification notification) => Log(notification, notification.IsRestarting);

      public void Handle(UmbracoApplicationStartedNotification notification) => Log(notification, notification.IsRestarting);

      public void Handle(UmbracoApplicationStoppingNotification notification) => Log(notification, notification.IsRestarting);

      public void Handle(UmbracoApplicationStoppedNotification notification) => Log(notification, notification.IsRestarting);

      private void Log(INotification notification, bool isRestarting) => _logger.LogInformation("{Type} - {IsRestarting}", notification.GetType().Name, isRestarting);
    }
}
```

## Notifications

<table>
  <tr>
    <th>Notification</th>
    <th>Members</th>
    <th>Description</th>
  </tr>

  <tr>
    <td>UmbracoApplicationStartingNotification</td>
    <td>
      <ul>
        <li>RuntimeLevel RuntimeLevel</li>
        <li>bool IsRestarting</li>
      </ul>
    </td>
    <td>
    Initializes a new instance of the UmbracoApplicationStartingNotification class.<br>
      <ol>
        <li>RuntimeLevel: Gets the runtime level.</li>
        <li>IsRestarting: Gets a value indicating whether Umbraco is restarting (e.g. after an install or upgrade).</li>
      </ol>
    </td>
  </tr>

  <tr>
    <td>UmbracoApplicationStartedNotification</td>
    <td>
       bool IsRestarting
    </td>
    <td>
    Initializes a new instance of the UmbracoApplicationStartedNotification class.<br>
    IsRestarting: Gets a value indicating whether Umbraco is restarting (e.g. after an install or upgrade).
    </td>
  </tr>

  <tr>
    <td>UmbracoApplicationStoppingNotification</td>
    <td>
    bool IsRestarting
    </td>
    <td>
    Initializes a new instance of the UmbracoApplicationStoppingNotification class.<br>
    IsRestarting: Gets a value indicating whether Umbraco is restarting (e.g. after an install or upgrade).
    </td>
  </tr>

  <tr>
    <td>UmbracoApplicationStoppedNotification</td>
    <td>
      bool IsRestarting
    </td>
    <td>
    Initializes a new instance of the UmbracoApplicationStoppedNotification class.<br>
    IsRestarting: Gets a value indicating whether Umbraco is restarting (e.g. after an install or upgrade).
    </td>
  </tr>

</table>