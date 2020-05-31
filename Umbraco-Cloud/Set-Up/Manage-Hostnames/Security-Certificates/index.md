---
versionFrom: 7.0.0
---

# Upload certificates manually

:::note
This feature is only available for Umbraco Cloud projects on a Professional or Enterprise plan.

All projects on a Starter or Standard plan will automatically be assigned an [Umbraco Latch certificate](../../Umbraco-Latch).

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

## Read more

* [Automatic certificates with Umbraco Latch](../../Umbraco-Latch)
* [Redirect from HTTP to HTTPS](../Rewrites-on-Cloud#running-your-site-on-https-only)
