---
description: Learn more about recommendations when working with the Content Delivery Network.
---

# Content Delivert Network Recommendations

In this section you will find information and best-practices how to use a Content Delivery Network (CDN) in combination with uMarketingSuite.

## Pages (HTML)

You should not cache pages on CDN level. uMS is based on serving a unique page to every (returning) visitor. By enabling page caching every visitor will be assigned the same uMS ID and Analytics, A/B testing and Personalisation will not work correctly.

### Cache static files (CSS and JavaScript)

It is possible to cache static CSS and JavaScript files. Please refer to the documentation of the CDN provider for the best-practice setup.

### Media files (Umbraco /media folder, images and PDF's)

It is possible to cache `/media` files. Please refer to the documentation of the CDN provider for best-practice the setup.