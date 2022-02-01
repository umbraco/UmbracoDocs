---
versionFrom: 7.0.0
keywords: whitelist allow list allowlist ip internal
---

# Using external services with Umbraco Cloud

In some cases Umbraco Cloud might not be the only service you are working with. You might need to work with other services as well - this could be either internal or third party services. In either case, it will be services external to Umbraco Cloud.

When you are working with an external service that is behind a firewall and that service needs to communicate with your Umbraco Cloud project, you need to make sure the Umbraco Cloud Server IPs are allowed to bypass the firewall.

An example could be, that you're fetching some information from an external service which is behind a firewall. In order to give your Umbraco Cloud project access to the external service you need to add the IPs used by the Umbraco Cloud servers to an allow list (other services may refer to it as a "whitelist").

Please reach out to support in order to get the outgoing IPs for your project.

:::warning
A change of plan for a project on Umbraco Cloud enforces a new set of outgoing IPs for that project. If the project to be changed is using external services and has its outgoing IPs whitelisted, please reach out to Umbraco support prior to upgrading/downgrading the plan.
:::
