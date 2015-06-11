#Trees v7

This section describes how to work with and create trees with the v7 APIs.

*NOTE: trees created with the v6 APIs will still work in v7 but will not have angular view support.*

##Creating trees

*coming soon*

##Tree Service API v7

The section API in v7+ is found in the interface `Umbraco.Core.Services.IApplicationTreeService` which is exposed on the ApplicationContext singleton. This API is used to control/query the storage for tree registrations in the ~/Config/trees.config file.

[See the tree service API reference here](../../Reference/Management-v6/Services/TreeService.md)
 
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
        //this example will filter any content tree node whose node name starts with
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
        //this example will add a custom menu item for all admin users
        // for all content tree nodes
        if (sender.TreeAlias == "content"
            && sender.Security.CurrentUser.UserType.Alias == "admin")
        {
            e.Menu.Items.Add(new MenuItem("tweetLink", "Tweet this"));
        }
    }


 