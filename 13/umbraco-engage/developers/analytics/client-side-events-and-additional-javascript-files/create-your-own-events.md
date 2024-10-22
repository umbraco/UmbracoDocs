---
icon: square-exclamation
description: Learn how to create and add custom events to Umbraco Engage.
---

# Create your own events

You can send custom client-side events to Umbraco Engage. An example could be if somebody pushes a button.

This is done by executing JavaScript using the following format:

```js
umbEngage("send", "event", "<Category name>", "<Action>", "<Label>");
```

The following example sends an event that tracks the category "**Tracking**", the action "**Blocked**" and the label "**Google Analytics**":

```js
umbEngage("send", "event", "Tracking", "Blocked", "Google Analytics");
```

You can track all these events in the Events report of the Analytics section.
