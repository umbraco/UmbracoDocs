---
description: >-
  Your Umbraco Cloud website is protected by a Web Application Firewall (WAF) by
  default. Learn more about the feature and the benefits.
---

# Web Application Firewall

A Web Application Firewall (WAF) is a security solution designed to protect web applications by filtering and monitoring HTTP traffic between them and the Internet. By acting as a shield between the web application and potential threats, it helps mitigate various common attacks such as cross-site scripting (XSS), SQL injection, and file inclusion.[ ](https://www.cloudflare.com/learning/ddos/glossary/web-application-firewall-waf/)

## Umbraco Cloud WAF

Umbraco Cloud uses [Cloudflare’s Managed Rulesets](https://developers.cloudflare.com/waf/managed-rules/) which include pre-configured rules that provide immediate protection against a wide range of threats. These managed rulesets are regularly updated to defend against the latest vulnerabilities and attack techniques. The rulesets include protections against:

* **Zero-day vulnerabilities**: Newly discovered vulnerabilities that have not yet been patched.
* **Top-10 attack techniques (logging only)**: Common attack methods identified by security organizations like OWASP.

WAF is enabled by default on each custom hostname. It is not available for the internal Cloud hostnames.

## Impact on your website

### **Performance**

A WAF helps maintain optimal performance by blocking malicious traffic before it reaches your web application. This means that your server resources are not wasted on processing harmful requests, which can slow down your website. Additionally, by preventing attacks that could exploit vulnerabilities, WAF helps ensure the website remains available and responsive to legitimate users.

### **Security**

A WAF enhances the security of your web applications by providing a robust defense against different types of attacks. It protects your website from data breaches, defacement, and other security incidents by filtering out malicious traffic. This helps not only safeguard sensitive data but also maintain the trust and confidence of your users.

## Requirements

The custom hostname(s) must be pointing to the Umbraco Cloud entry point  CNAME record pointing to `dns.umbraco.io` or A records.

Learn more about this in the article on [Managing Hostnames](../../../go-live/manage-hostnames/).

{% hint style="warning" %}
When using **a proxy server** with your Umbraco Cloud project you cannot enable WAF on your custom hostname.&#x20;
{% endhint %}

## Enable WAF on custom hostnames

The following steps outline enabling WAF on your custom hostname(s).

1. Open the Cloud project in the Umbraco Cloud Portal.
2. Navigate to **Transport Security** under **Security**.
3. Enable WAF for all future hostnames added to the project.
4. Enable WAF on your custom hostname(s).
