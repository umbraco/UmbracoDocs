# Asset Optimization

## Optimize Fonts

The fonts that we choose from a design point of view, can have an impact on the downloads required. If we opt for custom fonts, then these will need to be requested before rendering. The more custom fonts that we introduce the bigger the carbon impact. Therefore, it is recommended to use [system fonts by default](https://bitsofco.de/the-new-system-font-stack/).

If you wish to use custom fonts, then we need to think about how these are loaded. [WOFF2 is supported by all modern browsers](https://caniuse.com/woff2) and is the best format in terms of compression, resulting in better file sizes. You could also use only certain subsets and opt for self-hosting, reducing the dependency on a 3rd party and extra HTTP requests. Whilst Google Fonts is widely used, there are General Data Protection Regulation (GDPR) concerns too.

## Minify and Compress Assets

For a production build, we should be packaging up our assets. This way we can ensure these are minified to reduce their file size and number of requests needed from the user. We can also compress these using Gzip or Brotli to get them as optimized as possible.

## Cache Static Assets

Once we’ve ensured our assets are minified and compressed, we can also help the user by ensuring that these are denoted as cacheable assets. That can be done by [using ‘Cache-Control’](https://docs.umbraco.com/umbraco-cms/reference/response-caching) headers. These will then be cached by the browser on follow-up requests, reducing the downloads needed.

We can go one step further and [introduce service workers](https://css-tricks.com/serviceworker-for-offline/). That will opt to use these files first reducing the need for a network request and providing the added benefit of offline access.
