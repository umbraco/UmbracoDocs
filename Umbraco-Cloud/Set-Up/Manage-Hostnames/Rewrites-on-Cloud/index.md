# Rewrite rules on Umbraco Cloud

To make rewrite rules on Umbraco Cloud as seamless as possible, we've installed the [IIS Rewrite Module](https://our.umbraco.com/Documentation/Reference/Routing/IISRewriteRules/) on all our Umbraco Cloud servers.

The rewrite rules should be added to the `<system.webServer><rewrite>` module in your projects `Web.config` file.

    <!--
    If you wish to use IIS rewrite rules, see the documentation here: 
    https://our.umbraco.com/documentation/Reference/Routing/IISRewriteRules
    -->

    <!--
    <rewrite>
        <rules></rules>
    </rewrite>
    -->


## Best practices

When you are doing rewrite rules on Umbraco Cloud there are a few important things to keep in mind:

- Always make sure that you add a condition that negates the Umbraco Backoffice - `/umbraco`, otherwise you will not be able to do deployments to/from the environment
- To be able to continue working locally with your Umbraco Cloud project, you also need to add a condition that negates `localhost`

## Hiding the Default umbraco.io Url

Once you've assigned a hostname to your Live environment you may want to "hide" the projects default URL (e.g. mysite.s1.umbraco.io) for various reasons. Perhaps for SEO or just making it clear to your users that the site can be accessed using just one hostname.

One approach for this is to add a new rewrite rule to the `<system.webServer><rewrite><rules>` section in the `web.config` file. For example, the following rule will redirect all requests for the projects mysite.s1.umbraco.io URL to the mysite.com URL and respond with a permanent redirect status.        
        
    <rule name="Redirects umbraco.io to actual domain" stopProcessing="true">
      <match url=".*" />
      <conditions>
        <add input="{HTTP_HOST}" pattern="^(.*)?.s1.umbraco.io$" />
        <add input="{REQUEST_URI}" negate="true" pattern="^/umbraco" />
        <add input="{REQUEST_URI}" negate="true" pattern="^/DependencyHandler.axd" />
        <add input="{REQUEST_URI}" negate="true" pattern="^/App_Plugins" />
        <add input="{REQUEST_URI}" negate="true" pattern="localhost" />
      </conditions>
      <action type="Redirect" url="http://<your actual domain here>.com/{R:0}" 
              appendQueryString="true" redirectType="Permanent" />
    </rule>

**Note:** This will not rewrite anything under the `/umbraco` path so that you can still do content deployments. You don't have to give your editors the umbraco.io URL, and they won't see the umbraco.io URL if you give them the actual hostname. This rule will also not apply on your local copy of the site running on `localhost`.

## Running your site on HTTPS only

Once you've applied a certificate to your site you can make sure that anybody visiting your site will always end up on HTTPS instead of the insecure HTTP.

To accomplish this, add a rewrite rule to the live environment's `web.config` in the `<system.webServer><rewrite><rules>` section. 

For example, the following rule will redirect all requests for the site http://mysite.com URL to the secure https://mysite.com URL and respond with a permanent redirect status. 

    <rule name="HTTP to HTTPS redirect" stopProcessing="true">
      <match url="(.*)" />
      <conditions>
        <add input="{HTTPS}" pattern="off" ignoreCase="true" />
        <add input="{HTTP_HOST}" pattern="localhost" negate="true" />
        <add input="{REQUEST_URI}" negate="true" pattern="^/.well-known/acme-challenge" />
      </conditions>
      <action type="Redirect" url="https://{HTTP_HOST}/{R:1}" redirectType="Permanent" />
    </rule>        

**Note:** This redirect rule will not apply when the request is already going to the secure HTTPS URL. This redirect rule will also not apply on your local copy of the site running on `localhost`.
