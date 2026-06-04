# External Services

{% hint style="info" %}
This page covers **your project's own outbound IP addresses** - the addresses your website sends traffic *from*. Share these with an external service so it can allowlist requests coming from your Cloud project.

Looking for the IP addresses of Umbraco Cloud's own services so you can allowlist them in your firewall? See [Static Outbound IP Addresses for Umbraco Cloud](static-outbound-ip-addresses.md).
{% endhint %}

In some cases, Umbraco Cloud might not be the only service you are working with. You might need to work with other services as well. This could be either internal or third-party services. In either case, it will be serviced externally to Umbraco Cloud.

If an external service behind a firewall needs to communicate with your Umbraco Cloud project, allow Umbraco Cloud Server IPs to bypass the firewall.

For example, to retrieve information from an external service that is located behind a firewall, you must grant access to your Umbraco Cloud project. To do this, add the IP addresses used by Umbraco Cloud servers to an allowlist.

## Enabling static outbound IP addresses

For projects on a Standard, Professional, and Enterprise plan you can enable static outbound IP addresses.

On the **Advanced** page of your project, you can turn on the static outbound IP address feature to ensure persistent communication. This opt-in feature can be switched on for **Standard**, **Professional**, and **Enterprise** Cloud projects.

{% hint style="info" %}

The enabling of static outbound IP addresses will have the effect that port 25 will be blocked. Port 25 is the default port for SMTP relays and is commonly abused to send spam from compromised parties. Accordingly, this port is often blocked by ISPs and cloud providers such as Microsoft and Google. For SMTP submissions, we advise you to use port 587 or port 2525.

{% endhint %}

![StaticOutboundIps](https://user-images.githubusercontent.com/93588665/158338313-c433c994-71a5-40f5-a947-4947df23a0cf.gif)

The static outbound IP ranges vary per region. Below are the values per region in a [Classless Inter-Domain Routing (CIDR)](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) notation. The expanded IP ranges can be calculated by using [online tooling](https://www.ipaddressguide.com/cidr).

**West Europe**

```cs
40.113.173.32/28
```

**UK South**

```cs
20.90.182.0/28
```

**US East**

```cs
20.55.62.0/28
```

**Australia East**

```cs
4.147.161.240/28
```

If you need to use a CIDR Range for the IPs: `40.113.173.32/28`

{% hint style="info" %}
For projects on a Starter plan, you can see the current dynamic outbound IP addresses. The IP addresses for starter projects are dynamic and may change due to Azure or Umbraco optimizing resources.
{% endhint %}

## Umbraco Cloud service IP addresses

The IP addresses above are your project's *own* outbound addresses. These are different from the addresses used by Umbraco Cloud's internal services that connect to your environment. These services include both global and regional services.

If you need to allowlist those services in your firewall, see [Static Outbound IP Addresses for Umbraco Cloud](static-outbound-ip-addresses.md).
