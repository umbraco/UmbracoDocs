---
description: >-
  Security has high priority on the Umbraco Cloud platform. Learn more about the
  different options and features related.
---

# Security

In this article you can find information about security on Umbraco Cloud.

## HTTPS & Certificates

All Umbraco Cloud websites use HTTPS by default. Both the default {projectName}.{region}.umbraco.io and custom domains are protected by periodically renewed certificates issued by Cloudflare. This service is offered as part of Umbraco Cloud for all plans.

### Custom Certificates

Custom certificates can be used with all custom domains. Please refer to our [Managing Custom Certificates documentation](../../../go-live/manage-hostnames/security-certificates.md).

### TLS support

As of April 2020, we've deprecated support for TLS 1.0 & TLS 1.1.

TLS 1.2 is now the default supported TLS protocol going forward.

On the Security page for your cloud project, you can change the default settings for both TLS and HTTP.

Learn more about how this in the [Manage Security](manage-security.md) article.

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

The different Ciphers can be enabled or disabled on the security project settings page for your Cloud projects.

<figure><img src="../../../.gitbook/assets/image (7) (1) (1).png" alt=""><figcaption><p>Enable or disable TLS Ciphers</p></figcaption></figure>

### HSTS - HTTP Strict Transport Security

It's possible to enforce HSTS: [HTTP Strict Transport Security](https://en.wikipedia.org/wiki/HTTP_Strict_Transport_Security) by adding the headers to your website. This grants Umbraco Cloud Websites an A+ security rating on sslabs (March 2020).

You can add the header by modifying system.webServer/rewrite/outboundRules section in your web.config:

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

Alternatively this can be done in Startup.cs inside of the **ConfigureServices** method with the following C#:

```csharp
public void ConfigureServices(IServiceCollection services)
        {
            services.AddUmbraco(_env, _config)
                .AddBackOffice()
                .AddWebsite()
                .AddComposers()
                .Build();

            services.AddHsts(options =>
            {
                options.MaxAge = TimeSpan.FromDays(730);
                options.IncludeSubDomains = true;
                options.Preload = true;
            });
        }
```

This adds the "Strict-Transport-Security" header telling browsers how long the browser should not make any HTTP requests to this domain. In this example 63072000 seconds or 730 days is two years.

### TLS 1.2 by default in external services

In order to integrate older external applications to access Umbraco Cloud Websites you might have to modify the TLS support in the .Net application.

For ASP.NET applications, inspect the `<system.web><httpRuntime targetFramework>` element of web.config to find the version of the .NET Framework your application is using. .NET applications on .NET 4.7+ are using the OS specified TLS protocols. In Windows 8 & 10, Windows Server 2012 & 2016 TLS 1.2+ is used by default, therefore no actions necessary. .NET applications lower then 4.7 require updates to ensure they can communicate using TLS 1.2 by default.

More information specifically from Microsoft about .Net applications and Transport Layer Security (TLS) support can be found [in Microsoft's official docs](https://docs.microsoft.com/en-us/dotnet/framework/network-programming/tls#audit-your-code-and-make-code-changes). For other application frameworks/languages we encourage to lookup their respective documentations.

### HTTP

Umbraco Cloud supports both HTTP2 and HTTP3 protocols.

### Ports

By default, all ports are closed to secure them against external attacks. This is done for all ports apart from 80 (HTTP) and 443 (HTTPS).

{% hint style="info" %}
Some scanning tools will report some other ports open due to Cloudflare's default support on those ports. However, all traffic on those ports is managed by Umbraco Cloud and never reaches your project. You can read more about the Cloudflare Network Ports in the [Cloudflare Documentation](https://developers.cloudflare.com/fundamentals/reference/network-ports/).
{% endhint %}

## Firewall & Restricting public access to Umbraco Cloud resources

Umbraco Cloud offers a multitude of features allowing you to block access to different resources.

* Basic Authentication allows access to the Backoffice & Frontend of Umbraco Cloud Websites for authenticated users only.

{% hint style="info" %}
Basic authentication will not be available for projects running Umbraco 9. It is available for Umbraco Cloud version 10 (and newer) versions, however, the users are currently unable to exclude IP addresses for authentication using the allowlist feature.
{% endhint %}

* IP based list allowing access to Frontend & Backoffice
* IP based list allowing access to website database

### Web Application Firewall

WAF is or can be enabled on the custom hostname(s) you add to your Umbraco Cloud project. [Learn more about how this feature works and helps to secure your websites](web-application-firewall.md).

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
