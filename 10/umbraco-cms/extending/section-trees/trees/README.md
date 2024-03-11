---
meta.Title: Umbraco Tree
description: A guide to creating a custom tree in Umbraco
---

# Trees

This section describes how to work with and create trees with Umbraco APIs.

## Creating trees

To Create a Tree in a section of the Umbraco backoffice, you need to take several steps:

Create a `TreeController` class in C#. A new controller which inherits from the abstract `Umbraco.Cms.Web.BackOffice.Trees.TreeController`\*\` class and provides an implementation for two abstract methods:

* GetTreeNodes (returns a `TreeNodeCollection`) - Responsible for rendering the content of the tree structure;
* GetMenuForNode (returns a `MenuItemCollection`) - Responsible for returning the menu structure to use for a particular node within a tree.

You will need to add a constructor as `TreeController` requires this. See full code snippet in the "Implementing the Tree" section below.

The `Tree` attribute used to decorate the `TreeController` has multiple properties.

* `SectionAlias` - Alias of the section in which the tree appears
* `TreeAlias` - Alias of the tree
* `TreeTitle` - The title of the tree
* `TreeGroup` - The tree group, the tree belongs to
* `SortOrder` - Sort order of the tree

For example:

```csharp
[Tree("settings", "favouriteThingsAlias", TreeTitle = "Favourite Things Name", TreeGroup="favouritesGroup", SortOrder=5)]
public class FavouriteThingsTreeController : TreeController
{ }
```

The example above would register a custom tree with a title 'Favourite Things Name' in the Settings section of Umbraco, inside a custom group called 'Favourites'.

### Tree Groups

