# Events

Currently, Events are raised by the Config, Group, and Tasks services. You can also subscribe to the `DocumentPublish` and `DocumentUnpublish` processes.

You cannot cancel Events. They serve as an entry point for writing custom notification layers like Slack, SMS etc.

## ConfigService

The ConfigService is responsible for managing workflow configuration for nodes and content types. This service raises Events whenever a node or content type configuration is updated.

## GroupService

The GroupService is responsible for managing approval groups. This service raises Events whenever an approval group is created, updated, or deleted.

## TasksService

The TasksService is responsible for all operations involving workflow tasks. This service raises Events whenever a task is created or updated.

## DocumentPublishProcess and DocumentUnpublishProcess

These processes are the core of the workflow and manage instance/task creation and workflow progression. These processes raise Events whenever a workflow instance is created or updated.

## Events Subscription

You can subscribe to Events by adding a handler in a Component:

```csharp
public class ContentEventsComponent : IComponent
{
  public void Initialize()
  {
    GroupService.Updated += GroupService_Updated;
  }

  private void GroupService_Updated(object sender, GroupEventArgs e) {
    // do stuff whenever a group is updated
  }
}
```

where for all services, `e` will provide the object being created, updated, or deleted.