#MediaService Events#

The MediaService class implements IMediaService. It provides easy access to operations involving IMedia.

<table>
    <tr>
        <th>Event</th>
        <th>Signature</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>Creating</td>
        <td>(IMediaService sender, NewEventArgs&lt;IMedia&gt; e)</td>
        <td>
        Raised when MediaService.CreateMedia is called in the API. <br />
        The event is fired after the MediaType, ParentId and Name of the IMedia object have been set. <br/>
        "sender" will be the current IMediaService object.<br />
        "e" will provide:
            <ol>
                <li>Entity: Gets the IMedia object being created.</li>
                <li>Alias: Gets the MediaTypeAlias of the IMedia object being created.</li>
                <li>ParentId: Gets the Id of the parent of the IMedia object being created.</li>
                <li>Parent: Gets the parent of the IMedia object being created.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Created</td>
        <td>(IMediaService sender, NewEventArgs&lt;IMedia&gt; e)</td>
        <td>
        Raised when MediaService.CreateMedia is called in the API.<br />
        The event is fired after the CreatorId of the IMedia object has been set.<br />
        NOTE: The IMedia object has been created, but not saved so it does not have an identity yet (meaning no Id has been set).<br />
        "sender" will be the current IMediaService object.<br />
        "e" will provide:
            <ol>
                <li>Entity: Gets the created IMedia object.</li>
                <li>Alias: Gets the MediaTypeAlias of the IMedia object being created.</li>
                <li>ParentId: Gets the Id of the parent of the IMedia object being created.</li>
                <li>Parent: Gets the parent of the IMedia object being created.</li>
            </ol>
        </td>
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

