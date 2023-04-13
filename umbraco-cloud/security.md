# Security

In this article you can find information about security on Umbraco Cloud.

## HTTPS & Certificates

All Umbraco Cloud websites use HTTPS by default. Both the default {projectName}.{region}.umbraco.io and custom domains are protected by periodically renewed certificates issued by Cloudflare. This service is offered as part of Umbraco Cloud for all plans.

### Custom Certificates

Custom certificates can be used with all custom domains. Please refer to our [Managing Custom Certificates documentation](set-up/project-settings/manage-hostnames/security-certificates.md).

### TLS support

As of April 2020, we've deprecated support for TLS 1.0 & TLS 1.1.

TLS 1.2 is now the default supported TLS protocol going forward.

On the Security page for your cloud project you can change the default settings for both TLS and HTTP.

Learn more about how this in the [Manage Security](set-up/project-settings/manage-security.md) article.

### TLS Ciphers support

Umbraco Cloud Websites support the following TLS ciphers in this order:

* TLS\_ECDHE\_RSA\_WITH\_AES\_256\_CBC\_SHA384
* TLS\_ECDHE\_RSA\_WITH\_AES\_128\_CBC\_SHA256
* TLS\_ECDHE\_RSA\_WITH\_AES\_256\_CBC\_SHA
* TLS\_ECDHE\_RSA\_WITH\_AES\_128\_CBC\_SHA
* TLS\_DHE\_RSA\_WITH\_AES\_256\_GCM\_SHA384
* TLS\_DHE\_RSA\_WITH\_AES\_128\_GCM\_SHA256
* TLS\_DHE\_RSA\_WITH\_AES\_256\_CBC\_SHA
* TLS\_DHE\_RSA\_WITH\_AES\_128\_CBC\_SHA

### HSTS - HTTP Strict Transport Security

It's possible to enforce HTTP Strict Transport Security by adding the [HSTS](https://en.wikipedia.org/wiki/HTTP\_Strict\_Transport\_Security) headers to your website. This grants Umbraco Cloud Websites an A+ security rating on sslabs (March 2020). You can add the header by modifying system.webServer/rewrite/outboundRules section in your web.config:

```xml
 <outboundRules>
  <rule name="Add Strict-Transport-Security when HTTPS" enabled="true">
  <match serverVariable="RESPONSE_Strict_Transport_Security" pattern=".*" />
  <conditions>
   <add input="{HTTPS}" pattern="on" ignoreCase="true" />
   <add input="{HTTP_HOST}" pattern="localhost" negate="true" />
  </conditions>
  <action type="Rewrite" value="max-age=63072000; includeSubDomains; preload" />
  </rule>
 </outboundRules>
```

This adds the "Strict-Transport-Security" header that tells browsers: for the next 63072000 seconds (which is two years) the browser should not make any HTTP requests to this domain.

### TLS 1.2 by default in external services

In order to integrate older external applications to access Umbraco Cloud Websites you might have to modify the TLS support in the .Net application.

For ASP.NET applications, inspect the `<system.web><httpRuntime targetFramework>` element of web.config to find the version of the .NET Framework your application is using. .NET applications on .NET 4.7+ are using the OS specified TLS protocols. In Windows 8 & 10, Windows Server 2012 & 2016 TLS 1.2+ is used by default, therefore no actions necessary. .NET applications lower then 4.7 require updates to ensure they can communicate using TLS 1.2 by default.

