---
versionFrom: 7.0.0
versionRemoved: 8.0.0
---

# ContentService Events

The ContentService class is the most commonly used type when extending Umbraco using events. ContentService implements IContentService. It provides access to operations involving IContent.

## Usage

Example usage of the ContentService events:

```csharp
using Umbraco.Core;
using Umbraco.Core.Events;
using Umbraco.Core.Models;
using Umbraco.Core.Publishing;
using Umbraco.Core.Services;

namespace My.Namespace
{
    public class MyEventHandler : ApplicationEventHandler
    {

        protected override void ApplicationStarted(UmbracoApplicationBase umbracoApplication, ApplicationContext applicationContext)
        {
            ContentService.Published += ContentServicePublished;
        }

        private void ContentServicePublished(IPublishingStrategy sender, PublishEventArgs<IContent> args)
        {
            foreach (var node in args.PublishedEntities)
            {
                if (node.ContentType.Alias == "Comment")
                {
                    SendMail(node);
                }
            }
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
        <td>(IContentService sender, SaveEventArgs&lt;IContent&gt; e)</td>
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
        <td>(IContentService sender, SaveEventArgs&lt;IContent&gt; e)</td>
        <td>
        Raised when ContentService.Save is called in the API and after data has been persisted.<br />
        NOTE: It can be skipped completely if the parameter "raiseEvents" is set to false during the Save method call (true by default). <br />
        "sender" will be the current IContentService object.<br />
        "e" will provide:<br/>
        <em>NOTE: <a href="determining-new-entity">See here on how to determine if the entity is brand new</a></em>
            <ol>
                <li>SavedEntities: Gets the saved collection of IContent objects.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Publishing</td>
        <td>(IPublishingStrategy sender, PublishEventArgs&lt;Umbraco.Core.Models.IContent&gt; e)</td>
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
        <td>(IPublishingStrategy sender, PublishEventArgs&lt;Umbraco.Core.Models.IContent&gt; e)</td>
        <td>
        Raised when ContentService.Publish is called in the API and after data has been published.<br />
        NOTE: It can be skipped completely if the parameter "raiseEvents" is set to false during the Publish method call (true by default). <br />
        "sender" will be the current IPublishingStrategy object.<br />
        "e" will provide:<br/>
        <em>NOTE: <a href="determining-new-entity">See here on how to determine if the entity is brand new</a></em>
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
                <li>AllPropertyData: Gets the list of all property data associated with a content id.</li>
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
                <li>AllPropertyData: Gets the list of all property data associated with a content id.</li>
                <li>EmptiedSuccessfully: Boolean indicating whether the Recycle Bin was emptied successfully.</li>
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

### What happened to Creating and Created events?

Both the ContentService.Creating and ContentService.Created events have been obsoleted. Why? Because these events are not guaranteed to trigger and therefore should not be used. This is because these events *only* trigger when the ContentService.CreateContent method is used which is an entirely optional way to create content entities. It is also possible to construct a new content item - which is generally the preferred and consistent way - and therefore the Creating/Created events will not execute when constructing content that way.

Further more, there's no reason to listen for the Creating/Created events. They are misleading since they don't trigger before and after the entity has been persisted. They trigger inside the CreateContent method which never persists the entity, it constructs a new content object.

#### What do we use instead?

The ContentService.Saving and ContentService.Saved events will always trigger before and after an entity has been persisted. You can determine if an entity is brand new in either of those events. In the Saving event - before the entity is persisted - you can check the entity's HasIdentity property which will be 'false' if it is brand new. In the Saved event you can [use this extension method](determining-new-entity.md)
