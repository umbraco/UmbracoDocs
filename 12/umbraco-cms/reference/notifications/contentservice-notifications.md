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

## Notifications

| Notification                          | Members                                                                                                                                                                                                              | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| ------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ContentSavingNotification             | <ul><li>IEnumerable&#x3C;IContent> SavedEntities</li><li>EventMessages Messages</li><li>IDictionary&#x3C;string,object> State</li><li>bool Cancel</li></ul>                                                          | <p>Published when the IContentService.Save is called in the API.<br>NOTE: It can be skipped if the parameter "raiseEvents" is set to false during the Save method call (true by default).<br>SavedEntities: The collection of IContent objects being saved.<br><em>NOTE: If the entity is brand new then HasIdentity will equal false.</em></p>                                                                                                                                                                                                                             |
| ContentSavedNotification              | <ul><li>IEnumerable&#x3C;IContent> SavedEntities</li><li>EventMessages Messages</li><li>IDictionary&#x3C;string,object> State</li></ul>                                                                              | <p>Published when IContentService.Save is called in the API and after data has been persisted.<br>NOTE: It can be skipped if the parameter "raiseEvents" is set to false during the Save method call (true by default).<br><em>NOTE:</em> <a href="determining-new-entity.md"><em>See here on how to determine if the entity is brand new</em></a><br>SavedEntities: The saved collection of IContent objects.</p>                                                                                                                                                          |
| ContentPublishingNotification         | <ul><li>IEnumerable&#x3C;IContent> PublishedEntities</li><li>EventMessages Messages</li><li>IDictionary&#x3C;string,object> State</li><li>bool Cancel</li></ul>                                                      | <p>Published when IContentService.Publishing is called in the API.<br>NOTE: It can be skipped if the parameter "raiseEvents" is set to false during the Publish method call (true by default).<br><em>NOTE: If the entity is brand new then HasIdentity will equal false.</em><br>PublishedEntities: The collection of IContent objects being published.</p>                                                                                                                                                                                                                |
| ContentPublishedNotification          | <ul><li>IEnumerable&#x3C;IContent> PublishedEntities</li><li>EventMessages Messages</li><li>IDictionary&#x3C;string,object> State</li></ul>                                                                          | <p>Published when IContentService.Publish is called in the API and after data has been published.<br>NOTE: It can be skipped if the parameter "raiseEvents" is set to false during the Publish method call (true by default).<br><em>NOTE:</em> <a href="determining-new-entity.md"><em>See here on how to determine if the entity is brand new</em></a><br>PublishedEntities: The published collection of IContent objects.</p>                                                                                                                                            |
| ContentUnpublishingNotification       | <ul><li>IEnumerable&#x3C;IContent> UnpublishedEntities</li><li>EventMessages Messages</li><li>IDictionary&#x3C;string,object> State</li><li>bool Cancel</li></ul>                                                    | <p>Published when IContentService.UnPublishing is called in the API.<br>UnpublishedEntities: The collection of IContent being unpublished.</p>                                                                                                                                                                                                                                                                                                                                                                                                                              |
| ContentUnpublishedNotification        | <ul><li>IEnumerable&#x3C;IContent> UnpublishedEntities</li><li>EventMessages Messages</li><li>IDictionary&#x3C;string,object> State</li></ul>                                                                        | <p>Published when IContentService.UnPublish is called in the API and after data has been unpublished.<br>UnpublishedEntities: The collection of unpublished IContent.</p>                                                                                                                                                                                                                                                                                                                                                                                                   |
| ContentCopyingNotification            | <ul><li>EventMessages Messages</li><li>IDictionary&#x3C;string,object> State</li><li>bool Cancel</li><li>IContent Original</li><li>IContent Copy</li><li>int ParentId</li></ul>                                      | <p>Published when IContentService.Copy is called in the API.<br>The notification is published after a copy object has been created and had its parentId updated and its state has been set to unpublished.<br></p><ol><li>Original: Gets the original IContent object.</li><li>Copy: Gets the IContent object being copied.</li><li>ParentId: Gets the Id of the parent of the IContent being copied.</li></ol>                                                                                                                                                             |
| ContentCopiedNotification             | <ul><li>EventMessages Messages</li><li>IDictionary&#x3C;string,object> State</li><li>IContent Original</li><li>IContent Copy</li><li>int ParentId</li><li>bool RelateToOriginal</li></ul>                            | <p>Published when IContentService.Copy is called in the API.<br>The notification is published after the content object has been copied.<br></p><ol><li>Original: Gets the original IContent object.</li><li>Copy: Gets the IContent object being copied.</li><li>ParentId: Gets the Id of the parent of the IContent being copied.</li><li>RelateToOriginal: Boolean indicating whether the copy was related to the original</li></ol>                                                                                                                                      |
| ContentMovingNotification             | <ul><li>IEnumerable&#x3C;MoveEventInfo&#x3C;IContent>> MoveInfoCollection</li><li>EventMessages Messages</li><li>IDictionary&#x3C;string,object> State</li><li>bool Cancel</li></ul>                                 | <p>Published when IContentService.Move is called in the API.<br>NOTE: If the target parent is the Recycle bin, this notification is never published. Try the ContentMovingToRecycleBinNotification instead.<br>MoveInfoCollection will for each moving entity provide:</p><ol><li>Entity: Gets the IContent object being moved</li><li>OriginalPath: The original path the entity is moved from</li><li>NewParentId: Gets the Id of the parent the entity will have after it has been moved</li></ol>                                                                       |
| ContentMovedNotification              | <ul><li>IEnumerable&#x3C;MoveEventInfo&#x3C;IContent>> MoveInfoCollection</li><li>EventMessages Messages</li><li>IDictionary&#x3C;string,object> State</li></ul>                                                     | <p>Published when IContentService.Move is called in the API. The notification is published after the content object has been moved.<br>NOTE: If the target parent is the Recycle bin, this notification is never published. Try the ContentMovedToRecycleBinNotification instead.<br>MoveInfoCollection will for each moving entity provide:</p><ol><li>Entity: Gets the IContent object being moved</li><li>OriginalPath: The original path the entity is moved from</li><li>NewParentId: Gets the Id of the parent the entity will have after it has been moved</li></ol> |
| ContentMovingToRecycleBinNotification | <ul><li>IEnumerable&#x3C;MoveEventInfo&#x3C;IContent>> MoveInfoCollection</li><li>EventMessages Messages</li><li>IDictionary&#x3C;string,object> State</li><li>bool Cancel</li></ul>                                 | <p>Published when ContentService.MoveToRecycleBin is called in the API.<br>MoveInfoCollection will for each moving entity provide:</p><ol><li>Entity: Gets the IContent object being moved</li><li>OriginalPath: The original path the entity is moved from</li><li>NewParentId: Gets the Id of the RecycleBin</li></ol>                                                                                                                                                                                                                                                    |
| ContentMovedToRecycleBinNotification  | <ul><li>IEnumerable&#x3C;MoveEventInfo&#x3C;IContent>> MoveInfoCollection</li><li>EventMessages Messages</li><li>IDictionary&#x3C;string,object> State</li></ul>                                                     | <p>Published when ContentService.MoveToRecycleBin is called in the API. Is published after the content has been moved to the RecycleBin<br>MoveInfoCollection will for each moving entity provide:</p><ol><li>Entity: Gets the IContent object being moved</li><li>OriginalPath: The original path the entity is moved from</li><li>NewParentId: Gets the Id of the RecycleBin</li></ol>                                                                                                                                                                                    |
| ContentDeletingNotification           | <ul><li>IEnumerable&#x3C;IContent> DeletedEntities</li><li>EventMessages Messages</li><li>IDictionary&#x3C;string,object> State</li><li>bool Cancel</li></ul>                                                        | <p>Published when ContentService.DeleteContentOfType, ContentService.Delete, ContentService.EmptyRecycleBin are called in the API.<br>DeletedEntities: Gets the collection of IContent objects being deleted.</p>                                                                                                                                                                                                                                                                                                                                                           |
| ContentDeletedNotification            | <ul><li>IEnumerable&#x3C;IContent> DeletedEntities</li><li>EventMessages Messages</li><li>IDictionary&#x3C;string,object> State</li><li>bool Cancel</li></ul>                                                        | <p>Published when ContentService.Delete, ContentService.EmptyRecycleBin are called in the API, and the entity has been deleted.<br>DeletedEntities: Gets the collection of deleted IContent objects.</p>                                                                                                                                                                                                                                                                                                                                                                    |
| ContentDeletingVersionsNotification   | <ul><li>EventMessages Messages</li><li>IDictionary&#x3C;string,object> State</li><li>bool Cancel</li><li>int Id</li><li>int SpecificVersion</li><li>DateTime DateToRetain</li><li>bool DeletePriorVersions</li></ul> | <p>Published when ContentService.DeleteVersion, ContentService.DeleteVersions are called in the API.<br></p><ol><li>Id: Gets the id of the IContent object being deleted.</li><li>DateToRetain: Gets the latest version date.</li><li>SpecificVersion: Gets the id of the IContent object version being deleted.</li><li>DeletePriorVersions: False by default</li></ol>                                                                                                                                                                                                    |
| ContentDeletedVersionsNotification    | <ul><li>EventMessages Messages</li><li>IDictionary&#x3C;string,object> State</li><li>int Id</li><li>int SpecificVersion</li><li>DateTime DateToRetain</li><li>bool DeletePriorVersions</li></ul>                     | <p>Published when ContentService.DeleteVersion, ContentService.DeleteVersions are called in the API, and the version has been deleted.<br></p><ol><li>Id: Gets the id of the IContent object being deleted.</li><li>DateToRetain: Gets the latest version date.</li><li>SpecificVersion: Gets the id of the IContent object version being deleted.</li><li>DeletePriorVersions: False by default</li></ol>                                                                                                                                                                  |
| ContentRollingBackNotification        | <ul><li>IContent Entity</li><li>EventMessages Messages</li><li>IDictionary&#x3C;string,object> State</li><li>bool Cancel</li></ul>                                                                                   | <p>Published when ContentService.Rollback is called in the API.<br>Entity: Gets the IContent object being rolled back.</p>                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| ContentRolledBackNotification         | <ul><li>IContent Entity</li><li>EventMessages Messages</li><li>IDictionary&#x3C;string,object> State</li></ul>                                                                                                       | <p>Published when ContentService.Rollback is called in the API, after the content has been rolled back.<br>Entity: Gets the IContent object being rolled back.</p>                                                                                                                                                                                                                                                                                                                                                                                                          |
| ContentSendingToPublishNotification   | <ul><li>IContent Entity</li><li>EventMessages Messages</li><li>IDictionary&#x3C;string,object> State</li><li>bool Cancel</li></ul>                                                                                   | <p>Published when ContentService.SendToPublication is called in the API.<br>Entity: Gets the IContent object being sent to publish.</p>                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| ContentSentToPublishNotification      | <ul><li>IContent Entity</li><li>EventMessages Messages</li><li>IDictionary&#x3C;string,object> State</li></ul>                                                                                                       | <p>Published when ContentService.SendToPublication is called in the API, after the entity has been sent to publication.<br>Entity: Gets the IContent object being sent to publish.</p>                                                                                                                                                                                                                                                                                                                                                                                      |
| ContentEmptyingRecycleBinNotification | <ul><li>IEnumerable&#x3C;IContent> DeletedEntities</li><li>EventMessages Messages</li><li>IDictionary&#x3C;string,object> State</li><li>bool Cancel</li></ul>                                                        | <p>Published when ContentService.EmptyRecycleBin is called in the API.<br>DeletedEntities: The collection of IContent objects being deleted.</p>                                                                                                                                                                                                                                                                                                                                                                                                                            |
| ContentEmptiedRecycleBinNotification  | <ul><li>IEnumerable&#x3C;IContent> DeletedEntities</li><li>EventMessages Messages</li><li>IDictionary&#x3C;string,object> State</li></ul>                                                                            | <p>Published when ContentService.EmptyRecycleBin is called in the API, after the RecycleBin has been emptied.<br>DeletedEntities: The collection of deleted IContent object.</p>                                                                                                                                                                                                                                                                                                                                                                                            |
| ContentSavedBlueprintNotification     | <ul><li>IContent SavedBlueprint</li><li>EventMessages Messages</li><li>IDictionary&#x3C;string,object> State</li></ul>                                                                                               | <p>Published when ContentService.SavedBlueprint is called in the API.<br>SavedBlueprint: Gets the saved blueprint IContent object</p>                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| ContentDeletedBlueprintNotification   | <ul><li>IEnumerable&#x3C;IContent> DeletedBlueprints</li><li>EventMessages Messages</li><li>IDictionary&#x3C;string,object> State</li></ul>                                                                          | <p>Published when ContentService.DeletedBlueprint is called in the API.<br>DeletedBlueprints: The collection of deleted blueprint IContent</p>                                                                                                                                                                                                                                                                                                                                                                                                                              |

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
public bool HasUnpublishedCulture(ICotnent content, string culture);
```

#### IContent Helpers

In each of these notifications, the entities being Saved, Published, and Unpublished are `IContent` entities. There are some useful helper methods on IContent to discover the status of the content item's variant cultures:

```csharp
bool IsCultureAvailable(string culture);
bool IsCultureEdited(string culture);
bool IsCulturePublished(string culture);
```

### What happened to Creating and Created events?

Both the ContentService.Creating and ContentService.Created events were removed, and therefore never moved to notifications. Why? Because these events were not guaranteed to trigger and therefore should not be used. This is because these events would only trigger when the ContentService.CreateContent method was used which is an entirely optional way to create content entities. It is also possible to construct a new content item - which is generally the preferred and consistent way - and therefore the Creating/Created events would not execute when constructing content that way.

Furthermore, there was no reason to listen to the Creating/Created events. They were misleading since they didn't trigger before and after the entity persisted. They are triggered inside the CreateContent method which never persists the entity, it constructs a new content object.

#### What do we use instead?

The ContentSavingNotification and ContentSavedNotification will always be published before and after an entity has been persisted. You can determine if an entity is brand new in either of those notifications. In the Saving notification - before the entity is persisted - you can check the entity's HasIdentity property which will be `false` if it is brand new. In the Saved notification you can [check to see if the entity 'remembers being dirty'](determining-new-entity.md)
