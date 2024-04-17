# External Services

In some cases, Umbraco Cloud might not be the only service you are working with. You might need to work with other services as well - this could be either internal or third-party services. In either case, it will be serviced externally to Umbraco Cloud.

When you are working with an external service that is behind a firewall and that service needs to communicate with your Umbraco Cloud project, you need to make sure the Umbraco Cloud Server IPs are allowed to bypass the firewall.

An example could be, that you're fetching some information from an external service that is behind a firewall. To give your Umbraco Cloud project access to the external service you need to add the IPs used by the Umbraco Cloud servers to an allow list (other services may refer to it as a "whitelist").

## Enabling static outbound IP addresses

For projects on a Standard, Professional, and Enterprise plan you can enable static outbound IP addresses.

On the **Advanced** page of your project, you can turn on the static outbound IP address feature to ensure persistent communication. This opt-in feature can be switched on for **Standard**, **Professional**, and **Enterprise** Cloud projects.

{% hint style="info" %}
The enabling of static outbound IP addresses will have the effect that port 25 will be blocked. Port 25 is the default port for SMTP relays and is commonly abused to send spam from compromised parties. Accordingly, this port is often blocked by ISPs and cloud providers such as Microsoft and Google. For SMTP submissions, we advise you to use port 587 or port 2525.
{% endhint %}

![StaticOutboundIps](https://user-images.githubusercontent.com/93588665/158338313-c433c994-71a5-40f5-a947-4947df23a0cf.gif)

The static outbound IPs for every environment are:

```cs
40.113.173.32
40.113.173.33
40.113.173.34
40.113.173.35
40.113.173.36
40.113.173.37
40.113.173.38
40.113.173.39
40.113.173.40
40.113.173.41
40.113.173.42
40.113.173.43
40.113.173.44
40.113.173.45
40.113.173.46
40.113.173.47
```

If you need to use a CIDR (Classless Inter-Domain Routing) Range for the IPs: `40.113.173.32/28`

{% hint style="info" %}
For projects on a Starter plan, you can see the current dynamic outbound IP addresses. The IP addresses shown for starter projects are dynamic and are likely to change at some point due to either Azure or Umbraco optimizing hosting resources.
{% endhint %}
