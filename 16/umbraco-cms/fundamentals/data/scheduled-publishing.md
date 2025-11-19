---
description: >-
  Each document in Umbraco can be scheduled for publishing and unpublishing on a
  pre-defined date and time.
---

# Scheduled Publishing

Each document in Umbraco can be scheduled for publishing and unpublishing on a pre-defined date and time.

You can find the options to do this click on the arrow next to the **Save and publish** button and pick **Schedule...**

<figure><img src="../../../../15/umbraco-cms/.gitbook/assets/image (19) (1).png" alt="Scheduled publishing"><figcaption><p>Scheduled publishing</p></figcaption></figure>

This will open a **Schedule Publishing** dialog where you can specify dates and time.

![Scheduled publishing](images/scheduled-publishing.png)

## Timezones

Your server may be in a different timezone than where you are located. You are able to select a date and time in your timezone and Umbraco will make sure that the item gets published at that time. So, if you select 12 PM then the item will be published at 12PM in the timezone you are in. This may be 8 PM on the server, which is indicated when you select the date and time.

<figure><img src="../../../../15/umbraco-cms/.gitbook/assets/image (20) (1).png" alt="Scheduled publishing time"><figcaption><p>Scheduled publishing</p></figcaption></figure>

If you are in the same timezone as the server, this message will not appear under the date picker.

{% hint style="info" %}
In Umbraco versions lower than 7.5, the time you select has to be the time on the server. These older versions of Umbraco do not detect your local time zone.
{% endhint %}

## Permissions

All users with access to the Content section in the Umbraco backoffice are able to schedule content for publishing/unpublish.

## Configuration

In some cases you will need to adjust your configuration to ensure that scheduled publishing/unpublishing works. The schedule works by the server sending an HTTP(S) request to itself.

If you are in a load balanced environment special care must be given to ensure you've configured this correctly, [see the docs here](../setup/server-setup/load-balancing/file-system-replication.md)

If you are not load balancing, the way that Umbraco determines the base URL to send the scheduled HTTP(S) request to is as follows:

* umbracoSettings:settings/web.routing/@umbracoApplicationUrl if it exists _(see_ [_these docs_](../../reference/configuration/webroutingsettings.md) _for details)_
* Else umbracoSettings:settings/scheduledTasks/@baseUrl if it exits _(deprecated)_
* Else umbracoSettings:distributedCall/servers if we have the server in there _(deprecated, see load balance docs)_
* Else it's based on the first request that the website receives and uses the base URL of this request _(default)_

If the `umbracoApplicationUrl` is used, the value also specifies the scheme (either HTTP or HTTPS). The request for scheduled publishing will always be sent over HTTPS if the appSettings `umbracoUseSSL` is set to `true`.

## Troubleshooting

If your scheduled publishing/unpublishing is not working as expected it is probably an issue that your server cannot communicate with the scheduled publishing endpoint. This can be caused by a number of reasons such as:

* Url rewrites in place that prevent the endpoint from being reached
* DNS misconfiguration not allowing the server to communicate to the base URL used in the first request that the website receives - which could be directly affected by a firewall/Network Address Translation (NAT)/load balancer that your server sites behind
* Secure Sockets Layer (SSL) and/or umbracoUseSSL misconfiguration not allowing the server to communicate to the scheduled publishing endpoint on the correct http/https scheme

To better diagnose the issue you can temporarily change your log4net config settings to be `DEBUG` instead of `INFO`. This will give you all sorts of information including being able to see whether or not the scheduled publishing endpoint is being reached or not.

In some cases it might be easiest to specify the [umbracoSettings:settings/web.routing/@umbracoApplicationUrl](../../reference/configuration/webroutingsettings.md) setting. This is to ensure that your server is communicating to itself on the correct URL.
