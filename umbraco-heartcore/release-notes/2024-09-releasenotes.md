# September 2024
The following changes have been released to all Heartcore sites.

## Webhook Enhancements
With the core CMS having added webhook support, we have adapted the same function in Heartcore to use the same user interface. Not only does this mean you get the same consistent editing experience in both core Umbraco and Heartcore, but this also means we added support for some new features!
* You may now select multiple event types (for example, publish / unpublish) or content types for a webhook. No more needing to create dozens of hooks to achieve what can now be done with only one!
* You may now specify custom HTTP headers to send to your endpoint whenever the webhook fires.

Aside from the interface, all other aspects of webhooks in Heartcore are unchanged. Webhooks are still fired from the delivery platform with the same IP address range, retry policy, and payload that you're used to.

For more information about webhook functionality, both new and old, check out the [updated page here](../getting-started/webhooks.md).

## New Redirect Endpoint
For a long time, the only way to get redirect information from Heartcore was a single endpoint on the Delivery API. This endpoint returned paginated redirect information for _all_ content items in the tree. If you needed to find the canonical URL for a given path, then this endpoint was your only option. You would need to search for a matching path in the list of all items - a particular challenge if it wasn't on the first page of results!

In order to save you the trouble, a brand new endpoint has been added to the Delivery API. It allows you to fetch the canonical URL (and any other redirects) for a given path. For more information, check out the [updated page here](../api-documentation/redirect.md#get-content-by-redirect-url).

## Improved Firewall
We can't talk too much about this one, but we recently rolled out additional firewall rules for all Heartcore services. While we have made an effort to tune these, there is always a small possibility of false positives. If you believe your legitimate traffic is affected, please raise a support ticket through the portal.