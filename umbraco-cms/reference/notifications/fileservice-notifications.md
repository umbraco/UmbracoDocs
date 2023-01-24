# FileService Notifications

The FileService class implements IFileService. It provides access to operations involving IFile objects like scripts, stylesheets and templates.

<table>
  <tr>
    <th>Notification</th>
    <th>Members</th>
    <th>Description</th>
  </tr>

  <tr>
    <td>TemplateSavingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltITemplate&gt SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
        <li>string ContentTypeAlias</li>
        <li>bool CreateTemplateForContentType</li>
      </ul>
    </td>
    <td>
    Published when FileService.SaveTemplate is called in the API.<br>
      <ol>
        <li>SavedEntities: Gets the collection of ITemplate objects being saved.</li>
        <li>ContentTypeAlias: The alias of the ContentType the template is for, this is used when creating a Document Type with Template, it's not recommended to try and change or set this.</li>
        <li>CreateTemplateForContentType: Boolean value determining if the template is create for a Document Type, it's not recommended to change this value.</li>
      </ol>
    </td>
  </tr>

  <tr>
    <td>TemplateSavedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltITemplate&gt SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>string ContentTypeAlias</li>
        <li>bool CreateTemplateForContentType</li>
      </ul>
    </td>
    <td>
    Published when FileService.SaveTemplate is called in the API, after the template has been saved.<br>
      <ol>
        <li>SavedEntities: Gets the collection of saved ITemplate objects.</li>
        <li>ContentTypeAlias: The alias of the ContentType the template is for, this is used when creating a Document Type with Template, it's not recommended to try and change this value.</li>
        <li>CreateTemplateForContentType: Boolean value determining if the template is create for a Document Type, it's not recommended to change this value.</li>
      </ol>
    </td>
  </tr>

  <tr>
    <td>ScriptSavingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIScript&gt SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when FileService.SaveScript is called in the API.<br>
    SavedEntities: Gets the collection of IScript objects being saved.
    </td>
  </tr>

  <tr>
    <td>ScriptSavedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIScript&gt SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
      </ul>
    </td>
    <td>
    Published when FileService.SaveScript is called in the API, after the script has been saved.<br>
    SavedEntities: Gets the collection of saved IScript objects.
    </td>
  </tr>

  <tr>
    <td>StylesheetSavingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIStylesheet&gt SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when FileService.SaveStyleSheet is called in the API.<br>
    SavedEntities: Gets the collection of IStylesheet objects being saved.
    </td>
  </tr>

  <tr>
    <td>StylesheetSavedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIStylesheet&gt SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
      </ul>
    </td>
    <td>
    Published when FileService.SaveStylesheet is called in the API, after the script has been saved.<br>
    SavedEntities: Gets the collection of saved IStylesheet objects.
    </td>
  </tr>

  <tr>
    <td>TemplateDeletingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltITemplate&gt DeletedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
      Published when FileService.DeleteTemplate is called in the API.<br/>
      DeletedEntities: Gets the collection of ITemplate objects being deleted.
    </td>
  </tr>

  <tr>
    <td>TemplateDeletedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltITemplate&gt DeletedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
      </ul>
    </td>
    <td>
      Published when FileService.DeleteTemplate is called in the API, after the template has been deleted.<br/>
      DeletedEntities: Gets the collection of deleted ITemplate objects.
    </td>
  </tr>

  <tr>
    <td>ScriptDeletingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIScript&gt DeletedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
      Published when FileService.DeleteScript is called in the API.<br/>
      DeletedEntities: Gets the collection of IScript objects being deleted.
    </td>
  </tr>

  <tr>
    <td>ScriptDeletedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIScript&gt DeletedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
      </ul>
    </td>
    <td>
      Published when FileService.DeleteScript is called in the API, after the script has been deleted.<br/>
      DeletedEntities: Gets the collection of deleted IScript objects.
    </td>
  </tr>

  <tr>
    <td>StylesheetDeletingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIStylesheet&gt DeletedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
      Published when FileService.DeleteStylesheet is called in the API.<br/>
      DeletedEntities: Gets the collection of IStylesheet objects being deleted.
    </td>
  </tr>

  <tr>
    <td>StylesheetDeletedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIStylesheet&gt DeletedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
      </ul>
    </td>
    <td>
      Published when FileService.DeleteStylesheet is called in the API, after the stylesheet has been deleted.<br/>
      DeletedEntities: Gets the collection of deleted IStylesheet objects.
    </td>
  </tr>

</table>