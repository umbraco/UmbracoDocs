---
versionFrom: 9.0.0
versionTo: 10.0.0
---

# LocalizationService Events

The LocalizationService class implements ILocalizationService. It provides access to operations involving Language and DictionaryItem.

<table>
  <tr>
    <th>Notification</th>
    <th>Members</th>
    <th>Description</th>
  </tr>

  <tr>
    <td>LanguageSavingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltILanguage&gt SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when LocalizationService.Save (ILanguage overload) is called in the API.<br/>
    SavedEntities: Gets the collection of ILanguage objects being saved.
    </td>
  </tr>

  <tr>
    <td>LanguageSavedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltILanguage&gt SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
      </ul>
    </td>
    <td>
    RPublished when LocalizationService.Save (ILanguage overload) is called in the API after data has been persisted.<br/>
    SavedEntities: Gets the saved collection of ILanguage objects..
    </td>
  </tr>

  <tr>
    <td>DictionaryItemSavingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIDictionaryItem&gt SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when LocalizationService.Save (IDictionaryItem overload) is called in the API.<br/>
    SavedEntities: Gets the collection of IDictionaryItem objects being saved.
    </td>
  </tr>

  <tr>
    <td>DictionaryItemSavedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIDictionaryItem&gt SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
      </ul>
    </td>
    <td>
    Published when LocalizationService.Save (IDictionaryItem overload) is called in the API and the data has been persisted.<br/>
    SavedEntities: Gets the saved collection of IDictionary objects.
    </td>
  </tr>

  <tr>
    <td>LanguageDeletingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltILanguage&gt DeletedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when LocalizationService.Delete (ILanguage overload) is called in the API.<br/>
    DeletedEntities: Gets the collection of ILanguage objects being deleted.
    </td>
  </tr>

  <tr>
    <td>LanguageDeletedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltILanguage&gt DeletedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
      </ul>
    </td>
    <td>
    Published when LocalizationService.Delete (ILanguage overload) is called in the API, after the languages has been deleted.<br/>
    DeletedEntities: Gets the collection of deleted ILanguage objects.
    </td>
  </tr>

  <tr>
    <td>DictionaryItemDeletingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIDictionaryItem&gt DeletedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when LocalizationService.Delete (IDictionaryItem overload) is called in the API.<br/>
    DeletedEntities: Gets the collection of IDictionaryItem objects being deleted
    </td>
  </tr>

  <tr>
    <td>DictionaryItemDeletedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIDictionaryItem&gt DeletedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
      </ul>
    </td>
    <td>
    Published when LocalizationService.Delete (IDictionaryItem overload) is called in the API, after the dictionary items has been deleted.<br/>
    DeletedEntities: Gets the collection of deleted IDictionaryItem objects.
    </td>
  </tr>
</table>