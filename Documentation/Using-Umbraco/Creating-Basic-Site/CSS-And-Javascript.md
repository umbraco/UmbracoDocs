#CSS and Javascript


Looking at our homepage we’re obviously missing the CSS and JS from the Initializr template. To include this navigate to the root of your website directory (e.g. "C:\inetpub\wwwroot" - this may be different depending on your installation type) in Windows Explorer and copy over the **_css\style.css_** file into the **_Umbraco\Css_** folder (replace Umbraco with wherever your Umbraco instance is being served from – e.g. “_C:\inetpub\wwwroot_”. Now refresh your webpage in your browser and you’ll see a more styled page.

>NOTE – you could use the Umbraco UI to create your CSS file. **_Settings > Stylesheets_** > **_... > + Create_** and create a stylesheet called style (don’t add the file suffix .css) and paste the CSS in I find it easier to copy the CSS. Using either method should be noted does NOT include them in your HTML markup automatically – Umbraco produces clean output and this means you only wire up what you want and need. 


Next copy the **_scripts_** folder from the **js** directory of the initializr template to the **_[your website root]\Scripts_** directory – we’ll have to update the template to look in **\Scripts** instead of **\js**. To do this go to **_Settings > Templates > Homepage_** and change line 21 to say “_scripts/..._” and click **_Save_**.  

```
<script src="scripts/libs/modernizr-2.0.6.min.js"></script>
```

>NOTE – you can also use the UI interface to create your JS files too **_Settings > Scripts > ... > + Create_** (again don’t add the suffix but select .js from the **_Type_** dropdown) the reference in your template should be “_scripts/myfile.js_”. 


Now using Chrome Developer Tools or Firebug whilst browsing http://localhost you should find that the network tab (or the equivalent) doesn’t report any missing assets / files - if it does have a look and fix any typos / check the files are in the right places. 

---

##Next - [Outputting the Document Type Properties](Outputting-the-Document-Type-Properties.md)
How to wire the Umbraco Document Type Properties into the templates to output the editor's data in the right place.