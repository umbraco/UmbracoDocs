# Lazyload Resources

It’s possible that the assets that are within the context of your web page are not even visible to the user. It's therefore wasteful to load these resources. A technique is to add a lazy loading flag to images, videos, or iframes that are `below the fold`. They are only loaded when they enter the browser's viewport.

We can further expand this technique by loading assets based on user interaction. For example, if the video is visible but the user hasn't chosen to play it, there's no need to load its resources. By using `onclick` events, we can load only what’s needed when the user clicks the play button. This approach can also be applied to features like chatbots or external maps.
