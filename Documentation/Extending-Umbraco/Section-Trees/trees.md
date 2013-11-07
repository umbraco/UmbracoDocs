#Trees

Trees are also in a config file located: `~/Config/trees.config` . Each config item defines a tree and for what section it belongs to. For example, this is the definition of the user tree:

    <add application="users" alias="users" title="Users" 
         type="umbraco.loadUsers, umbraco" 
         iconClosed="icon-folder" iconOpen="icon-folder" sortOrder="0" />

The tree type should reference the assembly qualified type of the tree, for example the above user tree is of type: `umbraco.loadUsers, umbraco`. 

*NOTE: you don't need to specify the assembly version, etc...*

##Tree Service API v7

The section API in v7+ is found in the interface `Umbraco.Core.Services.IApplicationTreeService` which is exposed on the ApplicationContext singleton. This API is used to control/query the storage for tree registrations in the ~/Config/trees.config file.

[See the tree service API reference here](../../Reference/Management-v6/Services/TreeService.md)

##ApplicationTree API v6

The application tree API in v6/v4 is found in the class `umbraco.BusinessLogic.ApplicationTree`. This API is used to control/query the storage for tree registrations in the ~/Config/trees.config file.
 
##Tree events v7

In v7 legacy trees will continue to work but the events for legacy trees may no longer work because we are replacing all core trees with the new format. The good news is that the new tree events will always fire for new and legacy trees.

All tree events are defined on the class `Umbraco.Web.Trees.TreeControllerBase`

###RootNodeRendering

The `RootNodeRendering` is raised whenever a tree's root node is created.

**Definition:**

    public static event TypedEventHandler<TreeControllerBase, TreeNodeRenderingEventArgs> RootNodeRendering;

**Usage:**

	//register the event listener:
	TreeControllerBase.RootNodeRendering += TreeControllerBase_RootNodeRendering;

	//the event listener method:
    void TreeControllerBase_RootNodeRendering(TreeControllerBase sender, TreeNodeRenderingEventArgs e)
    {
        //normally you will want to target a specific tree, this can be done by checking the 
        // tree alias of by checking the tree type (casting 'sender')
        if (sender.TreeAlias == "content")
        {
            e.Node.Title = "My new title";
        }
    }	

###TreeNodesRendering

The `TreeNodesRendering` is raised whenever a list of child nodes are created

**Definition:**

    public static event TypedEventHandler<TreeControllerBase, TreeNodesRenderingEventArgs> TreeNodesRendering;

**Usage:**

	//register the event listener:
    TreeControllerBase.TreeNodesRendering += TreeControllerBase_TreeNodesRendering;

	//the event listener method:
    void TreeControllerBase_TreeNodesRendering(TreeControllerBase sender, TreeNodesRenderingEventArgs e)
    {
        //this example will filter any content tree node who's node name starts with
        // 'Private', for any user that is of the type 'customUser'
        if (sender.TreeAlias == "content"
            && sender.Security.CurrentUser.UserType.Alias == "customUser")
        {
            e.Nodes.RemoveAll(node => node.Title.StartsWith("Private"));
        }
    }


###MenuRendering

The `MenuRendering` is raised whenever a menu is generated for a tree node

**Definition:**

    public static event TypedEventHandler<TreeControllerBase, MenuRenderingEventArgs> MenuRendering;

**Usage:**

	//register the event listener:
    TreeControllerBase.MenuRendering += TreeControllerBase_MenuRendering;

	//the event listener method:
    void TreeControllerBase_MenuRendering(TreeControllerBase sender, MenuRenderingEventArgs e)
    {
        //this example will add a custom menu item for all admin user's
        // for all content tree nodes
        if (sender.TreeAlias == "content"
            && sender.Security.CurrentUser.UserType.Alias == "admin")
        {
            e.Menu.Items.Add(new MenuItem("tweetLink", "Tweet this"));
        }
    }

##Tree events v6

v6/v4 tree events are defined on the class: `umbraco.cms.presentation.Trees.BaseTree`

*NOTE: even though the events are defined on this class, it is up to the tree implementor to ensure the events are actually raised (this issue has been addressed with the new v7 tree APIs)*

The events are: `BeforeNodeRender`, `AfterNodeRender`, `BeforeTreeRender`, `AfterTreeRender`, `NodeActionsCreated`

It is not recommended to use the events BeforeTreeRender or AfterTreeRender since this will cause much higher performance spikes.





 