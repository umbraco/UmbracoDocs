---
versionFrom: 8.0.0
meta.Title: "Umbraco Tree Actions"
meta.Description: "A guide to creating a custom tree action in Umbraco"
meta.RedirectLink: "/umbraco-cms/tutorials/starter-kit/lessons/1-customize-the-starter-kit"
---

# Tree Actions

Items in an Umbraco Tree can have associated Actions, the actions visible to the currently logged in user can be controlled via User Permissions.

You can set a User's permissions for each item in the Umbraco Content tree from the User Section of the Umbraco Backoffice.

If you are developing a custom section, or a custom Dashboard, you might want to display some different options based on a User's permission set on a particular item.

For example, on a custom dashboard you might add a quick 'Create a Blog Post' button for an editor., but only if that editor has permissions to create a blog post. You could create some sort of API endpoint, to call from your AngularJS controller, that in turn uses the UserService to return the current user's permissions. Then you can see whether they have the required permission to 'create' within the site's blog section.

```csharp
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

If you have created a package using a custom tree action, please consider providing an update to this documentation page via a PR to the [documentation repository](https://github.com/umbraco/UmbracoDocs), such that other developers can discover and avoid using the same permission letter.

|Type|Alias|Letter|Can Be Permission Assigned|
|-|-|-|-|
|Umbraco.Web.Actions.ActionAssignDomain|assignDomain|I|True|
|Umbraco.Web.Actions.ActionBrowse|browse|F|True|
|Umbraco.Web.Actions.ActionCopy|copy|O|True|
|Umbraco.Web.Actions.ActionCreateBlueprintFromContent|createblueprint|ï|True|
|Umbraco.Web.Actions.ActionDelete|delete|D|True|
|Umbraco.Web.Actions.ActionMove|move|M|True|
|Umbraco.Web.Actions.ActionNew|create|C|True|
|Umbraco.Web.Actions.ActionProtect|protect|P|True|
|Umbraco.Web.Actions.ActionPublish|publish|U|True|
|Umbraco.Web.Actions.ActionRestore|restore|V|False|
|Umbraco.Web.Actions.ActionRights|rights|R|True|
|Umbraco.Web.Actions.ActionRollback|rollback|K|True|
|Umbraco.Web.Actions.ActionSort|sort|S|True|
|Umbraco.Web.Actions.ActionToPublish|sendtopublish|H|True|
|Umbraco.Web.Actions.ActionUnpublish|unpublish|Z|True|
|Umbraco.Web.Actions.ActionUpdate|update|A|True|
|Umbraco.Deploy.UI.Actions.ActionDeployTreeRestore|deployTreeRestore|Ψ|True|
|Umbraco.Deploy.UI.Actions.ActionDeployRestore|deployRestore|Q|True|
|Umbraco.Deploy.UI.Actions.ActionPartialRestore|deployPartialRestore|Ø|True|
|Umbraco.Deploy.UI.Actions.ActionQueueForTransfer|deployQueueForTransfer|T|True|
|Jumoo.TranslationManager.Core.Actions.ActionTranslate|translate|5|True|
|Jumoo.TranslationManager.Core.Actions.ActionManageTranslation|manageTranslations|Ť|True|
|uSync.Publisher.Actions.PushToServer|pushContent|>|True|
|uSync.Publisher.Actions.PullFromServer|pullContent|<|True|
|uSync.Publisher.Action.PushButton|pushContentButton|^|True|
|Our.Umbraco.LinkedPages.LinkedAction|linkPages|l|True|

*Note: up until Umbraco Deploy 4.4.2, the letter "N" was used for the "Queue For Transfer" action.  In 4.4.3 it was changed to be "T", to avoid clashing with the letter selected for the Umbraco CMS "Notify" action, introduced in CMS version 8.18.*