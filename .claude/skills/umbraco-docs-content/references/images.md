# Images Reference

Full guidelines for adding images to Umbraco documentation.

## Storage and Paths

- Store images in an `images/` directory next to the `.md` file that references them
- Use **relative paths** in markdown references
- Each directory level has its own `images/` folder

### Directory Structure

```
/topic/
├── README.md
├── another-page.md
├── images/
│   ├── dashboard-overview.png
│   └── settings-panel.png
└── subtopic/
    ├── README.md
    ├── topic.md
    └── images/
        └── subtopic-screenshot.png
```

## Format Requirements

- **Maximum width**: 800px
- **Allowed formats**: `png`, `jpg`, `gif`, `svg`
- **Prohibited formats**: `bmp`, `tiff`, `swf`
- Use **SVG** for diagrams and icons (scalable)
- Use the most efficient compression available

## Naming

- Use **descriptive filenames**: `dashboard-view.png`, `content-tree-expanded.png`
- Do not use generic names: `image1.png`, `screenshot.png`
- Use **lowercase** and **hyphens** for spaces

## Markdown Syntax

### Simple image with caption
```markdown
![Content section overview](images/content-section-overview.png)
```

### HTML figure with alt text
```html
<figure><img src="images/sample.png" alt="The backoffice dashboard"></figure>
```

### HTML figure with alt text and caption
```html
<figure>
  <img src="images/sample.png" alt="The backoffice dashboard">
  <figcaption>
    <p>The backoffice dashboard after logging in.</p>
  </figcaption>
</figure>
```

When contributing via GitHub, prefer Markdown syntax over HTML.

## Best Practices

- Always provide **alt text or caption** describing the image content and purpose
- Avoid placing large amounts of text inside images — put the text in the article instead
- Optimize images for web to improve page load times
- Ensure screenshots are clear, cropped to relevant content, and up to date
