# Using external services with Umbraco Cloud

In some cases you might be need your Cloud project to communicate with an external service that uses a firewall.

An example could be, that you're fetching information from an external service which is behind a firewall. In order to give Cloud access to the external service you need to whitelist the IPs used by the Umbraco Cloud servers.

These are the IPs you will need to whitelist:

```
52.166.147.129
13.95.93.29
40.68.36.142
13.94.247.45
52.157.96.229
```