---
description: >-
  Learn how to enhance your website's analytics by adding the Umbraco Engage
  JavaScript file.
---

# Additional measurements with analytics scripts

You can add the Umbraco Engage Analytics JavaScript file to your website by placing this code before the closing `</body>` tag of your website.

```html
<script src="/Assets/Umbraco.Engage/Scripts/umbracoEngage.analytics.js"></script>
```

{% hint style="info" %}
The following client-side tracking script loading types are currently not supported: "async" or "defer".
{% endhint %}

When this file is included, Umbraco Engage sends the following data to the server before the visitor navigates to another page:

* **Scroll Depth**: Tracks the maximum scroll depth in both pixels and percentage of the page. For example, a user might scroll to 93% of the page height, which could equal 967 pixels.
* **Total Time on Page**: The total time on page is measured in milliseconds. It is defined as the time difference between the page load and the moment the user leaves the page.
* **Engaged Time on Page**: This measures the time the user is active on the page and in our opinion is more accurate than the total time on page. This script measures only the time when you are scrolling or clicking on the page in the active tab. It excludes idle time, such as when you are getting coffee or working in another tab. A 5-second grace period is used to define engagement. For more information, see [this blogpost](https://www.simoahava.com/analytics/track-content-engagement-via-gtm/).
* **Clicks Tracked**: All clicks to the following URLs are measured:
  * External domains
  * .pdf, .doc, or .docx document
  * An internal onpage link which is defined by an anchor link (#intro)
  * `mailto:` and `tel:` links

{% hint style="info" %}
If the filename remains unchanged, this file will be overwritten each time you update the Umbraco Engage to a newer version.
{% endhint %}
