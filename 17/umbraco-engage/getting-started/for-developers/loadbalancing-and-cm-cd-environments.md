---
description: Recommendations for using Umbraco Engage within a load-balanced setup.
---

# Load Balancing and CM/CD Environments

## Umbraco setup

Make sure your Umbraco is set up according to best practices. Please refer to the [Umbraco documentation](https://docs.umbraco.com/umbraco-cms/fundamentals/setup/server-setup/load-balancing) for more details.

## Cockpit

In CM/CD environments, the Cockpit needs to authenticate users across different domains. Umbraco Engage provides two methods for this:

### Method 1: Open Cockpit Button (Recommended)

As of Umbraco Engage 17, you can open the Cockpit directly from the Umbraco backoffice:

1. Log in to the Umbraco backoffice on your CM server
2. Navigate to the **Engage** section
3. Click the **Open Cockpit** button in the dashboard
4. If multiple domains are configured, select the domain you want to view
5. The Cockpit opens in a new tab, already authenticated

This method uses secure, short-lived authentication tokens. No additional cookie configuration is required.

{% hint style="info" %}
This feature requires Data Protection keys to be shared across all servers. See the [Machine Key and Data Protection](#machine-key-and-data-protection) section below.
{% endhint %}

#### Session Duration

Your Cockpit session remains active for 30 minutes by default. After this period, you will need to use the Open Cockpit button again to re-authenticate.

#### Logging Out

When you log out of the Umbraco backoffice, all your Cockpit sessions across all CD servers are automatically ended.

### Method 2: Cookie Domain Configuration (Alternative)

If you prefer the Cockpit to appear automatically when browsing the frontend (without using the Open Cockpit button), you can configure Umbraco to share authentication cookies across domains.

This requires Umbraco and your website to run on the same domain or subdomain. For example:

**Umbraco:** `umbraco.domain.com`\
**Site:** `domain.com`

Configure the `AuthCookieDomain` in your SecuritySettings:

```json
"AuthCookieDomain": ".domain.com",
```

To learn more, read the documentation about [SecuritySettings](https://docs.umbraco.com/umbraco-cms/reference/configuration/securitysettings).

### Cockpit Authentication Settings

The following settings can be configured in `appsettings.json` under `Engage:Cockpit:Authentication`:

```json
{
  "Engage": {
    "Cockpit": {
      "EnableInjection": true,
      "Authentication": {
        "TokenLifetimeSeconds": 60,
        "SessionLifetimeMinutes": 30,
        "RequireHttps": true,
        "CleanupIntervalMinutes": 60,
        "TokenRetentionBufferMinutes": 5,
        "SessionRetentionBufferMinutes": 1440,
        "SessionCookieSameSite": "Lax"
      }
    }
  }
}
```

| Setting | Default | Description |
|---------|---------|-------------|
| TokenLifetimeSeconds | 60 | How long the authentication token remains valid after clicking Open Cockpit. |
| SessionLifetimeMinutes | 30 | How long your Cockpit session lasts before requiring re-authentication. |
| RequireHttps | true | Requires HTTPS for security. Set to `false` only for local development. |
| CleanupIntervalMinutes | 60 | How often expired tokens and sessions are cleaned up from the database. |
| TokenRetentionBufferMinutes | 5 | How long to keep expired tokens before deletion (for debugging). |
| SessionRetentionBufferMinutes | 1440 | How long to keep expired sessions before deletion (24 hours default). |
| SessionCookieSameSite | Lax | Cookie SameSite policy. Options: `Lax`, `Strict`, or `None`. |

{% hint style="warning" %}
Do not set `RequireHttps` to `false` in production environments. This setting is only intended for local development without HTTPS.
{% endhint %}

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
