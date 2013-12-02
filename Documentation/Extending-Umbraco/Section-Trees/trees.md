#Trees

Trees are also in a config file located: `~/Config/trees.config` . Each config item defines a tree and for what section it belongs to. For example, this is the definition of the user tree:

    <add application="users" alias="users" title="Users" 
         type="umbraco.loadUsers, umbraco" 
         iconClosed="icon-folder" iconOpen="icon-folder" sortOrder="0" />

The tree type should reference the assembly qualified type of the tree, for example the above user tree is of type: `umbraco.loadUsers, umbraco`. 

*NOTE: you don't need to specify the assembly version, etc...*

##[Trees in v7](trees-v7.md)

This section describes how to create trees with the v7 APIs.

*NOTE: trees created with the v6 APIs will still work in v7 but will not have angular view support.*

##[Trees in v6 (and v4)](trees-v6.md)

This section describes how to create trees with the v6 (and v4 APIs).