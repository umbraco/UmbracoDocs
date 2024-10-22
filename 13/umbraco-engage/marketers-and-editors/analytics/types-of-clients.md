---
icon: square-exclamation
description: >-
  Learn more about how Umbraco Engage distinguishes between bots and real
  visitors.
---

# Types Of Clients

Engage only tracks '**real**' visitors and discard any visit we determine to be from a bot. The data for bots is not stored in Umbraco Engage and cannot be viewed in the Analytics section. \
\
From an SEO perspective, bots, search engine crawlers, spiders, and the like, will always see the default content so no personalization and no participation in an A/B test.

The tracking of a visitor is done via the following steps:

* DeviceDetector.NET will assess if the visitor is a bot or a 'real' visitor\` using the device ID of the browser.
* If it is a 'real' visitor the page will send a special ping request to Umbraco Engage to record the visit. If this ping is not received the requests of this visitor will not be tracked.

