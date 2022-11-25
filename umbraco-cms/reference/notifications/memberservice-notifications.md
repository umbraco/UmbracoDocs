---
versionFrom: 9.0.0
versionTo: 10.0.0
---

# MemberService Notifications

The MemberService implements IMemberService and provides access to operations involving IMember.

## Usage

```C#
using Microsoft.Extensions.Logging;
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Services.Notifications;

namespace MySite
{
    public class MemberNotificationHandler : INotificationHandler<MemberSavedNotification>
    {
        private readonly ILogger<MemberNotificationHandler> _logger;

        public MemberNotificationHandler(ILogger<MemberNotificationHandler> logger)
        {
            _logger = logger;
        }
        
        public void Handle(MemberSavedNotification notification)
        {
            foreach (var member in notification.SavedEntities)
            {
                // Write to the logs every time a member is saved.
                _logger.LogInformation("Member {member} has been saved and notification published!", member.Name);
            }
        }
    }
}
```

<table>
  <tr>
    <th>Notification</th>
    <th>Members</th>
    <th>Description</th>
  </tr>

  <tr>
    <td>MemberSavingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIMember&gt SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when MemberService.Saving is called in the API.<br/>
    NOTE: It can be skipped completely if the parameter "raiseEvents" is set to false during the Save method call (true by default).<br/>
    SavedEntities: Gets the collection of IMember objects being saved.
    </td>
  </tr>

  <tr>
    <td>MemberSavedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIMember&gt SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
      </ul>
    </td>
    <td>
    Published when MemberService.Save is called in the API and after data has been persisted.<br/>
    NOTE: It can be skipped completely if the parameter "raiseEvents" is set to false during the Save method call (true by default).<br/>
    <em>NOTE: <a href="determining-new-entity.md">See here on how to determine if the entity is brand new</a></em><br />
    SavedEntities: Gets the saved collection of IMember objects.
    </td>
  </tr>

  <tr>
    <td>MemberDeletingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIMember&gt DeletedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when MemberService.Delete, and MemberService.DeleteMembersOfType are called in the API.<br/>
    DeletedEntities: Gets the collection of IMember objects being deleted.
    </td>
  </tr>

  <tr>
    <td>MemberDeletedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIMember&gt DeletedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
      </ul>
    </td>
    <td>
      Published when MemberService.Delete, and MemberService.DeleteMembersOfType are called in the API, after the members has been deleted.<br/>
      DeletedEntities: Gets the collection of deleted IMember objects.
    </td>
  </tr>

  <tr>
    <td>AssignedMemberRolesNotification</td>
    <td>
      <ul>
        <li>string[] Roles</li>
        <li>int[] MemberIds</li>
      </ul>
    </td>
    <td>
    Published when MemberService.AssignRoles, and MemberService.ReplaceRoles are called in the API.
      <ol>
        <li>Roles: Collection of role names being assigned.</li>
        <li>MemberIds: Collection of Ids of the members the roles are being assigned to.</li>
      </ol>
    </td>
  </tr>

  <tr>
    <td>RemovedMemberRolesNotification</td>
    <td>
      <ul>
        <li>string[] Roles</li>
        <li>int[] MemberIds</li>
      </ul>
    </td>
    <td>
    Published when MemberService.DissociateRoles are being called in the API.
    <ol>
        <li>Roles: Collection of role names being removed.</li>
        <li>MemberIds: Collection of Ids of the members the roles are being removed from.</li>
      </ol>
    </td>
  </tr>
</table>
