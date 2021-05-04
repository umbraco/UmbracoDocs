---
versionFrom: 7.0.0
---

# CSS and JavaScript

Looking at our homepage we’re missing the CSS and JavaScript from the Initializr template. To include these files navigate to the root of your website directory (e.g. "C:\inetpub\wwwroot" - this may be different depending on your installation type) in File Explorer. Here you copy over the `assets` and `images` folders from the Retrospect to the root of your site.

:::note
You could use the Umbraco UI to create your CSS file. **_Settings > Stylesheets_** > **_... > + Create_** and create a stylesheet called style (don’t add the file suffix .css) and paste the CSS in I find it easier to copy the CSS. Using either method should be noted does NOT include them in your HTML markup automatically – Umbraco produces clean output and this means you only wire up what you want and need.
:::

Next copy the **_scripts_** folder from the **js** directory of the Initializr template to the **_[your website root]\Scripts_** directory – we’ll have to update the template to look in **/Scripts** instead of **/js**. To do this go to **_Settings > Templates > Homepage_** and change line 21 to say “_scripts/..._” and click **_Save_**.

```js
<script src="scripts/libs/modernizr-2.0.6.min.js"></script>
```

:::note
You can also use the UI interface to create your JavaScript files too **_Settings > Scripts > ... > + Create_** (again don’t add the suffix but select .js from the **_Type_** dropdown) the reference in your template should be “_scripts/myfile.js_”.
:::

Now using Chrome Developer Tools or Firebug whilst browsing `http://localhost` you should find that the network tab doesn’t report any missing assets / files. If it does have a look and fix any typos / check the files are in the right places.

---

## Next - [Outputting the Document Type Properties](../Outputting-the-Document-Type-Properties/index-v7.md)

How to wire the Umbraco Document Type Properties into the templates to output the editor's data in the right place.
