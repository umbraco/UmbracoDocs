# RelationService notifications

The RelationService provides access to operations involving `IRelation` and `IRelationType`, and published the following relation notifications:

<table>
  <tr>
    <th>Notification</th>
    <th>Members</th>
    <th>Description</th>
  </tr>

  <tr>
    <td>RelationSavingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIRelation&gt SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when a relation is being saved.<br />
    SavedEntities: The collection of IRelation objects being saved. <br />
    </td>
  </tr>

  <tr>
    <td>RelationSavedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIRelation&gt SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when a relation has been saved.<br />
    SavedEntities: The collection of IRelation objects having been saved. <br />
    </td>
  </tr>

  <tr>
    <td>RelationDeletingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIRelation&gt DeletedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when a relation is being deleted.<br />
    SavedEntities: The collection of IRelation objects being deleted. <br />
    </td>
  </tr>

  <tr>
    <td>RelationDeletedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIRelation&gt DeletedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when a relation has been deleted.<br />
    SavedEntities: The collection of IRelation objects having been deleted. <br />
    </td>
  </tr>

  <tr>
    <td>RelationTypeSavingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIRelationType&gt SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when a relation type being saved.<br />
    SavedEntities: The collection of IRelationType objects being saved. <br />
    </td>
  </tr>

  <tr>
    <td>RelationTypeSavedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIRelationType&gt SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when a relation type has been saved.<br />
    SavedEntities: The collection of IRelationType objects having been saved. <br />
    </td>
  </tr>

  <tr>
    <td>RelationTypeDeletingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIRelationType&gt DeletedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when a relation type is being deleted.<br />
    SavedEntities: The collection of IRelationType objects being deleted. <br />
    </td>
  </tr>

  <tr>
    <td>RelationTypeDeletedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIRelationType&gt DeletedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when a relation type has been deleted.<br />
    SavedEntities: The collection of IRelationType objects having been deleted. <br />
    </td>
  </tr>


</table>
