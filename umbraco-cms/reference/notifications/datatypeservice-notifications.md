---
versionFrom: 9.0.0
versionTo: 10.0.0
---

# DataTypeService Notifications

The DataTypeService class implements IDataTypeService. It provides access to operations involving IDataType.

<table>
  <tr>
    <th>Notification</th>
    <th>Members</th>
    <th>Description</th>
  </tr>

  <tr>
    <td>DataTypeSavingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIDataType&gt SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when DataTypeService.Save is called in the API.<br/>
    SavedEntities: Gets the collection of IDataType objects being saved.
    </td>
  </tr>

  <tr>
    <td>DataTypeSavedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIDataType&gt SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
      </ul>
    </td>
    <td>
    Published when DataTypeService.Save is called in the API and after data has been persisted.
    NOTE: <em><a href="determining-new-entity.md">See here on how to determine if the entity is brand new</a></em><br>
    SavedEntities: Gets the saved collection of IDataType objects.
    </td>
  </tr>

  <tr>
    <td>DataTypeDeletingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIDataType&gt DeletedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when DataTypeService.Delete is called in the API.<br/>
    DeletedEntities: Gets the collection of IDataType objects being deleted.
    </td>
  </tr>

  <tr>
    <td>DataTypeDeletedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIDataType&gt DeletedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
      </ul>
    </td>
    <td>
    Published when DataTypeService.Delete is called in the API, after the IDataType objects has been deleted.<br/>
    DeletedEntities: Gets the collection of deleted IDataType objects.
    </td>
  </tr>

  <tr>
    <td>DataTypeMovingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltMoveEventInfo&ltIDataType&gt&gt MoveInfoCollection</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
      Published when IDataTypeService.Move is called in the API.<br/>
      MoveInfoCollection will for each moving entity provide:
      <ol>
        <li>Entity: Gets the IDataType object being moved</li>
        <li>OriginalPath: The original path the entity is moved from</li>
        <li>NewParentId: Gets the Id of the parent the entity will have after it has been moved</li>
      </ol>
    </td>
  </tr>

   <tr>
    <td>DataTypeMovedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltMoveEventInfo&ltIDataType&gt&gt MoveInfoCollection</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
      </ul>
    </td>
    <td>
      Published when IDataTypeService.Move is called in the API, after the IDataType has been moved.<br/>
      MoveInfoCollection will for each moving entity provide:
      <ol>
        <li>Entity: Gets the moved IDataType object</li>
        <li>OriginalPath: The original path the entity is moved from</li>
        <li>NewParentId: Gets the Id of the parent the entity will have after it has been moved</li>
      </ol>
    </td>
  </tr>
  
</table>
