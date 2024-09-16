# Types of Clients

### Version 1.21 and newer

In versions 1.21 and newer of uMarketingSuite we only track '**real**' visitors and discard any visit we determine to be from a bot. The data for bot visits is no longer stored in uMarketingSuite and thus can not be viewed in the analytics section with the bot tab for reporting.

The tracking of a visitor is done with the following steps:

- DeviceDetector.NET will assess if the visitor is a bot or a 'real' visitor
- If it's a 'real' visitor then the page will send a POST request to **umbraco/umarketingsuite/pagedata/ping** record a visit
- If they are deemed a bot, they won't make this request

### Prior to version 1.21

In versions older than 1.21 The uMarketingSuite automatically classified every visitor of the websites in two groups: **Bots** and "**Real**" visitors.

This is done by using [DeviceDetector.NET](https://github.com/totpero/DeviceDetector.NET)

With the uMarketingSuite we do **not** filter any traffic from your website. We only classify them. This classification is used in our Analytics reports. We do not show any bot-traffic within Analytics, only real visitors.

The obvious exception is of course the bots-tab in Analytics 😉!

![]