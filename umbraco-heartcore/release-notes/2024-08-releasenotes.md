# August 2024
The following changes have been released to all Heartcore sites.

## Webhook Enhancements
With the core CMS adding webhook support, the same functionality has been adapted into Heartcore to use the same user interface. You will now get the same consistent editing experience in both Umbraco CMS and Umbraco Heartcore, and it also comes with new features.
* You may now select multiple event types (for example, publish / unpublish) or content types for a webhook. No more needing to create dozens of hooks to achieve what can now be done with only one.
* You may now specify custom HTTP headers to send to your endpoint whenever the webhook fires.

Aside from the interface, all other aspects of webhooks in Heartcore are unchanged. Webhooks are still fired from the delivery platform with the same IP address range, retry policy, and payload that you are used to.

For more information about webhook functionality, both new and old, check out the [updated Webhooks article](../getting-started/webhooks.md).

## Improved Firewall
A recent roll-out has added additional firewall rules for all Heartcore services. While efforts have been made to tune these, there is always a small possibility of false positives. If you believe your legitimate traffic is affected, raise a support ticket through the portal.
