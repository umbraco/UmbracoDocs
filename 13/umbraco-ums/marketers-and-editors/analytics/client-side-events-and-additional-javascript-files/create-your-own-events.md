# Create Your Own Events

You can send your own client-side events to uMS, for example if somebody pushes a button.

This can be done by executing JavaScript using the following format:

```js
ums("send", "event", "<Category name>", "<Action>", "<Label>");
```

The following example sends an event that tracks the category "**Tracking**", the action "**Blocked**" and the label "**Google Analytics**:

```js
ums("send", "event", "Tracking", "Blocked", "Google Analytics");
```

You can track all these events in the Events report of the Analytics section.
