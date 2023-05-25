# Umbraco Cloud Plans

Umbraco Cloud plans Starter, Standard, and Professional are running on shared infrastructure, referred to as pools. To ensure performance and prevent exhaustion of a given pool, each website is assigned a resource quota, depending on the plan, and resource usage is continuously monitored.

The shared resources used by the Umbraco Cloud websites are:

- CPU
- RAM/Memory
- Disk space
- TCP connections

Currently, all available Umbraco Cloud plans are utilizing P1V3 Azure App Service Plans as their underlying infrastructure. A P1V3 Azure App Service Plan offers in total

- 2 CPU Cores
- 8GB of RAM
- 250 GB of Disk space
- 1,920 TCP connections

To ensure stable performance of all websites hosted on Umbraco Cloud shared plans, soft and hard quotas were put in place. Quotas per site and the number of sites in the pool vary per Umbraco Cloud Plan.

## Plan quotas for shared Umbraco Cloud Plans

Whenever a CPU or RAM quota is met, the website will be restarted within a minute to ensure stable performance for all websites in the pool. Meeting a disk quota will result in errors whenever performing write operations to disk. No plan limits exist for TCP connections per site, besides the total amount of TCP connections available to all sites in the pool set at 1,920, attempting to open new TCP connections afterwards will result in errors.

These are hard plan quotas, as they can't be broken for more than a 5 minute period. When an cloud environment uses more CPU or memory as defined by the plan quota, the app service hosting the environment will restart. If the app service is restarted several times, we consider it as noisy neighbour and will to move it to dedicated environment to ensure other tenants in the shared pool aren't negatively affected.

Umbraco Cloud Starter plan

- CPU - 20% (120 sec of CPU time for a 5 minute period)
- Memory - 1500 MB (in private bytes)
- Disk - 7800 MB

Umbraco Cloud Standard plan

- CPU - 35% (210 sec of CPU time for a 5 minute period)
- Memory - 1800 MB (in private bytes)
- Disk - 9600 MB

Umbraco Cloud Professional plan

- CPU - 50% (210 sec of CPU time for a 5 minute period)
- Memory - 2000 MB (in private bytes)
- Disk - 10400 MB

You will be able to see the current and past CPU and 
