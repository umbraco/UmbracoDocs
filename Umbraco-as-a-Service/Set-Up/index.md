#Set Up
Now that you've created a project there are a few things you may want to do to make working with your project easier. As you get ready to launch your live site there are some other considerations to take into account as well.

Most of the set up can be accomplished by using the options from your project's Settings drop down. Some of the setup applies to all of your projects, so you'll make these updates from your profile section.

#Project settings
![settings](images/settings.jpg)

##Naming a Project
This is a very personal choice of course. If you didn't manage to get just the right name the first time, you can always rename your project using the Settings > Rename project option. Heed the warnings before you do this.

Updating a project name will also update *all* of the project's Urls for the sites and the git repositories. That means that any links you have to the sites will be broken until you update them. *Fair warning, use with caution.*

##Deleting a Project
This does what it says. Once you've confirmed deletion of a project it is permanently removed as are all data, media, databases, configuration, setup, and domain bindings. So, make sure this is what you want.

##Domains (Hostname binding)
You can bind any hostname to your sites that you like. Keeping in mind, of course, that the hostname will need to have a DNS entry so that it resolves to the Umbraco as a Service service.

Once you add a domain here makes sure to update the hostame DNS entry to resolve to the umbraco.io service. We recommend setting an ALIAS record for your site's root domain (e.g. mysite.umbraco.io), rather than an A record for the umbraco.io service IP address. Check with your DNS host or domain registrar for details on how to configure this for your domain.

###Hiding the Default umbraco.io Url
Once you've assigned a hostname to your live site you may want to "hide" the site's default Url (e.g. mysite.umbraco.io) for various reasons. Perhaps for SEO or just making it clear to your users that the site can be accessed using just one hostname.

One approach for this is to add a redirect to your live site's web.config and to update the Deploy Url so you can still deploy to your live site. To accomplish this:

1. Add a redirect rule to the live site's web.config in the <system.webServer><httpRedirect> section. For example, the following rule will redirect all requests for the site's mysite.umbraco.io Url to the mysite.com Url and respond with a permanent redirect status.

        <add name="theoneurlredirect"
        redirect="Domain"
        ignoreCase="true" rewriteUrlParameter="IncludeQueryStringForRewrite"
        virtualUrl="https{0,1}://<your site name here>.umbraco.io/(.*)"
        redirectMode="Permanent"
        destinationUrl="http://<your actual domain here>.com/$1" />

2. Update the /Config/UmbracoDeploy.config entry in your staging site to use the updated Url for deployments. Note that you can make this update in your local clone or your umbraco.io development site then deploy it using the Portal to staging. For example, the updated entry would be as follows.

        <environment type="live" name="Live">http://mydomain.com</environment>

##SSL Certificates
You can apply SSL certificates to your live site by uploading them from the Manage Domains page. Your certificates need to be .pfx format and must be set to use a password. Each certificate can then be bound to a hostname you have already added to your site. Make certain you use the hostname you will bind the certificate to as the common name (CN) when generating the certificate.

##IP Whitelist
You can add specific IP addresses to the whitelist to automatically allow any client from these addresses to access your development or staging sites without the initial authorization dialog. This can reduce the amount of times you or your team wil need to enter your credentials in order to access your sites.

As with all things security related, make sure you use this feature judiciously as it will allow access to your Umbraco backoffice login page without requiring the initial authentication. Of course, the Umbraco backoffice will still require authentication.

#Profile Settings
![settings](images/profile.jpg)

###Name
The name that will be displayed on Umbraco as a Service

###Email
This email address is used for logging in to Umbraco as a Service and will receive email notifications from the portal.

###Change password
Change the password for your Umbraco as a Service account.

##Advanced settings

![Advanced settins](images/advanced.jpg)
###Timezones
From your profile settings you can set your timezone. This applies to the display of status messages in the Umbraco as a Service portal and makes it easier to determine the actual time a particular status was created.

###Experimental Features
You can enable the availability of experimental features for your projects. This includes features that may not be functionally complete and are not supported by Umbraco HQ. We recommend enabling this only if you fully understand the feature you will be using or are strictly using the project as a test.

####Other Set Up Topics
 - [Working with your site locally](Working-Locally/)
 - [Adding team members](Team-Members/)
 - [Working with Visual Studio](Visual-Studio/)
 - [Additional media topics](Media/)
