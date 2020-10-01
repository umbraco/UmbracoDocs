---
versionFrom: 8.0.0
meta.Title: "Umbraco MemberService Events"
meta.Description: "Information on the various events available in the MemberService"
---

# MemberService Events

The MemberService implements IMemberService and provides easy access to operations involving IMember.

## Usage

Example usage of the MemberService events:

```csharp
using System;
using Umbraco.Core;
using Umbraco.Core.Composing;
using Umbraco.Core.Services.Implement;

namespace Umbraco8.Components
{
    [RuntimeLevel(MinLevel = RuntimeLevel.Run)]
    public class SubscribeToSavedEventComposer : ComponentComposer<SubscribeToSavedEventComponent>
    { }
    
    public class SubscribeToSavedEventComponent : IComponent
    {
        private readonly ILogger _logger;

        public SubscribeToSavedEventComponent(ILogger logger)
        {
            this._logger = logger;
        }
       
        public void Initialize()
        {
            //specify my event handler
            MemberService.Saved += MemberService_Saved;
        }

        private void MemberService_Saved(IMemberService sender, SaveEventArgs<IMember> e)
        {
            foreach (var member in e.SavedEntities)
            {
                
              //write to the logs every time a member is saved
              this._logger.Info<MyPublishEventComponent>("member {member} has been saved and event fired!", member.Name);
            }
        }
        public void Terminate()
        {
            // Nothing to terminate
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
        <td>(IMemberService sender, SaveEventArgs<IMember> e)</td>
        <td>
        Raised when MemberService.Saving is called in the API.<br />
        NOTE: It can be skipped completely if the parameter "raiseEvents" is set to false during the Save method call (true by default).<br />
        "sender" will be the current IMemberService object.<br />
        "e" will provide:<br/>
            <ol>
                <li>SavedEntities: Gets the collection of IMember objects being saved.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Saved</td>
        <td>(IMemberService sender, ContentSavedEventArgs e)</td>
        <td>
        Raised when MemberService.Save is called in the API and after data has been persisted.<br />
        NOTE: It can be skipped completely if the parameter "raiseEvents" is set to false during the Save method call (true by default). <br />
        "sender" will be the current IMemberService object.<br />
        "e" will provide:<br/>
        <em>NOTE: <a href="determining-new-entity">See here on how to determine if the entity is brand new</a></em>
            <ol>
                <li>SavedEntities: Gets the saved collection of IContent objects.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Publishing</td>
        <td>(IPublishingStrategy sender, ContentPublishingEventArgs> e)</td>
        <td>
        Raised when MemberService.Publishing is called in the API.<br />
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
        Raised when MemberService.Publish is called in the API and after data has been published.<br />
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
        Raised when MemberService.UnPublishing is called in the API.<br />
        "sender" will be the current IPublishingStrategy object.<br />
        </td>
    </tr>
    <tr>
        <td>UnPublished</td>
        <td>(IPublishingStrategy sender, PublishEventArgs&lt;Umbraco.Core.Models.IContent&gt; e)</td>
        <td>
        Raised when MemberService.UnPublish is called in the API and after data has been published.<br />
        </td>
    </tr>
    <tr>
        <td>Copying</td>
        <td>(IMemberService sender, CopyEventArgs&lt;IContent&gt; e)</td>
        <td>
        Raised when MemberService.Copy is called in the API.<br />
        The event is fired after a copy object has been created and had its parentId updated and its state has been set to unpublished. <br />
        "sender" will be the current IMemberService object.<br />
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
        <td>(IMemberService sender, CopyEventArgs&lt;IContent&gt; e)</td>
        <td>
        Raised when MemberService.Copy is called in the API.<br />
        The event is fired after the content object has been copied. <br />
        "sender" will be the current IMemberService object.<br />
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
        <td>(IMemberService sender, MoveEventArgs&lt;IContent&gt; e)</td>
        <td>
        Raised when MemberService.Move is called in the API. <br />
        NOTE: If the target parent is the Recycle bin, this event is never fired. Try the Trashing event instead.<br />
        "sender" will be the current IMemberService object.<br />
        "e" will provide:
            <ol>
                <li>Entity: Gets the IContent object being moved.</li>
                <li>ParentId: Gets the Id of the parent of the IContent being moved.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Moved</td>
        <td>(IMemberService sender, MoveEventArgs&lt;IContent&gt; e)</td>
        <td>
        Raised when MemberService.Move is called in the API. <br />
        The event is fired after the content object has been moved.<br />
        NOTE: If the target parent is the Recycle bin, this event is never fired. Try the Trashed event instead.<br />
        "sender" will be the current IMemberService object.<br />
        "e" will provide:
            <ol>
                <li>Entity: Gets the moved IContent object.</li>
                <li>ParentId: Gets the Id of the parent of the IContent moved.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Trashing</td>
        <td>(IMemberService sender, MoveEventArgs&lt;IContent&gt; e)</td>
        <td>
        Raised when MemberService.MoveToRecycleBin is called in the API.<br />
        "sender" will be the current IMemberService object.<br />
        "e" will provide:
            <ol>
                <li>Entity: Gets the IContent object being trashed.</li>
                <li>ParentId: Gets the Id of the RecycleBin.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Trashed</td>
        <td>(IMemberService sender, MoveEventArgs&lt;IContent&gt; e)</td>
        <td>
        Raised when MemberService.MoveToRecycleBin is called in the API.<br/>
        "sender" will be the current IMemberService object.<br />
        "e" will provide:
            <ol>
                <li>Entity: Gets the trashed IContent object.</li>
                <li>ParentId: Gets the Id of the RecycleBin.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Deleting</td>
        <td>(IMemberService sender, DeleteEventArgs&lt;IContent&gt; e)</td>
        <td>
        Raised when MemberService.DeleteContentOfType, MemberService.Delete, MemberService.EmptyRecycleBin are called in the API.<br />
        "sender" will be the current IMemberService object.<br />
        "e" will provide:
            <ol>
                <li>DeletedEntities: Gets the collection of IContent objects being deleted.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Deleted</td>
        <td>(IMemberService sender, DeleteEventArgs&lt;IContent&gt; e)</td>
        <td>
        Raised when MemberService.Delete, MemberService.EmptyRecycleBin are called in the API.<br />
        "sender" will be the current IMemberService object.<br />
        "e" will provide:
            <ol>
                <li>DeletedEntities: Gets the collection of deleted IContent objects.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>DeletingVersions</td>
        <td>(IMemberService sender, DeleteRevisionsEventArgs e)</td>
        <td>
        Raised when MemberService.DeleteVersion, MemberService.DeleteVersions are called in the API.<br />
        "sender" will be the current IMemberService object.<br />
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
        <td>(IMemberService sender, DeleteRevisionsEventArgs e)</td>
        <td>
        Raised when MemberService.DeleteVersion, MemberService.DeleteVersions are called in the API.<br />
        "sender" will be the current IMemberService object.<br />
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
        <td>(IMemberService sender, RollbackEventArgs&lt;IContent&gt; e)</td>
        <td>
        Raised when MemberService.Rollback is called in the API.<br />
        "sender" will be the current IMemberService object.<br />
        "e" will provide:
            <ol>
                <li>Entity: Gets the IContent object being rolled back.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>RolledBack</td>
        <td>(IMemberService sender, RollbackEventArgs&lt;IContent&gt; e)</td>
        <td>
        Raised when MemberService.Rollback is called in the API. <br />
        "sender" will be the current IMemberService object.<br />
        "e" will provide:
            <ol>
                <li>Entity: Gets the rolled back IContent object.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>SendingToPublish</td>
        <td>(IMemberService sender, SendToPublishEventArgs&lt;IContent&gt; e)</td>
        <td>
        Raised when MemberService.SendToPublication is called in the API.<br />
        "sender" will be the current IMemberService object.<br />
        "e" will provide:
            <ol>
                <li>Entity: Gets the IContent object being sent to publish.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>SentToPublish</td>
        <td>(IMemberService sender, SendToPublishEventArgs&lt;IContent&gt; e)</td>
        <td>
        Raised when MemberService.SendToPublication is called in the API. <br />
        "sender" will be the current IMemberService object.<br />
        "e" will provide:
            <ol>
                <li>Entity: Gets the sent IContent object to publish.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>EmptyingRecycleBin</td>
        <td>(IMemberService sender, RecycleBinEventArgs e)</td>
        <td>
        Raised when MemberService.EmptyingRecycleBin is called in the API.<br />
        "sender" will be the current IMemberService object.<br />
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
        <td>(IMemberService sender, RecycleBinEventArgs e)</td>
        <td>
        Raised when MemberService.EmptiedRecycleBin is called in the API. <br />
        "sender" will be the current IMemberService object.<br />
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
        <td>(IMemberService sender, SaveEventArgs&lt;IContent&gt; e)</td>
        <td>
        Raised when MemberService.SavedBlueprint is called in the API.<br />
        "sender" will be the current IMemberService object.<br />
        "e" will provide:
            <ol>
                <li>Entity: Gets the saved blueprint IContent object.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>DeletedBlueprint</td>
        <td>(IMemberService sender, DeleteEventArgs&lt;IContent&gt; e)</td>
        <td>
        Raised when MemberService.DeletedBlueprint is called in the API. <br />
        "sender" will be the current IMemberService object.<br />
        "e" will provide:
            <ol>
                <li>Entity: Gets the deleted blueprint IContent.</li>
            </ol>
        </td>
    </tr>
</table>

