---
description: Recommendations for using Umbraco Engage within a load-balanced setup.
---

# Load Balancing and CM/CD Environments

## Umbraco setup

Make sure your Umbraco is set up according to best practices. Please refer to the [Umbraco documentation](https://docs.umbraco.com/umbraco-cms/fundamentals/setup/server-setup/load-balancing) for more details.

## Cockpit

For the Cockpit to function properly it is necessary that the cockpit can read the Umbraco login cookie. Umbraco and the site should run on the same domain or sub-domain.

For example:

**Umbraco:** `umbraco.domain.com`\
**Site:** `domain.com`

Make sure the `AuthCookieDomain` in your SecuritySettings of your Umbraco config has the following value:

```json
"AuthCookieDomain": ".domain.com",
```

To learn more, read the documentation about the [SecuritySettings](https://docs.umbraco.com/umbraco-cms/reference/configuration/securitysettings)

## Machine Key and Data Protection

You need to configure machine keys and data protection to **use the same keys on all servers** (content delivery and content-management).

Without this setup, each server will generate its own key. This will result in the Umbraco authentication cookie being encrypted and decrypted using different keys leaving the Cockpit unusable on the frontend servers.

To learn more, read the [Load Balancing article](https://docs.umbraco.com/umbraco-cms/fundamentals/setup/server-setup/load-balancing) in the Umbraco CMS documentation.

## Bot detection (ping)

Umbraco Engage will perform a ping (POST) to detect if the [visitor is a visitor or a bot](../../marketers-and-editors/analytics/types-of-clients.md). The `umbraco/engage/pagedata/ping` URL should be accessible from the content delivery and front-end servers. Make sure no firewall or other mechanism is blocking POST requests to `umbraco/engage/pagedata/ping`. If this URL is blocked, all visitors will be treated like a bot and no analytics data is collected.

## Configuration

Make sure the `IsProcessingServer` is set to `true` on the content management (Umbraco) environment and to `false` on the content delivery or front-end servers.

The setting can be set in your`appSettings.json`file.

## Sticky sessions

Sticky sessions, also known as session affinity, are essential for the proper functioning of Umbraco Engage in a load-balanced environment. Sticky sessions can be enabled using different methods such as cookie-based, IP-based, or URL-based session affinity, depending on the load balancer configuration. By enabling sticky sessions, you can ensure that user sessions remain intact and data consistency is maintained across the Umbraco Engage application. Sticky sessions will ensure that analytics, A/B testing and personalization works properly.

For specific instructions on enabling sticky sessions, refer to the documentation or configuration settings of your load balancer.
