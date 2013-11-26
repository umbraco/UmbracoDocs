#Trees v6 (and v4)

This section describes how to work with and create trees with the v6 (and v4 APIs).

##Creating trees

*coming soon*

##ApplicationTree API v6

The application tree API in v6/v4 is found in the class `umbraco.BusinessLogic.ApplicationTree`. This API is used to control/query the storage for tree registrations in the ~/Config/trees.config file.

##Tree events v6

v6/v4 tree events are defined on the class: `umbraco.cms.presentation.Trees.BaseTree`

*NOTE: even though the events are defined on this class, it is up to the tree implementor to ensure the events are actually raised (this issue has been addressed with the new v7 tree APIs)*

The events are: `BeforeNodeRender`, `AfterNodeRender`, `BeforeTreeRender`, `AfterTreeRender`, `NodeActionsCreated`

It is not recommended to use the events BeforeTreeRender or AfterTreeRender since this will cause much higher performance spikes.





 