# MediaTypeService Notifications

The MediaTypeService class implements IMediaTypeService. It provides access to operations involving IMediaType.

<table>
  <tr>
    <th>Notification</th>
    <th>Members</th>
    <th>Description</th>
  </tr>

  <tr>
    <td>MediaTypeSavingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIMediaType&gt SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when MediaTypeService.Save is called in the API.<br/>
    SavedEntities: Gets the collection of IMediaType objects being saved.
    </td>
  </tr>

  <tr>
    <td>MediaTypeSavedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIMediaType&gt SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
      </ul>
    </td>
    <td>
    Published when MediaTypeService.Save is called in the API, after the entities has been saved.<br/>
    NOTE: <em><a href="determining-new-entity.md">See here on how to determine if the entity is brand new</a></em><br/>
    SavedEntities: Gets the collection of saved IMediaType objects.
    </td>
  </tr>

  <tr>
    <td>MediaTypeDeletingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIMediaType&gt DeletedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
      Published when MediaTypeService.Delete is called in the API.<br/>
      DeletedEntities: Gets the collection of IMediaType objects being deleted.
    </td>
  </tr>

  <tr>
    <td>MediaTypeDeletedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIMediaType&gt DeletedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
      </ul>
    </td>
    <td>
      Published when MediaTypeService.Delete is called in the API, after the entities has been deleted.<br/>
      DeletedEntities: Gets the collection of deleted IMediaType objects.
    </td>
  </tr>

  <tr>
    <td>MediaTypeMovingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltMoveEventInfo&ltIMediaType&gt&gt MoveInfoCollection</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when MediaTypeService.Move is called in the API<br/>
    MoveInfoCollection will for each moving entity provide:
      <ol>
        <li>Entity: Gets the IMediaType object being moved</li>
        <li>OriginalPath: The original path the entity is moved from</li>
        <li>NewParentId: Gets the Id of the parent the entity will have after it has been moved</li>
      </ol>
    </td>
  </tr>

  <tr>
    <td>MediaTypeMovedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltMoveEventInfo&ltIMediaType&gt&gt MoveInfoCollection</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
      </ul>
    </td>
    <td>
    Published when MediaTypeService.Move is called in the API, after the entities has been moved.<br/>
    MoveInfoCollection will for each moving entity provide:
      <ol>
        <li>Entity: Gets the IMediaType object being moved</li>
        <li>OriginalPath: The original path the entity is moved from</li>
        <li>NewParentId: Gets the Id of the parent the entity will have after it has been moved</li>
      </ol>
    </td>
  </tr>

  <tr>
    <td>MediaTypeChangedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltMediaTypeChange&ltIMediaType&gt&gt Changes</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
      </ul>
    </td>
    <td>
    Published when a MediaType is saved or deleted, after the transaction has completed. This is mainly used for caching purposes, and generally not recommended, use Saved and Deleted notifications instead.<br/>
    Changes will for each item affected by the change prove:
    <ol>
      <li>Item: The IMediaType affected by the change.</li>
      <li>ChangeTypes: The type of change: Create, Remove, RefreshMain, etc.</li>
    </ol>
    </td>
  </tr>
</table>
