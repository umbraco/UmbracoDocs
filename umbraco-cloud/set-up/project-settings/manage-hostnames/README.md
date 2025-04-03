# Managing Hostnames

When you create an Umbraco Cloud project, the project URLs are based on the name of your project.

Let's say you have a project named `Snoopy`. The default hostnames will be:

* **Umbraco Cloud Portal** - `www.s1.umbraco.io/project/snoopy`
* **Live site** - `snoopy.euwest01.umbraco.io`
* **Development environment** - `dev-snoopy.euwest01.umbraco.io`
* **Staging environment** - `stage-snoopy.euwest01.umbraco.io`

The hostnames contain the region on which your project is hosted. Currently, there are four options available when choosing a region for your Umbraco project:

* West Europe (euwest01),
* East US (useast01),
* South UK (uksouth01), and
* Australian East (aueast01)

To access the backoffice, add `/umbraco` at the end of the Live, Development, or Staging URL.
{% hint style="info" %}
Limitation: A maximum of 100 hostnames can be configured for /umbraco login access.
{% endhint %}

## Domains

To add and manage your hostnames on Umbraco Cloud, follow the steps below:

1. Go to your project on Umbraco Cloud.
2. Go to **Configuration** in the side menu.
3. Click on **Hostnames** in the menu.
4. Click **Add new hostname** to add a new hostname.

<figure><img src="../../../.gitbook/assets/image (26).png" alt="Manage hostnames"><figcaption><p>Manage hostnames</p></figcaption></figure>

Ensure that the hostname you are binding to your Umbraco Cloud environment has a DNS entry that resolves to the Umbraco Cloud service. The DNS settings can either use a **CNAME** or an **A & AAAA** record:

* **CNAME**: Usually used for domains with "`www`" in the URL.

This is recommended to use, if possible, as the record is not changed as often as A & AAAA IPs are. When setting up a CNAME it needs to point to `dns.umbraco.io`.

* **A & AAAA** **records**: Are usually used for the Apex domain (without "`www`" in the URL).

It needs to be created at the root of your domain.

* **A-records** to either or both IPv4 addresses:
  * `162.159.140.127`
  * `172.66.0.125`
* **AAAA records** to either or both IPv6 addresses (to support IPv6 connectivity):
  * `2606:4700:7::7d`
  * `2a06:98c1:58::7d`

If you're using the [Former A and AAAA records](./#former-a-and-aaaa-records) consider changing them to the new A & AAAA records above.

<details>

<summary>Former A and AAAA records</summary>

The following Records will become obsolete in the future. Refrain from using them.

* A Records
  * `104.19.191.28`
  * `104.19.208.28`
  * `104.17.17.9`
  * `104.17.18.9`
* AAAA Records
  * `2606:4700::6813:bf1c`
  * `2606:4700::6813:d01c`
  * `2606:4700::6811:1209`
  * `2606:4700::6811:1109`

</details>

{% hint style="info" %}
Once you have updated your DNS records, you must remove the hostname and re-add it from Umbraco Cloud to re-validate the certificate with Cloudflare.

