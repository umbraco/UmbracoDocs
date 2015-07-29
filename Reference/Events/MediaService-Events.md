#MediaService Events#

The MediaService class implements IMediaService. It provides easy access to operations involving IMedia.

## Usage ##
Example usage of the MediaService events:

    using Umbraco.Core;
    using Umbraco.Core.Events;
    using Umbraco.Core.Models;
    using Umbraco.Core.Services;
    
    namespace My.Namespace
    {
        public class MyEventHandler : ApplicationEventHandler
        {

			protected override void ApplicationStarted(UmbracoApplicationBase umbracoApplication, ApplicationContext applicationContext)
            {
				MediaService.Saved += MediaServiceSaved;     
            }   
    
            void MediaServiceSaved(IMediaService sender, SaveEventArgs<IMedia> e)
            {
                foreach (var mediaItem in e.SavedEntities)
                {
                    UploadToAzure(mediaItem);
                }
            }
        }
    }

## Events ##
<table>
    <tr>
        <th>Event</th>
        <th>Signature</th>
        <th>Description</th>
    </tr>    
    <tr>
        <td>Saving</td>
        <td>(IMediaService sender, SaveEventArgs&lt;IMedia&gt; e)</td>
        <td>
        Raised when MediaService.Save is called in the API.<br />
        NOTE: It can be skipped completely if the parameter "raiseEvents" is set to false during the Save method call (true by default).<br />
        "sender" will be the current IMediaService object.<br />
        "e" will provide:
            <ol>
                <li>SavedEntities: Gets the collection of IMedia objects being saved.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Saved</td>
        <td>(IMediaService sender, SaveEventArgs&lt;IMedia&gt; e)</td>
        <td>
        Raised when MediaService.Save is called in the API and after data has been persisted.<br />
        NOTE: It can be skipped completely if the parameter "raiseEvents" is set to false during the Save method call (true by default). <br />
        "sender" will be the current IMediaService object.<br />
        "e" will provide:
		<br/>NOTE: <a href="determining-new-entity">See here on how to determine if the entity is brand new</a>
            <ol>
                <li>SavedEntities: Gets the saved collection of IMedia objects.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Moving</td>
        <td>(IMediaService sender, MoveEventArgs&lt;IMedia&gt; e)</td>
        <td>
        Raised when MediaService.Move is called in the API. <br />
        NOTE: If the target parent is the Recycle bin, this event is never fired. Try the Trashing event instead.<br />
        "sender" will be the current IMediaService object.<br />
        "e" will provide:
            <ol>
                <li>Entity: Gets the IMedia object being moved.</li>
                <li>ParentId: Gets the Id of the parent of the IMedia object being moved.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Moved</td>
        <td>(IMediaService sender, MoveEventArgs&lt;IMedia&gt; e)</td>
        <td>
        Raised when MediaService.Move is called in the API. <br />
        The event is fired after the content object has been moved.<br />
        NOTE: If the target parent is the Recycle bin, this event is never fired. Try the Trashed event instead.<br />
        "sender" will be the current IMediaService object.<br />
        "e" will provide:
            <ol>
                <li>Entity: Gets the moved IMedia object.</li>
                <li>ParentId: Gets the Id of the parent of the IMedia moved.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Trashing</td>
        <td>(IMediaService sender, MoveEventArgs&lt;IMedia&gt; e)</td>
        <td>
        Raised when MediaService.MoveToRecycleBin is called in the API.<br />
        "sender" will be the current IMediaService object.<br />
        "e" will provide:
            <ol>
                <li>Entity: Gets the IMedia object being trashed.</li>
                <li>ParentId: Gets the Id of the RecycleBin.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Trashed</td>
        <td>(IMediaService sender, MoveEventArgs&lt;IMedia&gt; e)</td>
        <td>
        Raised when MediaService.MoveToRecycleBin is called in the API.<br/>
        "sender" will be the current IMediaService object.<br />
        "e" will provide:
            <ol>
                <li>Entity: Gets the trashed IMedia object.</li>
                <li>ParentId: Gets the Id of the RecycleBin.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Deleting</td>
        <td>(IMediaService sender, DeleteEventArgs&lt;IMedia&gt; e)</td>
        <td>
        Raised when MediaService.DeleteMediaOfType, MediaService.Delete, MediaService.EmptyRecycleBin are called in the API.<br />
        "sender" will be the current IMediaService object.<br />
        "e" will provide:
            <ol>
                <li>DeletedEntities: Gets the collection of IMedia objects being deleted.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Deleted</td>
        <td>(IMediaService sender, DeleteEventArgs&lt;IMedia&gt; e)</td>
        <td>
        Raised when MediaService.Delete, MediaService.EmptyRecycleBin are called in the API.<br />
        "sender" will be the current IMediaService object.<br />
        "e" will provide:
            <ol>
                <li>DeletedEntities: Gets the collection of deleted IMedia objects.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>DeletingVersions</td>
        <td>(IMediaService sender, DeleteRevisionsEventArgs e)</td>
        <td>
        Raised when MediaService.DeleteVersion, MediaService.DeleteVersions are called in the API.<br />
        "sender" will be the current IMediaService object.<br />
        "e" will provide:
            <ol>
                <li>Id: Gets the id of the IMedia object being deleted.</li>
                <li>DateToRetain: Gets the latest version date.</li>
                <li>SpecificVersionId: Gets the id of the IMedia object version being deleted.</li>
                <li>IsDeletingSpecificRevision: Returns true if we are deleting a specific version.</li>
                <li>DeletePriorVersions: False by default.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>DeletedVersions</td>
        <td>(IMediaService sender, DeleteRevisionsEventArgs e)</td>
        <td>
        Raised when MediaService.DeleteVersion, MediaService.DeleteVersions are called in the API.<br />
        "sender" will be the current IMediaService object.<br />
        "e" will provide:
            <ol>
                <li>Id: Gets the id of the deleted IMedia object.</li>
                <li>DateToRetain: Gets the latest version date.</li>
                <li>SpecificVersionId: Gets the id of the deleted IMedia version.</li>
                <li>IsDeletingSpecificRevision: Returns true if we are deleting a specific version.</li>
                <li>DeletePriorVersions: False by default.</li>
            </ol>
        </td>
    </tr>
</table>

### What happened to Creating and Created events?

Both the MediaService.Creating and MediaService.Created events have been obsoleted. Why? Because these events are not guaranteed to trigger and therefore should not be used. This is because these events *only* trigger when the MediaService.CreateMedia method is used which is an entirely optional way to create media entities. It is also possible to simply construct a new media item - which is generally the preferred and consistent way - and therefore the Creating/Created events will not execute when constructing media that way. Further more, there's no reason to listen for the Creating/Created events because they are misleading since they don't actually trigger before and after the entity has been persisted, they simply trigger inside the CreateMedia method which never actually persists the entity, it simply just constructs a new media object.

#### What do we use instead?

The MediaService.Saving and MediaService.Saved events will always trigger before and after an entity has been persisted. You can determine if an entity is brand new in either of those events. In the Saving event - before the entity is persisted - you can check the entity's HasIdentity property which will be 'false' if it is brand new. In the Saved event you can [use this extension method](determining-new-entity.md)