---
versionFrom: 8.0.0
---

# How to move away from using Umbraco Latch

As of December 8th, 2020 the Umbraco Latch service used for issuing security certificates to hostnames added to Umbraco Cloud environments, has been replaced with another Umbraco Cloud service. Any hostnames added to your environments going forward will automatically be issued a TLS (HTTPS) certificate provided by CloudFlare.

All current certificates issued by the Umbraco Latch service, using Let's Encrypt, will continue to be renewed every three months.

In this article you will find a detailed guide on how to move away from Umbraco Latch (Let's Encrypt) and instead ensure that all your hostnames are protected by TLS (HTTPS) certificates provided by our Umbraco Cloud service and CloudFlare.

## Checking the certificate

The very first step, is to double-check which provider has issues the certificate which is currently protecting your hostname(s).

1. Open your website URL.
2. Select the "lock" icon to the left of the URL in the address bar in your browser.
3. Click on **Certificate**.
4. Identify the provider next to **Issued by:**.

If the certificate is already issued by CloudFlare, there are no further steps.

If the certificate is issues by Let's Encrypt, follow the steps below to issue a new TLS (HTTPS) certificate for your hostname(s).

## Removing the Umbraco Latch certificate

To follow the steps below, ensure that you have access to the DNS configuration for your hostname as well as admin access to the Umbraco Cloud Portal.

1. 
