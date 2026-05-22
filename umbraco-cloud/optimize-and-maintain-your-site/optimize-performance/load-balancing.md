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

* Umbraco CMS **17.0.0 or higher**.
* The project must run in **Umbraco Production Mode**.
* A plan that supports load balancing — Redis defaults differ per plan, see [Redis backplane and default configuration](#redis-backplane-and-default-configuration) below.

## Scaling modes

{% hint style="info" %}
**Image placeholder**: Portal screenshot of the load-balancing settings panel showing the static and dynamic scaling options. Will be added once the Portal user interface is final.
{% endhint %}

Umbraco Cloud offers two scaling modes. Select the mode that fits your traffic profile.

### Static scaling

Set a fixed instance count for the environment. The count remains the same until you change the value manually.

Choose static scaling when:

* Your traffic is predictable.
* You want full control over running cost.
* You are sizing for a known peak.

### Dynamic scaling

Umbraco Cloud increases or decreases the instance count automatically based on load. The platform adds instances when demand rises and removes them when demand falls.

Choose dynamic scaling when:

* Your traffic is spiky or hard to predict.
* You want capacity to follow demand without manual intervention.
* You want to reduce running cost during low-traffic periods.

## Redis Configuration by Cloud Plan

{% hint style="info" %}
**Image placeholder**: Portal screenshot of the Redis Stock Keeping Unit (SKU) display on the environment settings page. Will be added once the Portal user interface is final.
{% endhint %}

Each load-balanced environment is provisioned with a managed Redis instance. Redis acts as the SignalR backplane and the distributed cache that keeps state consistent across all running instances.

When you enable load balancing, Umbraco Cloud provisions a Redis Stock Keeping Unit (SKU) by default based on your plan. Higher-tier defaults include High Availability (HA) and a Service Level Agreement (SLA).

| Plan         | Default Redis SKU    |
| ------------ | -------------------- |
| Starter      | Extra Small (no SLA) |
| Standard     | Extra Small+ (HA)    |
| Professional | Small+ (HA)          |

The Extra Small SKU on the Starter plan does not include an SLA. The Extra Small+ and Small+ defaults on Standard and Professional plans include both an SLA and high availability.

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

* [Umbraco CMS Load Balancing](https://docs.umbraco.com/umbraco-cms/fundamentals/setup/server-setup/load-balancing) — for projects hosted outside Umbraco Cloud.
* [Load Balancing the Backoffice](https://docs.umbraco.com/umbraco-cms/fundamentals/setup/server-setup/load-balancing/load-balancing-backoffice) — backoffice-specific configuration available from Umbraco 17.
* [Dedicated Resources](../../build-and-customize-your-solution/set-up-your-project/project-settings/dedicated-resources.md) — when to combine load balancing with dedicated server resources.
