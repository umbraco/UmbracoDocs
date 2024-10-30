---
icon: square-exclamation
description: This article describes what data is tracked from videos on your website.
---

# Video tracking

Umbraco Engage gathers video statistics for the following types of videos:

* HTML5 videos (videos provided via the `<video>` element)
* Embedded YouTube videos

{% hint style="info" %}
Make sure the embed URL contains `?enablejsapi=1` as part of the full URL to enable tracking. The `src` property of the iframe should be something like: `https://www.youtube.com/embed/&lt;CODE&gt;?enablejsapi=1`.

The [https://www.youtube.com/iframe\_api](https://www.youtube.com/iframe\_api) is loaded for this purpose.
{% endhint %}

* Embedded Vimeo videos

{% hint style="info" %}
The [https://player.vimeo.com/api/player.js](https://player.vimeo.com/api/player.js) is loaded for this purpose.
{% endhint %}

Make sure you have installed the Umbraco Engage [analytics JavaScript file](client-side-events-and-additional-javascript-files/additional-measurements-with-the-analytics-scripts.md).
