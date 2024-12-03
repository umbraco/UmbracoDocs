# Plans

Umbraco Cloud plans Starter, Standard, and Professional are running on shared infrastructure, referred to as pools. To ensure performance and prevent exhaustion of a given pool, each website is assigned a resource quota, depending on the plan, and resource usage is continuously monitored.

The shared resources used by the Umbraco Cloud websites are:

* CPU
* RAM/Memory
* Disk space
* TCP connections

Currently, all available Umbraco Cloud plans are utilizing P1V3 Azure App Service Plans as their underlying infrastructure. A P1V3 Azure App Service Plan offers in total

* 2 CPU Cores
* 8GB of RAM
* 250 GB of Disk space
* 1,920 TCP connections

To ensure stable performance of all websites hosted on Umbraco Cloud shared plans, soft and hard quotas were implemented. Quotas per site and the number of sites in the pool vary per Umbraco Cloud Plan.

## Plan quotas for shared Umbraco Cloud Plans

Whenever a CPU or memory plan quota is met, the website will be restarted within a minute to ensure stable performance for all websites in the pool. Meeting a disk quota will result in errors whenever performing write operations to disk. No plan limits exist for TCP connections per site, besides the total amount of TCP connections available to all sites in the pool set at 1,920, attempting to open new TCP connections afterwards will result in errors.

Umbraco Cloud Starter plan

* CPU - 20% (120 sec of CPU time for a 5-minute period)
* Memory - 1500 MB (in private bytes)
* Disk - 7800 MB

Umbraco Cloud Standard plan

* CPU - 35% (210 sec of CPU time for a 5-minute period)
* Memory - 1800 MB (in private bytes)
* Disk - 9600 MB

Umbraco Cloud Professional plan

* CPU - 50% (300 sec of CPU time for a 5-minute period)
* Memory - 2000 MB (in private bytes)
* Disk - 10400 MB

These are hard plan quotas that cannot be exceeded for more than a 5-minute interval. When a cloud environment surpasses the CPU or memory limits defined by the plan quota, the app service hosting the environment will automatically restart. If the app service experiences multiple restarts, we will relocate it to a dedicated environment. This ensures other tenants in the shared pool are not negatively impacted.

You can look at the pricing, plans, and features on the [Umbraco Cloud Pricing](https://umbraco.com/products/umbraco-cloud/pricing/) page.
