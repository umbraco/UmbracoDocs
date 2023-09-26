---

meta-title: Creating and Publishing Custom Notifications
description: How to create and publish your own custom notifications
---

# Creating And Publishing Custom Notifications

There may be many reasons why you would like to create your own custom notifications, in this article we'll use the CleanUpYourRoom [recurring hosted service](../scheduling.md) as an example, which empties the recycle bin every 5 minutes. You might want to publish a notification once the task has started, and maybe once the task has successfully cleared the recycle bin.

For a notification to be publishable there's only one requirement, it must implement the empty marker interface `INotification`, the rest is up to you. For instance, we might want to create a notification that just signals that the clean your room task has started and nothing else, in this case, we'll create an empty class implementing `INotification`

{% tabs %}
{% tab title="Latest version" %}
```C#
using Umbraco.Cms.Core.Notifications;

namespace Umbraco.Cms.Web.UI.Notifications
{
    public class CleanYourRoomStartedNotification : INotification
    {

    }
}
```
{% endtab %}

{% tab title="Umbraco 9" %}
```C#
using Umbraco.Cms.Core.Notifications;

namespace Umbraco.Docs.Samples.Web.Notifications
{
    public class CleanYourRoomStartedNotification : INotification
    {

    }
}
```
{% endtab %}
{% endtabs %}

This notification can now be published, and we can create a notification handler to receive it with, see [MediaService-Notifications](mediaservice-notifications.md) for an example of how to implement a notification handler. But this notification alone might not be super helpful, we might want to be able to send some additional information with the notification, however, since this is, in essence, just a normal class, we can include whatever information we want. Let's try and create a `RoomCleanedNotification` which contains the number of nodes removed from the recycle bin:

{% tabs %}
{% tab title="Latest version" %}
```C#
using Umbraco.Cms.Core.Notifications;

namespace Umbraco.Cms.Web.UI.Notifications
{
    public class RoomCleanedNotification : INotification
    {
        public int ItemsDeleted { get; }

        public RoomCleanedNotification(int itemsDeleted)
        {
            ItemsDeleted = itemsDeleted;
        }
    }
}
```
{% endtab %}

{% tab title="Umbraco 9" %}
```C#
using Umbraco.Cms.Core.Notifications;

namespace Umbraco.Docs.Samples.Web.Notifications
{
    public class RoomCleanedNotification : INotification
    {
        public int ItemsDeleted { get; }

        public RoomCleanedNotification(int itemsDeleted)
        {
            ItemsDeleted = itemsDeleted;
        }
    }
}
```
{% endtab %}
{% endtabs %}

Now you can create a handler that receives the amount of items deleted through the notification.

# Sending notifications

Just creating the notification classes is not enough, we also want to be able to publish them. There's two ways of publishing notifications:

* `IEventAggregator` - Notifications published with `IEventAggregator` will always be published immediately.
* `IScope.Notifications` - Notifications published with a scope will only be published once the scope has been completed and disposed. 

The method you use to publish notifications depends on what your needs are, the benefits of publishing notifications with a scope is that the notification will only be published if you complete the scope, and then only once the scope is disposed of. This can be useful if you access the database, or do some other operation that might fail causing you to do a rollback, disposing of the scope without completing it, in this case, you might not want to publish a notification that signals that the operation was a success, using scopes will handle this for you. On the other hand, you might want to publish the notification immediately no matter what, for instance with the `CleanYourRoomStartedNotification`, for this, the `IEventAggregator` is the right choice.

## Example

{% tabs %}
{% tab title="Latest version" %}
```C#
using System;
using System.Threading.Tasks;
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Scoping;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Infrastructure.HostedServices;
using Umbraco.Cms.Web.UI.Notifications;

namespace Umbraco.Cms.Web.UI
{
    public class CleanUpYourRoom : RecurringHostedServiceBase
    {
        private readonly IContentService _contentService;
        private readonly ICoreScopeProvider _coreScopeProvider;
        private readonly IEventAggregator _eventAggregator;
        private static TimeSpan HowOftenWeRepeat => TimeSpan.FromMinutes(5);
        private static TimeSpan DelayBeforeWeStart => TimeSpan.FromMinutes(1);

        public CleanUpYourRoom(
            IContentService contentService,
            ICoreScopeProvider coreScopeProvider,
            IEventAggregator eventAggregator,
            ILogger<CleanUpYourRoom> logger)
            : base(logger, HowOftenWeRepeat, DelayBeforeWeStart)
        {
            _contentService = contentService;
            _coreScopeProvider = coreScopeProvider;
            _eventAggregator = eventAggregator;
        }

        public override Task PerformExecuteAsync(object state)
        {
            // This will be published immediately
            _eventAggregator.Publish(new CleanYourRoomStartedNotification());

            using ICoreScope scope = _coreScopeProvider.CreateCoreScope();
            int numberOfThingsInBin = _contentService.CountChildren(Constants.System.RecycleBinContent);

            if (_contentService.RecycleBinSmells())
            {
                _contentService.EmptyRecycleBin(userId: -1);
                // This will only be published when the scope is completed and disposed.
                scope.Notifications.Publish(new RoomCleanedNotification(numberOfThingsInBin));
            }

            // Remember to complete the scope when done.
            scope.Complete();
            return Task.CompletedTask;
        }
    }
}
```
{% endtab %}

{% tab title="Umbraco 9" %}
```C#
using System;
using System.Threading.Tasks;
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Scoping;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Infrastructure.HostedServices;
using Umbraco.Cms.Web.UI.Notifications;

namespace Umbraco.Docs.Samples.Web.Notifications
{
    public class CleanUpYourRoom : RecurringHostedServiceBase
    {
        private readonly IContentService _contentService;
        private readonly IScopeProvider _scopeProvider;
        private readonly IEventAggregator _eventAggregator;
        private static TimeSpan HowOftenWeRepeat => TimeSpan.FromMinutes(5);
        private static TimeSpan DelayBeforeWeStart => TimeSpan.FromMinutes(1);

        public CleanUpYourRoom(
            IContentService contentService,
            IScopeProvider scopeProvider,
            IEventAggregator eventAggregator)
            : base(HowOftenWeRepeat, DelayBeforeWeStart)
        {
            _contentService = contentService;
            _scopeProvider = scopeProvider;
            _eventAggregator = eventAggregator;
        }

        public override Task PerformExecuteAsync(object state)
        {
            // This will be published immediately
            _eventAggregator.Publish(new CleanYourRoomStartedNotification());

            using IScope scope = _scopeProvider.CreateScope();

            int numberOfThingsInBin = _contentService.CountChildren(Constants.System.RecycleBinContent);

            if (_contentService.RecycleBinSmells())
            {
                _contentService.EmptyRecycleBin(userId: -1);
                
                // This will only be published when the scope is completed and disposed.
                scope.Notifications.Publish(new RoomCleanedNotification(numberOfThingsInBin));
            }

            // Remember to complete the scope when done.
            scope.Complete();

            return Task.CompletedTask;
        }
    }
}
```
{% endtab %}
{% endtabs %}

In this case, the `CleanYourRoomStartedNotification` will always be published immediately, however, `RoomCleanedNotification` will only be published once the operation is done, and if you remove the `scope.Complete();` line it will never be published, the recycle bin won't be emptied either. 

