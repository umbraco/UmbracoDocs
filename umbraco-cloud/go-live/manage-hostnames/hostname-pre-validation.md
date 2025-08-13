# Hostname Pre-Validation

In typical scenarios, the recommended approach for hostname validation in Umbraco Cloud is to point your Domain Name System (DNS) directly to Umbraco Cloud. The platform handles the process from start to finish. However, this may not be suitable for all environments—such as when working with production domains where zero downtime is critical.

In such cases, Umbraco Cloud supports using a pre-validation method. You can complete hostname validation and Transport Layer Security (TLS) certificate issuance before switching your live DNS over. This approach ensures a seamless transition with no interruptions in service.

## When to Use Hostname Pre-Validation

Use pre-validation when:
- You're dealing with live or production domains that require 100% uptime.
- You want to avoid the brief downtime that may occur while TLS certificates are being validated after pointing DNS to Umbraco Cloud.

## How to Use Hostname Pre-Validation

### 1. Enable Pre-Validation for the Hostname

After adding your custom hostname in the Umbraco Cloud Portal, navigate to the Hostname Settings. Toggle the Pre-Validation option to enable it.

Umbraco Cloud will then provide two DNS records:

- A **TXT** record used to verify domain ownership.

- A **CNAME** record required for the TLS certificate issuance.


### 2. Add DNS Records at Your Domain Registrar

Log in to your DNS provider or domain registrar and add the records provided:

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

The status will change to Active when everything is set up correctly. The hostname will have been validated and the TLS certificate has been issued.


### 4. Point Your DNS to Umbraco Cloud

Once the certificate is issued:

- Update your domain's A record or CNAME to point to the Umbraco Cloud DNS (add link).

- Your site will be accessible securely via HTTPS without any downtime because the certificate is already in place.


### 5. Disable Pre-Validation and Clean Up DNS Records

After the hostname is active and secure:

- Go back to Hostname Settings and disable the pre-validation method.

- Remove the TXT and CNAME records you added for pre-validation.

Umbraco Cloud will automatically handle future certificate renewals without requiring manual DNS management.
