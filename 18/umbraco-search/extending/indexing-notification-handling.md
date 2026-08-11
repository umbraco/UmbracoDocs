---
description: >-
  Describes the notification system of Umbraco Search and how to interact with
  it as a developer
---

# Indexing Notification Handling

Before content is pushed to any content index, Umbraco Search fires the `ContentIndexingNotification`. This notification lets you manipulate the data going into an index, or entirely prevent it from being indexed.

## Keep it lightweight

The `ContentIndexingNotification` fires for _all_ content index updates, and the notification handling is not subject to any [caching](database-cache-for-index-values.md).

If a notification handler performs expensive operations, this can introduce a large performance overhead. Consider creating [content indexers](gathering-data-with-content-indexers.md) for tasks like:

* Complex value calculation.
* Content look-ups, for example, through the published cache.
* Out-of-process operations, including database lookups and external service calls.

## Manipulating data going into an index

The notification contains a `Fields` collection of fields aggregated from all the [content indexers](gathering-data-with-content-indexers.md). These fields can be manipulated by the notification handler.

{% hint style="warning" %}
Be careful if you change or remove any of the [system fields](../getting-started/system-fields.md), as this might corrupt the index.
{% endhint %}

In the following example, the content being indexed might contain a `length` field. This is a radio button list property, and thus it [produces keywords](../getting-started/built-in-property-editors.md) for filtering and faceting.

Keywords are not available for full-text querying by default. You can use a notification handler to amend this for the `length` field:

{% code title="MakeLengthSearchableNotificationHandler.cs" %}
```csharp
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Search.Core.Models.Indexing;
using Umbraco.Cms.Search.Core.Notifications;

namespace My.Site.NotificationHandlers;

public class MakeLengthSearchableNotificationHandler
    : INotificationHandler<ContentIndexingNotification>
{
    public void Handle(ContentIndexingNotification notification)
    {
        // Find the "length" field and make sure it has any keywords set.
        var field = notification.Fields.FirstOrDefault(field => field.FieldName == "length");
        if (field?.Value.Keywords is null)
        {
            return;
        }

        // Update the fields for indexing (the collection itself is immutable):
        // 1. Remove the original field.
        // 2. Add a replacement field with the Texts collection included, to make the length values searchable.
        notification.Fields = notification.Fields
            .Except([field])
            .Union([
                new IndexField(
                    field.FieldName,
                    new IndexValue
                    {
                        Keywords = field.Value.Keywords,
                        Texts = field.Value.Keywords
                    },
                    field.Culture,
                    field.Segment
                )
            ])
            .ToArray();
    }
}
```
{% endcode %}

{% hint style="info" %}
The example works if you need to target a specific property value (the `length` property in this case).

If you want to change the indexing of _all_ property values for a given property editor, use a [property value handler](index-values-for-property-editors.md) instead.
{% endhint %}

## Preventing content from being indexed

Cancelling the notification will prevent content from being added to the target index:

{% code title="OmitSettingsFromPublishedContentIndexNotificationHandler.cs" %}
```csharp
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Search.Core;
using Umbraco.Cms.Search.Core.Notifications;

namespace My.Site.NotificationHandlers;

public class OmitSettingsFromPublishedContentIndexNotificationHandler
    : INotificationHandler<ContentIndexingNotification>
{
    // The ID of the "Settings" content type (as a string).
    private const string SettingsContentTypeId = "34068730-7E9E-4A04-BA10-B95873EE7E59";
    
    public void Handle(ContentIndexingNotification notification)
    {
        // This notification handler only deals with the published content index.
        if (notification.IndexAlias is not Constants.IndexAliases.PublishedContent)
        {
            return;
        }

        // Find the system field for content type ID.
        var contentTypeIdField = notification
            .Fields
            .FirstOrDefault(field => field.FieldName == Constants.FieldNames.ContentTypeId);

        // Grab the content type ID from the keywords collection.
        var contentTypeId = contentTypeIdField?.Value.Keywords?.FirstOrDefault();
        
        // No content type ID could be found. Prevent the content from being indexed to be on the safe side.
        // NOTE: This should never happen.

        // Prevent the content from being indexed in the published content index if either:
        // 1. The content is of type "Settings".
        // 2. The content type could not be determined. This should never happen, but let's be on the safe side.
        notification.Cancel = contentTypeId is null || contentTypeId.InvariantEquals(SettingsContentTypeId);
    }
}
```
{% endcode %}
