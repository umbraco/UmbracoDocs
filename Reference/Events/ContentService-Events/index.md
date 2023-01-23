---
versionFrom: 8.0.0
meta.Title: "Umbraco ContentService Events"
meta.Description: "Information on the various events available in the ContentService"
meta.RedirectLink: "/umbraco-cms/reference/notifications/contentservice-notifications"
---

# ContentService Events

The ContentService class is the most commonly used type when extending Umbraco using events. ContentService implements IContentService. It provides access to operations involving IContent.

:::note

## Are you using Umbraco 9?

Note that in Umbraco 9, ContentService Events have been renamed to [**ContentService Notifications**](../../Notifications/ContentService-Notifications/index.md).

Find more information about notifications in Umbraco 9 in the [Notifications](../../Notifications) section.
:::

## Usage

Example usage of the ContentService events:

```csharp
using System;
using Umbraco.Core;
using Umbraco.Core.Composing;
using Umbraco.Core.Services.Implement;

namespace Umbraco8.Components
{
    [RuntimeLevel(MinLevel = RuntimeLevel.Run)]
    public class SubscribeToPublishEventComposer : ComponentComposer<SubscribeToPublishEventComponent>
    { }
    
    public class SubscribeToPublishEventComponent : IComponent
    {
        public void Initialize()
        {
            ContentService.Publishing += ContentService_Publishing;
        }

        private void ContentService_Publishing(Umbraco.Core.Services.IContentService sender, Umbraco.Core.Events.ContentPublishingEventArgs e)
        {
            foreach (var node in e.PublishedEntities)
            {
                if (node.ContentType.Alias == "CorporateNewsAnnouncement")
                {
                    var newsArticleTitle = node.GetValue<string>("newsTitle");
                    if (newsArticleTitle.Equals(newsArticleTitle.ToUpper()))
                    {
                        // Stop putting news article titles in upper case, so cancel publish
                        e.Cancel = true;
                        
                        // Explain why the publish event is cancelled
                        e.Messages.Add(new Umbraco.Core.Events.EventMessage("Corporate style guideline infringement", "Don't put the news article title in upper case, no need to shout!", Umbraco.Core.Events.EventMessageType.Error));
                    }
                }
            }
        }
        public void Terminate()
        {
            //unsubscribe during shutdown
             ContentService.Publishing -= ContentService_Publishing;
        }
    }
}
```

## Events

