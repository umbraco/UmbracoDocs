#DataTypeService Events#

The DataTypeService class implements IDataTypeService. It provides easy access to operations involving IDataType and IDataTypeDefinition.

<table>
    <tr>
        <th>Event</th>
        <th>Signature</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>Saving</td>
        <td>(IDataTypeService sender, SaveEventArgs&lt;IDataTypeDefinition&gt; e)</td>
        <td>
        Raised when DataTypeService.Save is called in the API.<br />
        "sender" will be the current IDataTypeService object.<br />
        "e" will provide:
            <ol>
                <li>SavedEntities: Gets the collection of IDataTypeDefinition objects being saved.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Saved</td>
        <td>(IDataTypeService sender, SaveEventArgs&lt;IDataTypeDefinition&gt; e)</td>
        <td>
        Raised when DataTypeService.Save is called in the API and after data has been persisted.<br />
        "sender" will be the current IDataTypeService object.<br />
        "e" will provide:
		<br/>NOTE: <a href="determining-new-entity">See here on how to determine if the entity is brand new</a>
            <ol>
                <li>SavedEntities: Gets the saved collection of IDataTypeDefinition objects.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Deleting</td>
        <td>(IDataTypeService sender, DeleteEventArgs&lt;IDataTypeDefinition&gt; e)</td>
        <td>
        Raised when DataTypeService.Delete is called in the API.<br />
        "sender" will be the current IDataTypeService object.<br />
        "e" will provide:
            <ol>
                <li>DeletedEntities: Gets the collection of IDataTypeDefinition objects being deleted.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Deleted</td>
        <td>(IDataTypeService sender, DeleteEventArgs&lt;IDataTypeDefinition&gt; e)</td>
        <td>
        Raised when DataTypeService.Delete is called in the API.<br />
        "sender" will be the current IDataTypeService object.<br />
        "e" will provide:
            <ol>
                <li>DeletedEntities: Gets the collection of deleted IDataTypeDefinition objects.</li>
            </ol>
        </td>
    </tr>
</table>

