# Image optimization

Images typically make up [42% of the Largest Contentful Paint](https://paulcalvano.com/2021-06-07-lcp-httparchive/) element for websites, being responsible for the largest over-the-wire transfer rates. We can reduce their size and deliver them with optimization in mind.

## Optimize before upload

It's important that we optimize these **before uploading** to our website. This results in a smaller footprint for a user to download, but also will use less computing to upload. Using tools such as [Squoosh](https://squoosh.app/) or resizing to an appropriate maximum expected size that the image will be displayed on the website will help reduce the overall emissions during the website lifetime.

## Use the best file format

We can make use of better image formats. It could be AV1 Image File Format (AVIF) and WebP to see 50% and 26% smaller file sizes than JPEGs respectively. AVIF is less well supported than WebP so it’s important to use a `<picture>` tag to ensure compatibility. You can read more about this in the [Using Modern Image Formats: AVIF And WebP](https://www.smashingmagazine.com/2021/09/modern-image-formats-avif-webp/) article.

The other benefit of using a `<picture>` tag is that we can denote which images to use based on screen size. This is helping us to provide the most appropriate image to the user, avoiding unnecessary downloads of larger images. 

There is a package available for Umbraco called [Slimsy](https://github.com/Jeavon/Slimsy) that makes setting this up easier, using the `GetCropUrl` method to match the crop settings that can be configured within Umbraco with [Image Cropper](https://docs.umbraco.com/umbraco-cms/v/12.latest/fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/image-cropper#sample-code).

## Consider using SVGs

For icons or illustrations, it's probable that these would be better suited to be included as an SVG compared to raster outputs (PNG, JPEG, WebP, AVIF, etc). These can also be [optimized](https://jakearchibald.github.io/svgomg/) and you can include them directly in the HTML to avoid additional requests. There is a tag helper `<our-svg>` for this included in a [community package](https://github.com/umbraco-community/Our-Umbraco-TagHelpers?tab=readme-ov-file#our-svg) for Umbraco, which reads the file contents of an SVG file and outputs it as an inline SVG in the DOM.

However, if your SVG is fairly complex, then it would still likely be a smaller size in another image format. It's important to test for your use case to ensure the smallest file size.

## Image delivery

Other options when it comes to image optimization could be to use **external services**. It could be to provide a Content Delivery Network (CDN) to deliver images at the edge with good optimization and caching in place. Cloudflare and Cloudinary are examples of these. 

For Cloudflare specifically, there is a package available for Umbraco called [CloudflareImageUrlGenerator
](https://github.com/Jeavon/CloudflareImageUrlGenerator) that offloads image format conversion of AVIF and WebP formats to Cloudflare Image Resizing. This can also be combined with Slimsy.
