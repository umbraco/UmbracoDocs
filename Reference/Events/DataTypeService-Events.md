---
versionFrom: 8.0.0
meta.Title: "Umbraco DataTypeService Events"
meta.Description: "Information on the various events available in the DataTypeService"
---

# DataTypeService Events#

The DataTypeService class implements IDataTypeService. It provides access to operations involving IDataType.

<table>
    <tr>
        <th>Event</th>
        <th>Signature</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>Saving</td>
        <td>(IDataTypeService sender, SaveEventArgs&lt;IDataType&gt; e)</td>
        <td>
        Raised when DataTypeService.Save is called in the API.<br />
        "sender" will be the current IDataTypeService object.<br />
        "e" will provide:
            <ol>
                <li>SavedEntities: Gets the collection of IDataType objects being saved.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Saved</td>
        <td>(IDataTypeService sender, SaveEventArgs&lt;IDataType&gt; e)</td>
        <td>
        Raised when DataTypeService.Save is called in the API and after data has been persisted.<br />
        "sender" will be the current IDataTypeService object.<br />
        "e" will provide:
        <br/>NOTE: <a href="determining-new-entity">See here on how to determine if the entity is brand new</a>
            <ol>
                <li>SavedEntities: Gets the saved collection of IDataType objects.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Deleting</td>
        <td>(IDataTypeService sender, DeleteEventArgs&lt;IDataType&gt; e)</td>
        <td>
        Raised when DataTypeService.Delete is called in the API.<br />
        "sender" will be the current IDataTypeService object.<br />
        "e" will provide:
            <ol>
                <li>DeletedEntities: Gets the collection of IDataType objects being deleted.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>Deleted</td>
        <td>(IDataTypeService sender, DeleteEventArgs&lt;IDataType&gt; e)</td>
        <td>
        Raised when DataTypeService.Delete is called in the API.<br />
        "sender" will be the current IDataTypeService object.<br />
        "e" will provide:
            <ol>
                <li>DeletedEntities: Gets the collection of deleted IDataType objects.</li>
            </ol>
        </td>
    </tr>
</table>

## Other Events
 - DeletedContainer, DeletingContainer
 - SavedContainer, SavingContainer
 - Moving, Moved
