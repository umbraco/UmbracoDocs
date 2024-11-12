---
description: Umbraco webhooks enable seamless integration and real-time updates by notifying external services about content changes and events within the Umbraco CMS
---

# Webhooks

Webhooks provide real-time, event-driven communication within Umbraco. Seamlessly integrated, these lightweight, HTTP-based notifications empower you to trigger instant actions and synchronize data. With its different extension points, you can tailor these webhooks to fit a broad range of requirements.

## Getting Started

To work with Webhooks, go to **Webhooks** in the **Settings** section.

![Webhooks section](images/webhook-section-v14.png)

To create a webhook, click the `Create` button. It will take you to the Create webhook screen.

![Creating a webhook](images/create-webhook-v14.png)

## URL

The `Url` should be the endpoint you want the webhook to send a request to, whenever a given `Event` is fired.

## Events

Events are when a given action happens. By default, there are 5 events you can choose from.

- Content Published - This event happens whenever some content gets published.
- Content Unpublished - This event happens whenever some content gets unpublished
- Content Deleted - This event happens whenever some content gets deleted.
- Media Deleted - This event happens whenever a media item is deleted.
- Media Saved - This event happens whenever a media item is saved.

## Content Type

For Content or Media events, you can specify if your webhook should trigger only for specific Document or Media types.

For example, if you have selected the `Content Published` event, you can set your webhook to trigger only for specific content types.

## Headers

You can specify custom headers that will be sent with your request.

For example, you can specify `Accept: application/json`, security headers, and so on.

## Defaults

Umbraco webhooks are configured with some defaults, such as default headers or some events that send a payload. In this section, we will take a look at those.

### JSON payload

For example, the `Content Published` event sends the specific content that triggered the event. The JSON format is identical to the `Content Delivery API`. Here’s an example of a JSON object:

```json
{
  "Name": "Root",
  "CreateDate": "2023-12-11T12:02:38.9979314",
  "UpdateDate": "2023-12-11T12:02:38.9979314",
  "Route": {
    "Path": "/",
    "StartItem": {
      "Id": "c1922956-7855-4fa0-8f2c-7af149a92135",
      "Path": "root"
    }
  },
  "Id": "c1922956-7855-4fa0-8f2c-7af149a92135",
  "ContentType": "root",
  "Properties": {}
}
```

However, the `Content deleted` does not send the entire content as JSON, instead, it sends the `Id` of the content:

```json
{
  "Id": "c1922956-7855-4fa0-8f2c-7af149a92135"
}
```

### Headers

By default, webhook requests includes 3 headers:

- `user-agent: Umbraco-Cms/{version}` - where version is the current version of Umbraco.
- `umb-webhook-retrycount: {number of retries}` - where number of retries is the current retry count for a given webhook request.
- `umb-webhook-event: {Umbraco.event}` - where event is the event that triggered the request. For example, for Content published: `umb-webhook-event: Umbraco.ContentUnpublish`

## Configuring Webhooks

### Adding Events

To add more than the default events to Umbraco, you can leverage the provided `IUmbracoBuilder` and `IComposer` interfaces. Below is an example of how you can extend the list of available webhook events using a custom `WebhookComposer`:

```csharp
using Umbraco.Cms.Core.Composing;

public class CustomWebhookComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.WebhookEvents()
            .Clear()
            .AddCms(cmsBuilder =>
            {
                // Add your custom events here
                cmsBuilder
                    .AddDefault()
                    .AddContent()
                    .AddContentType()
                    .AddDataType()
                    .AddDictionary()
                    .AddDomain()
                    .AddFile()
                    .AddHealthCheck()
                    .AddLanguage()
                    .AddMedia()
                    .AddMember()
                    .AddPackage()
                    .AddPublicAccess()
                    .AddRelation()
                    .AddRelationType()
                    .AddUser();
            });
    }
}
```

This is a list of all the current events that are available through Umbraco. If you want them all enabled, use the following:

```csharp
builder.WebhookEvents().Clear().AddCms(false);
```

## Replace Webhook Events

Sometimes it is desirable to modify one of the standard Umbraco webhooks, for example, to change the Payload. This can be done by adding a custom implementation, as shown in the code example below:

{% include "../../../.gitbook/includes/obsolete-warning-ipublishedsnapshotaccessor.md" %}

```csharp
[WebhookEvent("Content Published", Constants.WebhookEvents.Types.Content)]
public class MyCustomContentPublishedWebhookEvent : WebhookEventContentBase<ContentPublishedNotification, IContent>
{
    private readonly IPublishedSnapshotAccessor _publishedSnapshotAccessor;
    private readonly IApiContentBuilder _apiContentBuilder;


    public MyCustomContentPublishedWebhookEvent(IWebhookFiringService webhookFiringService, IWebhookService webhookService, IOptionsMonitor<WebhookSettings> webhookSettings, IServerRoleAccessor serverRoleAccessor, IPublishedSnapshotAccessor publishedSnapshotAccessor, IApiContentBuilder apiContentBuilder) : base(webhookFiringService, webhookService, webhookSettings, serverRoleAccessor)
    {
        _publishedSnapshotAccessor = publishedSnapshotAccessor;
        _apiContentBuilder = apiContentBuilder;
    }

    public override string Alias => "Umbraco.ContentPublish";
    protected override IEnumerable<IContent> GetEntitiesFromNotification(ContentPublishedNotification notification) => notification.PublishedEntities;

    protected override object? ConvertEntityToRequestPayload(IContent entity)
    {
        if (_publishedSnapshotAccessor.TryGetPublishedSnapshot(out IPublishedSnapshot? publishedSnapshot) is false || publishedSnapshot!.Content is null)
        {
            return null;
        }

        IPublishedContent? publishedContent = publishedSnapshot.Content.GetById(entity.Key);

        return new
        {
            MyData = "Your data",
            PublishedContent = publishedContent is null ? null : _apiContentBuilder.Build(publishedContent)
        };
    }
}
```

Add the following line in a Composer to replace the standard Umbraco implementation with your custom implementation:

```csharp
public class MyComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.WebhookEvents().Replace<ContentPublishedWebhookEvent, MyCustomContentPublishedWebhookEvent>();
    }
}
```

### Webhook Settings

Configure Webhook settings in your `appsettings.*.json` and is in the `Umbraco::CMS` section:

```json
  "Umbraco": {
    "CMS": {
      "Webhook": {
        "Enabled": true,
        "MaximumRetries": 5,
        "Period": "00:00:10",
        "EnableLoggingCleanup": true,
        "KeepLogsForDays": 30
      }
```

- **Enabled**: Specifies whether webhooks are enabled.
- **MaximumRetries**: Defines the number of retries for a webhook request.
- **Period**: The interval between checks for any webhook requests that need to be fired.
- **EnableLoggingCleanup**: Indicates whether webhook log cleanup is enabled.
- **KeepLogsForDays**: Determines the number of days to retain webhook logs.
