# Using Notifications

Umbraco Workflow uses Notifications to allow you to hook into the processes for the backoffice. For example, you might want to execute some code every time an approval group is updated. Notifications allow you to do that. For more information on how Umbraco implements Notifications, see the [Using Notifications](https://docs.umbraco.com/umbraco-cms/reference/notifications) article.

## Notifications

All notifications reside in the `Umbraco.Workflow.Core.Notifications` namespace and are postfixed with `Notification`.

Typically, available notifications exist in pairs, with a "before" and "after" notification. For example, the `SettingsService` class publishes both a `WorkflowSettingsSavingNotification` and a `WorkflowSettingsSavedNotification` when settings are modified.

Which one you want to use depends on what you want to achieve. If you want to cancel the action, you will use the "before" notification and use the CancelOperation method on the notification to cancel it. If you want to execute some code after the settings have been updated, then you would use the "after" notification.

## ContentReviewService Notifications

<table>
  <tr>
    <th>Notification</th>
    <th>Members</th>
    <th>Description</th>
  </tr>

  <tr>
    <td>WorkflowContentReviewsConfigSavingNotification</td>
    <td>
      <ul>
        <li>IEnumerable<IWorkflowConfig> SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when ContentReviewService.SaveContentReviewConfig is called in the API.<br/>
    SavedEntities: Gets the collection of IWorkflowConfig objects being saved.
    </td>
  </tr>
  <tr>
    <td>WorkflowContentReviewsConfigSavedNotification</td>
    <td>
      <ul>
        <li>IEnumerable<IWorkflowConfig> SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
      </ul>
    </td>
    <td>
    Published when ContentReviewService.SaveContentReviewConfig is called in the API after the entities have been saved.<br/>
    SavedEntities: Gets the collection of saved IWorkflowConfig objects.
    </td>
  </tr>
  <tr>
    <td>WorkflowContentReviewsEmailNotificationsSendingNotification</td>
    <td>
      <ul>
        <li>Dictionary&ltUserGroupPoco, List&ltContentReviewConfigPoco&gt&gt Target</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>        
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when ContentReviewReminderEmailer.SendReviewReminders is called in the API, before email notifications are sent.<br/>
    Target: Gets a dictionary containing information about the nodes requiring review, and the assigned review groups.
    </td>
  </tr>   
  <tr>
    <td>WorkflowContentReviewsEmailNotificationsSentNotification</td>
    <td>
      <ul>
        <li>Dictionary&ltUserGroupPoco, List&ltContentReviewConfigPoco&gt&gt Target</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>      
      </ul>
    </td>
    <td>
    Published when ContentReviewReminderEmailer.SendReviewReminders is called in the API, after email notifications are sent.<br/>    
    Target: Gets a dictionary containing information about the nodes requiring review, and the assigned review groups.
    </td>
  </tr> 
  <tr>
    <td>WorkflowContentReviewsReviewingNotification</td>
    <td>
      <ul>
        <li>ContentReviewNodePoco Target</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>      
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when ContentReviewService.MarkAsReviewed is called in the API, before the node review status is updated.<br/>    
    Target: Get an object with information about the node being reviewed.
    </td>
  </tr>     
  <tr>
    <td>WorkflowContentReviewsReviewedNotification</td>
    <td>
      <ul>
        <li>ContentReviewNodePoco Target</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>      
      </ul>
    </td>
    <td>
    Published when ContentReviewService.MarkAsReviewed is called in the API, after the node review status is updated.<br/>    
    Target: Get an object with information about the reviewed node.
    </td>
  </tr>    
</table>

## ConfigService Notifications

<table>
  <tr>
    <th>Notification</th>
    <th>Members</th>
    <th>Description</th>
  </tr>

  <tr>
    <td>WorkflowContentTypeConfigDeletingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIWorkflowConfig&gt DeletedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when ConfigService.DeleteContentTypeConfig is called in the API, before the config items are deleted.<br/>
    DeletedEntities: Gets the collection of IWorkflowConfig objects being deleted.
    </td>
  </tr>
  <tr>
    <td>WorkflowContentTypeConfigDeletedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIWorkflowConfig&gt DeletedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
      </ul>
    </td>
    <td>
    Published when ConfigService.DeleteContentTypeConfig is called in the API, after the config items are deleted.<br/>
    DeletedEntities: Gets the collection of deleted IWorkflowConfig objects. Note these items are no longer in the database, and exist only in memory.
    </td>
  </tr> 
<tr>
    <td>WorkflowContentTypeConfigSavingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIWorkflowConfig&gt SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when ConfigService.UpdateContentTypeConfig is called in the API.<br/>
    SavedEntities: Gets the collection of IWorkflowConfig objects being saved.
    </td>
  </tr>
  <tr>
    <td>WorkflowContentTypeConfigSavedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIWorkflowConfig&gt SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
      </ul>
    </td>
    <td>
    Published when ConfigService.UpdateContentTypeConfig is called in the API, after the entities have been saved.<br/>
    SavedEntities: Gets the collection of saved IWorkflowConfig objects.
    </td>
  </tr>    
  <tr>
    <td>WorkflowNodeConfigDeletingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIWorkflowConfig&gt DeletedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when ConfigService.DeleteNodeConfig is called in the API, before the config items are deleted.<br/>
    DeletedEntities: Gets the collection of IWorkflowConfig objects being deleted.
    </td>
  </tr>
  <tr>
    <td>WorkflowNodeConfigDeletedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIWorkflowConfig&gt DeletedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
      </ul>
    </td>
    <td>
    Published when ConfigService.DeleteNodeConfig is called in the API, after the config items are deleted.<br/>
    DeletedEntities: Gets the collection of deleted IWorkflowConfig objects. Note these items are no longer in the database, and exist only in memory.
    </td>
  </tr> 
  <tr>
    <td>WorkflowNodeConfigSavingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIWorkflowConfig&gt SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when ConfigService.UpdateNodeConfig is called in the API.<br/>
    SavedEntities: Gets the collection of IWorkflowConfig objects being saved.
    </td>
  </tr>
  <tr>
    <td>WorkflowNodeConfigSavedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIWorkflowConfig&gt SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>
      </ul>
    </td>
    <td>
    Published when ConfigService.UpdateNodeConfig is called in the API, after the entities have been saved.<br/>
    SavedEntities: Gets the collection of saved IWorkflowConfig objects.
    </td>
  </tr>     
    
</table>

## NotificationsService Notifications

<table>
  <tr>
    <th>Notification</th>
    <th>Members</th>
    <th>Description</th>
  </tr>
    
  <tr>
    <td>WorkflowEmailNotificationsSendingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIWorkflowInstance&gt Target</li>
        <li>EmailType EmailType</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>        
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when NotificationsService.SendEmailNotifications is called in the API, before email notifications are generated and sent.<br/>
    Target: Gets the object describing the workflow instance used to build the email messages<br />
    EmailType: Gets the enum value describing the email type
    </td>
  </tr>         
  <tr>
    <td>WorkflowEmailNotificationsSentNotification</td>
    <td>
      <ul>
        <li>IHtmlEmailModel Target</li>
        <li>List&ltEmailUserModel&gt Recipients</li>
        <li>EmailType EmailType</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>        
      </ul>
    </td>
    <td>
    Published when WorkflowReminderEmailer.Send is called in the API, after email notifications are sent.<br/>
    Target: Gets the object describing the email<br />
    Recipients: Gets the collection of email recipients<br />
    EmailType: Gets the enum value describing the email type
    </td>
  </tr>
  <tr>
    <td>WorkflowEmailRemindersSendingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIWorkflowInstance&gt Target</li>
        <li>EmailType EmailType</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>        
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when NotificationsService.SendEmailReminders is called in the API, before email notifications are generated and sent.<br/>
    Target: Gets the collection of objects describing the workflow instances used to build the email messages<br />
    EmailType: Gets the enum value describing the email type, which will always be `EmailType.Reminder`
    </td>
  </tr>         
  <tr>
    <td>WorkflowEmailRemindersSentNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIWorkflowInstance&gt Target</li>
        <li>List&EmailTaskListModel&gt Tasks</li>
        <li>EmailType EmailType</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>        
      </ul>
    </td>
    <td>
    Published when WorkflowReminderEmailer.Send is called in the API, after email notifications are sent.<br/>
    Target: Gets the collection of objects describing the workflow instances used to build the email messages<br />
    Tasks: Gets the collection of objects describing the overdue workflows for each notified user<br />
    EmailType: Gets the enum value describing the email type, which will always be `EmailType.Reminder`
    </td>
  </tr>        
    
</table>

## GroupService Notifications

<table>
  <tr>
    <th>Notification</th>
    <th>Members</th>
    <th>Description</th>
  </tr>
    
  <tr>
    <td>WorkflowGroupCreatingNotification</td>
    <td>
      <ul>
        <li>IWorkflowGroup SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>        
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when GroupService.CreateUserGroupAsync is called in the API, before the entity is created.<br/>
    CreatedEntity: Gets the created IWorkflowGroup object.
    </td>
  </tr>  
  <tr>
    <td>WorkflowGroupCreatedNotification</td>
    <td>
      <ul>
        <li>IWorkflowGroup SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>        
      </ul>
    </td>
    <td>
    Published when GroupService.CreateUserGroupAsync is called in the API, after the entity has been created.<br/>
    CreatedEntity: Gets the created IWorkflowGroup object.
    </td>
  </tr>      
  <tr>
    <td>WorkflowGroupDeletingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIWorkflowGroup&gt DeletedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>        
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when GroupService.DeleteUserGroupAsync is called in the API, before the group is deleted.<br/>
    DeletedEntities: Gets the collection of IWorkflowGroup objects being deleted.
    </td>
  </tr>  
  <tr>
    <td>WorkflowGroupDeletedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIWorkflowGroup&gt DeletedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>        
      </ul>
    </td>
    <td>
    Published when GroupService.DeleteUserGroupAsync is called in the API, after the group is deleted.<br/>
    DeletedEntities: Gets the collection of deleted IWorkflowGroup objects.
    </td>
  </tr>
  <tr>
    <td>WorkflowGroupSavingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIWorkflowGroup&gt SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>        
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when GroupService.UpdateUserGroupAsync is called in the API, before the group is updated.<br/>
    SavedEntities: Gets the collection of IWorkflowGroup objects being saved.
    </td>
  </tr>  
  <tr>
    <td>WorkflowGroupSavedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltIWorkflowGroup&gt SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>        
      </ul>
    </td>
    <td>
    Published when GroupService.UpdateUserGroupAsync is called in the API, after the group is updated.<br/>
    SavedEntities: Gets the collection of saved IWorkflowGroup objects.
    </td>
  </tr>
    
</table>

## WorkflowProcess Notifications

<table>
  <tr>
    <th>Notification</th>
    <th>Members</th>
    <th>Description</th>
  </tr>
    
  <tr>
    <td>WorkflowInstanceApprovingNotification</td>
    <td>
      <ul>
        <li>IWorkflowInstance Target</li>
        <li>WorkflowAction Action</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>        
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when WorkflowProcess.ActionWorkflow is called in the API, before the workflow stage is approved.<br/>
    Target: Gets the IWorkflowInstance object being approved.<br />
    Action: Gets the WorkflowAction being executed. Will be WorkflowAction.Approve.
    </td>
  </tr>
  <tr>
    <td>WorkflowInstanceApprovedNotification</td>
    <td>
      <ul>
        <li>IWorkflowInstance Target</li>
        <li>WorkflowAction Action</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>        
      </ul>
    </td>
    <td>
    Published when WorkflowProcess.ActionWorkflow is called in the API, after the workflow stage is approved.<br/>
    Target: Gets the approved IWorkflowInstance object.<br />
    Action: Gets the WorkflowAction being executed. Will be WorkflowAction.Approve.
    </td>
  </tr>    
  <tr>
    <td>WorkflowInstanceCancellingNotification</td>
    <td>
      <ul>
        <li>IWorkflowInstance Target</li>
        <li>WorkflowAction Action</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>        
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when WorkflowProcess.ActionWorkflow is called in the API, before the workflow stage is cancelled.<br/>
    Target: Gets the IWorkflowInstance object being cancelled.<br />
    Action: Gets the WorkflowAction being executed. Will be WorkflowAction.Cancel.
    </td>
  </tr>
  <tr>
    <td>WorkflowInstanceCancelledNotification</td>
    <td>
      <ul>
        <li>IWorkflowInstance Target</li>
        <li>WorkflowAction Action</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>        
      </ul>
    </td>
    <td>
    Published when WorkflowProcess.ActionWorkflow is called in the API, after the workflow stage is cancelled.<br/>
    Target: Gets the cancelled IWorkflowInstance object.<br />
    Action: Gets the WorkflowAction being executed. Will be WorkflowAction.Cancel.
    </td>
  </tr> 
  <tr>
    <td>WorkflowInstanceCompletedNotification</td>
    <td>
      <ul>
        <li>IWorkflowInstance Target</li>
        <li>WorkflowType WorkflowType</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>        
      </ul>
    </td>
    <td>
    Published when WorkflowProcess.HandleCompleteNow<T> or WorkflowProcess.HandleCompleteLater<T> is called in the API, after the workflow is completed.<br/>
    Target: Gets the completed IWorkflowInstance object.<br />
    WorkflowType: Gets the WorkflowType enum value representing the workflow type, either Publish or Unpublish
    </td>
  </tr> 
  <tr>
    <td>WorkflowInstanceCreatingNotification</td>
    <td>
      <ul>
        <li>IWorkflowInstance CreatedEntity</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>        
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when WorkflowProcess.InitiateWorkflow is called in the API, before the workflow is initiated.<br/>
    CreatedEntity: Gets the IWorkflowInstance object being created.
    </td>
  </tr>
  <tr>
    <td>WorkflowInstanceCreatedNotification</td>
    <td>
      <ul>
        <li>IWorkflowInstance CreatedEntity</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>        
      </ul>
    </td>
    <td>
    Published when WorkflowProcess.InitiateWorkflow is called in the API, after the workflow is initiated.<br/>
    CreatedEntity: Gets the created IWorkflowInstance object.
    </td>
  </tr>     
  <tr>
    <td>WorkflowInstanceRejectingNotification</td>
    <td>
      <ul>
        <li>IWorkflowInstance Target</li>
        <li>WorkflowAction Action</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>        
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when WorkflowProcess.ActionWorkflow is called in the API, before the workflow stage is rejected.<br/>
    Target: Gets the IWorkflowInstance object being rejected.<br />
    Action: Gets the WorkflowAction being executed. Will be WorkflowAction.Reject.
    </td>
  </tr>
  <tr>
    <td>WorkflowInstanceRejectedNotification</td>
    <td>
      <ul>
        <li>IWorkflowInstance Target</li>
        <li>WorkflowAction Action</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>        
      </ul>
    </td>
    <td>
    Published when WorkflowProcess.ActionWorkflow is called in the API, after the workflow stage is rejected.<br/>
    Target: Gets the rejected IWorkflowInstance object.<br />
    Action: Gets the WorkflowAction being executed. Will be WorkflowAction.Reject.
    </td>
  </tr>    
  <tr>
    <td>WorkflowInstanceResubmittingNotification</td>
    <td>
      <ul>
        <li>IWorkflowInstance Target</li>
        <li>WorkflowAction Action</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>        
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when WorkflowProcess.ResubmitWorkflow is called in the API, before the workflow stage is resubmitted.<br/>
    Target: Gets the IWorkflowInstance object being resubmitted.<br />
    Action: Gets the WorkflowAction being executed. Will be WorkflowAction.Resubmit.
    </td>
  </tr>
  <tr>
    <td>WorkflowInstanceResubmittedNotification</td>
    <td>
      <ul>
        <li>IWorkflowInstance Target</li>
        <li>WorkflowAction Action</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>        
      </ul>
    </td>
    <td>
    Published when WorkflowProcess.ResubmitWorkflow is called in the API, after the workflow stage is resubmitted.<br/>
    Target: Gets the resubmitted IWorkflowInstance object.<br />
    Action: Gets the WorkflowAction being executed. Will be WorkflowAction.Resubmit.
    </td>
  </tr>   
  <tr>
    <td>WorkflowInstanceUpdatingNotification</td>
    <td>
      <ul>
        <li>IWorkflowInstance Target</li>
        <li>WorkflowAction Action</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>        
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Base notification class for Approving, Cancelling, Creating, Rejecting and Resubmitting and can be used in place of these, using the Action value to identify the executed workflow action.<br/>
    Published when WorkflowProcess.ResubmitWorkflow is called in the API, before the workflow is updated.<br/>
    Target: Gets the IWorkflowInstance object being updated.<br />
    Action: Gets the WorkflowAction being executed.
    </td>
  </tr>
  <tr>
    <td>WorkflowInstanceUpdatedNotification</td>
    <td>
      <ul>
        <li>IWorkflowInstance Target</li>
        <li>WorkflowAction Action</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>        
      </ul>
    </td>
    <td>
    Base notification class for Approved, Cancelled, Created, Rejected, Resubmitted and can be used in place of these, using the Action value to identify the executed workflow action.<br/>
    Published when WorkflowProcess.ResubmitWorkflow is called in the API, after the workflow stage is updated.<br/>
    Target: Gets the updated IWorkflowInstance objects.<br />
    Action: Gets the WorkflowAction being executed.
    </td>
  </tr>    
 <tr>
    <td>WorkflowResubmitTaskCreatingNotification</td>
    <td>
      <ul>
        <li>IWorkflowInstance CreatedEntity</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>        
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when WorkflowProcess.ResubmitWorkflow is called in the API, before the workflow task is persisted.<br/>
    CreatedEntity: Gets the IWorkflowTask object being created.
    </td>
  </tr>
  <tr>
    <td>WorkflowResubmitTaskCreatedNotification</td>
    <td>
      <ul>
        <li>IWorkflowInstance CreatedEntity</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>        
      </ul>
    </td>
    <td>
    Published when WorkflowProcess.ResubmitWorkflow is called in the API, after the workflow task is persisted.<br/>
    CreatedEntity: Gets the created IWorkflowTask.
    </td>
  </tr>     
 <tr>
    <td>WorkflowTaskCreatingNotification</td>
    <td>
      <ul>
        <li>IWorkflowInstance CreatedEntity</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>        
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when WorkflowTaskManager.CreateApprovalTask is called in the API, before the workflow task is persisted.<br/>
    CreatedEntity: Gets the IWorkflowTask object being created.
    </td>
  </tr>
  <tr>
    <td>WorkflowTaskCreatedNotification</td>
    <td>
      <ul>
        <li>IWorkflowInstance CreatedEntity</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>        
      </ul>
    </td>
    <td>
    Published when WorkflowTaskManager.CreateApprovalTask is called in the API, after the workflow task is persisted.<br/>
    CreatedEntity: Gets the created IWorkflowTask.
    </td>
  </tr>            
 <tr>
    <td>WorkflowTaskUpdatingNotification</td>
    <td>
      <ul>
        <li>IWorkflowInstance Target</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>        
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when WorkflowTaskManager.ResubmitWorkflow is called in the API, before the workflow task is updated.<br/>
    CreatedEntity: Gets the IWorkflowTask object being updated.
    </td>
  </tr>
  <tr>
    <td>WorkflowTaskUpdatedNotification</td>
    <td>
      <ul>
        <li>IWorkflowInstance Target</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>        
      </ul>
    </td>
    <td>
    Published when WorkflowTaskManager.ResubmitWorkflow is called in the API, after the workflow task is updated.<br/>
    CreatedEntity: Gets the updated IWorkflowTask.
    </td>
  </tr>           
        
</table>

## SettingsService Notifications

<table>
  <tr>
    <th>Notification</th>
    <th>Members</th>
    <th>Description</th>
  </tr>
    
  <tr>
    <td>WorkflowSettingsSavingNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltISettings&gt SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>        
        <li>bool Cancel</li>
      </ul>
    </td>
    <td>
    Published when SettingsService.UpdateSettings<T> is called in the API, before the settings are saved.<br/>
    SavedEntities: Gets the collection of ISettings objects being saved.<br />
    </td>
  </tr>
  <tr>
    <td>WorkflowSettingsSavedNotification</td>
    <td>
      <ul>
        <li>IEnumerable&ltISettings&gt SavedEntities</li>
        <li>EventMessages Messages</li>
        <li>IDictionary&ltstring,object&gt State</li>        
      </ul>
    </td>
    <td>
    Published when SettingsService.UpdateSettings<T is called in the API, after the settings are saved.<br/>
    SavedEntities: Gets the collection of saved ISettings objects.<br />
    </td>
  </tr>  
</table>
