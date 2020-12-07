---
versionFrom: 7.0.0
---

# Upload certificates manually

:::note
This feature is only available for Umbraco Cloud projects on a Professional or Enterprise plan.

All projects on a Starter, Standard or Pro plans will automatically be assigned a TLS (HTTPS) certificate.

See the full list of features including in the [Umbraco Cloud pricing plans on Umbraco.com](https://umbraco.com/umbraco-cloud-pricing/).
:::

Under **Certificates** you'll find an option to manually upload your own certificate and assign it to one of the hostnames you've added.

Your certificates need to be **`.pfx`** format and must be set to use a password. Each certificate can then be bound to a hostname you have already added to your site. Make sure you use the hostname you will bind the certificate to as the common name (CN) when generating the certificate.

<iframe width="800" height="450" src="https://www.youtube.com/embed/IM7mi7KuHpY?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

## 1. Upload certificate

* Upload your certificate from your local machine
* Type in the password for your certificate
* Click **Add**

## 2. Bind certificate to hostname

* Click **Add new binding**
* Choose your hostname from the *Hostname* dropdown
* Choose your newly uploaded certificate from the *Certificate* dropdown
* Click **Add**

You've now successfully added your certificate to the Cloud project!

## From custom certificate to automatic TLS (HTTPS)

In some cases, you might want to switch from using your own custom certificate, to use the ones provided by the Umbraco Cloud service.

By removing your own certificate from your Cloud project, Umbraco will automatically assign a new TLS (HTTPS) certificate to the hostname that was using the removed certificate.

:::note
Did your manually uploaded security certificate expire?

You will need to remove the expired certificate in order for Latch to assign a new certificate to your hostname(s).
:::

## Read more

* [Redirect from HTTP to HTTPS](../Rewrites-on-Cloud#running-your-site-on-https-only)
