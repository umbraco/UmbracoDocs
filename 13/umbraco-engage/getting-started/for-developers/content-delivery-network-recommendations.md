---
description: >-
  Learn more about recommendations when working with the Content Delivery
  Network.
---

# Content Delivery Network recommendations

This article provides information and best practices on using Content Delivery Network (CDN)  with Umbraco Engage.

## Pages (HTML)

Do not cache pages on the CDN level. Umbraco Engage is based on serving a unique page to every (returning) visitor. By enabling page caching every visitor will be assigned the same Umbraco Engage ID and Analytics, A/B testing, and Personalisation will not work correctly.

### Cache static files (CSS and JavaScript)

It is possible to cache static CSS and JavaScript files. Refer to the documentation of the CDN provider for the best-practice setup.

### Media files (Umbraco /media folder, images, and PDFs)

It is possible to cache `/media` files. Refer to the documentation of the CDN provider for best-practice setup.
