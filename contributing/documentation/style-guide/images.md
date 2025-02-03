---
description: >-
  Learn how to add images to the documentation.
---

# Images

Images should be stored in an `images` or `assets` directory next to the `.md` file referencing them, using relative paths. Use descriptive alt text and captions to ensure accessibility and Search Engine Optimization (SEO) benefits. Optimize images for the web to improve page load times.

## General Guidelines

* Maximum image width: **800px**.

* Supported formats: `png`, `jpg`, `gif` (use the most efficient compression available).

* Prohibited formats: `bmp`, `tiff`, `swf` (Flash)

## Folder Structure

If images are used, these must be stored in an `images` or `assets` directory next to the `.md` file referencing them using relative paths.

Maintain a clear and consistent directory structure:

```plaintext
/topic               # Main documentation directory
│── README.md        # Main content file
│── another-page.md  # Another markdown file
│── /images          # Image storage
│   ├── image1.png
│   ├── image2.jpg
│
└── /subtopic        # Subdirectory for related content
    │── README.md
    │── topic.md
    │── another-topic.md  
    │── /images      # Subdirectory for subtopic images
        ├── image3.png
```

## Adding images in Markdown

Use the following markdown syntax to insert images:

* Image with Caption

```markdown
![Caption](../images/sample.png)
```

* Image with Alt Text (Markdown/GitHub):

```markdown
![Alt text describing the image](images/img.png)
```

* Image with Alt Text (GitBook)

```html
<figure><img src="../images/sample.png" alt="The New Backoffice"></figure>
```

{% hint style="info" %}
Always provide alt text or a caption to describe the image’s purpose and content.
{% endhint %}

## Best Practices

* Use clear and relevant filenames. For example: dashboard-view.png instead of image1.png.
* Avoid excessive text in images. If text is necessary, provide a description above or below the image in the documentation.
* Use SVG format for diagrams and icons where possible to ensure scalability.
