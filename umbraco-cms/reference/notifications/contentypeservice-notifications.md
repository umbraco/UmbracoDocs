# ContentTypeService Notifications

The ContentTypeService class implements IContentTypeService. It provides access to operations involving IContentType

<table>
  <tr>
    <th>Notification</th>
    <th>Members</th>
    <th>Description</th>
  </tr>

  <tr>
    <td>ContentTypeSavingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIContentType&gt SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when ContentTypeService.Save is called in the API.<br/>
    SavedEntities: Gets the collection of IContentType objects being saved.
    </td>
  </tr>

  <tr>
    <td>ContentTypeSavedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIContentType&gt SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
      </ul>
    </td>
    <td>
    Published when ContentTypeService.Save is called in the API, after the entities has been saved.<br/>
    NOTE: <em><a href="determining-new-entity.md">See here on how to determine if the entity is brand new</a></em><br/>
    SavedEntities: Gets the collection of saved IContentType objects.
    </td>
  </tr>

  <tr>
    <td>ContentTypeDeletingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIContentType&gt DeletedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
      Published when ContentTypeService.Delete is called in the API.<br/>
      DeletedEntities: Gets the collection of IContentType objects being deleted.
    </td>
  </tr>

  <tr>
    <td>ContentTypeDeletedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIContentType&gt DeletedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
      </ul>
    </td>
    <td>
      Published when ContentTypeService.Delete is called in the API, after the entities has been deleted.<br/>
      DeletedEntities: Gets the collection of deleted IContentType objects.
    </td>
  </tr>

  <tr>
    <td>ContentTypeMovingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltMoveEventInfo&ltIContentType&gt&gt MoveInfoCollection</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when ContentTypeService.Move is called in the API<br/>
    MoveInfoCollection will for each moving entity provide:
      <ol>
        <li>Entity: Gets the IContentType object being moved</li>
        <li>OriginalPath: The original path the entity is moved from</li>
        <li>NewParentId: Gets the Id of the parent the entity will have after it has been moved</li>
      </ol>
    </td>
  </tr>

  <tr>
    <td>ContentTypeMovedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltMoveEventInfo&ltIContentType&gt&gt MoveInfoCollection</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
      </ul>
    </td>
    <td>
    Published when ContentTypeService.Move is called in the API, after the entities has been moved.<br/>
    MoveInfoCollection will for each moving entity provide:
      <ol>
        <li>Entity: Gets the IContentType object being moved</li>
        <li>OriginalPath: The original path the entity is moved from</li>
        <li>NewParentId: Gets the Id of the parent the entity will have after it has been moved</li>
      </ol>
    </td>
  </tr>

  <tr>
    <td>ContentTypeChangedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltContentTypeChange&ltIContentType&gt&gt Changes</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
      </ul>
    </td>
    <td>
    Published when a ContentType is saved or deleted, after the transaction has completed. This is mainly used for caching purposes, and generally not recommended, use Saved and Deleted notifications instead.<br/>
    Changes will for each item affected by the change prove:
    <ol>
      <li>Item: The IContentType affected by the change.</li>
      <li>ChangeTypes: The type of change: Create, Remove, RefreshMain, etc.</li>
    </ol>
    </td>
  </tr>
</table>