More information specifically from Microsoft about .Net applications and TLS support can be found [in Microsofts official docs](https://docs.microsoft.com/en-us/dotnet/framework/network-programming/tls#audit-your-code-and-make-code-changes). For other application frameworks/languages we encourage to lookup their respective documentations.

### HTTP

HTTP protocol is supported but not used by default on Umbraco Cloud Websites. If you'd like to keep using HTTP, which we strongly discourage, you'll need to remove a web.config transform as specified in [Rewrite rules on Umbraco Cloud](set-up/project-settings/manage-hostnames/rewrites-on-cloud.md#running-your-site-on-https-only)

### Ports

By default, all ports are closed to secure them against external attacks. This is done for all ports apart from 80 (HTTP) and 443 (HTTPS).

## Firewall & Restricting public access to Umbraco Cloud resources

Umbraco Cloud offers a multitude of features allowing you to block access to different resources.

* Basic Authentication allows access to the Backoffice & Frontend of Umbraco Cloud Websites for authenticated users only.

{% hint style="info" %}
Basic authentication will not be available for projects running Umbraco 9. It is available for Umbraco Cloud version 10 (and newer) versions, however, the users are currently unable to exclude IP addresses for authentication using the allowlist feature.
{% endhint %}

* IP based list allowing access to Frontend & Backoffice
* IP based list allowing access to website database

## Cookies and security

On Umbraco Cloud sites, you will find an ARRAffinity cookie. This is not sent over HTTPS, and might to some, look like a security risk.

It is **not** a security risk. This cookie is set by the load balancer (LB) and only used by the LB to track which server your site is on. It is set by the software we use (Azure App Service) and only useful when your website is being scaled to multiple servers. In Umbraco Cloud we cannot scale your site to multiple servers so the cookie is effectively unused.

There is no vulnerable data in this cookie and manipulating or stealing this cookie can not lead to any security issues.

In the future, the cookie will be set to `HttpOnly` on Umbraco Cloud to conform to best practices. This does not mean that there's anything wrong with the current way it is set.

For more information see [the related GitHub issue](https://github.com/Azure/app-service-announcements/issues/12).

## Deny specific IPs from accessing your website

You can block people and bots(e.g. a malicious scanning bot) from accessing your website by adding their IP addresses to a deny-list.

The following rule can be added to your web.config file in the `system.webServer/rewrite/rules/` section.

```xml
<rule name="RequestBlockByIP" patternSyntax="Wildcard" stopProcessing="true">
    <match url="*"/>
    <conditions>
    <add input="{HTTP_CF_Connecting_IP}" negate="false" pattern="123.123.123.123"/>
    </conditions>
    <action type="AbortRequest"/>
</rule>
```

For anyone using the 123.123.123.123 IP, this will result in them getting a 502 error. You can choose your own error.

## Restrict backoffice access using IP filtering

It is possible to restrict who can access the Umbraco backoffice by applying an IP filter. When doing this on an Umbraco Cloud site, there are a few things to pay attention to as the backoffice URL is used in the deployment workflow.

The following rule can be added to your web.config file in the `system.webServer/rewrite/rules/` section.

Please note these two different variations, which differ if you have a reverse proxy like Cloudflare (with Proxying turned on) in front of the website.

{% hint style="info" %}
Since December 8th, 2020 all Umbraco Cloud sites uses Cloudflare for DNS, so new and updated projects should use the Reverse Proxy version.

If you are unsure whether your Cloud project uses Cloudflare or not, get in touch with the friendly support team, and they will help you out.
{% endhint %}

**Reverse Proxy version (eg. Cloudflare)**

When using Cloudflare, which is the default setup for all Cloud projects, the project will from behind a reverse proxy get the IPs from the `CF-Connecting-IP` header. In this case, which is most cases, use the first variation here to restrict access to your backoffice using IP filtering.

You can read more about the HTTP request headers coming from Cloudflare in the [Cloudflare Documentation.](https://developers.cloudflare.com/fundamentals/get-started/reference/http-request-headers/).

```xml
<rule name="Exluding Umbraco Deploy" enabled="true" stopProcessing="true">
  <match url="^(umbraco/umbracodeploy|umbraco/deploy|umbraco/backoffice/deploy/environment/)(.*)" ignoreCase="true" />
  <conditions logicalGrouping="MatchAll" trackAllCaptures="false"></conditions>
  <action type="None" />
</rule>
<rule name="Backoffice IP Filter excluding localhost" enabled="true" stopProcessing="true">
  <match url="(^umbraco/backoffice/(.*)|^umbraco($|/$))" />
  <conditions logicalGrouping="MatchAll" trackAllCaptures="false">

    <!-- Don't apply rules on localhost so your local environment still works -->
    <add input="{HTTP_HOST}" pattern="localhost" negate="true" />

    <!-- Custom IP list -->
    <add input="{HTTP_CF_Connecting_IP}" pattern="123.123.123.123" negate="true" />
  </conditions>
  <action type="CustomResponse" statusCode="403" />
</rule>
```

{% hint style="info" %}
In the first rule we exclude the Umbraco Deploy endpoints, so that all deployment and content transfers can still work.
{% endhint %}

**Non-Reverse Proxy (eg. non-Cloudflare)**

When your Cloud project is not using Cloudflare, your site gets the Remote IP address of the website visitor. In this case, you should use the second variation as shown below, when restricting access to your backoffice.

```xml
<rule name="Exluding Umbraco Deploy" enabled="true" stopProcessing="true">
  <match url="^(umbraco/umbracodeploy|umbraco/deploy|umbraco/backoffice/deploy/environment/)(.*)" ignoreCase="true" />
  <conditions logicalGrouping="MatchAll" trackAllCaptures="false"></conditions>
  <action type="None" />
</rule>
<rule name="Backoffice IP Filter excluding localhost" enabled="true" stopProcessing="true">
    <match url="(^umbraco/backoffice/(.*)|^umbraco($|/$))" />
    <conditions logicalGrouping="MatchAll" trackAllCaptures="false">
    
    <!-- Don't apply rules on localhost so your local environment still works -->
    <add input="{HTTP_HOST}" pattern="localhost" negate="true" />

    <!-- Custom IP list -->
    <add input="{REMOTE_ADDR}" pattern="123.123.123.123" negate="true" />
    </conditions>
    <action type="CustomResponse" statusCode="403" />
</rule>
```

What we're doing here is blocking all the requests to `umbraco/backoffice/` (while still allowing Umbraco Deploy to work)and all of the routes that start with this.

All of the Umbraco APIs use this route as a prefix, including Umbraco Deploy. So what we need to do first is to allow Umbraco Cloud to still be allowed to access the Deploy endpoints. That is achieved with the first 5 IP addresses, which are all specific to the servers we use for Umbraco Cloud.

You will notice that the regex `^umbraco/backoffice/(.*)|^umbraco` also stops people from going to `yoursite.com/umbraco`, so even the login screen will not show up. Even if you remove the `|^umbraco` part in the end, it should be no problem. You'll get a login screen but any login attempts will be blocked before they reach Umbraco. This is because the login posts to `umbraco/backoffice/UmbracoApi/Authentication/PostLogin`, e.g. it's using the backoffice URL.

The Autoupgrader on Umbraco Cloud needs to have access to the site to succesfully run the upgrade process and apply new patches, by adding these two IP's it ensures that the site is accessible and the autoupgrader can apply the newly released patches.

The last IP address is an example. You can add the addresses that your organization uses as new items to this list.

{% hint style="info" %}
It is possible to change the `umbraco/` route so if you've done that then you need to use the correct prefix. Doing this on Cloud is untested and at the moment not supported.
{% endhint %}
