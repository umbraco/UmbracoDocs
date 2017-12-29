# Manage your project settings

When working with an Umbraco Cloud project you can handle a lot of the project configuration directly in the Umbraco Cloud Portal.

The things you can configure includes hostnames / domains, SSL certificates, database connections and deployment webhooks.

![settings](images/settings.jpg)

## Connection details

This is where you go to find connection details to your [Umbraco Cloud databases](../../Databases).

You will need to whitelist your IP in order to connect to the databases with your local machine - this can also be done from this page.

## Manage domains

When you've finished building your website with Umbraco Cloud you most likely want to bind a hostname to your project. This can be done from **Manage domains**.

You can bind any hostname to your project environments. Keeping in mind, of course, that the hostname will need to have a DNS entry so that it resolves to the Umbraco Cloud service.

You can bind a total of 15 hostnames to each of your Umbraco Cloud environments.

Once you add a domain to one of your environments make sure to update the hostname DNS entry to resolve to the umbraco.io service. We recommend setting an ALIAS record for your root domain (e.g. mysite.s1.umbraco.io), rather than an A record for the umbraco.io service IP address. Check with your DNS host or domain registrar for details on how to configure this for your domain. 

You will also need to add the hostnames to your root content node.

* Go to the Umbraco Backoffice
* *Right-click* the root content node
* Choose **Culture and Hostnames**
* Add your hostname
* Hit *Save*

### Hiding the Default umbraco.io Url

We create your project’s URL using the name you used when you created the project, and then we add _s1.umbraco.io_. 
If you named your project **Snoopy**, your project URL will be *snoopy.s1.umbraco.io* and your project’s Umbraco backoffice URL will be *snoopy.s1.umbraco.io/umbraco*. 
For the Development environment we prefix with *dev-* so the URLs will be *dev-snoopy.s1.umbraco.io* and *dev-snoopy.s1.umbraco.io/umbraco*. 
You'll find all environments for a project listed on the [Project page](../../Getting-started/The-Umbraco-Cloud-Portal/#project-management).

Once you've assigned a hostname to your Live environment you may want to "hide" the projects default URL (e.g. mysite.s1.umbraco.io) for various reasons. Perhaps for SEO or just making it clear to your users that the site can be accessed using just one hostname.

One approach for this is to add a add a new rewrite rule to the `<system.webServer><rewrite><rules>` section in the `web.config` file. For example, the following rule will redirect all requests for the projects mysite.s1.umbraco.io URL to the mysite.com URL and respond with a permanent redirect status.        
        
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

### Security Certificates

On the **Manage domains** page you'll also find option to upload and configure SSL certificates for your Cloud environments.

Your certificates need to be `.pfx` format and must be set to use a password. Each certificate can then be bound to a hostname you have already added to your site. Make certain you use the hostname you will bind the certificate to as the common name (CN) when generating the certificate.

#### Running your site on HTTPS only
Once you've applied a certificate to your site you can make sure that anybody visiting your site will always end up on HTTPS instead of the insecure HTTP.

To accomplish this, add a rewrite rule to the live environment's `web.config` in the `<system.webServer><rewrite><rules>` section. 

For example, the following rule will redirect all requests for the site http://mysite.com URL to the secure https://mysite.com URL and respond with a permanent redirect status. 

    <rule name="HTTP to HTTPS redirect" stopProcessing="true">
      <match url="(.*)" />
      <conditions>
        <add input="{HTTPS}" pattern="off" ignoreCase="true" />
        <add input="{HTTP_HOST}" pattern="localhost" negate="true" />
      </conditions>
      <action type="Redirect" url="https://{HTTP_HOST}/{R:1}" redirectType="Permanent" />
    </rule>        

**Note:** This redirect rule will not apply when the request is already going to the secure HTTPS URL. This redirect rule will also not apply on your local copy of the site running on `localhost`.

## Manage IP Whitelist

This is where you go to whitelist IP's for the basic authentication that's enabled on the Development and Staging environments. Simply add the IP's to the list on under the environment you want to open access to, and we'll take care of the rest!

If you are on a Trial plan, you can also whitelist IP's for bypassing the basic authentication on the Live environment - on paid projects the basic authentication will be disabled by default on the Live environment.

## Upgrade your project

From the *Settings* menu you'll find an option to easily upgrade your Umbraco Cloud Starter plan to a Professional plan.

The option will not be avaliable when you are already on a Professional plan or if you are running in Trial mode.

## Renaming and deleting

Sometimes you might want to rename your Umbraco Cloud project - find an option to do that from the *Settings* menu. 

**NOTE**: If you are working locally you need to make a fresh local clone of the project, once you’ve changed your project name.

If you want to delete your Umbraco Cloud project you can find an option to do this from the *Settings* menu as well. Deleting your Umbraco Cloud project is permanent - all data, media, databases, configuration, setup, and domain bindings are removed in the process.

**Note**: Deleting your Umbraco Cloud project will also cancel any subscriptions you have set up for your project.

## Deployment Webhook

On Umbraco Cloud projects we've made it possible to configure a deployment webhook on your environments. This will be triggered upon succesfull deployments, and you can configure where you want information about the deployment to be posted.

Read the [Deployment Webhook](../../Deployment/Deployment-webhook) article for more details on how to set this up.