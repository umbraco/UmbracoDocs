---
versionFrom: 8.0.0
---
# CSS and JavaScript

Looking at our homepage, we’re missing the CSS and JavaScript files from the Retrospect template. To include these files navigate to the root of your website directory (e.g. "C:\inetpub\wwwroot" - this may be different depending on your installation type) in File Explorer. Here you copy over the `assets` and `images` folders from the Retrospect to the root of your site.

:::note
For organizational purposes, you would place the CSS and JavaScript files in separate folders (`CSS` and `JavaScript`) to make your project nice and tidy, but for now, we will go with the quick option.
:::

Now using Chrome/Firefox/Edge Developer Tools whilst browsing `http://localhost` you should find that the network tab doesn’t report any missing assets/files. If it does, have a look and fix any typos, and check if the files are in the right places.

---

## Next - [Outputting the Document Type Properties](../Outputting-the-Document-Type-Properties)

How to wire the Umbraco Document Type Properties into the templates, and output the editor's data in the right place.
