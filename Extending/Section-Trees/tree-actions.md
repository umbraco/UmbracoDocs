# Tree Actions

Items in an Umbraco Tree can have associated Actions, the actions visible to the currently logged in user can be controlled via User Permissions.

You can set a User's permissions for each item in the Umbraco Content tree from the User Section of the Umbraco Backoffice.

If you are developing a custom section, or a custom Dashboard, you might want to display some different options based on a Users's Permission set on a particular item.

For example, on a custom dashboard you might add a quick 'Create a Blog Post' button for an editor, but only if that editor has permissions to create a blog post, and so you could create some sort of API endpoint, to call from your AngularJS controller, that in turn uses the UserService to return the current user's permissions, and see whether they have the required permission to 'create' within the site's blog section...
	
~~~~
bool canCreateBlogs = false;
var us = Services.UserService;     
var user = us.GetByEmail(email);
var userPermissionsForBlog = us.GetPermissions(user, blogId);
foreach (var permission in userPermissionsForBlog)
    {
        if (permission.AssignedPermissions.Contains("C"))
            {
                canCreateBlogs = true;
            }
    }
	
~~~~	

## But how to know which letter corresponds to which Tree Action?

Each tree action in Umbraco implements the IAction interface, and each Action has a corresponding 'Letter', and a boolean value describing whether Permissions can be assigned for an action.
~~~~
/// <summary>
	/// </summary>
	/// Summary description for ActionI.
	public interface IAction : IDiscoverable
    {
		char Letter {get;}
		bool ShowInNotifier {get;}
		bool CanBePermissionAssigned {get;}
		string Icon {get;}
		string Alias {get;}
		string JsFunctionName {get;}
        /// <summary>
        /// A path to a supporting JavaScript file for the IAction. A script tag will be rendered out with the reference to the JavaScript file.
        /// </summary>
		string JsSource {get;}
	}
~~~~

When you pull back the AssignedPermissions for a user on a particular item, it is these letters that indicate which actions the User is permitted to peform in the context of the tree item.

### User Permission Codes

Here's a list of the current User Permission codes, their alias, whether they can be permission assigned, their icon, and the javascript function they call... (if relevant)

| Letter | Alias                | Can be Permission Assigned | Icon                | Javascript Function                                                                                                                     |
|--------|----------------------|----------------------------|---------------------|-----------------------------------------------------------------------------------------------------------------------------------------|
| F      | Action Browse        | True                       |                     | This action is used as a security constraint that grants a user the ability to view nodes in a tree that has permissions applied to it. |
| ï      | createblueprint      | True                       | blueprint           |                                                                                                                                         |
| I      | assignDomain         | True                       | home                | UmbClientMgr.appActions().actionAssignDomain()                                                                                          |
| Z      | auditTrail           | True                       | time                | UmbClientMgr.appActions().actionAudit()                                                                                                 |
| 7      | changeDocType        | True                       | axis-rotation-2     | UmbClientMgr.appActions().actionChangeDocType()                                                                                         |
| O      | copy                 | True                       | documents           | UmbClientMgr.appActions().actionCopy()                                                                                                  |
| D      | delete               | True                       | delete              | UmbClientMgr.appActions().actionDelete()                                                                                                |
| E      | disable              | False                      | remove              | UmbClientMgr.appActions().actionDisable()                                                                                               |
| N      | emptyRecycleBin      | False                      | trash               | UmbClientMgr.appActions().actionEmptyTranscan()                                                                                         |
| 9      | exportDocumentType   | False                      | download-alt        | UmbClientMgr.appActions().actionExport()                                                                                                |
| 8      | importDocumentType   | False                      | page-up             | UmbClientMgr.appActions().actionImport()                                                                                                |
| M      | move                 | True                       | enter               | UmbClientMgr.appActions().actionMove()                                                                                                  |
| C      | create               | True                       | add                 | UmbClientMgr.appActions().actionNew()                                                                                                   |
| !      | createFolder         | False                      | plus-sign-alt       | UmbClientMgr.appActions().actionNewFolder()                                                                                             |
| T      | notify               | False                      | megaphone           | UmbClientMgr.appActions().actionNotify()                                                                                                |
| X      | importPackage        | False                      | gift                | UmbClientMgr.appActions().actionPackage()                                                                                               |
| Y      | createPackage        | False                      | gift                | UmbClientMgr.appActions().actionPackageCreate()                                                                                         |
| P      | protect              | True                       | lock                | UmbClientMgr.appActions().actionProtect()                                                                                               |
| U      | publish              | True                       | globe               | UmbClientMgr.appActions().actionPublish()                                                                                               |
| Q      | logout               | False                      | signout             | UmbClientMgr.appActions().actionQuit()                                                                                                  |
| L      | refreshNode          | False                      | refresh             | UmbClientMgr.appActions().actionRefresh()                                                                                               |
| B      | republish            | False                      | globe               | UmbClientMgr.appActions().actionRePublish()                                                                                             |
| R      | rights               | True                       | vcard               | UmbClientMgr.appActions().actionRights()                                                                                                |
| K      | rollback             | True                       | undo                | UmbClientMgr.appActions().actionRollback()                                                                                              |
| 5      | sendToTranslate      | True                       | chat                | UmbClientMgr.appActions().actionSendToTranslate()                                                                                       |
| S      | sort                 | True                       | navigation-vertical | UmbClientMgr.appActions().actionSort()                                                                                                  |
| H      | sendtopublish        | True                       | outbox              | UmbClientMgr.appActions().actionToPublish()                                                                                             |
| 4      | translate            | True                       | comments            |                                                                                                                                         |
| A      | update               | True                       | save                | UmbClientMgr.appActions().actionUpdate()                                                                                                |
| Z      | unpublish            | False                      | circle-dotted       |                                                                                                                                         |
| ¤      | delete               | False                      | delete              | javascript:actionDeleteRelationType(UmbClientMgr.mainTree().getActionNode().nodeId,UmbClientMgr.mainTree().getActionNode().nodeName);   |
| ®      | create               | False                      | add                 | javascript:actionNewRelationType();                                                                                                     |
| V      | ActionRestore        | False                      |                     | This action is invoked when the content item is to be restored from the recycle bin                                                     |
| -      | Action Null          | False                      |                     | This is used internally to assign no permissions to a node for a user and shouldn't be used in code                                     |
| ,      | ContextMenuSeperator | False                      |                     | Used simply to define context menu seperator items. This should not be used directly in any code except for creating menus              |