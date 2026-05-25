---
description: >-
  Enable load balancing on Umbraco Cloud to scale an environment across multiple instances for higher throughput and improved availability.
---

# Load Balancing

Load balancing distributes traffic across multiple instances of the same Umbraco Cloud environment. Enable it when you need higher throughput, resilience against instance failures, or capacity for traffic spikes.

## What load balancing is and why you would enable it

Load balancing runs an Umbraco Cloud environment on two or more instances that share the same database, media storage, and Redis backplane. Incoming requests are distributed across the instances by the platform.

Enable load balancing when you need:

* **Higher throughput** — more concurrent requests than a single instance can serve.
* **Smoother traffic spikes** — capacity for short-term load increases such as campaigns or product launches.
* **Improved availability** — a single failing instance does not take the environment offline.

Load balancing is **not** a multi-region failover and does not provide zero-downtime deployments. See [Deployments and restarts](#deployments-and-restarts) below.

## Before you enable load balancing

Confirm your project meets these requirements before turning load balancing on.

Load balancing requires:

* Umbraco CMS **17.4.2 or higher**.
* The project must run in [Umbraco Production Mode](https://docs.umbraco.com/umbraco-cms/fundamentals/setup/server-setup/runtime-modes#production-mode).
* `Umbraco:CMS:ModelsBuilder:ModelsMode` set to `Nothing` — see [ModelsBuilder Settings](https://docs.umbraco.com/umbraco-cms/reference/configuration/modelsbuildersettings).
* Pre-compiled views at build/publish time — see [Runtime Modes](https://docs.umbraco.com/umbraco-cms/fundamentals/setup/server-setup/runtime-modes#production-mode).
* A plan that supports load balancing — see [Cache Configuration by Cloud Plan](#cache-configuration-by-cloud-plan) below.

{% hint style="info" %}
Production mode enforces the `ModelsMode = Nothing` and pre-compiled views requirements at boot — an Umbraco app in Production mode that fails either check throws `BootFailedException`. They are listed separately so you can verify each one against your project before enabling Production mode.
{% endhint %}

## Scaling modes

{% hint style="info" %}
**Image placeholder**: Portal screenshot of the load-balancing settings panel showing the manual scaling option. Will be added once the Portal user interface is final.
{% endhint %}

Umbraco Cloud supports manual scaling. Dynamic scaling, where the platform adjusts the instance count automatically based on load, is planned for a future release.

### Manual scaling

You choose the exact number of instances your environment runs on. The count remains fixed until you change the value.

Choose manual scaling when:

* Your traffic is predictable.
* You want full control over running cost.
* You are sizing for a known peak.

{% hint style="warning" %}
Load-balanced environments currently have sticky sessions enabled. Each visitor is routed to the same instance for the duration of their session, which limits how evenly traffic is distributed across instances.
{% endhint %}

## Cache Configuration by Cloud Plan

{% hint style="info" %}
**Image placeholder**: Portal screenshot of the Redis Stock Keeping Unit (SKU) display on the environment settings page. Will be added once the Portal user interface is final.
{% endhint %}

Load balancing is available on dedicated plans from **Standard Dedicated 1** and up. It is not available on Starter, Standard (shared), Standard Dedicated 1, or shared Professional plans. If you need load balancing on a smaller plan, contact Umbraco Support to discuss upgrade paths.

Each load-balanced environment runs against a managed Redis instance. Redis acts as the SignalR backplane and the distributed cache that keeps state consistent across all running instances. If the environment does not already have Cache enabled, Umbraco Cloud provisions a managed Redis cache as part of enabling load balancing — see [Cache Configuration](cache-configuration.md).

Umbraco CMS uses Microsoft's HybridCache for its distributed cache. See the [HybridCacheOptions reference](https://docs.umbraco.com/umbraco-cms/reference/configuration/cache-settings#hybridcacheoptions) for configuration details.

When you enable load balancing, Umbraco Cloud selects a Redis Stock Keeping Unit (SKU) automatically based on your plan. All eligible plans include High Availability (HA) and a Service Level Agreement (SLA) on the Redis instance.

| Plan                 | Default Redis SKU | High Availability |
| -------------------- | ----------------- | ----------------- |
| Standard Dedicated 2 | Extra Small+      | ✅                 |
| Pro Dedicated 1      | Small+            | ✅                 |
| Pro Dedicated 2      | Small+            | ✅                 |
| Pro Dedicated 3      | Small+            | ✅                 |

For the full list of available Redis SKUs and how to choose one, see [Cache Configuration](cache-configuration.md).

## Performance and availability

Load balancing changes how performance and availability behave in an Umbraco Cloud environment. Two behaviors stand out:

### Logs are split per instance

Each instance writes a separate log stream. Per-instance logs trace requests to the specific serving instance. This helps diagnose problems affecting only one instance in the fleet.

For where to find logs and how to read them, see [Log files](../monitor-and-troubleshoot/resolve-issues-quickly-and-efficiently/log-files.md).

### Capacity and resilience

Multiple instances absorb traffic spikes more effectively than a single instance. If one instance becomes unhealthy, the remaining instances continue to serve traffic while the platform recovers the failed instance.

## Deployments and restarts

{% hint style="warning" %}
Load balancing does **not** provide rolling updates. When you deploy code or publish content, all instances are restarted. Visitors may experience brief downtime while instances restart.
{% endhint %}

Plan deployments and large content transfers during low-traffic windows where possible.

## Related articles

* [Cache Configuration](cache-configuration.md) — managed Redis cache that backs load-balanced environments; lists available SKUs.
* [Umbraco CMS Load Balancing](https://docs.umbraco.com/umbraco-cms/fundamentals/setup/server-setup/load-balancing) — for projects hosted outside Umbraco Cloud.
* [Load Balancing the Backoffice](https://docs.umbraco.com/umbraco-cms/fundamentals/setup/server-setup/load-balancing/load-balancing-backoffice) — backoffice-specific configuration available from Umbraco 17.
* [Dedicated Resources](../../build-and-customize-your-solution/set-up-your-project/project-settings/dedicated-resources.md) — when to combine load balancing with dedicated server resources.
