#Document Events#

The Document class is the most commonly used type when extending Umbraco using events.

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
</table>

