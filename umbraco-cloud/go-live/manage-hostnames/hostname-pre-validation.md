# Hostname Pre-Validation

In typical scenarios, the recommended approach for hostname validation in Umbraco Cloud is to point your DNS directly to Umbraco Cloud. This lets the platform handle the process from start to finish. However, this might not be suitable for all environments—such as when working with production domains where zero downtime is critical.

In such cases, Umbraco Cloud supports using a pre-validation method that allows you to complete hostname validation and SSL certificate issuance before switching your live DNS over. This approach ensures a seamless transition with no interruptions in service.

## When to Use Hostname Pre-Validation

Use pre-validation when:
- You’re dealing with live or production domains that require 100% uptime.
- You want to avoid the brief downtime that might occur while SSL certificates are being validated after pointing DNS to Umbraco Cloud.

## How to Use Hostname Pre-Validation

### 1. Enable Pre-Validation for the Hostname

After adding your custom hostname in the Umbraco Cloud Portal, navigate to the Hostname Settings and toggle the Pre-Validation option to enable it.

Umbraco Cloud will then provide two DNS records:

- A **TXT** record used to verify domain ownership.

- A **CNAME** record required for the SSL certificate issuance.


### 2. Add DNS Records at Your Domain Registrar

Log in to your DNS provider or domain registrar and add the records provided:

- **TXT Record:**

    Name:  _cf-custom-hostname.\<hostname\>

    Value: Provided by Umbraco Cloud.

- **CNAME Record:**

    Name: _acme-challenge.\<hostname\>

    Value: Points to a domain under Umbraco's control (e.g., \<hostname\>.53231a669c5282f8.dcv.cloudflare.com).

{% hint style="info" %}
DNS propagation times can vary. It might take a few minutes to several hours for your changes to become active globally. Tools like https://www.nslookup.io/ can help verify that your records are live.
{% endhint %}


### 3. Check Validation Status

Return to the Hostname page in Umbraco Cloud. You’ll see a Hostname Information Box showing the current status of your validation.

If everything is set up correctly, the status will change to Active, and the Hostname will have been validated and the SSL certificate has been issued.


### 4. Point Your DNS to Umbraco Cloud

Once the certificate is issued:

- Update your domain's A record or CNAME to point to the Umbraco Cloud DNS (add link).

- Because the certificate is already in place, your site will be accessible securely (via HTTPS) without any downtime.


### 5. Disable Pre-Validation and Clean Up DNS Records

After the hostname is active and secure:

- Go back to Hostname Settings and disable the pre-validation method.

- Remove the TXT and CNAME records you added for pre-validation.

This ensures that future certificate renewals are automatically handled by Umbraco Cloud without requiring manual DNS management.
