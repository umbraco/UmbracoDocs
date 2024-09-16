# Create Your Own Events

You can send your own client side events to the uMarketingSuite as well, for example if somebody pushes a button. 

This can be done by executing the following javascript-call that has the following syntax:

    ums("send", "event", "<Category name>", "<Action>", "<Label>");

For example the following call sends an event to the uMarketingSuite that tracks the category "**Tracking**", the action "**Blocked**" and the label "**Google Analytics**:

    ums("send", "event", "Tracking", "Blocked", "Google Analytics");

You can track all these events in the Events report of the Analytics section.