<table>
    <tr>
        <th>Event</th>
        <th>Signature</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>Saving</td>
        <td>(IContentService sender, ContentSavingEventArgs e)</td>
        <td>
        Raised when ContentService.Save is called in the API.<br />
        NOTE: It can be skipped completely if the parameter "raiseEvents" is set to false during the Save method call (true by default).<br />
        "sender" will be the current IContentService object.<br />
        "e" will provide:<br/>
        <em>NOTE: If the entity is brand new then HasIdentity will equal false.</em>
            <ol>
                <li>SavedEntities: Gets the collection of IContent objects being saved.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Saved</td>
        <td>(IContentService sender, ContentSavedEventArgs e)</td>
        <td>
        Raised when ContentService.Save is called in the API and after data has been persisted.<br />
        NOTE: It can be skipped completely if the parameter "raiseEvents" is set to false during the Save method call (true by default). <br />
        "sender" will be the current IContentService object.<br />
        "e" will provide:<br/>
        <em>NOTE: <a href="../determining-new-entity">See here on how to determine if the entity is brand new</a></em>
            <ol>
                <li>SavedEntities: Gets the saved collection of IContent objects.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Publishing</td>
        <td>(IPublishingStrategy sender, ContentPublishingEventArgs> e)</td>
        <td>
        Raised when ContentService.Publishing is called in the API.<br />
        NOTE: It can be skipped completely if the parameter "raiseEvents" is set to false during the Publish method call (true by default).<br />
        "sender" will be the current IPublishingStrategy object.<br />
        "e" will provide:<br/>
        <em>NOTE: If the entity is brand new then HasIdentity will equal false.</em>
            <ol>
                <li>PublishedEntities: Gets the collection of IContent objects being published.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Published</td>
        <td>(IPublishingStrategy sender, ContentPublishedEventArgs e)</td>
        <td>
        Raised when ContentService.Publish is called in the API and after data has been published.<br />
        NOTE: It can be skipped completely if the parameter "raiseEvents" is set to false during the Publish method call (true by default). <br />
        "sender" will be the current IPublishingStrategy object.<br />
        "e" will provide:<br/>
        <em>NOTE: <a href="../determining-new-entity">See here on how to determine if the entity is brand new</a></em>
            <ol>
                <li>PublishedEntities: Gets the published collection of IContent objects.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>UnPublishing</td>
        <td>(IPublishingStrategy sender, PublishEventArgs&lt;Umbraco.Core.Models.IContent&gt; e)</td>
        <td>
        Raised when ContentService.UnPublishing is called in the API.<br />
        "sender" will be the current IPublishingStrategy object.<br />
        </td>
    </tr>
    <tr>
        <td>UnPublished</td>
        <td>(IPublishingStrategy sender, PublishEventArgs&lt;Umbraco.Core.Models.IContent&gt; e)</td>
        <td>
        Raised when ContentService.UnPublish is called in the API and after data has been published.<br />
        </td>
    </tr>
    <tr>
        <td>Copying</td>
        <td>(IContentService sender, CopyEventArgs&lt;IContent&gt; e)</td>
        <td>
        Raised when ContentService.Copy is called in the API.<br />
        The event is fired after a copy object has been created and had its parentId updated and its state has been set to unpublished. <br />
        "sender" will be the current IContentService object.<br />
        "e" will provide:
            <ol>
                <li>Copy: Gets the IContent object being copied.</li>
                <li>Original: Gets the original IContent object.</li>
                <li>ParentId: Gets the Id of the parent of the IContent being copied.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Copied</td>
        <td>(IContentService sender, CopyEventArgs&lt;IContent&gt; e)</td>
        <td>
        Raised when ContentService.Copy is called in the API.<br />
        The event is fired after the content object has been copied. <br />
        "sender" will be the current IContentService object.<br />
        "e" will provide:
            <ol>
                <li>Copy: Gets the copied IContent object.</li>
                <li>Original: Gets the original IContent object.</li>
                <li>ParentId: Gets the Id of the parent of the IContent being copied.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Moving</td>
        <td>(IContentService sender, MoveEventArgs&lt;IContent&gt; e)</td>
        <td>
        Raised when ContentService.Move is called in the API. <br />
        NOTE: If the target parent is the Recycle bin, this event is never fired. Try the Trashing event instead.<br />
        "sender" will be the current IContentService object.<br />
        "e" will provide:
            <ol>
                <li>Entity: Gets the IContent object being moved.</li>
                <li>ParentId: Gets the Id of the parent of the IContent being moved.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Moved</td>
        <td>(IContentService sender, MoveEventArgs&lt;IContent&gt; e)</td>
        <td>
        Raised when ContentService.Move is called in the API. <br />
        The event is fired after the content object has been moved.<br />
        NOTE: If the target parent is the Recycle bin, this event is never fired. Try the Trashed event instead.<br />
        "sender" will be the current IContentService object.<br />
        "e" will provide:
            <ol>
                <li>Entity: Gets the moved IContent object.</li>
                <li>ParentId: Gets the Id of the parent of the IContent moved.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Trashing</td>
        <td>(IContentService sender, MoveEventArgs&lt;IContent&gt; e)</td>
        <td>
        Raised when ContentService.MoveToRecycleBin is called in the API.<br />
        "sender" will be the current IContentService object.<br />
        "e" will provide:
            <ol>
                <li>Entity: Gets the IContent object being trashed.</li>
                <li>ParentId: Gets the Id of the RecycleBin.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Trashed</td>
        <td>(IContentService sender, MoveEventArgs&lt;IContent&gt; e)</td>
        <td>
        Raised when ContentService.MoveToRecycleBin is called in the API.<br/>
        "sender" will be the current IContentService object.<br />
        "e" will provide:
            <ol>
                <li>Entity: Gets the trashed IContent object.</li>
                <li>ParentId: Gets the Id of the RecycleBin.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Deleting</td>
        <td>(IContentService sender, DeleteEventArgs&lt;IContent&gt; e)</td>
        <td>
        Raised when ContentService.DeleteContentOfType, ContentService.Delete, ContentService.EmptyRecycleBin are called in the API.<br />
        "sender" will be the current IContentService object.<br />
        "e" will provide:
            <ol>
                <li>DeletedEntities: Gets the collection of IContent objects being deleted.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Deleted</td>
        <td>(IContentService sender, DeleteEventArgs&lt;IContent&gt; e)</td>
        <td>
        Raised when ContentService.Delete, ContentService.EmptyRecycleBin are called in the API.<br />
        "sender" will be the current IContentService object.<br />
        "e" will provide:
            <ol>
                <li>DeletedEntities: Gets the collection of deleted IContent objects.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>DeletingVersions</td>
        <td>(IContentService sender, DeleteRevisionsEventArgs e)</td>
        <td>
        Raised when ContentService.DeleteVersion, ContentService.DeleteVersions are called in the API.<br />
        "sender" will be the current IContentService object.<br />
        "e" will provide:
            <ol>
                <li>Id: Gets the id of the IContent object being deleted.</li>
                <li>DateToRetain: Gets the latest version date.</li>
                <li>SpecificVersionId: Gets the id of the IContent object version being deleted.</li>
                <li>IsDeletingSpecificRevision: Returns true if we are deleting a specific version.</li>
                <li>DeletePriorVersions: False by default.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>DeletedVersions</td>
        <td>(IContentService sender, DeleteRevisionsEventArgs e)</td>
        <td>
        Raised when ContentService.DeleteVersion, ContentService.DeleteVersions are called in the API.<br />
        "sender" will be the current IContentService object.<br />
        "e" will provide:
            <ol>
                <li>Id: Gets the id of the deleted IContent object.</li>
                <li>DateToRetain: Gets the latest version date.</li>
                <li>SpecificVersionId: Gets the id of the deleted IContent version.</li>
                <li>IsDeletingSpecificRevision: Returns true if we are deleting a specific version.</li>
                <li>DeletePriorVersions: False by default.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>RollingBack</td>
        <td>(IContentService sender, RollbackEventArgs&lt;IContent&gt; e)</td>
        <td>
        Raised when ContentService.Rollback is called in the API.<br />
        "sender" will be the current IContentService object.<br />
        "e" will provide:
            <ol>
                <li>Entity: Gets the IContent object being rolled back.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>RolledBack</td>
        <td>(IContentService sender, RollbackEventArgs&lt;IContent&gt; e)</td>
        <td>
        Raised when ContentService.Rollback is called in the API. <br />
        "sender" will be the current IContentService object.<br />
        "e" will provide:
            <ol>
                <li>Entity: Gets the rolled back IContent object.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>SendingToPublish</td>
        <td>(IContentService sender, SendToPublishEventArgs&lt;IContent&gt; e)</td>
        <td>
        Raised when ContentService.SendToPublication is called in the API.<br />
        "sender" will be the current IContentService object.<br />
        "e" will provide:
            <ol>
                <li>Entity: Gets the IContent object being sent to publish.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>SentToPublish</td>
        <td>(IContentService sender, SendToPublishEventArgs&lt;IContent&gt; e)</td>
        <td>
        Raised when ContentService.SendToPublication is called in the API. <br />
        "sender" will be the current IContentService object.<br />
        "e" will provide:
            <ol>
                <li>Entity: Gets the sent IContent object to publish.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>EmptyingRecycleBin</td>
        <td>(IContentService sender, RecycleBinEventArgs e)</td>
        <td>
        Raised when ContentService.EmptyingRecycleBin is called in the API.<br />
        "sender" will be the current IContentService object.<br />
        "e" will provide:
            <ol>
                <li>NodeObjectType: Gets the Id of the node object type of the items being deleted from the Recycle Bin.</li>
                <li>RecycleBinEmptiedSuccessfully: Boolean indicating whether the Recycle Bin was emptied successfully.</li>
                <li>IsContentRecycleBin: Boolean indicating whether this event was fired for the Content's Recycle Bin.</li>
                <li>IsMediaRecycleBin: Boolean indicating whether this event was fired for the Media's Recycle Bin.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>EmptiedRecycleBin</td>
        <td>(IContentService sender, RecycleBinEventArgs e)</td>
        <td>
        Raised when ContentService.EmptiedRecycleBin is called in the API. <br />
        "sender" will be the current IContentService object.<br />
        "e" will provide:
            <ol>
                <li>NodeObjectType: Gets the Id of the node object type of the items deleted from the Recycle Bin.</li>
                <li>RecycleBinEmptiedSuccessfully: Boolean indicating whether the Recycle Bin was emptied successfully.</li>
                <li>IsContentRecycleBin: Boolean indicating whether this event was fired for the Content's Recycle Bin.</li>
                <li>IsMediaRecycleBin: Boolean indicating whether this event was fired for the Media's Recycle Bin.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>SavedBlueprint</td>
        <td>(IContentService sender, SaveEventArgs&lt;IContent&gt; e)</td>
        <td>
        Raised when ContentService.SavedBlueprint is called in the API.<br />
        "sender" will be the current IContentService object.<br />
        "e" will provide:
            <ol>
                <li>Entity: Gets the saved blueprint IContent object.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>DeletedBlueprint</td>
        <td>(IContentService sender, DeleteEventArgs&lt;IContent&gt; e)</td>
        <td>
        Raised when ContentService.DeletedBlueprint is called in the API. <br />
        "sender" will be the current IContentService object.<br />
        "e" will provide:
            <ol>
                <li>Entity: Gets the deleted blueprint IContent.</li>
            </ol>
        </td>
    </tr>
