---
description: >-
  Learn how Umbraco Cloud holds back public traffic until your site reports
  that it is ready after a restart, outage, or upgrade.
tags:
  - ai-generated
---

# Readiness Gating

When an environment restarts, recovers from an outage, or upgrades, visitors see an error page. Readiness gating keeps that error page in place until your site reports that it is ready. Without gating, all queued traffic is released at the first successful response. That can overwhelm a site that is still warming up and take it down again.

## How it works

Umbraco Cloud asks your site whether it is ready by calling the readiness endpoint:

```
GET /umbraco/api/health/ready
```

The endpoint is anonymous. A `200` response means the site is ready. A `503` response means the site is not ready, for example, while it is starting or an upgrade is pending or running.

While the site reports not ready, visitors see exactly what they see during downtime today. That is your custom error page if one is assigned, otherwise the default Umbraco Cloud maintenance page. There is no new page to configure. See the [Error Pages](error-pages.md) article for how to upload and assign custom error pages.

Once the site reports ready, normal traffic resumes within roughly ten seconds.

{% hint style="info" %}
A site is never stuck behind the error page because of readiness gating. If the readiness endpoint responds `404` for any reason, Umbraco Cloud immediately reverts to the previous behaviour. Traffic is then released at the first successful response, as before.
{% endhint %}

## Supported versions

Readiness gating relies on the readiness endpoint being present on your site:

| Your site                             | Readiness gating                                                                                                                     |
| ------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| Umbraco 13 with Umbraco.Cloud.Cms     | Active with `Umbraco.Cloud.Cms` version 13.x.x or later, which ships the readiness endpoint.                                          |
| Umbraco 17.6 and later                | Active. Umbraco ships the readiness endpoint natively. See [Health Probes](https://docs.umbraco.com/umbraco-cms/run-in-production/infrastructure-and-ops/server-setup/health-probes) in the CMS documentation. |
| All other versions                    | Not active. The endpoint does not exist and behaviour is unchanged.                                                                    |

<!-- TODO before publishing: replace 13.x.x with the Umbraco.Cloud.Cms release that ships the readiness endpoint (platform work item #69344). -->

For versions without the endpoint, nothing changes and nothing breaks. Custom error pages work exactly as before, and there is nothing you need to do.

## Working on a site while it is gated

While public visitors see the error page, requests to the following paths always go through to the site:

* `/umbraco` - the backoffice and Umbraco APIs, including everything beneath it.
* `/install` - the install and upgrade wizard.
* `/umbraco-signin-oidc` and `/umbraco-signout-oidc` - Umbraco ID sign-in callbacks.
* `/App_Plugins` - backoffice package assets.
* `/sb` - script and style bundles (Umbraco 13 only).

This lets you log in, debug, and complete upgrades while the site is held back. For example, during an upgrade the site may be running but not yet upgraded. Visitors keep seeing the error page while an administrator signs into `/umbraco` and completes the upgrade at `/install`. The site then reports ready and public traffic resumes automatically.

{% hint style="info" %}
The paths are matched as exact path segments. Content pages that start with the same text, such as `/umbraco-cms-guide` or `/installation-guide`, are not affected. They are gated like any other public page.
{% endhint %}

## Related

* [Error Pages](error-pages.md)
* [Health Probes (Umbraco CMS)](https://docs.umbraco.com/umbraco-cms/run-in-production/infrastructure-and-ops/server-setup/health-probes)
