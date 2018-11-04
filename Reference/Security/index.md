# Security

_This section includes information on Umbraco security, its various security options and configuring how authentication & authorization works in Umbraco_

## Umbraco Security overview

We have a dedicated security page on our main site which provides most of the details you may need to know about security within the Umbraco CMS including how to report a vulnerability: [https://umbraco.com/products/umbraco-cms/security/](https://umbraco.com/products/umbraco-cms/security/)

## SSL/HTTPS

We highly encourage the use of HTTPS on Umbraco websites especially in production environments. By using HTTPS you greatly improve the security of your website. There are several benefits of HTTPS:

* Trust - when your site is delivered over HTTPS your users will see that your site is secured, they are able to view the certificate assigned to your site and know that your site is legitimate
* Removing an attack vector called ["Man in the middle"](https://www.owasp.org/index.php/Man-in-the-middle_attack) (or network Sniffing)
* Guards against [Phishing](https://en.wikipedia.org/wiki/Phishing), an attacker will have a hard time obtaining an authentic SSL certificate
* Google likes HTTPS, it may help your site's rankings

Another benefits of HTTPS is that you are able to use the [http2](https://en.wikipedia.org/wiki/HTTP/2) protocol if your web server and browser support it.

__UseSSL configuration option__

Umbraco allows you to force SSL/HTTPS for all backoffice communications very easily but using the following appSettings configuration:

	<add key="umbracoUseSSL" value="true" />

This options does several things when it is turned on:

* Ensures that the backoffice authentication cookie is set to [secure only](https://www.owasp.org/index.php/SecureFlag) (so it can only be transmitted over https)
* All non-https requests to any backoffice controller is redirected to https
* All self delivered Umbraco requests (i.e. scheduled publishing, keep alive, etc...) are performed over https
* All Umbraco notification emails with links generated have https links
* All authorization attempts for backoffice handlers and services will be denied if the request is not over https

Once you enable HTTPS for your site you should redirect all requests to your site to HTTPS, this can be done with an IIS rewrite rule. The IIS rewrite module needs to be installed for this to work, most hosting providers will have that enabled by default.

In your `web.config` find or add the `<system.webServer><rewrite><rules>` section and put the following rule in there. This rule will redirect all requests for the site http://mysite.com URL to the secure https://mysite.com URL and respond with a permanent redirect status.

	<rule name="HTTP to HTTPS redirect" stopProcessing="true">
		<match url="(.*)" />
		<conditions>
			<add input="{HTTPS}" pattern="off" ignoreCase="true" />
			<add input="{HTTP_HOST}" pattern="localhost" negate="true" />
		</conditions>
		<action type="Redirect" url="https://{HTTP_HOST}/{R:1}" redirectType="Permanent" />
	</rule>        

Note that the rule includes an ignore for `localhost`. If you run your local environment on a different URL than `localhost` you can add additional ignore rules. Additionally, if you have a staging environment that doesn't run on HTTPS, you can add that to the ignore rules too.

## Backoffice users

Authentication for backoffice users in Umbraco uses [ASP.NET Identity](https://www.asp.net/identity) which is a very flexible and extensible framework for authentication.

Out of the box Umbraco ships with a custom ASP.NET Identity implementation which uses Umbraco's database data. Normally this is fine for most Umbraco developers
but in some cases the authentication process needs to be customized. ASP.NET Identity can be easily extended by using custom OAuth providers which is helpful if you want
your users to authenticate with a custom OAuth provider like Azure Active Directory, or even Google accounts. ASP.NET identity is also flexible enough for you to override/replace
any part of the process of authentication.

### Custom OAuth providers

The Umbraco backoffice supports custom OAuth providers for performing authentication of your users. For example: Any OpenIDConnect provider such as Azure Active Directory or Identity Server, Google, Facebook, Microsoft Account, etc...

To install and configure a custom OAuth provider you should use the Identity Extensions package: [https://github.com/umbraco/UmbracoIdentityExtensions](https://github.com/umbraco/UmbracoIdentityExtensions)

The installation of these packages will install snippets of code with readme files on how to get up and running. Depending on the provider you've configured and its caption/color, the end result will look similar to:

![OAuth login screen](images/google-oauth.png)

#### Auto-linking accounts for custom OAuth providers

Traditionally a backoffice user will need to exist first and then that user can link their user account to an OAuth account in the backoffice, however in many cases the identity server you choose will be the source of truth for all of your users.

In this case you would want to be able to create user accounts in your identity server and then have that user given access to the backoffice without having to create the user in the backoffice first. This is done via auto-linking.

Read more about [auto linking](auto-linking.md)

### Custom password check

You are able [check the username and password against your own credentials](custom-password-checker.md) store by implementing a new  `IBackOfficeUserPasswordChecker`.

### Authenticating with Active Directory credentials

Umbraco comes with a built-in `IBackOfficeUserPasswordChecker` for Active Directory: `Umbraco.Core.Security.ActiveDirectoryBackOfficeUserPasswordChecker`.

Remember to add the namespace `Umbraco.Core.Models.Identity` to resolve the `BackOfficeIdentityUser`.

To configure Umbraco to use `ActiveDirectoryBackOfficeUserPasswordChecker`, first install the [Umbraco Identity Extensibility](https://github.com/umbraco/UmbracoIdentityExtensions) package:

    Install-Package UmbracoCms.IdentityExtensions

Then modify `~/App_Start/UmbracoStandardOwinStartup.cs` to override `UmbracoStandardOwinStartup.Configuration` like so:

    public override void Configuration(IAppBuilder app)
    {
        // ensure the default options are configured
        base.Configuration(app);
        // active directory authentication

        var applicationContext = ApplicationContext.Current;
        app.ConfigureUserManagerForUmbracoBackOffice<BackOfficeUserManager, BackOfficeIdentityUser>(
            applicationContext,
            (options, context) =>
            {
                var membershipProvider = Umbraco.Core.Security.MembershipProviderExtensions.GetUsersMembershipProvider().AsUmbracoMembershipProvider();
		var settingContent = Umbraco.Core.Configuration.UmbracoConfig.For.UmbracoSettings().Content;
                var userManager = BackOfficeUserManager.Create(
                    options,
                    applicationContext.Services.UserService,
                    applicationContext.Services.EntityService,
                    applicationContext.Services.ExternalLoginService,
                    membershipProvider,
		    settingContent
                );
                userManager.BackOfficeUserPasswordChecker = new ActiveDirectoryBackOfficeUserPasswordChecker();
                return userManager;
            });
    }

The `ActiveDirectoryBackOfficeUserPasswordChecker` will look in appSettings for the name of your domain. Add this setting to Web.config:

    <appSettings>
        <add key="ActiveDirectoryDomain" value="mydomain.local" />
    </appSettings>

Finally, to use your `UmbracoStandardOwinStartup` class during startup, add this setting to Web.config:

    <appSettings>
        <add key="owin:appStartup" value="UmbracoStandardOwinStartup" />
    </appSettings>

If the active directory setup uses usernames instead of emails for authentication this will need configuring against the Umbraco user. This can be done in Umbraco back office under a specific user in user management by setting the name and Username to be the active directory username. Making Username visible for editing requires `usernameIsEmail` in umbracoSettings.config to be set to false:

	<usernameIsEmail>false</usernameIsEmail>

**Note:** if the username entered in the login screen does not already exist in Umbraco then `ActiveDirectoryBackOfficeUserPasswordChecker()` does not run.  Umbraco will fall back to the default authentication.

### Sensitive data

Marking fields as sensitive will hide the data in those fields for backoffice users that have no business viewing personal data of members.

In order to start marking fields as sensitive, you can add the users who need access to this data to the "Sensitive data" user group. In the User management sections go to Groups and choose the Sensitive data group.

![Sensitive data user group](images/sensitive-data-user-group.jpg)

From there on, add the users who need access to this data to this group.

![Update member type](images/update-member-type.png)

When a user in the backoffice does not have access to this data they get told so:

![Sensitive data hidden](images/sensitive-data-hidden.png)

Users who don't have access to sensitive data also do not have access to the "Export member" functionality on each member.

![Export member](images/export-member.png)



### [Setup Umbraco for a FIPS Compliant Server](Setup-Umbraco-for-a-Fips-Server/index.md)

How to configure Umbraco to run on a FIPS compliant server.

### [Security settings](Security-settings/index.md)

Some security settings that can be used in Umbraco.