Tree Groups enable you to group trees in a section. You provide the alias of the Tree Group name, you wish to add your tree to - see [Constants.Trees.Groups](https://apidocs.umbraco.com/v10/csharp/api/Umbraco.Cms.Core.Constants.Trees.Groups.html) for a list of existing group alias. An example of tree groups in the backoffice would be the _Settings_ tree group and the _Templating_ tree group in the _Settings_ section.

If you add your own alias, you'll need to add a translation key. This can be done by adding a language file to a `lang` folder with your application folder in `App_Plugins`: `App_Plugins/favouriteThings/lang/en-us.xml`. This will avoid the alias appearing as the header in \[square brackets].

The language file should contain the following XML:

```xml
<language>
  <area alias="treeHeaders">
    <key alias="favouritesGroup">Favourites</key>
  </area>
</language>
```

### Customising the Root Tree Node

The first node in the tree is referred to as the **Root Node**. You can customise the Root Node by overriding the abstract `CreateRootNode` method. You can assign a custom icon to the Root Node. You can also specify a custom URL route path in the backoffice to use with your custom tree. The method can be useful if your section has a single node (single page app).

[See Also: How to create your own custom section](../sections.md)

### Implementing the Tree

```csharp
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Actions;
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Models.Trees;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Core.Trees;
using Umbraco.Cms.Web.BackOffice.Trees;
using Umbraco.Extensions;

namespace My.Website.Trees
{
    [Tree("settings", "favouriteThingsAlias", TreeTitle = "Favourite Things Name", TreeGroup = "favouritesGroup", SortOrder = 5)]
    public class FavouriteThingsTreeController : TreeController
    {

        private readonly IMenuItemCollectionFactory _menuItemCollectionFactory;

        public FavouriteThingsTreeController(ILocalizedTextService localizedTextService,
            UmbracoApiControllerTypeCollection umbracoApiControllerTypeCollection,
            IMenuItemCollectionFactory menuItemCollectionFactory,
            IEventAggregator eventAggregator)
            : base(localizedTextService, umbracoApiControllerTypeCollection, eventAggregator)
        {
            _menuItemCollectionFactory = menuItemCollectionFactory ?? throw new ArgumentNullException(nameof(menuItemCollectionFactory));
        }

        protected override ActionResult<TreeNodeCollection> GetTreeNodes(string id, FormCollection queryStrings)
        {
            var nodes = new TreeNodeCollection();

            // check if we're rendering the root node's children
            if (id == Constants.System.Root.ToInvariantString())
            {
                // you can get your custom nodes from anywhere, and they can represent anything...
                Dictionary<int, string> favouriteThings = new Dictionary<int, string>();
                favouriteThings.Add(1, "Raindrops on Roses");
                favouriteThings.Add(2, "Whiskers on Kittens");
                favouriteThings.Add(3, "Skys full of Stars");
                favouriteThings.Add(4, "Warm Woolen Mittens");
                favouriteThings.Add(5, "Cream coloured Unicorns");
                favouriteThings.Add(6, "Schnitzel with Noodles");

                // loop through our favourite things and create a tree item for each one
                foreach (var thing in favouriteThings)
                {
                    // add each node to the tree collection using the base CreateTreeNode method
                    // it has several overloads, using here unique Id of tree item,
                    // -1 is the Id of the parent node to create, eg the root of this tree is -1 by convention
                    // - the querystring collection passed into this route
                    // - the name of the tree node
                    // - css class of icon to display for the node
                    // - and whether the item has child nodes
                    var node = CreateTreeNode(thing.Key.ToString(), "-1", queryStrings, thing.Value, "icon-presentation", false);
                    nodes.Add(node);
                }
            }

            return nodes;
        }

        protected override ActionResult<MenuItemCollection> GetMenuForNode(string id, FormCollection queryStrings)
        {
            // create a Menu Item Collection to return so people can interact with the nodes in your tree
            var menu = _menuItemCollectionFactory.Create();

            if (id == Constants.System.Root.ToInvariantString())
            {
                // root actions, perhaps users can create new items in this tree, or perhaps it's not a content tree, it might be a read only tree, or each node item might represent something entirely different...
                // add your menu item actions or custom ActionMenuItems
                menu.Items.Add(new CreateChildEntity(LocalizedTextService));
                // add refresh menu item (note no dialog)
                menu.Items.Add(new RefreshNode(LocalizedTextService, true));
            }
            else
            {
                // add a delete action to each individual item
                menu.Items.Add<ActionDelete>(LocalizedTextService, true, opensDialog: true);
            }

            return menu;
        }

        protected override ActionResult<TreeNode?> CreateRootNode(FormCollection queryStrings)
        {
            var rootResult = base.CreateRootNode(queryStrings);
            if (!(rootResult.Result is null))
            {
                return rootResult;
            }

            var root = rootResult.Value;

            // set the icon
            root.Icon = "icon-hearts";
            // could be set to false for a custom tree with a single node.
            root.HasChildren = true;
            //url for menu
            root.MenuUrl = null;

            return root;
        }
    }
}
```

![Favourite Things Custom Tree](../../../../../13/umbraco-cms/extending/section-trees/trees/images/favourite-things-custom-tree-v8.png)

### Responding to Tree Actions

The actions on items in an Umbraco Tree will trigger a request to load an AngularJS view, with a name corresponding to the name of the action, from a subfolder of the views folder matching the name of the 'customTreeAlias'.

Clicking on one of the 'Favourite Things' in the custom tree example will load an `edit.html` view from the folder: `/views/favouriteThingsAlias/edit.html`. The 'Delete' menu item would also load a view from: `/views/favouriteThingsAlias/delete.html`

When creating a custom tree as part of a Umbraco package, it is recommended to change the location of the default folder. It should be changed to the `App_Plugins` folder. You achieve this by decorating your MVC `TreeController` with the `PluginController` attribute.

```csharp
@using Umbraco.Cms.Web.Common.Attributes;

[Tree("settings", "favouriteThingsAlias", TreeTitle = "Favourite Things Name")]
[PluginController("favouriteThings")]
public class FavouriteThingsTreeController : TreeController
{ }
```

The edit view in the example would now be loaded from the location: `/App_Plugins/favouriteThings/backoffice/favouriteThingsAlias/edit.html`

#### Providing functionality in your Tree Action Views

You can instruct the Umbraco backoffice to load additional JavaScript resources (eg. angularJS controllers) to use in conjunction with your 'tree action views' by adding a `package.manifest` file in the same folder location as your views.

**For example**...

```json
{
    "javascript": [
        "~/App_Plugins/favouriteThings/favouriteThings.resource.js",
        "~/App_Plugins/favouriteThings/backoffice/favouriteThingsAlias/edit.controller.js",
        "~/App_Plugins/favouriteThings/backoffice/favouriteThingsAlias/delete.controller.js"
    ]
}
```

...this manifest would load files for two controllers to work with the edit and delete views and a general resource file, perhaps containing code to retrieve, create, edit and delete 'favourite things' from some external non-Umbraco API.

Our Tree Action View would then be wired to the loaded controller using the `ng-controller` attribute. The delete view would perhaps the delete view look a little bit like this:

```csharp
<div class="umb-dialog umb-pane" ng-controller="Our.Umbraco.FavouriteThings.DeleteController">
    <div class="umb-dialog-body">
        <p class="umb-abstract">
            Are you sure you want to delete this favourite thing: <strong>{{currentNode.name}}</strong> ?
        </p>
        <umb-confirm on-confirm="performDelete" on-cancel="cancel">
        </umb-confirm>
    </div>
</div>
```

![Delete Raindrops on Roses](../../../../../13/umbraco-cms/extending/section-trees/trees/images/delete-raindrops-on-roses-v8.png)

[see Tree Actions for a list of tree _ActionMenuItems_ and _IActions_](tree-actions.md)

### Single Node Trees / Customising the Root Node Action

It is possible to create 'trees' consisting of only a single node - perhaps to provide an area to control some settings or a placeholder for a single page backoffice app. See the LogViewer in the settings section for a good example. (or as in the case of the 'settings/content templates' tree, it's possible to have a custom view for the root node as an 'introduction' page to the tree).

In both scenarios you need to override the `CreateRootNode` method for the custom tree.

```csharp
[Tree("settings", "favouritistThingsAlias", TreeTitle = "Favourite Thing", TreeGroup = "favoritesGroup", SortOrder = 5)]
[PluginController("favouriteThing")]
public class FavouritistThingsTreeController : TreeController
{ }
```

You can override the `CreateRootNode` method to set the 'RoutePath' to where the single page application will live (or introduction page). Setting `HasChildren` to `false` will result in a Single Node Tree.

```csharp
protected override ActionResult<TreeNode> CreateRootNode(FormCollection queryStrings)
{
    var rootResult = base.CreateRootNode(queryStrings);
    if (!(rootResult.Result is null))
    {
        return rootResult;
    }

    var root = rootResult.Value;

    //optionally setting a routepath would allow you to load in a custom UI instead of the usual behaviour for a tree
    root.RoutePath = string.Format("{0}/{1}/{2}", Constants.Applications.Settings, "favouritistThingsAlias", "overview");
    // set the icon
    root.Icon = "icon-hearts";
    // set to false for a custom tree with a single node.
    root.HasChildren = false;
    //url for menu
    root.MenuUrl = null;

    return root;
}
```

The RoutePath should be in the format of: **section/treeAlias/method**. As our example controller uses the `PluginController` attribute, clicking the root node would now request `/App_Plugins/favouriteThing/backoffice/favouritistThingsAlias/overview.html`. If you are not using the `PluginController` attribute, then the request would be to `/umbraco/views/favouritistThingsAlias/overview.html`.

![Favourite Thing Custom Single Node Tree](../../../../../13/umbraco-cms/extending/section-trees/trees/images/favourite-thing-custom-single-node-tree.png)

#### Full Width App - IsSingleNodeTree

It's possible to make your single node tree app stretch across the full screen of the backoffice (no navigation tree) - see Packages section for an example. To achieve this add an additional attribute `IsSingleNodeTree`, in the Tree attribute for the custom controller.

```csharp
[Tree("settings", "favouritistThingsAlias", IsSingleNodeTree = true, TreeTitle = "Favourite Thing", TreeGroup = "favoritesGroup", SortOrder = 5)]
[PluginController("favouriteThing")]
public class FavouritistThingsTreeController : TreeController
{ }
```

## Tree notifications

All tree notications are defined in the namespace `Umbraco.Cms.Core.Notifications`.

For more information about registering and using notifications see [Notifications](../../../reference/notifications/)

### RootNodeRenderingNotification

The `RootNodeRenderingNotification` is published whenever a tree's root node is created.

**Members:**

* `TreeNode Node`
* `FormCollection QueryString`
* `string TreeAlias`

**Usage:**

```csharp
public void Handle(RootNodeRenderingNotification notification)
{
    // normally you will want to target a specific tree, this can be done by checking the tree alias
    if (notification.TreeAlias.Equals("content"))
    {
        notification.Node.Name = "My new title";
    }
}
```

### TreeNodesRenderingNotification

The `TreeNodesRenderingNotification` is published whenever a list of child nodes are created.

**Members:**

* `TreeNodeCollection Nodes`
* `FormCollection QueryString`
* `string TreeAlias`

**Usage:**

```csharp
using Umbraco.Cms.Core.Security;

public class TreeNotificationHandler :INotificationHandler<TreeNodesRenderingNotification>
{
    private readonly IBackOfficeSecurityAccessor _backOfficeSecurityAccessor;

    public TreeNotificationHandler(IBackOfficeSecurityAccessor backOfficeSecurityAccessor)
    {
        _backOfficeSecurityAccessor = backOfficeSecurityAccessor;
    }

    public void Handle(TreeNodesRenderingNotification notification)
    {
        // this example will filter any content tree node whose node name starts with
        // 'Private', for any user that is in the customUserGroup
        if (notification.TreeAlias.Equals("content") &&
            _backOfficeSecurityAccessor.BackOfficeSecurity.CurrentUser.Groups.Any(f =>
                f.Alias.Equals("customUserGroupAlias")))
        {
            notification.Nodes.RemoveAll(node => node.Name.StartsWith("Private"));
        }
    }
}
```

### MenuRenderingNotification

The `MenuRenderingNotification` is raised whenever a menu is generated for a tree node.

**Members:**

* `MenuItemCollection Menu`
* `string NodeId`
* `FormCollection QueryString`
* `string TreeAlias`

**Usage:**

```csharp
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Notifications;
using Umbraco.Cms.Core.Security;

public class TreeNotificationHandler : INotificationHandler<MenuRenderingNotification>
{
    private readonly IBackOfficeSecurityAccessor _backOfficeSecurityAccessor;

    public TreeNotificationHandler(IBackOfficeSecurityAccessor backOfficeSecurityAccessor)
    {
        _backOfficeSecurityAccessor = backOfficeSecurityAccessor;
    }

    public void Handle(MenuRenderingNotification notification)
    {
        // this example will add a custom menu item for all admin users

        // for all content tree nodes
        if (notification.TreeAlias.Equals("content") &&
            _backOfficeSecurityAccessor.BackOfficeSecurity.CurrentUser.Groups.Any(x =>
                x.Alias.InvariantEquals("admin")))
        {
            // Creates a menu action that will open /umbraco/currentSection/itemAlias.html
            var menuItem = new Umbraco.Cms.Core.Models.Trees.MenuItem("itemAlias", "Item name");

            // optional, if you don't want to follow the naming conventions, but do want to use a angular view
            // you can also use a direct path "../App_Plugins/my/long/url/to/view.html"
            menuItem.AdditionalData.Add("actionView", "my/long/url/to/view.html");

            // sets the icon to icon-wine-glass
            menuItem.Icon = "wine-glass";
            // insert at index 5
            notification.Menu.Items.Insert(5, menuItem);
        }
    }
}
```

## Tree Actions and User Permissions

[See a list of Tree Actions and User Permission Codes](tree-actions.md)
