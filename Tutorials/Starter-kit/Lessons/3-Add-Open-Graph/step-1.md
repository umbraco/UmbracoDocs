# Add Open Graph - Step 1
Adding support for Open Graph can be done in many ways. In this lesson we'll create a reusable set of properties we can add to specific page types. First we need to see what the expected outcome will be. Open Graph for web pages needs to contain at least the following:

    <meta property="og:title" content="{Page or site title}" />
    <meta property="og:type" content="website" />
    <meta property="og:url" content="{URL to the content item}" />
    <meta property="og:image" content="{URL to the open graph image}" />

Looking at the above we can pull a couple of things out automatically and then add ways to input the rest. In this lesson we'll only add Open Graph Content of the type "website", so we don't need an input for that. We can also get the URL for the page we are currently on. This leaves us with two remaining properties to add: title and image.

### Create a document type composition

1. Go to the **Settings** section
2. Right-click on **Document Types**
3. Create a new **Document Type without a template**
3. Name the Document Type *Open Graph*
4. Create a tab called *Open Graph*
5. Add a property to the tab called *Open Graph Title*
6. Click **Choose editor**, search for *textstring* and add this to the tab.
7. Add another property named *Open Graph Image* and use the **Media Picker** editor.
8. Save the document type by clicking **Save** in the lower right corner.

[Previous](index.md) - [Next](step-2.md)