</table>

### Variants and Events

Umbraco V8 introduced the concept of Variants for Document Types, initially to allow different language variants of particular properties within a Document Type to be edited/translated based on the languages configured in your instance of Umbraco.

These variants can be saved, published and unpublished independently of each other. (Unpublishing a 'mandatory language' variant of a content item - will trigger all culture variants to be unpublished).

This poses a problem when handling 'events' of the ContentService - eg Which culture just got published? do I want to run my 'custom' code that fires on save if it's just the Spanish version that's been published? Also, if only the Spanish variant is 'unpublished' - that feels like a different situation to if 'all the variants' have been 'unpublished'. Depending which event you are handling there are helper methods you can call to find out:

#### Saving

When handling the 'ContentService.Saving' event this will be triggered whenever a variant is saved.
You can tell 'which' variant has triggered the save using a helper method on the `ContentSavingEventArgs` called 'IsSavingCulture'

```csharp
public bool IsSavingCulture(IContent content, string culture);
```
For example you could check which cultures are being saved (it could be multiple, if multiple checkboxes are checked)
```csharp
   private void ContentService_Saving(IContentService sender, Events.ContentSavingEventArgs e)
        {
  foreach (var entity in e.SavedEntities)
            {
                    //cultures being saved
                  var savingCultures = entity.AvailableCultures.Where(f => e.IsSavingCulture(entity, f)).ToList();
                  //or
                  if (e.IsSavingCulture(entity,"en-GB") {
                  // do things differently if the UK version of the page is being saved!
                  }
           }
```

