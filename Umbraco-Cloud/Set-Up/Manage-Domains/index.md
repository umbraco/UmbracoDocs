# Managing domains

When you create an Umbraco Cloud project we create the project URLs based on the name you give your project. 

Let's say you have a project named `Snoopy`. These will be the default domains:

* Umbraco Cloud Portal: *www.s1.umbraco.io/project/snoopy*
* Live site: *snoopy.s1.umbraco.io*
* Development environment: *dev-snoopy.s1.umbraco.io*
* Staging environment: *stage-snoopy.s1.umbraco.io*

To access the backoffice, simply add `/umbraco` to the end of the Live, Development or Staging domain.

## Domains

Under *Settings* in the Umbraco Cloud Portal, you'll find **Manage domains**. This is where you go when you want to bind domains to your Cloud environments and when you want to add security certificates to your environments.

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

**Note:** This will not rewrite anything under the `/umbraco` path so that you can still do content deployments. You don't have to give your editors the umbraco.io URL, and they won't see the umbraco.io URL if you give them the actual domain name. This rule will also not apply on your local copy of the site running on `localhost`. Read more about best practices and rewrites in the [Rewrites on Umbraco Cloud](Rewrites-on-Cloud) article.

## [Security Certificates](Security-Certificates)

## [Rewrites on Umbraco Cloud](Rewrites-on-Cloud)
