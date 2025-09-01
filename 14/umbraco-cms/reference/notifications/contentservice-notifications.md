---
description: Find out more about ContentService Notifications and explore some example of how to use it
---

# ContentService Notifications

The ContentService class is the most commonly used type when extending Umbraco using notifications. ContentService implements IContentService. It provides access to operations involving IContent.

## Usage

Example usage of the ContentPublishingNotification:

```csharp
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Notifications;

namespace Umbraco.Docs.Samples.Web.Notifications;

public class DontShout : INotificationHandler<ContentPublishingNotification>
{
    public void Handle(ContentPublishingNotification notification)
    {
        foreach (var node in notification.PublishedEntities)
        {
            if (node.ContentType.Alias.Equals("announcement"))
            {
                var newsArticleTitle = node.GetValue<string>("title");
                if (!string.IsNullOrWhiteSpace(newsArticleTitle) && newsArticleTitle.Equals(newsArticleTitle.ToUpper()))
                {
                    notification.CancelOperation(new EventMessage("Corporate style guideline infringement",
                        "Don't put the announcement title in upper case, no need to shout!",
                        EventMessageType.Error));
                }
            }
        }
    }
}
```

### Variants and Notifications

Umbraco V8 introduced the concept of Variants for Document Types, initially to allow different language variants of particular properties within a Document Type to be edited/translated based on the languages configured in your instance of Umbraco.

These variants can be saved, published, and unpublished independently of each other. (Unpublishing a 'mandatory language' variant of a content item - will trigger all culture variants to be unpublished).

This poses a problem when handling notifications from the ContentService - for example which culture got published? Do I want to run my 'custom' code that fires on save if it's only the Spanish version that's been published? Also, if only the Spanish variant is 'unpublished' - that feels like a different situation than if 'all the variants' have been 'unpublished'. Depending on which event you are handling there are helper methods you can call to find out.

#### Saving

When handling the ContentSavingNotification which will be published whenever a variant is saved. You can tell 'which' variant has triggered the save using an extension method on the ContentSavingNotification called 'IsSavingCulture'

```csharp
public bool IsSavingCulture(IContent content, string culture);
```

As an example, you could check which cultures are being saved (it could be multiple if multiple checkboxes are checked)

```csharp
public void Handle(ContentSavingNotification notification)
{
    foreach (var entity in notification.SavedEntities)
    {
        // Cultures being saved
        var savingCultures = entity.AvailableCultures
            .Where(culture => notification.IsSavingCulture(entity, culture)).ToList();
        // or
        if (notification.IsSavingCulture(entity, "en-GB"))
        {
            // Do things differently if the UK version of the page is being saved.
        }
    }
}
```

#### Saved

With the Saved notification you can similarly use the 'HasSavedCulture' method of the 'ContentSavedNotification' to detect which culture caused the Save.

```csharp
public bool HasSavedCulture(IContent content, string culture);
```

#### Unpublishing

When handling the Unpublishing notification, it might not work how you would expect. If 'all the variants' are being unpublished at the same time (or the mandatory language is being unpublished, which forces this to occur) then the Unpublishing notification will be published as expected.

```csharp
public void Handle(ContentUnpublishingNotification  notification)
{
 foreach (var unPublishedEntity  in notification.UnpublishedEntities)
 {
  // complete unpublishing of entity, all cultures
 }
}
```

However, if only one variant is being unpublished, the Unpublishing event will not be triggered. This is because the content item itself is not fully 'unpublished' by the action. Instead, what occurs is a 'publish' action 'without' the unpublished variant.

You can therefore detect the Unpublishing of a variant in the publishing notification - using the IsUnpublishingCulture extension method of the `ContentPublishingNotification`

```csharp
public void Handle(ContentPublishingNotification notification)
{
    foreach (var node in notification.PublishedEntities)
    {
        if (notification.IsUnpublishingCulture(node, "da-DK"))
        {
            // Bye bye DK!
        }
    }
}
```

#### Unpublished

Again, the Unpublished notification does not get published when a single variant is Unpublished, instead, the Published notification can be used, and the 'HasUnpublishedCulture' extension method of the ContentPublishedNotification can determine which variant being unpublished triggered the publish.

```csharp
public bool HasUnpublishedCulture(IContent content, string culture);
```

#### Publishing

When handling the ContentPublishingNotification which will be triggered whenever a variant is published (or unpublished - see note in the Unpublishing section above).

You can tell 'which' variant has triggered the publish using a helper method on the ContentPublishingNotification called IsPublishingCulture.

```csharp
public bool IsPublishingCulture(IContent content, string culture);
```

For example, you could check which cultures are being published and act accordingly (it could be multiple if multiple checkboxes are checked).

```csharp
public void Handle(ContentPublishingNotification notification)
{
    foreach (var node in notification.PublishedEntities)
    {
        var publishingCultures = node.AvailableCultures
            .Where(culture => notification.IsPublishingCulture(node, culture)).ToList();
        
        var unPublishingCultures = node.AvailableCultures
            .Where(culture => notification.IsUnpublishingCulture(node, culture)).ToList();
        // or
        if (notification.IsPublishingCulture(node, "da-DK"))
        {
            // Welcome back DK!
        }
    }
}
```

#### Published

In the Published notification you can similarly use the HasPublishedCulture and HasUnpublishedCulture methods of the 'ContentPublishedEventArgs' to detect which culture caused the Publish or the UnPublish if it was only a single non-mandatory variant that was unpublished.

```csharp
public bool HasPublishedCulture(IContent content, string culture);
public bool HasUnpublishedCulture(IContent content, string culture);
```

#### IContent Helpers

In each of these notifications, the entities being Saved, Published, and Unpublished are `IContent` entities. There are some useful helper methods on IContent to discover the status of the content item's variant cultures:

```csharp
bool IsCultureAvailable(string culture);
bool IsCultureEdited(string culture);
bool IsCulturePublished(string culture);
```

<details>

<summary>What happened to Creating and Created events?</summary>

Both the ContentService.Creating and ContentService.Created events were removed, and therefore never moved to notifications. Why? Because these events were not guaranteed to trigger and therefore should not be used. This is because these events would only trigger when the ContentService.CreateContent method was used which is an entirely optional way to create content entities. It is also possible to construct a new content item - which is generally the preferred and consistent way - and therefore the Creating/Created events would not execute when constructing content that way.

Furthermore, there was no reason to listen to the Creating/Created events. They were misleading since they didn't trigger before and after the entity persisted. They are triggered inside the CreateContent method which never persists the entity, it constructs a new content object.

**What do we use instead?**

The ContentSavingNotification and ContentSavedNotification will always be published before and after an entity has been persisted. You can determine if an entity is brand new in either of those notifications. In the Saving notification - before the entity is persisted - you can check the entity's HasIdentity property which will be 'false' if it is brand new. In the Saved notification you can [check to see if the entity 'remembers being dirty'](determining-new-entity.md)

</details>

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

The main reason for ever doing this would be performance for bulk operations. The callers should be aware that suppressing events will lead to an inconsistent content cache state (if notifications are suppressed for content or media services). This is because notifications are used by NuCache to populate the cmsContentNu table and populate the content caches. They are also used to populate the Examine indexes.

So if you did suppress events, it will require you to rebuild the NuCache and examine data manually.

</details>
