---
icon: square-exclamation
description: Learn how to bridge data between Google Tag Manager and Umbraco Engage.
---

# Bridging Library for Google Tag Manager

When using Google Tag Manager you can collect all events in Umbraco Engage. This is set up in the same way as [classic Google Analytics](bridging-library-for-google-analytics.md).

To include the file add the following code before the closing `body` tag in your HTML:

```html
<script src="~/Assets/Umbraco.Engage/Scripts/umbracoEngage.analytics.ga-bridge.js"></script>
```
