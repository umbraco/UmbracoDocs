---
description: Learn how to bridge data between Google Tag Manager and Umbraco Engage.
---

# Bridging Library for Google Tag Manager

When using Google Tag Manager you can collect all events in Umbraco Engage. This is set up in the same way as the [Google Analytics](bridging-library-for-google-analytics.md) bridge.

To include the file add the following code before the closing `body` tag in your HTML:

```html
<script src="~/Assets/Umbraco.Engage/Scripts/umbracoEngage.analytics.ga4-bridge.min.js"></script>
```

{% hint style="info" %}
The "async" or "defer" Google Analytics bridging script loading types are currently not supported.
{% endhint %}
