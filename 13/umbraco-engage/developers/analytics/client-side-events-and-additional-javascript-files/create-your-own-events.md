---
description: Learn how to create and add custom events to Umbraco Engage.
---

# Create your own events

You can send custom client-side events to Umbraco Engage. An example could be tracking when a visitor clicks a specific button.

{% hint style="info" %}
Custom events require the Umbraco Engage Analytics script (`umbracoEngage.analytics.js`) to already be loaded on the page. See [Additional measurements with analytics scripts](additional-measurements-with-the-analytics-scripts.md) for how to add it.
{% endhint %}

This is done by executing JavaScript using the following format:

```js
umbEngage("send", "event", "<Category name>", "<Action>", "<Label>");
```

## Example: Tracking a button click

Say you want to track how many visitors click a "Sign up" button on your page. Attach the event call to the button's click handler:

```js
document.querySelector("#signUpButton").addEventListener("click", function () {
  umbEngage("send", "event", "Navigation", "Clicked", "Sign Up Button");
});
```

This sends an event with the category "**Navigation**", the action "**Clicked**", and the label "**Sign Up Button**" every time a visitor clicks the button.

{% hint style="info" %}
Umbraco Engage also sends some built-in events automatically, such as Google Analytics blocker detection. See [Google Analytics Blocker Detection](google-analytics-blocker-detection.md) for an example of a built-in event using this same format.
{% endhint %}

You can track all these events in the Events report of the Analytics section.

You can track all these events in the **Events** report of the **Analytics** section.
