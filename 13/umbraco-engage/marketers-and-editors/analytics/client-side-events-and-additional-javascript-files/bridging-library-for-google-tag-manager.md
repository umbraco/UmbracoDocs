---
icon: square-exclamation
description: Learn how to bridge data between Google Tag Manager and Umbraco Engage.
---

# Bridging library for Google Tag Manager

When using Google Tag Manager you can collect all events already in Umbraco Engage. This is set up in the same way as [classic Google Analytics](../../../../../analytics/clientside-events-and-additional-javascript-files/bridging-library-for-google-analytics/).

To include the file add the following code before the closing `body` tag in your HTML:

```html
<script src="~/Assets/umbracoEngage/Scripts/umbracoEngage.analytics.ga-bridge.js"></script>
```
