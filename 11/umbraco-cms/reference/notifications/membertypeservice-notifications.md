# MemberTypeService Notifications

The MemberTypeService class implements IMemberTypeService. It provides access to operations involving IMemberType

<table>
  <tr>
    <th>Notification</th>
    <th>Members</th>
    <th>Description</th>
  </tr>

  <tr>
    <td>MemberTypeSavingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIMemberType&gt SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when MemberTypeService.Save is called in the API.<br/>
    SavedEntities: Gets the collection of IMemberType objects being saved.
    </td>
  </tr>

  <tr>
    <td>MemberTypeSavedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIMemberType&gt SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
      </ul>
    </td>
    <td>
    Published when MemberTypeService.Save is called in the API, after the entities has been saved.<br/>
    NOTE: <em><a href="determining-new-entity.md">See here on how to determine if the entity is brand new</a></em><br/>
    SavedEntities: Gets the collection of saved IMemberType objects.
    </td>
  </tr>

  <tr>
    <td>MemberTypeDeletingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIMemberType&gt DeletedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
      Published when MemberTypeService.Delete is called in the API.<br/>
      DeletedEntities: Gets the collection of IMemberType objects being deleted.
    </td>
  </tr>

  <tr>
    <td>MemberTypeDeletedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIMemberType&gt DeletedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
      </ul>
    </td>
    <td>
      Published when MemberTypeService.Delete is called in the API, after the entities has been deleted.<br/>
      DeletedEntities: Gets the collection of deleted IMemberType objects.
    </td>
  </tr>

  <tr>
    <td>MemberTypeMovingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltMoveEventInfo&ltIMemberType&gt&gt MoveInfoCollection</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when MemberTypeService.Move is called in the API<br/>
    MoveInfoCollection will for each moving entity provide:
      <ol>
        <li>Entity: Gets the IMemberType object being moved</li>
        <li>OriginalPath: The original path the entity is moved from</li>
        <li>NewParentId: Gets the Id of the parent the entity will have after it has been moved</li>
      </ol>
    </td>
  </tr>

  <tr>
    <td>MemberTypeMovedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltMoveEventInfo&ltIMemberType&gt&gt MoveInfoCollection</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
      </ul>
    </td>
    <td>
    Published when MemberTypeService.Move is called in the API, after the entities has been moved.<br/>
    MoveInfoCollection will for each moving entity provide:
      <ol>
        <li>Entity: Gets the IMemberType object being moved</li>
        <li>OriginalPath: The original path the entity is moved from</li>
        <li>NewParentId: Gets the Id of the parent the entity will have after it has been moved</li>
      </ol>
    </td>
  </tr>

  <tr>
    <td>MemberTypeChangedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltMemberTypeChange&ltIMemberType&gt&gt Changes</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
      </ul>
    </td>
    <td>
    Published when a MemberType is saved or deleted, after the transaction has completed. This is mainly used for caching purposes, and generally not recommended, use Saved and Deleted notifications instead.<br/>
    Changes will for each item affected by the change prove:
    <ol>
      <li>Item: The IMemberType affected by the change.</li>
      <li>ChangeTypes: The type of change: Create, Remove, RefreshMain, etc.</li>
    </ol>
    </td>
  </tr>
</table>
