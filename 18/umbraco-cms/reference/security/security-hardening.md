---
description: Learn how to strengthen the security of your Umbraco installation, and reduce the risk of unauthorized access.
---

# Umbraco Security Hardening

Here you find some tips and trick for hardening the security of your Umbraco installation.

## Lock down access to your Umbraco folder (IIS)

It’s considered a good practice to lock down the Umbraco folder to specific IP addresses and/or IP ranges to ensure this folder is not available to everyone.

The prerequisite of this to work is that you’re using [IISRewrite](../routing/iisrewriterules.md)

If you’ve made sure that you’ve installed this on your server we can start locking down our Umbraco folder. This can be down by following these three steps.

1. We are going to lock down /Umbraco/, but because API-controllers and Surface-controller will use the path /umbraco/api/ and /umbraco/surface/ these will also be locked down. Our first rule in the IISRewrite.config will be used to make sure that these are not locked by IP-address.

```xml
<rule name="Ignore" stopProcessing="true">
    <match url="^(?:umbraco/api|umbraco/surface)/" />
    <action type="None" />
</rule>
```

Some older versions of Umbraco also relied on /umbraco/webservices/ for loadbalancing purposes. If you're loadbalancing you should also add umbraco/webservices to the rule.

```xml
<rule name="Ignore" stopProcessing="true">
    <match url="^(?:umbraco/api|umbraco/surface|umbraco/webservices)/" />
    <action type="None" />
</rule>
```

1. Get the IP-addresses of your client and write these down like a regular expression. If the IP-addresses are for example 213.3.10.8 and 88.4.43.108 the regular expression would be "213.3.10.8|88.4.43.108".
2. Lock down the Umbraco folder by putting this rule into your IISRewrite-rules

```xml
<rule name="Allowed IPs" stopProcessing="true">
    <match url="^(?:umbraco)(?:/|$)" />
    <conditions>
        <add input="{REMOTE_ADDR}" negate="true" pattern="213.3.10.8|88.4.43.108" />
    </conditions>
    <action type="AbortRequest" />
</rule>
```

{% hint style="info" %}
If your server is behind a load balancer, you should use `{HTTP_X_FORWARDED_FOR}` instead of `{REMOTE_ADDR}` as the input for the rule.
{% endhint %}

If you now go to `/umbraco/` from a different IP-address the login screen will not be rendered.
