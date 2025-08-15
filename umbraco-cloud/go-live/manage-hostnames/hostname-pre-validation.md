# Hostname Pre-Validation

In typical scenarios, the recommended approach for hostname validation in Umbraco Cloud is to point your Domain Name System (DNS) directly to Umbraco Cloud. The platform handles the process from start to finish. However, this may not be suitable for all environments, such as when working with production domains where zero downtime is critical.

In these cases, Umbraco Cloud supports using a pre-validation method. You can complete hostname validation and Transport Layer Security (TLS) certificate issuance before switching over your live DNS. This approach ensures a seamless transition with no interruptions in service.

## When to Use Hostname Pre-Validation

Use pre-validation when:

- You're dealing with live or production domains that require 100% uptime.
- You want to avoid the brief downtime that may occur while TLS certificates are being validated after pointing DNS to Umbraco Cloud.

## How to Use Hostname Pre-Validation

The following steps outline how to use hostname pre-validation.

### 1. Enable Pre-Validation for the Hostname

After adding your custom hostname in the Umbraco Cloud Portal:

1. Navigate to **Hostname Settings**.
2. Toggle the Pre-Validation option to enable it.

Umbraco Cloud will provide two DNS records:

- A **TXT** record used to verify domain ownership.
- A **CNAME** record that is required for the TLS certificate issuance.

<figure><img src="images/hostname-settings-modal.png" alt="This is an image of the Hostname settings modal"></figure>

### 2. Add DNS Records at Your Domain Registrar

1. Log in to your DNS provider or domain registrar.
2. Add the records provided:

- **TXT Record:**

    Name:  _cf-custom-hostname.\<hostname\>

    Value: Provided by Umbraco Cloud.

- **CNAME Record:**

    Name: _acme-challenge.\<hostname\>

    Value: Points to a domain under Umbraco's control (e.g., \<hostname\>.53231a669c5282f8.dcv.cloudflare.com).

{% hint style="info" %}
DNS propagation times can vary. Changes may take a few minutes to several hours to become active globally. Tools like https://www.nslookup.io/ can help verify that your records are live.
{% endhint %}


### 3. Check Validation Status

Return to the Hostname page in Umbraco Cloud. You'll see a Hostname Information Box showing the current status of your validation.

The status will change to Active when everything is set up correctly. The hostname is validated, and the TLS certificate issued.

<figure><img src="images/pre-validation-status-modal.png" alt="This is an image of the Pre-Validation status modal"></figure>

pre-validation-status-modal

### 4. Point Your DNS to Umbraco Cloud

Once the certificate is issued, update your domain's A record or CNAME to point to the Umbraco Cloud DNS (add link).

Your site will be accessible securely via HTTPS without any downtime because the certificate is already in place.

### 5. Disable Pre-Validation and Clean Up DNS Records

After the hostname is active and secure:

1. Go back to Hostname Settings and disable the pre-validation method.
2. Remove the TXT and CNAME records you added for pre-validation.

Umbraco Cloud will automatically handle future certificate renewals without the need for manual DNS management.

## Custom Certificate

If you plan to use a [custom certificate](security-certificates), the Hostname Pre-Validation method can be used to prove ownership of the hostname before binding the custom certificate.

You can do this by following these steps:

1. Enable Pre-Validation for the Hostname.
2. Add the TXT record provided to your Domain Name System (DNS) settings. The record will prove ownership of the domain.
3. Upload a custom certificate and set a binding to the Hostname.
4. Wait a couple of minutes, then disable Pre-Validation for the Hostname. The status will now show "Manual" for the Hostname.
