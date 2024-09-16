# Content Delivert Network Recommendations

In this section you will find information and best-practices how to use a content delivery network (CDN) in combination with uMarketingSuite in your Umbraco installation.

### Pages (html)

You should not cache pages on CDN level. uMarketingSuite is based on serving a unique page to every (returning) visitor. By enabling page caching every visitor will be assigned the same uMarketingSuite ID and Analytics, A/B testing and Personalisation will not work correctly.

### Cache static files (CSS and javascript)

It is possible to cache static CSS and javascript files. Please refer to the documentation of the CDN provider for the best-practice setup.

### Media files (Umbraco /media folder, images and pdf's)

It is possible to cache /media files. Please refer to the documentation of the CDN provider for best-practice the setup.