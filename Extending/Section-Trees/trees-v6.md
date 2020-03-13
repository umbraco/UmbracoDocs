---
versionFrom: 6.0.0
versionRemoved: 7.0.0
---

# Trees

Trees are also in a [config file located: `~/Config/trees.config`](../../Reference/Config/trees/index.md). Each config item defines a tree and for what section it belongs to. For example, this is the definition of the user tree:

```xml
<add application="users" alias="users" title="Users"
        type="umbraco.loadUsers, umbraco"
        iconClosed="icon-folder" iconOpen="icon-folder" sortOrder="0" />
```

The tree type should reference the assembly qualified type of the tree, for example the above user tree is of type: `umbraco.loadUsers, umbraco`.

:::note
You don't need to specify the assembly version, etc...
:::

# Trees v6 (and v4)

This section describes how to work with and create trees with the v6 (and v4 APIs).

## ApplicationTree API v6

The application tree API in v6/v4 is found in the class `umbraco.BusinessLogic.ApplicationTree`. This API is used to control/query the storage for tree registrations in the ~/Config/trees.config file.

## Tree events v6

v6/v4 tree events are defined on the class: `umbraco.cms.presentation.Trees.BaseTree`

:::note
Even though the events are defined on this class, it is up to the tree implementor to ensure the events are raised (this issue has been addressed with the new v7 tree APIs)
:::

The events are: `BeforeNodeRender`, `AfterNodeRender`, `BeforeTreeRender`, `AfterTreeRender`, `NodeActionsCreated`

It is not recommended to use the events BeforeTreeRender or AfterTreeRender since this will cause much higher performance spikes.






