---
versionFrom: 7.0.0
keywords: whitelist allow list allowlist ip internal
---

# Using external services with Umbraco Cloud

In some cases Umbraco Cloud might not be the only service you are working with. You might need to work with other services as well - this could be either internal or third party services. In either case, it will be services external to Umbraco Cloud.

When you are working with an external service that is behind a firewall and that service needs to communicate with your Umbraco Cloud project, you need to make sure the Umbraco Cloud Server IPs are allowed to bypass the firewall.

An example could be, that you're fetching some information from an external service which is behind a firewall. In order to give your Umbraco Cloud project access to the external service you need to add the IPs used by the Umbraco Cloud servers to an allow list (other services may refer to it as a "whitelist").

These are the IPs you will need to add:

```
52.166.147.129
13.95.93.29
40.68.36.142
13.94.247.45
52.157.96.229
```
The addresses above will be replaced as part of the [migration to our new platform](https://umbraco.com/blog/the-future-of-umbraco-cloud/). The outgoing IPs of the new platform are:
```
20.73.236.170
20.73.116.47
20.73.117.188
20.71.72.232
20.71.72.216
20.73.117.69
20.73.117.242
20.73.118.105
20.73.112.139
20.73.118.128
20.73.118.167
20.73.236.227
20.73.119.47
20.73.119.98
20.73.114.150
20.73.117.131
20.73.233.232
20.73.237.117
20.73.119.207
20.73.114.207
20.73.117.108
20.73.118.39
20.71.73.203
20.76.56.206
20.76.56.210
20.76.57.19
20.73.116.61
20.73.117.164
20.73.117.133
20.73.119.53
20.50.2.41
20.73.238.219
20.73.239.127
20.73.239.146
20.73.112.71
20.73.232.74
20.71.77.129
20.50.2.31
```

These are the **out-going** IPs on the Umbraco Cloud servers. Whenever we add new IPs they will be updated here.

:::note
When new IPs are added we will also send the information directly to the [Technical Contacts](../Team-Members/Technical-Contact.md) for each Umbraco Cloud project.
:::

If you are using an external service that is not behind a firewall, you do not need to include the Umbraco Cloud IPs in an allow list.
