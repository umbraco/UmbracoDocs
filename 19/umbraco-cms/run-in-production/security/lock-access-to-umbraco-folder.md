---
description: >-
  Learn how to restrict access to the /umbraco/ folder by allowlisting
  IP addresses using IIS URL Rewrite rules.
---

# Lock down access to your Umbraco folder (IIS)

This article explains how to lock down the `/umbraco/` folder to specific IP addresses using IIS URL Rewrite. Use this approach to prevent the Umbraco backoffice from being accessible to everyone on the internet.

To follow these steps, you must have [IIS URL Rewrite](../../develop-with-umbraco/application-code/backend-and-custom-logic/routing/iisrewriterules.md) installed on your server.

Locking down `/umbraco/` will also block API and Surface controllers and the Delivery API. The steps below exclude these paths before restricting the rest.

1. Add the following rule to your `IISRewrite.config` to exclude paths that should remain publicly accessible:

```xml
<rule name="Ignore" stopProcessing="true">
    <match url="^(?:umbraco/api|umbraco/surface|umbraco/delivery)/" />
    <action type="None" />
</rule>
```

{% hint style="info" %}
Some packages and add-ons expose paths under `/umbraco/` that must also remain publicly accessible. For example, [Umbraco Engage requires `/umbraco/engage/*`](https://docs.umbraco.com/umbraco-engage/security-and-privacy/security-and-privacy#security-settings) to be excluded.

Check the documentation for any installed packages to identify paths that need to be added to the exclusion rule.
{% endhint %}

2. Note your allowed IP addresses as a pipe-separated regular expression. For example, `213.3.10.8` and `88.4.43.108` becomes `^(213\.3\.10\.8|88\.4\.43\.108)$`.

3. Add the following rule to your `IISRewrite.config` to block all other IP addresses:

```xml
<rule name="Allowed IPs" stopProcessing="true">
    <match url="^(?:umbraco)(?:/|$)" />
    <conditions>
        <add input="{REMOTE_ADDR}" negate="true" pattern="^(213\.3\.10\.8|88\.4\.43\.108)$" />
    </conditions>
    <action type="AbortRequest" />
</rule>
```

{% hint style="info" %}
If your server is behind a load balancer, you should use `{HTTP_X_FORWARDED_FOR}` instead of `{REMOTE_ADDR}` as the input for the rule.
{% endhint %}

If you now go to `/umbraco/` from a different IP-address the login screen will not be rendered.
