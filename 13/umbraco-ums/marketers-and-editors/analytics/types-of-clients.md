# Types of Clients

## Version 1.21 and newer

In versions 1.21 and newer of uMarketingSuite we only track '**real**' visitors and discard any visit we determine to be from a bot. The data for bots is no longer stored in uMS and cannot be viewed in the Analytics section.

The tracking of a visitor is done via the following steps:

- DeviceDetector.NET will assess if the visitor is a bot or a 'real' visitor`.
- If it is a 'real' visitor the page will send a POST request to `umbraco/umarketingsuite/pagedata/ping` recording a visit.
- If they are deemed a bot, the page will not make the POST request.

## Prior to version 1.21

In versions older than 1.21 uMS automatically classified every visitor of the websites in two groups: **Bots** and "**Real**" visitors.

This is done by using [DeviceDetector.NET](https://github.com/totpero/DeviceDetector.NET).

No traffic is filtered from your website. Instead, the traffic is classified. This classification is used in the Analytics reports. No bot-traffic is showed within Analytics, only real visitors.

You can find bot-traffix under the Bots-tab in the Analytics section.

![]