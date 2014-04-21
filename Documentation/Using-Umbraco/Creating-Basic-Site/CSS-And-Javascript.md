#CSS and Javascript
21.  Looking at our homepage we’re obviously missing the CSS and JS from the Initializr template. To include this navigate to your Umbraco directory in Windows Explorer and copy over the **_css\style.css_** file into the **_Umbraco\Css_** folder (replace Umbraco with wherever your Umbraco instance is being served from – e.g. “_C:\inetpub\wwwroot_”. Now refresh your webpage in your browser and you’ll see a more styled page.

>NOTE – you could use the Umbraco UI to create your CSS file. **_Settings > Stylesheets_** > **_... > + Create_** and create a stylesheet called style (don’t add the file suffix .css) and paste the CSS in I find it easier to copy the CSS. Using either method should be noted does NOT include them in your HTML markup automatically – Umbraco produces clean output and this means you only wire up what you want and need. 
22.  Next copy the **_scripts_** folder from the **js** directory of the initializr template to the **_Umbraco\Scripts_** directory – we’ll have to update the template to look in **\Scripts** instead of **\j**s. To do this go to **_Settings > Templates > Homepage_** and change line 21 to say “_scripts/..._” and click **_Save_**.  

<script src="scripts/libs/modernizr-2.0.6.min.js"></script>

>NOTE – you can also use the UI interface to create your JS files too **_Settings > Scripts > ... > + Create_** (again don’t add the suffix but select .js from the **_Type_** dropdown) the reference in your template should be “_scripts/myfile.js_”. 
23.  Now in dev tools when looking at the http://localhost page you should find that the network tab doesn’t report any missing assets - if it does have a look and fix any typos / check the files are in the right places! 
