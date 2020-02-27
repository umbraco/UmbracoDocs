# Security on Umbraco Cloud

## HTTPS & Certificates

All Umbraco Cloud websites use HTTPS by default. Both the default {projectName}.s1.umbraco.io and custom domains are protected by periodically renewed certificates from Let's Encrypt. This service is offered as part of Umbraco Cloud by [Umbraco LATCH](../Umbraco-Latch).

### Custom Certificates

Custom certificates can be used with all custom domains. Please refer to our [Managing Custom Certificates documentation](../Manage-Hostnames/Security-Certificates)

### TLS support

As of April 2020, we've deprecated support for TLS1.0 & TLS 1.1. TLS1.2 is now the default supported TLS protocol going forward.

Umbraco v8 sites are using TLS 1.2 as a prefert TLS protocol by default. Umbraco v7 sites, due to running on an older .NET framework 4.5.2, have been updated to default to TLS 1.2.

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

### TLS 1.2 by default in external services

In order to integrate older external applications to access Umbraco Cloud Websites you might have to modify the TLS support in the .Net application.

For ASP.NET applications, inspect the `<system.web><httpRuntime targetFramework>` element of web.config to find the version of the .NET Framework your application is using. .NET applications on .NET 4.7+ are using the OS specified TLS protocols. In Windows 8 & 10, Windows Server 2012 & 2016 TLS 1.2+ is used by default, therefore no actions necessary. .NET applications lower then 4.7 require updates to ensure they can communicate using TLS 1.2 by default.

More information specifically from Microsoft about .Net applications and TLS support can be found [in MS docs](https://docs.microsoft.com/en-us/dotnet/framework/network-programming/tls#audit-your-code-and-make-code-changes). For other application frameworks/languages we encourage to lookup their respective documentations.

### HTTP

HTTP protocol is supported but not used by default on Umbraco Cloud Websites. If you'd like to keep using HTTP, which we strongly discourage, you'll need to remove a web.config transform as specified in [Umbraco LATCH documentation](/Umbraco-Cloud/Set-Up/Umbraco-Latch)

## Firewall & Restricting public access to Umbraco Cloud resources

Umbraco Cloud offers a multitude of features allowing you to block access to different resources.
- Basic Authentication allowing access to Backoffice & Frontend of Umbraco Cloud Websites only for authenticated users.
- IP based whitelist allowing access to Frontend & Backoffice
- IP based whitelist allowing access to website database
