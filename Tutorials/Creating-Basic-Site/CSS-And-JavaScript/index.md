---
versionFrom: 8.0.0
---
# CSS and JavaScript

Looking at our homepage, we’re missing the CSS and image files. To include these files, navigate to the Umbraco installation directory (e.g. "C:\inetpub\wwwroot" - this may be different depending on your installation type) in File Explorer. Copy over the `css` and `images` folders from the Retrospect template folder to the root of your site (Umbraco installation directory).

:::note
For organizational purposes, place the CSS and images files in separate folders (`CSS` and `images`).
:::

Now using Chrome/Firefox/Edge Developer Tools whilst browsing `http://localhost` you should find that the network tab doesn’t report any missing assets/files. If it does, have a look and fix any typos, and check if the files are in the right places.

---

## Next - [Outputting the Document Type Properties](../Outputting-the-Document-Type-Properties)

How to wire the Umbraco Document Type Properties into the templates, and output the editor's data in the right place.
