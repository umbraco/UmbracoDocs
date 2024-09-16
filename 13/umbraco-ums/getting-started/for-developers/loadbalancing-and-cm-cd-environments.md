# Load balancing and CM/CD Environments

## **Umbraco setup**

Make sure your Umbraco is setup according to the Umbraco best-practices. Please refer to the [Umbraco documentation](https://docs.umbraco.com/umbraco-cms/fundamentals/setup/server-setup/load-balancing).

## **Cockpit** 

**Configuring the AuthCookieDomain cookie**For the cockpit to function properly it is necessary that the cockpit can read the Umbraco login cookie or else the cockpit won't be visible. **Umbraco and the site should run on the same domain / sub-domain**. For example:

**Umbraco:** umbraco.domain.com  
**Site:** domain.com

Make sure the AuthCookieDomain in your SecuritySettings of your Umbraco config is set to

    "AuthCookieDomain": ".domain.com",

Also see: [https://docs.umbraco.com/umbraco-cms/reference/configuration/securitysettings](https://docs.umbraco.com/umbraco-cms/reference/configuration/securitysettings)

**Machine key / Data Protection**

You need to configure machine keys / data protection to **use the same keys on all servers** (content delivery and content-management). Without this setup, each server will generate its own key, resulting in that the Umbraco authentication cookie is encrypted and decrypted using different keys and the uMarketingSuite cockpit will not be shown on the front-end servers.

Also see the Data Protection section at: [https://docs.umbraco.com/umbraco-cms/fundamentals/setup/server-setup/load-balancing](https://docs.umbraco.com/umbraco-cms/fundamentals/setup/server-setup/load-balancing)

## **Bot detection (ping)**

uMarketingSuite will perform a ping (POST) to detect if the [visitor is a visitor or a bot](/analytics/types-of-clients/). The url umbraco/umarketingsuite/pagedata/ping should be accessible from the content delivery / front-end servers so make sure no firewall or other mechanism is blocking POST requests to **umbraco/umarketingsuite/pagedata/ping** or else all visitors will be treated like a bot and no analytics data is collected.

## **Configuration**

Make sure the **IsProcessingServer** is set to **True** on the content management (Umbraco) server/environment and to **False** on the content delivery / front-end servers in your **uMarketingSuite.config** ([uMarktingSuite v1.x](/installing-umarketingsuite/configuration-options-1-x/)) or **AppSettings.json** ([uMarketingSuite v2.x](/installing-umarketingsuite/configuration-options-2-x/)) file.

## **Sticky sessions**

Sticky sessions, also known as session affinity, are essential for the proper functioning of uMarketingSuite in a load-balanced environment. Sticky sessions can be enabled using various methods such as cookie-based, IP-based, or URL-based session affinity, depending on the load balancer configuration. By enabling sticky sessions, you can ensure that user sessions remain intact and data consistency is maintained across the uMarketingSuite application so analytics, a/b testing and personalization can work properly.

Please refer to the documentation or configuration settings of your load balancer for specific instructions on enabling sticky sessions.