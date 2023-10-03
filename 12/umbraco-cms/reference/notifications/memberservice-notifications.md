# MemberService Notifications

The MemberService implements IMemberService and provides access to operations involving IMember.

## Usage

```csharp
using Microsoft.Extensions.Logging;
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Services.Notifications;

namespace MySite;

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
```

| Notification                    | Members                                                                                                                                                      | Description                                                                                                                                                                                                                                                                                                                                                                                                                     |
| ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| MemberSavingNotification        | <ul><li>IEnumerable&#x3C;IMember> SavedEntities</li><li>EventMessages Messages</li><li>IDictionary&#x3C;string,object> State</li><li>bool Cancel</li></ul>   | <p>Published when MemberService.Saving is called in the API.<br>NOTE: It can be skipped completely if the parameter "raiseEvents" is set to false during the Save method call (true by default).<br>SavedEntities: Gets the collection of IMember objects being saved.</p>                                                                                                                                                      |
| MemberSavedNotification         | <ul><li>IEnumerable&#x3C;IMember> SavedEntities</li><li>EventMessages Messages</li><li>IDictionary&#x3C;string,object> State</li></ul>                       | <p>Published when MemberService.Save is called in the API and after data has been persisted.<br>NOTE: It can be skipped completely if the parameter "raiseEvents" is set to false during the Save method call (true by default).<br><em>NOTE:</em> <a href="determining-new-entity.md"><em>See here on how to determine if the entity is brand new</em></a><br>SavedEntities: Gets the saved collection of IMember objects.</p> |
| MemberDeletingNotification      | <ul><li>IEnumerable&#x3C;IMember> DeletedEntities</li><li>EventMessages Messages</li><li>IDictionary&#x3C;string,object> State</li><li>bool Cancel</li></ul> | <p>Published when MemberService.Delete, and MemberService.DeleteMembersOfType are called in the API.<br>DeletedEntities: Gets the collection of IMember objects being deleted.</p>                                                                                                                                                                                                                                              |
| MemberDeletedNotification       | <ul><li>IEnumerable&#x3C;IMember> DeletedEntities</li><li>EventMessages Messages</li><li>IDictionary&#x3C;string,object> State</li></ul>                     | <p>Published when MemberService.Delete, and MemberService.DeleteMembersOfType are called in the API, after the members has been deleted.<br>DeletedEntities: Gets the collection of deleted IMember objects.</p>                                                                                                                                                                                                                |
| AssignedMemberRolesNotification | <ul><li>string[] Roles</li><li>int[] MemberIds</li></ul>                                                                                                     | <p>Published when MemberService.AssignRoles, and MemberService.ReplaceRoles are called in the API.</p><ol><li>Roles: Collection of role names being assigned.</li><li>MemberIds: Collection of Ids of the members the roles are being assigned to.</li></ol>                                                                                                                                                                    |
| RemovedMemberRolesNotification  | <ul><li>string[] Roles</li><li>int[] MemberIds</li></ul>                                                                                                     | <p>Published when MemberService.DissociateRoles are being called in the API.</p><ol><li>Roles: Collection of role names being removed.</li><li>MemberIds: Collection of Ids of the members the roles are being removed from.</li></ol>                                                                                                                                                                                          |
