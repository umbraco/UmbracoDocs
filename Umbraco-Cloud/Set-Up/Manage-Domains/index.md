# Managing domains and certificates

Under *Settings* in the Umbraco Cloud Portal, you'll find **Manage domains**. This is where you go when you want to bind domains to your Cloud environments and when you want to add security certificates to your environments.

## Domains

When you've finished building your website with Umbraco Cloud you most likely want to bind a hostname to your project. This can be done from **Manage domains**.

![Manage domains](images/manage-domains.png)

You can bind any hostname to your project environments. Keeping in mind, of course, that the hostname will need to have a DNS entry so that it resolves to the Umbraco Cloud service.

You can bind a total of 15 hostnames to each Umbraco Cloud environments.

Once you add a domain to one of your environments make sure to update the hostname DNS entry to resolve to the umbraco.io service. We recommend setting an ALIAS record for your root domain (e.g. mysite.s1.umbraco.io), rather than an A record for the umbraco.io service IP address. Check with your DNS host or domain registrar for details on how to configure this for your domain. 

You will also need to add the hostnames to your root content node.

* Go to the Umbraco Backoffice
* *Right-click* the root content node
* Choose **Culture and Hostnames**
* Add your hostname
* Hit *Save*

![Culture and Hostnames](images/culture-and-hostnames.png)

### Hiding the Default umbraco.io Url

We create your project’s URL based on the name of the project project, and then we add _s1.umbraco.io_. 
If you named your project **Snoopy**, your project URL will be *snoopy.s1.umbraco.io* and your project’s Umbraco backoffice URL will be *snoopy.s1.umbraco.io/umbraco*. 
For the Development environment we prefix with *dev-* so the URLs will be *dev-snoopy.s1.umbraco.io* and *dev-snoopy.s1.umbraco.io/umbraco*. 
You'll find all environments for a project listed on the [Project page](../../Getting-started/The-Umbraco-Cloud-Portal/#project-management).

Once you've assigned a hostname to your Live environment you may want to "hide" the projects default URL (e.g. mysite.s1.umbraco.io) for various reasons. Perhaps for SEO or just making it clear to your users that the site can be accessed using just one hostname.

One approach for this is to add a new rewrite rule to the `<system.webServer><rewrite><rules>` section in the `web.config` file. For example, the following rule will redirect all requests for the projects mysite.s1.umbraco.io URL to the mysite.com URL and respond with a permanent redirect status.        
        
    <rule name="Redirects umbraco.io to actual domain" stopProcessing="true">
      <match url=".*" />
      <conditions>
        <add input="{HTTP_HOST}" pattern="^(.*)?.s1.umbraco.io$" />
        <add input="{REQUEST_URI}" negate="true" pattern="^/umbraco" />
        <add input="{REQUEST_URI}" negate="true" pattern="localhost" />
      </conditions>
      <action type="Redirect" url="http://<your actual domain here>.com/{R:0}" 
              appendQueryString="true" redirectType="Permanent" />
    </rule>

**Note:** This will not rewrite anything under the `/umbraco` path so that you can still do content deployments. You don't have to give your editors the umbraco.io URL, and they won't see the umbraco.io URL if you give them the actual domain name. This rule will also not apply on your local copy of the site running on `localhost`.  
