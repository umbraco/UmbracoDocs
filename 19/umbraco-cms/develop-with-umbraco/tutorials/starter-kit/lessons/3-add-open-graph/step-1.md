# Add Open Graph - Step 1

Adding support for Open Graph can be done in many ways. In this lesson, we'll create a reusable set of properties we can add to specific page types.

First we need to see what the expected outcome will be. Open Graph for web pages needs to contain at least the following:

```html
<meta property="og:title" content="{Page or site title}" />
<meta property="og:type" content="website" />
<meta property="og:url" content="{URL to the content item}" />
<meta property="og:image" content="{URL to the open graph image}" />
```

Looking at the above we can pull a couple of things out automatically and then add ways to input the rest.

In this lesson, we'll only add Open Graph Content of the type "website", so we don't need input for that. We can also get the URL for the page we are currently on. This leaves us with two remaining properties to add: title and image.

## Create a document type composition

1. Go to the **Settings** section.
2. Click on **Document Types**.
3. Select **Create** > **Document Type**.
4. Name the Document Type *Open Graph*.
5. Click **Add Group** and name it *Open Graph*.
6. **Add a property** to the group called *Open Graph Title*.
7. Select **Select property editor** and search for *textstring*.
8. Click **Add**.
9. Add another property named *Open Graph Image* and use the **Media Picker** as the editor.
10. Click **Add**.
11. Click **Save**.
