#ContentService Events#

The ContentService class is the most commonly used type when extending Umbraco using events. ContentService implements IContentService. It provides easy access to operations involving IContent.

<table>
	<tr>
		<th>Event</th>
		<th>Signature</th>
		<th>Description</th>
	</tr>
	<tr>
		<td>Creating</td>
		<td>(IContentService sender, NewEventArgs<IContent> e)</td>
		<td>
		Raised when ContentService.CreateContent is called in the API. <br />
                The event is fired after the ContentType of the Content object has been set. <br/>
                "sender" will be the current IContentService object.<br />
                "e" will provide:
                        1. Entity: Gets the IContent object being created.
                        2. Alias: Gets the ContentTypeAlias of the IContent being created.
                        3. ParentId: Gets the Id of the parent of the IContent being created.
                        4. Parent: Gets the parent of the IContent being created.
		</td>
	</tr>
	<tr>
		<td>Created</td>
		<td>(IContentService sender, NewEventArgs<IContent> e)</td>
		<td>
		Raised when ContentService.CreateContent is called in the API.<br />
                The event is fired after the CreatedId and WriterId of the Content object have been set.<br />
                NOTE: The content object has been created, but not saved so it does not have an identity yet (meaning no Id has been set)
                "sender" will be the current IContentService object.<br />
                "e" will provide:
                        1. Entity: Gets the created IContent object.
                        2. Alias: Gets the ContentTypeAlias of the IContent being created.
                        3. ParentId: Gets the Id of the parent of the IContent being created.
                        4. Parent: Gets the parent of the IContent being created.
		</td>
	</tr>
	<tr>
		<td>Saving</td>
		<td>(IContentService sender, SaveEventArgs<IContent> e)</td>
		<td>
		Raised when ContentService.Save is called in the API.<br />
                NOTE: It can be skipped completely if the parameter "raiseEvents" is set to true during the Save method call (true by default).<br />
                "sender" will be the current IContentService object.<br />
                "e" will provide:
                        1. SavedEntities: Gets the collection of IContent objects being saved.
		</td>
	</tr>
	<tr>
		<td>Saved</td>
		<td>(IContentService sender, SaveEventArgs<IContent> e)</td>
		<td>
		Raised when ContentService.Save is called in the API and after data has been persisted.<br />
                NOTE: It can be skipped completely if the parameter "raiseEvents" is set to true during the Save method call (true by default). <br />
                "sender" will be the current IContentService object.<br />
                "e" will provide:
                        1. SavedEntities: Gets the saved collection of IContent objects.
		</td>
	</tr>
	<tr>
		<td>Copying</td>
		<td>(IContentService sender, CopyEventArgs<IContent> e)</td>
		<td>
		Raised when ContentService.Copy is called in the API.<br />
                The event is fired after a copy object has been created and had its parentId updated and its state has been set to unpublished. <br />
                "sender" will be the current IContentService object.<br />
                "e" will provide:
                        1. Copy: Gets the IContent object being copied.
                        2. Original: Gets the original IContent object.
                        3. ParentId: Gets the Id of the parent of the IContent being copied.
		</td>
	</tr>
	<tr>
		<td>Copied</td>
		<td>(IContentService sender, CopyEventArgs<IContent> e)</td>
		<td>
		Raised when ContentService.Copy is called in the API.<br />
                The event is fired after the content object has been copied. <br />
                "sender" will be the current IContentService object.<br />
                "e" will provide:
                        1. Copy: Gets the copied IContent object.
                        2. Original: Gets the original IContent object.
                        3. ParentId: Gets the Id of the parent of the IContent being copied.
		</td>
	</tr>
	<tr>
		<td>Moving</td>
		<td>(IContentService sender, MoveEventArgs<IContent> e)</td>
		<td>
		Raised when ContentService.Move is called in the API. <br />
                NOTE: If the target parent is the Recycle bin, this event is never fired. Try the Trashing event instead.
                "sender" will be the current IContentService object.<br />
                "e" will provide:
                        1. Entity: Gets the IContent object being moved.
                        2. ParentId: Gets the Id of the parent of the IContent being moved.
		</td>
	</tr>
	<tr>
		<td>Moved</td>
		<td>(IContentService sender, MoveEventArgs<IContent> e)</td>
		<td>
		Raised when ContentService.Move is called in the API. <br />
                The event is fired after the content object has been moved.<br />
                NOTE: If the target parent is the Recycle bin, this event is never fired. Try the Trashed event instead.
                "sender" will be the current IContentService object.<br />
                "e" will provide:
                        1. Entity: Gets the moved IContent object.
                        2. ParentId: Gets the Id of the parent of the IContent moved.
		</td>
	</tr>
	<tr>
		<td>Trashing</td>
		<td>(IContentService sender, MoveEventArgs<IContent> e)</td>
		<td>
                Raised when ContentService.MoveToRecycleBin is called in the API.<br />
                "sender" will be the current IContentService object.<br />
                "e" will provide:
                        1. Entity: Gets the IContent object being trashed.
                        2. ParentId: Gets the Id of the RecycleBin.
		</td>
	</tr>
	<tr>
		<td>Trashed</td>
		<td>(IContentService sender, MoveEventArgs<IContent> e)</td>
		<td>
		Raised when ContentService.MoveToRecycleBin is called in the API.<br/>
                "sender" will be the current IContentService object.<br />
                "e" will provide:
                        1. Entity: Gets the trashed IContent object.
                        2. ParentId: Gets the Id of the RecycleBin.
		</td>
	</tr>
	<tr>
		<td>Deleting</td>
		<td>(IContentService sender, DeleteEventArgs<IContent> e)</td>
		<td>
		Raised when ContentService.Delete, ContentService.EmptyRecycleBin are called in the API.<br />
                "sender" will be the current IContentService object.<br />
                "e" will provide:
                        1. DeletedEntities: Gets the collection of IContent objects being deleted.
		</td>
	</tr>
	<tr>
		<td>Deleted</td>
		<td>(IContentService sender, DeleteEventArgs<IContent> e)</td>
		<td>
                Raised when ContentService.Delete, ContentService.EmptyRecycleBin are called in the API.<br />
                "sender" will be the current IContentService object.<br />
                "e" will provide:
                        1. DeletedEntities: Gets the collection of deleted IContent objects.
		</td>
	</tr>
	<tr>
		<td>DeletingVersions</td>
		<td>(IContentService sender, DeleteRevisionsEventArgs e)</td>
		<td>
                Raised when ContentService.DeleteVersions is called in the API.<br />
                "sender" will be the current IContentService object.<br />
                "e" will provide:
                        1. Id: Gets the id of the IContent object being deleted.
                        2. DateToRetain: Gets the latest version date.
                        3. SpecificVersionId: Gets the id of the IContent object version being deleted.
                        4. IsDeletingSpecificRevision: Returns true if we are deleting a specific version.
                        5. DeletePriorVersions: False by default.
		</td>
	</tr>
	<tr>
		<td>DeletedVersions</td>
		<td>(IContentService sender, DeleteRevisionsEventArgs e)</td>
		<td>
                Raised when ContentService.DeleteVersions is called in the API.<br />
                "sender" will be the current IContentService object.<br />
                "e" will provide:
                        1. Id: Gets the id of the deleted IContent object.
                        2. DateToRetain: Gets the latest version date.
                        3. SpecificVersionId: Gets the id of the deleted IContent version.
                        4. IsDeletingSpecificRevision: Returns true if we are deleting a specific version.
                        5. DeletePriorVersions: False by default.
		</td>
	</tr>
	<tr>
		<td>RollingBack</td>
		<td>(IContentService sender, RollbackEventArgs<IContent> e)</td>
		<td>
                Raised when ContentService.Rollback is called in the API.<br />
                "sender" will be the current IContentService object.<br />
                "e" will provide:
                        1. Entity: Gets the IContent object being rolledback.
		</td>
	</tr>
	<tr>
		<td>RolledBack</td>
		<td>(IContentService sender, RollbackEventArgs<IContent> e)</td>
		<td>
                Raised when ContentService.Rollback is called in the API. <br />
                "sender" will be the current IContentService object.<br />
                "e" will provide:
                        1. Entity: Gets the rolledback IContent object.
		</td>
	</tr>
	<tr>
		<td>SendingToPublish</td>
		<td>(IContentService sender, SendToPublishEventArgs<IContent> e)</td>
		<td>
                Raised when ContentService.SendToPublication is called in the API.<br />
                "sender" will be the current IContentService object.<br />
                "e" will provide:
                        1. Entity: Gets the IContent object being sent to publish.
		</td>
	</tr>
	<tr>
		<td>SentToPublish</td>
		<td>(IContentService sender, SendToPublishEventArgs<IContent> e)</td>
		<td>
                Raised when ContentService.SendToPublication is called in the API. <br />
                "sender" will be the current IContentService object.<br />
                "e" will provide:
                        1. Entity: Gets the sent IContent object to publish.
		</td>
	</tr>
</table>

