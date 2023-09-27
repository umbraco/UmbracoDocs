# Lazy load resources - images, videos, iframes

It’s possible that the assets that are within the context of your web page are not even visible to the user. It's therefore wasteful to load these resources. A technique for this that was introduced in recent years is to add a lazy loading flag to images, videos or iframes that are “below the fold”. By doing this they are only loaded when they come into the browsers viewport. 

Again, we can expand on this technique to only load assets based on interaction. So, whilst the video might be visible to the user they have not decided to play the video. There is then no need to load its resources. By introducing some ```onclick``` events, we can only load what’s necessary when the user clicks the play button. Other examples where this could be applied would be for chatbots or external maps.
