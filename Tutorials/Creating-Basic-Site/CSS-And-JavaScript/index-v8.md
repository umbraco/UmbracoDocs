---
versionFrom: 8.0.0
---
# CSS and JavaScript

Looking at our homepage we’re obviously missing the CSS and JavaScript from the Retrospect template. To include this navigate to the root of your website directory (e.g. "C:\inetpub\wwwroot" - this may be different depending on your installation type) in Windows Explorer and copy over the `assets` and `images` folders from the Retrospect to the root of your site.

:::note
Normally you would place css in a `Css` folder and javascript in a `Scripts` folder, but for now we will go with the quick option.
:::

Now using Chrome Developer Tools or Firebug whilst browsing http://localhost you should find that the network tab (or the equivalent) doesn’t report any missing assets / files - if it does have a look and fix any typos / check the files are in the right places. 

---

## Next - [Outputting the Document Type Properties](Outputting-the-Document-Type-Properties/index-v8.md)
How to wire the Umbraco Document Type Properties into the templates to output the editor's data in the right place.
