---
versionFrom: 7.0.0
---

# Umbraco Latch

All new projects on Umbraco Cloud are automatically protected by Umbraco Latch. This means, that the default Umbraco Cloud URL for your project as well as any new hostnames you add will be assigned a TLS certificate automatically.

![Adding a hostname](images/adding-hostname-to-cloud.gif)

In order for Umbraco Latch to be applied to your hostname, you need to make sure that your DNS has been setup one of these ways:

* CNAME pointing at the Cloud URL mysite.s1.umbraco.io
* A Record pointing at the Cloud IP: 23.100.15.180

Learn more about our recommendations for DNS records in the [Manage Hostnames](../Manage-Hostnames) article.

## HTTPS by default

All new Live sites created on Cloud since version 7.12 will automaticallt have a permanent redirect (301) from HTTP to HTTPS. This is achieved by a web.config transform called: `Latch.Web.live.xdt.config` - accessible in your git repository. If you'd like to remove the redirect rule (which we and [others](https://www.blog.google/products/chrome/milestone-chrome-security-marking-http-not-secure/) strongly discourage) you'll need to remove the file `Latch.Web.live.xdt.config` from projects repository and push the change to Cloud.

## Default TLS Certificates

All `*.umbraco.io` domains will serve a default wildcard certificate with a common name `*.umbraco.io`.
Custom domains will automatically be secured by a Let's Encrypt certificate.

On Umbraco Cloud projects on the Professional or Enterprise plan, it is possible to [upload a custom certificate](../Manage-Hostnames/Security-Certificates/) that will overwrite the default certificates provided for the domains.

## Latch and CDN

You will not get an Umbraco Latch certificate if you are using a CDN service (e.g. CloudFlare) on your Umbraco Cloud project.

In that case you can manually add a TLS certificate to your project instead. Read more about how to do that in the [Upload certificates manually](../Manage-Hostnames/Security-Certificates/) article.

:::note
Umbraco Latch can issue 5 certificates for a single domain per week. If this limit is exceeded, you will have to wait a week in order to regenerate the certificate for the domain.
:::

:::note
The generation process might freeze (e.g. Initial > DnsApproved > ChallengeFileWritten > Initial) when your DNS provider has both an IPv4 and IPv6 IP address. 
Unfortunately, Latch doesn't support IPv6 but Lets Encrypt will take that over IPv4 when it's there.
In order to resolve this, you will need to disable IPv6 for that domain.
:::

## Status definitions

When Umbraco Latch is issuing a certificate for one of your hostnames it goes through the following states:

* Initial
* DnsApproved
* NoRewrites
* AcmeRequested
* ChallengeFileWritten
* AcmeVerified
* PfxGenerated
* CertificateInstalled
* Protected by LATCH

It can take up to 30minutes for the certificate to be issued. Once you see the **Protected by Latch** your site is secure.

### Bad states

If issuing a certificate to a hostname fails, it will end up in one of the following states:

#### Dns Misconfigured

This means that there is an issue with how the DNS for the provided hostname has been configured. Umbraco Latch will not be able to issue a certificate before the DNS configuration is fixed.

Learn more about how the setup hostnames for Umbraco Cloud in the [Manage Hostnames](../Manage-Hostnames) article.

#### Rewrites Error

If you see this state on your hostname, it means that there is an issue with some of your rewrites that needs to be resolved before a certificate can be issued.

When redirecting all requests from HTTP to HTTPS, you will need to add the following condition to the rewrite rule:

```xml
<add input="{REQUEST_URI}" negate="true" pattern="^/\.well-known/acme-challenge" />
```

Read more about best practices with rewrites on Umbraco Cloud in the [Rewrites on Umbraco Cloud](../Manage-Hostnames/Rewrites-on-Cloud) article.

#### Special Characters

There are some special characters that Umbraco Latch does not accept when issuing certificates. If you are seeing the **Special Characters** state next to your hostname, it means that you are using some special characters that are not allowed.

Do you need to add the hostname, we recommend setting up CDN and [upload a manual certificate](../Manage-Hostnames/Security-Certificates/).

#### Tried 5 times

This is the state you will see next to your hostname if Umbraco Latch has tried issuing a certificate 5 times, which is the limit per week.

If you see this state, you will need to wait a week, before Umbraco Latch can assign a certificate to your hostname.

## CAA records and Umbraco Latch
If you have CAA (Certification Authority Authorization) records configured for your domain, that does not allow the certificate provider of Umbraco Latch (Lets Encrypt) to issue a certificate, the hostname will be stuck in the 'Inital' phase. To make sure that Umbraco Latch can have a certificate issued for your hostname, you can either delete the CAA record preventing issuance, or you can add a record to allow LetsEncrypt to issue certificates for your domain. Let’s Encrypt’s identifying domain name for CAA is ```letsencrypt.org```. You can read more about CAA and LetsEncrypt in [the official LetsEncrypt documentation](https://letsencrypt.org/docs/caa/).

## Read more

* [Redirect from HTTP to HTTPS](https://our.umbraco.com/documentation/Umbraco-Cloud/Set-Up/Manage-Hostnames/Rewrites-on-Cloud/#running-your-site-on-https-only)
* [Blog post: Introducing Umbraco Latch](https://umbraco.com/blog/introducing-umbraco-latch/)
* [Umbraco Latch on Umbraco.com](https://umbraco.com/products/umbraco-latch/)
