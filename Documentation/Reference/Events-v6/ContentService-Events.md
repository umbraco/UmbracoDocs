#ContentService Events#

The ContentService class is the most commonly used type when extending Umbraco using events. ContentService implements IContentService. It provides easy access to operations involving IContent.

Example usage of the ContentService events:

```
using Umbraco.Core;
using Umbraco.Core.Events;
using Umbraco.Core.Models;
using Umbraco.Core.Publishing;
using Umbraco.Core.Services;

namespace My.Namespace
{
    public class MyEventHandler : ApplicationEventHandler
    {
        public MyEventHandler()
        {
            ContentService.Published += Go;
        }

        private void Go(IPublishingStrategy sender, PublishEventArgs<IContent> args)
        {
            foreach (var publishedEntity in args.PublishedEntities)
            {
                if (publishedEntity.ContentType.Alias == "Comment")
                {
                    SendMail(comment);
                }
            }
        }
    }
}
```

## Events ##

<table>
    <tr>
        <th>Event</th>
        <th>Signature</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>Creating</td>
        <td>(IContentService sender, NewEventArgs&lt;IContent&gt; e)</td>
        <td>
        Raised when ContentService.CreateContent is called in the API. <br />
        The event is fired after the ContentType, ParentId and Name of the IContent object have been set. <br/>
        "sender" will be the current IContentService object.<br />
        "e" will provide:
            <ol>
                <li>Entity: Gets the IContent object being created.</li>
                <li>Alias: Gets the ContentTypeAlias of the IContent object being created.</li>
                <li>ParentId: Gets the Id of the parent of the IContent object being created.</li>
                <li>Parent: Gets the parent of the IContent object being created.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Created</td>
        <td>(IContentService sender, NewEventArgs&lt;IContent&gt; e)</td>
        <td>
        Raised when ContentService.CreateContent is called in the API.<br />
        The event is fired after the CreatorId and WriterId of the Content object have been set.<br />
        NOTE: The IContent object has been created, but not saved so it does not have an identity yet (meaning no Id has been set).<br />
        "sender" will be the current IContentService object.<br />
        "e" will provide:
            <ol>
                <li>Entity: Gets the created IContent object.</li>
                <li>Alias: Gets the ContentTypeAlias of the IContent object being created.</li>
                <li>ParentId: Gets the Id of the parent of the IContent object being created.</li>
                <li>Parent: Gets the parent of the IContent object being created.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Saving</td>
        <td>(IContentService sender, SaveEventArgs&lt;IContent&gt; e)</td>
        <td>
        Raised when ContentService.Save is called in the API.<br />
        NOTE: It can be skipped completely if the parameter "raiseEvents" is set to false during the Save method call (true by default).<br />
        "sender" will be the current IContentService object.<br />
        "e" will provide:
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
        "e" will provide:
            <ol>
                <li>SavedEntities: Gets the saved collection of IContent objects.</li>
            </ol>
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
                <li>Entity: Gets the IContent object being rolledback.</li>
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
                <li>Entity: Gets the rolledback IContent object.</li>
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
</table>

