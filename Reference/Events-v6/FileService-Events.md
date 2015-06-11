#FileService Events#

The FileService class implements IFileService. It provides easy access to operations involving IFile objects like scripts, stylesheets and templates.  

<table>
    <tr>
        <th>Event</th>
        <th>Signature</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>SavingTemplate</td>
        <td>(IFileService sender, SaveEventArgs&lt;ITemplate&gt; e)</td>
        <td>
        Raised when FileService.SaveTemplate is called in the API.<br />
        "sender" will be the current IFileService object.<br />
        "e" will provide:
            <ol>
                <li>SavedEntities: Gets the collection of ITemplate objects being saved.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>SavedTemplate</td>
        <td>(IFileService sender, SaveEventArgs&lt;ITemplate&gt; e)</td>
        <td>
        Raised when FileService.SaveTemplate is called in the API and after data has been persisted.<br />
        "sender" will be the current IFileService object.<br />
        "e" will provide:
		<br/>NOTE: <a href="determining-new-entity">See here on how to determine if the entity is brand new</a>
            <ol>
                <li>SavedEntities: Gets the saved collection of ITemplate objects.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>SavingScript</td>
        <td>(IFileService sender, SaveEventArgs&lt;Script&gt; e)</td>
        <td>
        Raised when FileService.SaveScript is called in the API.<br />
        "sender" will be the current IFileService object.<br />
        "e" will provide:
            <ol>
                <li>SavedEntities: Gets the collection of Script objects being saved.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>SavedScript</td>
        <td>(IFileService sender, SaveEventArgs&lt;Script&gt; e)</td>
        <td>
        Raised when FileService.SaveScript is called in the API and after data has been persisted.<br />
        "sender" will be the current IFileService object.<br />
        "e" will provide:
            <ol>
                <li>SavedEntities: Gets the saved collection of Script objects.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>SavingStylesheet</td>
        <td>(IFileService sender, SaveEventArgs&lt;Stylesheet&gt; e)</td>
        <td>
        Raised when FileService.SaveStylesheet is called in the API.<br />
        "sender" will be the current IFileService object.<br />
        "e" will provide:
            <ol>
                <li>SavedEntities: Gets the collection of Stylesheet objects being saved.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>SavedStylesheet</td>
        <td>(IFileService sender, SaveEventArgs&lt;Stylesheet&gt; e)</td>
        <td>
        Raised when FileService.SaveStylesheet is called in the API and after data has been persisted.<br />
        "sender" will be the current IFileService object.<br />
        "e" will provide:
            <ol>
                <li>SavedEntities: Gets the saved collection of Stylesheet objects.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>DeletingTemplate</td>
        <td>(IFileService sender, DeleteEventArgs&lt;ITemplate&gt; e)</td>
        <td>
        Raised when FileService.DeleteTemplate is called in the API.<br />
        "sender" will be the current IFileService object.<br />
        "e" will provide:
            <ol>
                <li>DeletedEntities: Gets the collection of ITemplate objects being deleted.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>DeletedTemplate</td>
        <td>(IFileService sender, DeleteEventArgs&lt;ITemplate&gt; e)</td>
        <td>
        Raised when FileService.DeleteTemplate is called in the API.<br />
        "sender" will be the current IFileService object.<br />
        "e" will provide:
            <ol>
                <li>DeletedEntities: Gets the collection of deleted ITemplate objects.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>DeletingScript</td>
        <td>(IFileService sender, DeleteEventArgs&lt;Script&gt; e)</td>
        <td>
        Raised when FileService.DeleteScript is called in the API.<br />
        "sender" will be the current IFileService object.<br />
        "e" will provide:
            <ol>
                <li>DeletedEntities: Gets the collection of Script objects being deleted.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>DeletedScript</td>
        <td>(IFileService sender, DeleteEventArgs&lt;Script&gt; e)</td>
        <td>
        Raised when FileService.DeleteScript is called in the API.<br />
        "sender" will be the current IFileService object.<br />
        "e" will provide:
            <ol>
                <li>DeletedEntities: Gets the collection of deleted Script objects.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>DeletingStylesheet</td>
        <td>(IFileService sender, DeleteEventArgs&lt;Stylesheet&gt; e)</td>
        <td>
        Raised when FileService.DeleteStylesheet is called in the API.<br />
        "sender" will be the current IFileService object.<br />
        "e" will provide:
            <ol>
                <li>DeletedEntities: Gets the collection of Stylesheet objects being deleted.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>DeletedStylesheet</td>
        <td>(IFileService sender, DeleteEventArgs&lt;Stylesheet&gt; e)</td>
        <td>
        Raised when FileService.DeleteStylesheet is called in the API.<br />
        "sender" will be the current IFileService object.<br />
        "e" will provide:
            <ol>
                <li>DeletedEntities: Gets the collection of deleted Stylesheet objects.</li>
            </ol>
        </td>
    </tr>
</table>