You can also check the DNS propagation using a site like [What is my DNS?](https://www.whatsmydns.net/).
{% endhint %}

Check with your DNS host or hostname registrar regarding configuration details for your Hostnames.

{% embed url="https://youtu.be/iBGM0AKg3Fw" %}
Adding hostname and configuring Content Delivery Network (CDN) and Cache
{% endembed %}

To specify the hostname for each root node using a multisite setup, follow these steps:

1. Go to the **Backoffice** of the project.
2. Right-click the root content node.
3. Select **Culture and Hostnames**.
4. Click **Add New Domain** in the **Culture and Hostnames** window.
5. Enter your **Domain** name and select the **Language** from the drop-down list.&#x20;

<figure><img src="../../manage-hostnames/images/culture-and-hostnames-v10.png" alt="Enter domain and select Language."><figcaption><p>Enter domain and select Language.</p></figcaption></figure>

6. Click **Save**.

Once you've assigned a Hostname to your Umbraco Cloud environment, you may want to hide the default `umbraco.io` URL (e.g. _snoopy.euwest01.umbraco.io_). To do so, see the [Rewrites on Cloud](rewrites-on-cloud.md#hiding-the-default-umbracoio-url) article.

### Using special characters

Umbraco Cloud supports Internationalized Domain Names (IDN) allowing you to configure domain names including special characters.

When using an IDN direct access to the Umbraco backoffice from that domain is unavailable. If you have configured `måneskin.dk` as a domain, you cannot access the backoffice using `måneskin.dk/umbraco`. The backoffice will still be accessible using the default Cloud URL (`maaneskin.euwest01.umbraco.io/umbraco`), or from other domain names that do not include special characters.

### Automatic Transport Layer Security (TLS)

All hostnames added to an Umbraco Cloud project's environment will get a TLS (HTTPS) certificate added, by default. The certificate is issued by Cloudflare and valid for 90 days after which it will be automatically renewed. Everything around certificates and renewals is handled for you and you only need to ensure the DNS records are configured according to our recommendations above.

{% hint style="info" %}
You will need to **remove the old DNS entry** before the Cloudflare service generates a new certificate for your Hostname.
{% endhint %}

### Is your Domain hosted on your own Cloudflare account?

Cloudflare is a popular DNS provider, which offers a variety of different services to improve performance and security. We also use it for DNS and Hostnames on Umbraco Cloud.

When adding a hostname to your project hosted on Umbraco Cloud, using your own Cloudflare account the process is slightly different.

1. Set Proxy Status to **DNS Only** when creating a _CNAME_ or _A-record_ for your hostname in Cloudflare.
2. Change Proxy Status to **Proxied** once your hostname is **Protected** on the Hostname page for your Cloud project. Also, make sure the website is accessible through the hostname.

The above is primarily relevant when you need to use specific Cloudflare services like Page Rules, Workers, and so on.

### Using Certificate Authority Authorization (CAA) for your domain?

CAA is a [DNS resource record ](https://tools.ietf.org/html/rfc6844)defined in RFC 6844 allowing domain owners to indicate which Certificate Authorities (CA) allow to issue certificates for them. If you use CAA records on your domain, you will either need to remove CAA entirely or add the following through your DNS provider:

```sql
example.com. IN CAA 0 issue "pki.goog"
```

This is necessary because Google Trust Services is the Certificate Authority for the certificates issued on Umbraco Cloud.

CAA records can be set on the subdomain, but it's not something that is commonly used. If there’s a CAA record at, e.g., app.example.com, you’ll need to remove or update it. If you want to use wildcards and allow certificates for any subdomain, the CAA record should look like this:

```sql
example.com. IN CAA 0 issuewild "pki.goog"
```

{% hint style="info" %}
The Certificate Authority (CA) used to issue certificates for all Umbraco Cloud sites' custom hostnames was changed on September 26, 2022. From October 31, 2022, certificate renewals for existing hostnames will also be updated to use the new CA.

**No action is required unless you set a Certificate Authority Authorization (CAA) record** on your domain. In that case you need to update the CAA record before renewal. Please follow the [Migrate to new Certificate Authority for custom hostnames](ca-record-migration.md) documentation.
{% endhint %}

## [Upload certificates manually](security-certificates.md)

On the Professional and Enterprise plans, you can manually add your certificate to your project and bind it to one of the configured hostnames.

## Using your Web Application Firewall (WAF) on Umbraco Cloud

If you need to use WAF in front of your Umbraco Cloud website this section will highlight some of the common configurations needed.

{% hint style="info" %}
Configuration may vary depending on which WAF you are using, so you should always consult your vendor for best practices and recommendations.
{% endhint %}

In most cases, you need to ensure that the WAF and Umbraco Cloud are using the same certificate on the specific hostname. Custom certificates are a plan-specific feature on Umbraco Cloud, so make sure that you have access to upload certificates.

* Make sure the hostname is pointing to Umbraco Cloud (dns.umbraco.io).
* Certificate issued for the actual hostname. A custom certificate is required for a WAF hostname.
* Be on a [plan](https://umbraco.com/products/umbraco-cloud/pricing/) that supports custom certificates.

When configuring the hostname and certificate on Umbraco Cloud it will be necessary to validate the hostname using a TXT record. This is needed because in most cases the WAF will hide that the website is running on Umbraco Cloud. This means that the usual domain ownership verification cannot be performed. This same approach can also be used to configure a hostname before updating the DNS for the hostname.

Adding a hostname on a Cloud project is possible before a DNS change. It can take up to approx. 14 days before it's removed. That means that you have 14 days to add a TXT record in your DNS settings.

Reach out to support and they will assist you with the details needed to be in the TXT record. We will first be able to see what you need to add to the TXT record when you have added the hostname.

When that is added it should work immediately.

## [Rewrites on Umbraco Cloud](rewrites-on-cloud.md)

Learn more about best practices for working with rewrite rules on Umbraco Cloud projects.
