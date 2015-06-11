#Document Events#

The Document class is the most commonly used type when extending Umbraco using events.

Document inherits from the CMSNode class, and will also have the Move and New events from there.

<table>
	<tr>
		<th>Event</th>
		<th>Signature</th>
		<th>Description</th>
	</tr>
	<tr>
		<td>BeforeSave</td>
		<td>(Document sender, SaveEventArgs args)</td>
		<td>
		Raised before a document is saved from the UI, or when Document.Save() is called in the API. <br/>
		NOTE: When the event is fired from the UI, then the "sender" will be the current document in the database, and not have the values that are about to be saved.
		</td>
	</tr>
	<tr>
		<td>AfterSave</td>
		<td>(Document sender, SaveEventArgs args)</td>
		<td>
		Raised after a document is saved from the UI, or when Document.Save() is called in the API.
		</td>
	</tr>
	<tr>
		<td>BeforeSendToPublish</td>
		<td>(Document sender, SendToPublishEventArgs args)</td>
		<td>
		Raised before a document is sent for publication. Setting args.Cancel = true will cancel the send.
		</td>
	</tr>
	<tr>
		<td>AfterSendToPublish</td>
		<td>(Document sender, SendToPublishEventArgs args)</td>
		<td>
		Raised after a document is sent to publishing.
		</td>
	</tr>
	<tr>
		<td>BeforePublish</td>
		<td>(Document sender, PublishEventArgs args)</td>
		<td>
		Raised before a document is published. Setting args.Cancel = true will cancel the publishing.
		</td>
	</tr>
	<tr>
		<td>AfterPublish</td>
		<td>(Document sender, PublishEventArgs args)</td>
		<td>
		Raised after a document is published.
		</td>
	</tr>
	<tr>
		<td>BeforeUnPublish</td>
		<td>(Document sender, UnPublishEventArgs args)</td>
		<td>
		Raised before a document is unpublished. Setting args.Cancel = true will cancel the unpublishing.
		</td>
	</tr>
	<tr>
		<td>AfterUnPublish</td>
		<td>(Document sender, UnPublishEventArgs args)</td>
		<td>
		Raised after a document is unpublished.
		</td>
	</tr>
	<tr>
		<td>BeforeCopy</td>
		<td>(Document sender, CopyEventArgs args)</td>
		<td>
		Raised before a document is copied. Setting args.Cancel = true will cancel the copy.<br/>
		args.CopyTo contains the id of the target parent node.
		</td>
	</tr>
	<tr>
		<td>AfterCopy</td>
		<td>(Document sender, CopyEventArgs args)</td>
		<td>
		Raised after a document is copied.<br/>
		args.NewDocument contains the newly created copy.
		</td>
	</tr>
	<tr>
		<td>BeforeMoveToTrash</td>
		<td>(Document sender, MoveToTrashEventArgs args)</td>
		<td>
		Raised before a document is moved to trash. Setting args.Cancel = true will cancel the move.
		</td>
	</tr>
	<tr>
		<td>AfterMoveToTrash</td>
		<td>(Document sender, MoveToTrashEventArgs args)</td>
		<td>
		Raised after a document is moved to trash.
		</td>
	</tr>
	<tr>
		<td>BeforeDelete</td>
		<td>(Document sender, DeleteEventArgs args)</td>
		<td>
		Raised before a document is deleted from the trashbin. Setting args.Cancel = true will cancel the delete.
		</td>
	</tr>
	<tr>
		<td>AfterDelete</td>
		<td>(Document sender, DeleteEventArgs args)</td>
		<td>
		Raised after a document is delete from the trashbin.
		</td>
	</tr>
	<tr>
		<td>BeforeRollBack</td>
		<td>(Document sender, RollBackEventArgs args)</td>
		<td>
		Raised before a document is rolled back to a previous version. Setting args.Cancel = true will cancel the rollback.
		</td>
	</tr>
	<tr>
		<td>AfterRollBack</td>
		<td>(Document sender, RollBackEventArgs args)</td>
		<td>
		Raised after a document is rolled back to a previous version.
		</td>
	</tr>
</table>

