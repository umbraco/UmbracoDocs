#LocalizationService Events#

The LocalizationService class implements ILocalizationService. It provides easy access to operations involving Language and DictionaryItem.

<table>
    <tr>
        <th>Event</th>
        <th>Signature</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>SavingLanguage</td>
        <td>(ILocalizationService sender, SaveEventArgs&lt;ILanguage&gt; e)</td>
        <td>
        Raised when LocalizationService.Save (ILanguage overload) is called in the API.<br />
        "sender" will be the current ILocalizationService object.<br />
        "e" will provide:
            <ol>
                <li>SavedEntities: Gets the collection of ILanguage objects being saved.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>SavedLanguage</td>
        <td>(ILocalizationService sender, SaveEventArgs&lt;ILanguage&gt; e)</td>
        <td>
        Raised when LocalizationService.Save (ILanguage overload) is called in the API and after data has been persisted.<br />
        "sender" will be the current ILocalizationService object.<br />
        "e" will provide:
            <ol>
                <li>SavedEntities: Gets the saved collection of ILanguage objects.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>SavingDictionaryItem</td>
        <td>(ILocalizationService sender, SaveEventArgs&lt;IDictionaryItem&gt; e)</td>
        <td>
        Raised when LocalizationService.Save (IDictionaryItem overload) is called in the API.<br />
        "sender" will be the current ILocalizationService object.<br />
        "e" will provide:
            <ol>
                <li>SavedEntities: Gets the collection of IDictionaryItem objects being saved.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>SavedDictionaryItem</td>
        <td>(ILocalizationService sender, SaveEventArgs&lt;IDictionaryItem&gt; e)</td>
        <td>
        Raised when LocalizationService.Save (IDictionaryItem overload) is called in the API and after data has been persisted.<br />
        "sender" will be the current ILocalizationService object.<br />
        "e" will provide:
            <ol>
                <li>SavedEntities: Gets the saved collection of IDictionary objects.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>DeletingLanguage</td>
        <td>(ILocalizationService sender, DeleteEventArgs&lt;ILanguage&gt; e)</td>
        <td>
        Raised when LocalizationService.Delete (ILanguage overload) is called in the API.<br />
        "sender" will be the current ILocalizationService object.<br />
        "e" will provide:
            <ol>
                <li>DeletedEntities: Gets the collection of ILanguage objects being deleted.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>DeletedLanguage</td>
        <td>(ILocalizationService sender, DeleteEventArgs&lt;ILanguage&gt; e)</td>
        <td>
        Raised when LocalizationService.Delete (ILanguage overload) is called in the API.<br />
        "sender" will be the current ILocalizationService object.<br />
        "e" will provide:
            <ol>
                <li>DeletedEntities: Gets the collection of deleted ILanguage objects.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>DeletingDictionaryItem</td>
        <td>(ILocalizationService sender, DeleteEventArgs&lt;IDictionaryItem&gt; e)</td>
        <td>
        Raised when LocalizationService.Delete (IDictionaryItem overload) is called in the API.<br />
        "sender" will be the current ILocalizationService object.<br />
        "e" will provide:
            <ol>
                <li>DeletedEntities: Gets the collection of IDictionaryItem objects being deleted.</li>
            </ol>
        </td>
    </tr>
    <tr>
        <td>DeletedDictionaryItem</td>
        <td>(ILocalizationService sender, DeleteEventArgs&lt;IDictionaryItem&gt; e)</td>
        <td>
        Raised when LocalizationService.Delete (IDictionaryItem overload) is called in the API.<br />
        "sender" will be the current ILocalizationService object.<br />
        "e" will provide:
            <ol>
                <li>DeletedEntities: Gets the collection of deleted IDictionaryItem objects.</li>
            </ol>
        </td>
    </tr>
</table>

