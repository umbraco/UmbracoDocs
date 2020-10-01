---
versionFrom: 7.0.0
---

# Security on Umbraco Cloud

In this article you can find information about security on Umbraco Cloud. 

## HTTPS & Certificates

All Umbraco Cloud websites use HTTPS by default. Both the default {projectName}.s1.umbraco.io and custom domains are protected by periodically renewed certificates from Let's Encrypt. This service is offered as part of Umbraco Cloud by [Umbraco LATCH](../Set-Up/Umbraco-Latch).

### Custom Certificates

Custom certificates can be used with all custom domains. Please refer to our [Managing Custom Certificates documentation](../Set-Up/Manage-Hostnames/Security-Certificates).

### TLS support

As of April 2020, we've deprecated support for TLS 1.0 & TLS 1.1.

TLS 1.2 is now the default supported TLS protocol going forward.

Umbraco 8 sites are using the TLS 1.2 protocol by default. Umbraco 7 sites, due to running on an older .NET framework 4.5.2, have been updated to TLS 1.2.

### TLS Ciphers support

Umbraco Cloud Websites support the following TLS ciphers in this order:

- TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
- TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256
- TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA
- TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA
- TLS_DHE_RSA_WITH_AES_256_GCM_SHA384
- TLS_DHE_RSA_WITH_AES_128_GCM_SHA256
- TLS_DHE_RSA_WITH_AES_256_CBC_SHA
- TLS_DHE_RSA_WITH_AES_128_CBC_SHA

### HSTS - HTTP Strict Transport Security

It's possible to enforce HTTP Strict Transport Security by adding the [HSTS](https://en.wikipedia.org/wiki/HTTP_Strict_Transport_Security) headers to your website. This grants Umbraco Cloud Websites an A+ security rating on sslabs (March 2020). You can add the header by modifying system.webServer/rewrite/outboundRules section in your web.config:

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

HTTP protocol is supported but not used by default on Umbraco Cloud Websites. If you'd like to keep using HTTP, which we strongly discourage, you'll need to remove a web.config transform as specified in [Umbraco LATCH documentation](../Set-Up/Umbraco-Latch)

## Firewall & Restricting public access to Umbraco Cloud resources

Umbraco Cloud offers a multitude of features allowing you to block access to different resources.
- Basic Authentication allowing access to Backoffice & Frontend of Umbraco Cloud Websites only for authenticated users.
- IP based list allowing access to Frontend & Backoffice
- IP based list allowing access to website database

## Cookies and security

On all Umbraco Cloud sites, you will find an ARRAffinity cookie. This is not sent over HTTPS, and might to some, look like a security risk.

It is **not** a security risk. This cookie is set by the load balancer (LB) and only used by the LB to track which server your site is on. It is set by the software we use (Azure Pack) and only useful when your website is being scaled to multiple servers. In Umbraco Cloud we cannot scale your site to multiple servers so the cookie is effectively unused.

There is no vulnerable data in this cookie and manipulating or stealing this cookie can not lead to any security issues.

In the future, the cookie will be set to `HttpOnly` on Umbraco Cloud to conform to best practices. This does not mean that there's anything wrong with the current way it is set.

For more information see [the related GitHub issue](https://github.com/Azure/app-service-announcements/issues/12).

## Restrict backoffice access using IP filtering

It is possible to restrict who can access the Umbraco backoffice by applying an IP filter. When doing this on an Umbraco Cloud site, there are a few things to pay attention to as the backoffice URL is used in the deployment workflow.

The following rule can be added to your web.config file in the `system.webServer/rewrite/rules/` section.

```xml
<rule name="Backoffice IP Filter" enabled="true">
    <match url="(^umbraco/backoffice/(.*)|^umbraco($|/$))"/>
    <conditions logicalGrouping="MatchAll">

        <!-- Umbraco Cloud to Cloud connections should be allowed -->
        <add input="{REMOTE_ADDR}" pattern="52.166.147.129" negate="true" />
        <add input="{REMOTE_ADDR}" pattern="13.95.93.29" negate="true" />
        <add input="{REMOTE_ADDR}" pattern="40.68.36.142" negate="true" />
        <add input="{REMOTE_ADDR}" pattern="13.94.247.45" negate="true" />
        <add input="{REMOTE_ADDR}" pattern="52.157.96.229" negate="true" />

        <!-- Don't apply rules on localhost so your local environment still works -->
        <add input="{HTTP_HOST}" pattern="localhost" negate="true" />
        
        <!-- Allow the  Umbraco Cloud Autoupgrade to access the site -->
         <add input="{REMOTE_ADDR}" pattern="52.232.105.169" negate="true" />
         <add input="{REMOTE_ADDR}" pattern="52.174.66.30" negate="true" />

        <!-- Add other client IPs that need access to the backoffice -->
        <add input="{REMOTE_ADDR}" pattern="123.123.123.123" negate="true" />
       
    </conditions>
    <action type="CustomResponse" statusCode="403"/>
</rule>
```

What we're doing here is blocking all the requests to `umbraco/backoffice/` and all of the routes that start with this.

All of the Umbraco APIs use this route as a prefix, including Umbraco Deploy. So what we need to do first is to allow Umbraco Cloud to still be allowed to access the Deploy endpoints. That is achieved with the first 5 IP addresses, which are all specific to the servers we use for Umbraco Cloud.

You will notice that the regex `^umbraco/backoffice/(.*)|^umbraco` also stops people from going to `yoursite.com/umbraco`, so even the login screen will not show up. Even if you remove the `|^umbraco` part in the end, it should be no problem. You'll get a login screen but any login attempts will be blocked before they reach Umbraco. This is because the login posts to `umbraco/backoffice/UmbracoApi/Authentication/PostLogin`, e.g. it's using the backoffice URL.

The Autoupgrader on Umbraco Cloud needs to have access to the site to succesfully run the upgrade process and apply new patches, by adding these two IP's it ensures that the site is accessible and the autoupgrader can apply the newly released patches.

The last IP address is an example. You can add the addresses that your organization uses as new items to this list.

:::note
It is possible to change the `umbraco/` route so if you've done that then you need to use the correct prefix. Doing this on Cloud is untested and at the moment not supported.
:::