#### Saved

In the Saved event you can similarly use the 'HasSavedCulture' method of the 'ContentSavedEventArgs' to detect which culture caused the Save.
```csharp
public bool HasSavedCulture(IContent content, string culture);
```
#### Unpublishing

When handling the Unpublishing event, this might not work how you would expect! If 'all the variants' are being unpublished at the same time (or the mandatory language is being unpublished, which forces this to occur, then the Unpublishing event will be fired as expected. 

However, if only one variant is being unpublished, the Unpublishing event will not be triggered. This is because the content item itself is not fully 'unpublished' by the action. Instead what occurs is a 'publish' action'without' the variant that has been unpublished.

You can therefore detect the Unpublishing of a variant, in the Publishing event - using the `IsUnpublishingCulture` helper of the `ContentPublishingEventArgs`
```csharp
     private void ContentService_Publishing(IContentService sender, Events.ContentPublishingEventArgs e)
        {
            foreach (var entity in e.PublishedEntities)
            {
                if (e.IsUnpublishingCulture(entity, "en-GB"))    
                {
                    // bye bye UK!
                }
            }
        }
```

#### Unpublished

Again the Unpublished event does not get fired when a single variant is Unpublished, instead the Published event can be used, and the 'HasUnpublishedCulture' method of the ContentPublishedEventArgs can determine which variant being unpublished triggered the publish.

```csharp
public bool HasUnpublishedCulture(IContent content, string culture);
```

#### Publishing

When handling the 'ContentService.Publishing' event this will be triggered whenever a variant is published (or unpublished - see note in Unpublishing section).

You can tell 'which' variant has triggered the publish using a helper method on the `ContentPublishingEventArgs` called IsPublishingCulture 
```csharp
public bool IsPublishingCulture(IContent content, string culture);
```
For example you could check which cultures are being published and act accordingly (it could be multiple, if multiple checkboxes are checked)
```csharp
     private void ContentService_Publishing(IContentService sender, Events.ContentPublishingEventArgs e)
        {
            foreach (var entity in e.PublishedEntities)
            {
                var publishingCultures = entity.AvailableCultures.Where(f => e.IsPublishingCulture(entity, f)).ToList();
                var unPublishingCultures = entity.AvailableCultures.Where(f => e.IsUnpublishingCulture(entity, f)).ToList();
                //or
                if (e.IsPublishingCulture(entity,"en-GB"))
                {
                    // welcome back Britain!
                }
            }
        }
```

#### Published

In the Published event you can similarly use the HasPublishedCulture and HasUnpublishedCulture methods of the 'ContentPublishedEventArgs' to detect which culture caused the Publish or the UnPublish if it was only a single non mandatory variant that was unpublished.
```csharp
public bool HasPublishedCulture(IContent content, string culture);
public bool HasUnpublishedCulture(IContent content, string culture);
```
#### IContent Helpers
In each of these events, the entities being Saved, Published and Unpublished are `IContent` entities. There are some useful helper methods on IContent to discover the status of the content item's variant cultures:
```csharp
bool IsCultureAvailable(string culture);
bool IsCultureEdited(string culture);
bool IsCulturePublished(string culture);
```

### What happened to Creating and Created events?

Both the ContentService.Creating and ContentService.Created events have been removed. Why? Because these events are not guaranteed to trigger and therefore should not be used. This is because these events *only* trigger when the ContentService.CreateContent method is used which is an entirely optional way to create content entities. It is also possible to construct a new content item - which is generally the preferred and consistent way - and therefore the Creating/Created events will not execute when constructing content that way.

Further more, there's no reason to listen for the Creating/Created events. They are misleading since they don't trigger before and after the entity has been persisted. They trigger inside the CreateContent method which never persists the entity, it constructs a new content object.

#### What do we use instead?

The ContentService.Saving and ContentService.Saved events will always trigger before and after an entity has been persisted. You can determine if an entity is brand new in either of those events. In the Saving event - before the entity is persisted - you can check the entity's HasIdentity property which will be 'false' if it is brand new. In the Saved event you can [check to see if the entity 'remembers being dirty'](../determining-new-entity.md)
