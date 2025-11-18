---
description: A guide to creating a custom tree action in Umbraco
---

# Tree Actions

Items in an Umbraco Tree can have associated Actions. The actions visible to the currently logged in user can be controlled via User Permissions.

You can set a User's permissions for each item in the Umbraco Content tree from the User Section of the Umbraco Backoffice.

If you are developing a custom section, or a custom Dashboard, you might want to display some different options based on a User's permission set on a particular item.

For example, on a custom dashboard you might add a quick 'Create a Blog Post' button for an editor, but only if that editor has permissions to create a blog post. You could create some sort of API endpoint, to call from your AngularJS controller, that in turn uses the UserService to return the current user's permissions. Then you can see whether they have the required permission to 'create' within the site's blog section.

```csharp
bool canCreateBlogs = false;
var user = _userService.GetByEmail(email);
var userPermissionsForBlog = _userService.GetPermissions(user, blogId);
foreach (var permission in userPermissionsForBlog)
{
    if (permission.AssignedPermissions.Contains("C"))
    {
        canCreateBlogs = true;
    }
}
```

## But how to know which letter corresponds to which Tree Action?

Each tree action in Umbraco implements the IAction interface, and each Action has a corresponding 'Letter', and a boolean value describing whether permissions can be assigned for an action.

```csharp
public interface IAction : IDiscoverable
{
    char Letter {get;}
    bool ShowInNotifier {get;}
    bool CanBePermissionAssigned {get;}
    string Icon {get;}
    string Alias {get;}
    string JsFunctionName {get;}
    /// <summary>
    /// A path to a supporting JavaScript file for the IAction. A script tag will be rendered out with the reference to the  JavaScript file.
    /// </summary>
    string JsSource {get;}
}
```

When you pull back the AssignedPermissions for a user on a particular item, it is these letters that indicate which actions the User is permitted to perform in the context of the tree item.

### User Permission Codes

Here is a list of the tree actions and associated user permission codes shipped by Umbraco CMS and add-on projects (such as Umbraco Deploy), as well as those used by some community packages.

If building a package or adding custom tree actions to your solution, it's important to pick a permission letter that doesn't clash with one of these.

If you have created a package using a custom tree action, consider providing an update to this documentation page via a PR to the [documentation repository](https://github.com/umbraco/UmbracoDocs), such that other developers can discover and avoid using the same permission letter.

| Type                                                          | Alias                  | Letter | Can Be Permission Assigned |
| ------------------------------------------------------------- | ---------------------- | ------ | -------------------------- |
| Umbraco.Cms.Core.Actions.ActionAssignDomain                   | assignDomain           | I      | True                       |
| Umbraco.Cms.Core.Actions.ActionBrowse                         | browse                 | F      | True                       |
| Umbraco.Cms.Core.Actions.ActionCopy                           | copy                   | O      | True                       |
| Umbraco.Cms.Core.Actions.ActionCreateBlueprintFromContent     | createblueprint        | ï      | True                       |
| Umbraco.Cms.Core.Actions.ActionDelete                         | delete                 | D      | True                       |
| Umbraco.Cms.Core.Actions.ActionMove                           | move                   | M      | True                       |
| Umbraco.Cms.Core.Actions.ActionNew                            | create                 | C      | True                       |
| Umbraco.Cms.Core.Actions.ActionNotify                         | notify                 | N      | True                       |
| Umbraco.Cms.Core.Actions.ActionProtect                        | protect                | P      | True                       |
| Umbraco.Cms.Core.Actions.ActionPublish                        | publish                | U      | True                       |
| Umbraco.Cms.Core.Actions.ActionRestore                        | restore                | V      | False                      |
| Umbraco.Cms.Core.Actions.ActionRights                         | rights                 | R      | True                       |
| Umbraco.Cms.Core.Actions.ActionRollback                       | rollback               | K      | True                       |
| Umbraco.Cms.Core.Actions.ActionSort                           | sort                   | S      | True                       |
| Umbraco.Cms.Core.Actions.ActionToPublish                      | sendtopublish          | H      | True                       |
| Umbraco.Cms.Core.Actions.ActionUnpublish                      | unpublish              | Z      | True                       |
| Umbraco.Cms.Core.Actions.ActionUpdate                         | update                 | A      | True                       |
| Umbraco.Deploy.UI.Actions.ActionDeployRestore                 | deployRestore          | Q      | True                       |
| Umbraco.Deploy.UI.Actions.ActionDeployTreeRestore             | deployTreeRestore      | Ψ      | True                       |
| Umbraco.Deploy.UI.Actions.ActionPartialRestore                | deployPartialRestore   | Ø      | True                       |
| Umbraco.Deploy.UI.Actions.ActionQueueForTransfer              | deployQueueForTransfer | T      | True                       |
| Umbraco.Deploy.UI.Actions.Export                              | deployExport           | П      | True                       |
| Umbraco.Deploy.UI.Actions.Import                              | deployImport           | Џ      | True                       |
| Jumoo.TranslationManager.Core.Actions.ActionTranslate         | translate              | 5      | True                       |
| Jumoo.TranslationManager.Core.Actions.ActionManageTranslation | manageTranslations     | Ť      | True                       |
| uSync.Publisher.Actions.PushToServer                          | pushContent            | >      | True                       |
| uSync.Publisher.Actions.PullFromServer                        | pullContent            | <      | True                       |
| uSync.Publisher.Action.PushButton                             | pushContentButton      | ^      | True                       |
| Our.Umbraco.LinkedPages.LinkedAction                          | linkPages              | l      | True                       |

{% hint style="info" %}
_Up until Umbraco Deploy 9.2.0, the letter "N" was used for the "Queue For Transfer" action. In 9.2.1 it was changed to be "T". To avoid clashing with the letter selected for the Umbraco CMS "Notify" action, introduced in CMS version 8.18._
{% endhint %}
