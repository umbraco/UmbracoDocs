# Image optimization

Images typically make up [42% of the Largest Contentful Paint](https://paulcalvano.com/2021-06-07-lcp-httparchive/) element for websites. It's therefore vital that we optimize these before uploading to our website. This results in a smaller footprint for a user to download, but also will use less computing to upload.&#x20;

We can make use of better image formats. It could be AV1 Image File Format (AVIF) and WebP to see 50% and 26% smaller file sizes than JPEGs respectively. AVIF is less well supported than Webp so it’s important to use a **picture tag** to ensure compatibility. You can read more about this in the [Using Modern Image Formats: AVIF And WebP](https://www.smashingmagazine.com/2021/09/modern-image-formats-avif-webp/) article.

The other benefit of using a picture tag is that we can denote which images to use based on screen size. This is helping us to provide the most appropriate image to the user.

Other options when it comes to image optimization could be to use **external services**. It could be to provide a Content Delivery Network (CDN) to deliver images at the edge with good optimization and caching in place. Cloudflare and Cloudinary are examples of these.&#x20;
