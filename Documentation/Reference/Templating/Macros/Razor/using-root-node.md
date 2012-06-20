#Using the root node for site settings
<!-- original author Jonas Eriksson -->
Most sites need a place to store some global settings, like a couple of node id's and email addresses. One easy way to handle such is to store them as properties in the root node and to access them with the help of DynamicNode methods.

MySite.Com (root node for the site)
- searchPageNodeId (property, type "content")
- administrativeEmailAddress (property, type "textstring")

Get the email setting:

    <p>Admin email address : @Model.AncestorOrSelf().AdministrativeEmailAddress</p>

Get the search node:

    @using umbraco.MacroEngines
    @{
      dynamic settingsNode = Model.AncestorOrSelf();
      dynamic searchPageNode = new DynamicNode(settingsNode.SearchPageNodeId);
    }
    <a href="@searchPageNode.Url">Search</a>

AncestorOrSelf() gets the node at level 1, starting at the current node, moving straight up the node tree.
I ran some perf tests, and the query takes about 1/1000 of a second, which I think is very good.