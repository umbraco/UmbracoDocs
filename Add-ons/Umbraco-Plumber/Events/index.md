---
meta.Title: "Umbraco Plumber Events"
meta.Description: "Information on Umbraco Plumber Events"
versionFrom: 8.0.0
versionTo: 10.0.0
---

# Events

Umbraco Plumber raises events in a similar fashion to Umbraco - if you're familiar with Umbraco's events, Plumber won't have any surprises.

Currently, events are raised by the Config, Group and Tasks services, and the DocumentPublish and DocumentUnpublish processes and can be subscribed to as follows:

Events are not cancellable, and serve to provide an entry point for writing custom notification layers - Slack, SMS, whatever you choose.

## ConfigService

The Config service is responsible for managing workflow configuration for nodes and content types.

Events are raised whenever a node or content type configuration is updated.

## GroupService

The Group service is responsible for managing approval groups.

This service raises events whenever an approval group is created, updated or deleted.

## TasksService

The Tasks service is responsible for all operations involving workflow tasks.

This service raises events whenever a task is created or updated.

## DocumentPublishProcess and DocumentUnpublishProcess

These processes are the core of the workflow, and manage instance/task creation and workflow progression.

The processes raise events whenever a workflow instance is created or updated.

## Event Subscription

Subscribe to events in the same way as Umbraco events - by adding a handler in a Component:

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

For all services, `e` will provide the object being created, updated or deleted.
