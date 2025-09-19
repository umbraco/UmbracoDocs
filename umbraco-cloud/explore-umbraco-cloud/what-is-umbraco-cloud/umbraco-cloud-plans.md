---
description: Overview of Umbraco Cloud plans, resource quotas, and infrastructure details.
---

# Plans

Umbraco Cloud plans - Starter, Standard, and Professional - run on shared infrastructure, referred to as pools. To ensure consistent performance and prevent resource exhaustion within a pool, each website is assigned a resource quota based on its plan. Resource usage is continuously monitored to maintain stability across all sites.

The shared resources used by Umbraco Cloud websites include:

* Central Processing Unit (CPU)
* Random Access Memory (RAM)/Memory
* Disk space
* Transmission Control Protocol (TCP) connections

Currently, all available Umbraco Cloud plans utilize P1V3 Azure App Service Plans as their underlying infrastructure. A P1V3 Azure App Service Plan provides:

* 2 CPU Cores
* 8GB of RAM
* 250 GB of Disk space
* 1,920 TCP connections

To ensure stable performance for all websites hosted on Umbraco Cloud shared plans, both soft and hard quotas are in place. Quotas per site and the number of sites in each pool vary by Umbraco Cloud Plan.

## Plan quotas for shared Umbraco Cloud Plans

Each plan has specific resource quotas. If a CPU or memory quota is exceeded, the application will restart to maintain stability for all adjacent sites on the app service plan. Exceeding the disk space quota will result in errors when performing write operations.

While there are no per-site limits for TCP connections, the total available TCP connections for all sites in the pool is 1,920. Once this limit is reached, any additional connection attempts will result in errors.

### Umbraco Cloud Starter plan

* CPU - 20% (120 seconds of CPU time within a 5-minute period)
* Memory - 1,500 MB (private bytes)
* Disk - 7,800 MB

### Umbraco Cloud Standard plan

* CPU - 35% (210 seconds of CPU time within a 5-minute period)
* Memory - 1,800 MB (private bytes)
* Disk - 9,600 MB

### Umbraco Cloud Professional plan

* CPU - 50% (300 seconds of CPU time within a 5-minute period)
* Memory - 2,000 MB (private bytes)
* Disk - 10,400 MB

These quotas are hard limits and cannot be exceeded for more than a 5-minute interval. If an application surpasses the CPU or memory limits defined by the plan quota, the app service hosting the application will automatically restart. If multiple restarts occur, we will relocate the application to a dedicated instance to prevent negative impacts on other tenants within the shared pool.

For more details on pricing, plans, and features, visit the [Umbraco Cloud Pricing](https://umbraco.com/products/umbraco-cloud/pricing/) page.
