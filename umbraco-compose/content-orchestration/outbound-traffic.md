---
description: >-
  Umbraco Compose uses static, region-specific outbound IP addresses for
  features like webhooks and ingestion functions, enabling you to allow them
  through your firewall.
---

# Outbound Traffic

Some features of Umbraco Compose generate outbound traffic to your applications. You may want to configure firewall rules to allow this traffic. Compose will always make requests from a static IP address. IP addresses differ depending on the region in which your project resides.

## Compose IP addresses

| Compose Region       | Outbound IP Address(es) |
| -------------------- | ----------------------- |
| Germany West Central | `9.141.127.49`          |
| US East              | `Coming Soon.`          |

Both [webhooks](webhooks.md) and any [ingestion functions](../apis/ingestion/functions.md) that make HTTP requests will use these addresses.
