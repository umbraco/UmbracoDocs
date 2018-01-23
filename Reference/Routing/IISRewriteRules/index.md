# IIS Rewrite Rules

If you require static rewrites you should use IIS Rewrite rules. This is an IIS plugin that exists outside of Umbraco 
but should be installed by the vast majority of hosting providers. [There is a significant amount of documentation](https://www.iis.net/learn/extensions/url-rewrite-module) 
for doing static rewrites with IIS Rewrite rules. This documentation will list some basic examples with links to some reference sites.

## Enabling the rules

By default the web.config with Umbraco (7.6+) will contain a commented out section that looks like:

    <!--
    If you wish to use IIS rewrite rules, see the documentation here: 
    https://our.umbraco.org/documentation/Reference/Routing/IISRewriteRules
    -->
    <!--
    <rewrite>
      <rules></rules>
    </rewrite>
    -->


If you wish to use the rules, be sure that you have the [IIS Rewrite Module](https://www.iis.net/learn/extensions/url-rewrite-module/using-the-url-rewrite-module) 
installed and uncomment the <rewrite> section. If you don't have the IIS Rewrite module installed, you will get a YSOD.

## Storing rules in an external file

You can store the rules in an external file if you with by using this syntax:

    <rewrite>
      <rules configSource="config\IISRewriteRules.config" />
    </rewrite>


and creating a file at `~/Config/IISRewriteRules.config` with the content:

    <rules></rules>


## Examples

* Main documentation: [https://www.iis.net/learn/extensions/url-rewrite-module](https://www.iis.net/learn/extensions/url-rewrite-module)
* A great site showing 10 very handy IIS Rewrite rules: [http://ruslany.net/2009/04/10-url-rewriting-tips-and-tricks/](http://ruslany.net/2009/04/10-url-rewriting-tips-and-tricks/)
* Another site showing some handy examples of IIS Rewrite rules: [http://odetocode.com/blogs/scott/archive/2014/03/27/some-useful-iis-rewrite-rules.aspx](http://odetocode.com/blogs/scott/archive/2014/03/27/some-useful-iis-rewrite-rules.aspx)
* If you needed to a lot of static rewrites using rewrite maps: [https://www.iis.net/learn/extensions/url-rewrite-module/rule-with-rewrite-map-rule-template](https://www.iis.net/learn/extensions/url-rewrite-module/rule-with-rewrite-map-rule-template)

For example, to always remove trailing slash from the URL:

    <rule name="Remove trailing slash" stopProcessing="true">  
      <match url="(.*)/$" />  
        <conditions>  
          <add input="{REQUEST_FILENAME}" matchType="IsFile" negate="true" />  
          <add input="{REQUEST_FILENAME}" matchType="IsDirectory" negate="true" />  
        </conditions>  
      <action type="Redirect" redirectType="Permanent" url="{R:1}" />  
    </rule>  

Another example would be to enforce HTTPS only on your site:

    <rule name="HTTP to HTTPS redirect" stopProcessing="true">
      <match url="(.*)" />
      <conditions>
        <add input="{HTTPS}" pattern="off" ignoreCase="true" />
        <add input="{HTTP_HOST}" pattern="localhost" negate="true" />
      </conditions>
      <action type="Redirect" url="https://{HTTP_HOST}/{R:1}" redirectType="Permanent" />
    </rule> 
