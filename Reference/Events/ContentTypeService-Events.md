#ContentTypeService Events#

The ContentTypeService class implements IContentTypeService. It provides easy access to operations involving IContentType and IMediaType.

<table>
    <tr>
        <th>Event</th>
        <th>Signature</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>SavingContentType</td>
        <td>(IContentTypeService sender, SaveEventArgs&lt;IContentType&gt; e)</td>
        <td>
        Raised when ContentTypeService.Save (IContentType overloads) is called in the API.<br />
        "sender" will be the current IContentTypeService object.<br />
        "e" will provide:
            <ol>
                <li>SavedEntities: Gets the collection of IContentType objects being saved.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>SavedContentType</td>
        <td>(IContentTypeService sender, SaveEventArgs&lt;IContentType&gt; e)</td>
        <td>
        Raised when ContentTypeService.Save (IContentType overloads) is called in the API and after data has been persisted.<br />
        "sender" will be the current IContentTypeService object.<br />
        "e" will provide:
		<br/>NOTE: <a href="determining-new-entity">See here on how to determine if the entity is brand new</a>
            <ol>
                <li>SavedEntities: Gets the saved collection of IContentType objects.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>SavingMediaType</td>
        <td>(IContentTypeService sender, SaveEventArgs&lt;IMediaType&gt; e)</td>
        <td>
        Raised when ContentTypeService.Save (IMediaType overloads) is called in the API.<br />
        "sender" will be the current IContentTypeService object.<br />
        "e" will provide:
            <ol>
                <li>SavedEntities: Gets the collection of IMediaType objects being saved.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>SavedMediaType</td>
        <td>(IContentTypeService sender, SaveEventArgs&lt;IMediaType&gt; e)</td>
        <td>
        Raised when ContentTypeService.Save (IMediaType overloads) is called in the API and after data has been persisted.<br />
        "sender" will be the current IContentTypeService object.<br />
        "e" will provide:
		<br/>NOTE: <a href="determining-new-entity">See here on how to determine if the entity is brand new</a>
            <ol>
                <li>SavedEntities: Gets the saved collection of IMediaType objects.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>DeletingContentType</td>
        <td>(IContentTypeService sender, DeleteEventArgs&lt;IContentType&gt; e)</td>
        <td>
        Raised when ContentTypeService.Delete (IContentType overloads) is called in the API.<br />
        "sender" will be the current IContentTypeService object.<br />
        "e" will provide:
            <ol>
                <li>DeletedEntities: Gets the collection of IContentType objects being deleted.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>DeletedContentType</td>
        <td>(IContentTypeService sender, DeleteEventArgs&lt;IContentType&gt; e)</td>
        <td>
        Raised when ContentTypeService.Delete (IContentType overloads) is called in the API.<br />
        "sender" will be the current IContentTypeService object.<br />
        "e" will provide:
            <ol>
                <li>DeletedEntities: Gets the collection of deleted IContentType objects.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>DeletingMediaType</td>
        <td>(IContentTypeService sender, DeleteEventArgs&lt;IMediaType&gt; e)</td>
        <td>
        Raised when ContentTypeService.Delete (IMediaType overloads) is called in the API.<br />
        "sender" will be the current IContentTypeService object.<br />
        "e" will provide:
            <ol>
                <li>DeletedEntities: Gets the collection of IMediaType objects being deleted.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>DeletedMediaType</td>
        <td>(IContentTypeService sender, DeleteEventArgs&lt;IMediaType&gt; e)</td>
        <td>
        Raised when ContentTypeService.Delete (IMediaType overloads) is called in the API.<br />
        "sender" will be the current IContentTypeService object.<br />
        "e" will provide:
            <ol>
                <li>DeletedEntities: Gets the collection of deleted IMediaType objects.</li>
            </ol>
        </td>
    </tr>
</table>
