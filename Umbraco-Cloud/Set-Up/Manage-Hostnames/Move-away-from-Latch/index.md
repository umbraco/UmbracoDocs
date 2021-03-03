---
versionFrom: 7.0.0
meta.Title: "How to move away from using Umbraco Latch"
meta.Description: "The Umbraco Latch service has been deprecated and it instead being replaced by a new Umbraco Cloud service which uses Cloudflare as a provider for issueing TLS (HTTPS) certificates to hostnames added to Cloud environments. In this article you can learn how to move to use the new service."
---

# How to move away from using Umbraco Latch

As of December 8th, 2020 the Umbraco Latch service used for issuing security certificates to hostnames added to Umbraco Cloud environments, has been replaced with another Umbraco Cloud service. Any hostnames added to your environments going forward will automatically be issued a TLS (HTTPS) certificate provided by Cloudflare.

All current certificates issued by the Umbraco Latch service, using Let's Encrypt, will continue to be renewed every three months.

In this article you will find a guide on how to move away from Umbraco Latch (Let's Encrypt) and instead ensure that all your hostnames are protected by TLS (HTTPS) certificates provided by our Umbraco Cloud service and Cloudflare.

## Checking the certificate

The very first step, is to double-check which provider has issued the certificate which is currently protecting your hostname(s).

1. Open your website URL.
2. Select the "lock" icon to the left of the URL in the address bar in your browser.
3. Click on **Certificate**.
4. Identify the provider next to **Issued by:**.

If the certificate is already issued by Cloudflare, there are no further steps.

If the certificate is issues by Let's Encrypt, follow the steps below to issue a new TLS (HTTPS) certificate for your hostname(s).

## Removing the Umbraco Latch certificate

To follow the steps below, ensure that you have access to the DNS configuration for your hostname as well as admin access to the Umbraco Cloud Portal.

1. Access the DNS configuration for your hostname.
2. Update the DNS entry to a **CNAME** record pointing to `dns.umbraco.io`.
3. Save the new configuration settings.
4. Access the Umbraco Cloud Portal.
5. Open the **Hostnames** page for your project.
6. Remove the hostname for which you've updated the DNS configuration.
7. Add the hostname again.

:::note
If you for some reason cannot use a CNAME record, you can use an A-record which points to one of these IPs: `104.19.191.28` or `104.19.208.28`.

As these static IPs a volatile towards change, this is something you should only do when using a CNAME record is not possible.
:::

Depending on your DNS provider, it might take some time before the changes kick in.

Eventually, you should see that your hostname is now protected by a new TLS (HTTPS) certificate issues by Cloudflare.

This certificate will continue to be renewed on an annual basis.

:::links

## Related articles

* [Manage Hostnames](../)
* [Custom security certificates](../Security-Certificates)

:::
