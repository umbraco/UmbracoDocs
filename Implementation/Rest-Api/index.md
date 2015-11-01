#REST APIs in Umbraco

_Information about REST APIs in Umbraco_

##Creating your own

It is entirely possible and quite easy to create your own REST APIs for Umbraco by utilizing ASP.Net's WebApi in conjuntion with [Umbraco's UmbracoApiController's](../Controllers).

##Using an existing REST API platform

A free add-on for Umbraco 7.3+ has been built by the Umbraco HQ that gives you a nice REST API for working with content, media, members & relations.
The source code for this project lives at GitHub: [https://github.com/umbraco/UmbracoRestApi](https://github.com/umbraco/UmbracoRestApi)

It's Based on the [HAL specification](http://stateless.co/hal_specification.html) [(GitHub link)](https://github.com/mikekelly/hal_specification)
and is using a wonderful WebApi implementation of HAL which can be found on GitHub: [https://github.com/JakeGinnivan/WebApi.Hal](https://github.com/JakeGinnivan/WebApi.Hal).

### Installation

Installation can be done via Nuget:

	Install-Package UmbracoCms.RestApi

This package will also install another add-on for Umbraco called [Identity Extensions](https://github.com/umbraco/UmbracoIdentityExtensions).

Once installed, a readme is displayed with a snippet of code to enable the REST API. This can be done using OWIN startup classes and because the IdentityExtensions package has
been installed, a few classes have been added to your ~/App_Startup folder. The easiest way to enable the REST API is to copy the code snippet from the readme that
is displayed:


	app.ConfigureUmbracoRestApi(new UmbracoRestApiOptions()
	{
		//Modify the CorsPolicy as required
		CorsPolicy = new CorsPolicy()
            {
                AllowAnyHeader = true,
                AllowAnyMethod = true,
                AllowAnyOrigin = true
            }
	});

then open the file: `~/App_Startup/UmbracoStandardOwinStartup.cs`

and paste this snippet just underneath this line of code: `base.Configuration(app);`

If you would like to have the Umbraco back office cookie used to authenticate the REST API
you can add this line of code too:


	app.UseUmbracoCookieAuthenticationForRestApi(ApplicationContext.Current);

That's it, you've now enabled the REST API.

### Discovery

A great way to browse Umbraco's REST service is to use the great html/javascript [HAL Browser](https://github.com/mikekelly/hal-browser). The starting endpoints are:

/umbraco/rest/v1/content
/umbraco/rest/v1/media
/umbraco/rest/v1/members
/umbraco/rest/v1/relations

We will be enabling a single root endpoint that list these HAL links in the very near future!

### Security

Currently the REST API is secured based on back office user logins. In the future this will be enabled for front-end member logins and we'll allow for an easy
approach for configuring the security during startup/configuration of the REST API.

In the meantime, there are a couple of options for securing the REST API. The first (as mentioned above), is to enable cookie authentication for the REST API.
This is the same cookie authentication that is used to authenticate back office requests.
So, if you are using the REST API endpoints from within your application, then you can enable this by adding this line of code to your OWIN startup:


	app.UseUmbracoCookieAuthenticationForRestApi(ApplicationContext.Current);

The other approach is to authenticate the request using Bearer tokens. This is a requirement if you are consuming the REST API from outside of your domain.

**IMPORTANT**

_Since the REST API is currently only secured against back office user logins it is important to understand that if you want to use the REST API for applications
that exist outside of the web domain, that you do not hard code back office user login credentials. In the future when the security for the REST API can be more flexible
it would be advised to authenticate your apps based on a member's credentials that your app users would need to enter._

To enable token based authentication, see the file that has been installed at ~/App_Startup/UmbracoAuthTokenServerExtensions.cs which contains a lot of detail about
how to enable a token authentication server. In it's simplest form, this can be enabled with the following startup code:

	app.UseUmbracoBackOfficeTokenAuth();

There are plenty of options and extensibility points that can be set for the token auth server. The IdentityExtensions package installs these extension methods for you
which are based on ASP.Net conventions. For more info about tokens, authentication and authorization visit [ASP.Net's documentation](http://www.asp.net/aspnet/overview/owin-and-katana/owin-oauth-20-authorization-server).

Here's an example token request for the default endpoint that the above method creates:

	POST /umbraco/oauth/token HTTP/1.1
	Host: localhost
	Accept: application/json
	Content-Type: application/x-www-form-urlencoded

	grant_type=password&username=YOURUSERNAME&password=YOURPASSWORD

Of course you'll need to modify YOURUSERNAME and YOURPASSWORD with valid Umbraco user credentials.

The response will look something like:

	{
	  "access_token": "DUxMxH415liyvWcqtMQ9qMStu2rBGcWELRTlB1lUncAraw_xzyXUWmo2QNklI1YLlwQ_eliUV9x3t4MxJJ2lzraYlCGQIkKbzQ487G6vekbIPnaQ0mnEWwFBnSRK6bZa2CL_GdhTrlkMnrCDvhNjYh4U2lbvmAWuz8_23BIkH2K9G9JbVeTSnpk1o666fnITkbeLM602OSZqUT",
	  "token_type": "bearer",
	  "expires_in": 86399
	}

You can then use the value from `access_token` in the requests to the REST API endpoints, for example:

	GET /umbraco/rest/v1/content HTTP/1.1
	Host: localhost
	Accept: application/hal+json
	Content-Type: application/hal+json
	Authorization: Bearer DUxMxH415liyvWcqtMQ9qMStu2rBGcWELRTlB1lUncAraw_xzyXUWmo2QNklI1YLlwQ_eliUV9x3t4MxJJ2lzraYlCGQIkKbzQ487G6vekbIPnaQ0mnEWwFBnSRK6bZa2CL_GdhTrlkMnrCDvhNjYh4U2lbvmAWuz8_23BIkH2K9G9JbVeTSnpk1o666fnITkbeLM602OSZqUT
