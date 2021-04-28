---
versionFrom: 8.0.0
---
# CSS and Images

Our homepage is currently missing the CSS and image files. To include these files:

1. Navigate to the Umbraco installation directory and the template folder in File Explorer.
2. Copy the `css` and `images` folders from the template folder to the Umbraco installation directory.
    :::note
    For organizational purposes, place the CSS and images files in separate folders (`CSS` and `images`).
    :::
3. Using Chrome/Firefox/Edge Developer Tools, start your `http://localhost:xxxx.` The network tab should not report any missing css or images files. If it does, check for typos and if the files are in the right places.

---

## Next - [Outputting the Document Type Properties](../Outputting-the-Document-Type-Properties)

How to wire the Umbraco Document Type Properties into the templates, and output the editor's data in the right place.
