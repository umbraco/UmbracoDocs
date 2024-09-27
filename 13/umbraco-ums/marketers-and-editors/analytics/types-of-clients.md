---
description: Learn more about how uMS distinguishes between bots and real visitors.
---

# Types Of Clients

## Version 1.21 and newer

In versions 1.21 and newer of uMS, we only track '**real**' visitors and discard any visit we determine to be from a bot. The data for bots is no longer stored in uMS and cannot be viewed in the Analytics section.

The tracking of a visitor is done via the following steps:

* DeviceDetector.NET will assess if the visitor is a bot or a 'real' visitor\`.
* If it is a 'real' visitor the page will send a POST request to `umbraco/umarketingsuite/pagedata/ping` recording a visit.
* The page will not add a POST request if the visitor is deemed a bot.

## Before version 1.21

In versions older than 1.21 uMS automatically classified every visitor of the websites into two groups: **Bots** and "**Real**" visitors.

This is done by using [DeviceDetector.NET](https://github.com/totpero/DeviceDetector.NET).

No traffic is filtered from your website. Instead, the traffic is classified. This classification is used in the Analytics reports. No bot traffic is shown within Analytics, only real visitors.

You can find bot traffic under the Bots-tab in the Analytics section.

!\[]
